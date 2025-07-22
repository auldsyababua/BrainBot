import json
import logging
import re
from typing import Dict, Any, List, Optional, Tuple
from datetime import datetime
from openai import OpenAI

from src.core.config import (
    OPENAI_API_KEY,
    GPT_MODEL,
    MAX_TOKENS,
    TEMPERATURE,
    SYSTEM_PROMPT,
    CONVERSATION_MAX_MESSAGES,
    CONVERSATION_TTL_HOURS,
)
from src.core.tools import (
    create_file,
    append_to_file,
    read_file,
    search_files,
    list_all_files,
)
from src.storage.redis_store import redis_store
from src.storage.vector_store import vector_store
from src.core.api_client import get_resilient_client, RetryConfig
from src.core.benchmarks import get_performance_monitor, async_benchmark

# Initialize resilient OpenAI client with custom retry config
retry_config = RetryConfig(
    max_retries=3, base_delay=1.0, max_delay=30.0, exponential_base=2.0, jitter=True
)
resilient_client = get_resilient_client(retry_config)

# Keep original client for backwards compatibility
client = OpenAI(api_key=OPENAI_API_KEY)

# Note: Conversation history is now stored in Redis via redis_store
# Previous conversations are also stored in Redis with a "prev:" prefix

FUNCTION_DEFINITIONS = [
    {
        "name": "create_file",
        "description": "Create a new markdown file with content",
        "parameters": {
            "type": "object",
            "properties": {
                "title": {
                    "type": "string",
                    "description": "Title of the file (will be sanitized into filename)",
                },
                "content": {
                    "type": "string",
                    "description": "Markdown content of the file",
                },
                "folder": {
                    "type": "string",
                    "description": "Optional folder path to organize the file",
                },
                "type": {
                    "type": "string",
                    "description": "Type of document (note, list, recipe, etc)",
                    "default": "note",
                },
                "tags": {
                    "type": "array",
                    "items": {"type": "string"},
                    "description": "Optional tags for categorization",
                },
            },
            "required": ["title", "content"],
        },
    },
    {
        "name": "append_to_file",
        "description": "Append content to an existing markdown file",
        "parameters": {
            "type": "object",
            "properties": {
                "file_path": {
                    "type": "string",
                    "description": "Path to the file to append to",
                },
                "content": {"type": "string", "description": "Content to append"},
            },
            "required": ["file_path", "content"],
        },
    },
    {
        "name": "read_file",
        "description": "Read content from a markdown file",
        "parameters": {
            "type": "object",
            "properties": {
                "file_path": {
                    "type": "string",
                    "description": "Path to the file to read",
                }
            },
            "required": ["file_path"],
        },
    },
    {
        "name": "search_files",
        "description": "Search for files containing specific text",
        "parameters": {
            "type": "object",
            "properties": {
                "query": {"type": "string", "description": "Text to search for"}
            },
            "required": ["query"],
        },
    },
    {
        "name": "list_all_files",
        "description": "List all markdown files in the system",
        "parameters": {"type": "object", "properties": {}},
    },
]


class ConversationManager:
    """Manages conversation history with sliding window and performance tracking."""

    def __init__(self, max_messages: int = 20, ttl_hours: int = 24):
        """Initialize conversation manager.

        Args:
            max_messages: Maximum messages to keep in sliding window
            ttl_hours: Hours before conversation expires
        """
        self.max_messages = max_messages
        self.ttl_seconds = ttl_hours * 3600
        self.monitor = None

    async def _ensure_monitor(self):
        """Ensure performance monitor is initialized."""
        if self.monitor is None:
            self.monitor = get_performance_monitor()

    async def get_conversation_history(self, chat_id: str) -> List[Dict[str, str]]:
        """Get conversation history with sliding window management."""
        # Try to get conversation from Redis
        messages = await redis_store.get_conversation(chat_id)

        # If no conversation exists, create a new one
        if messages is None:
            messages = [{"role": "system", "content": SYSTEM_PROMPT}]
            await redis_store.save_conversation(chat_id, messages)
        else:
            # Extend TTL on active conversation
            await redis_store.extend_conversation_ttl(chat_id)

        # Apply sliding window (keep system prompt + last N messages)
        if len(messages) > self.max_messages + 1:  # +1 for system prompt
            # Keep system prompt and last max_messages
            messages = [messages[0]] + messages[-(self.max_messages) :]
            # Save trimmed conversation back to Redis
            await redis_store.save_conversation(chat_id, messages)

        # Track conversation size
        await self._ensure_monitor()
        self.monitor.track_conversation_size(chat_id, len(messages))

        return messages

    async def add_message(self, chat_id: str, role: str, content: str):
        """Add a message to conversation with automatic sliding window."""
        # Get existing conversation
        messages = await redis_store.get_conversation(chat_id)

        if messages is not None:
            # Add new message
            messages.append({"role": role, "content": content})

            # Apply sliding window if needed
            if len(messages) > self.max_messages + 1:  # +1 for system prompt
                # Keep system prompt and last max_messages
                messages = [messages[0]] + messages[-(self.max_messages) :]

            # Save back to Redis with TTL
            await redis_store.save_conversation(chat_id, messages)

            # Track updated size
            await self._ensure_monitor()
            self.monitor.track_conversation_size(chat_id, len(messages))

    async def cleanup_old_conversations(self, days_inactive: int = 7):
        """Cleanup conversations older than specified days.

        Note: This is handled automatically by Redis TTL, but this method
        can be used for manual cleanup or different retention policies.
        """
        # Since we're using Redis TTL, this is mostly a placeholder
        # In a production system, you might want to:
        # 1. Archive old conversations to S3/storage
        # 2. Generate summaries before deletion
        # 3. Track cleanup metrics
        logger = logging.getLogger(__name__)
        logger.info(
            f"Cleanup requested for conversations older than {days_inactive} days"
        )

    async def get_conversation_stats(self, chat_id: str) -> Dict[str, Any]:
        """Get statistics about a conversation."""
        messages = await redis_store.get_conversation(chat_id)

        if messages is None:
            return {"exists": False}

        # Calculate stats
        user_messages = sum(1 for m in messages if m.get("role") == "user")
        assistant_messages = sum(1 for m in messages if m.get("role") == "assistant")
        total_chars = sum(len(m.get("content", "")) for m in messages)

        return {
            "exists": True,
            "total_messages": len(messages),
            "user_messages": user_messages,
            "assistant_messages": assistant_messages,
            "total_characters": total_chars,
            "estimated_tokens": total_chars // 4,  # Rough estimate
            "has_system_prompt": any(m.get("role") == "system" for m in messages),
        }


# Global conversation manager instance with config values
conversation_manager = ConversationManager(
    max_messages=CONVERSATION_MAX_MESSAGES, ttl_hours=CONVERSATION_TTL_HOURS
)


async def get_conversation_history(
    chat_id: str, max_messages: int = None
) -> List[Dict[str, str]]:
    """Get conversation history for a chat.

    This is a compatibility wrapper for the new ConversationManager.
    """
    if max_messages is not None:
        # Create temporary manager with custom max_messages
        temp_manager = ConversationManager(max_messages=max_messages)
        return await temp_manager.get_conversation_history(chat_id)
    else:
        return await conversation_manager.get_conversation_history(chat_id)


async def add_to_conversation_history(chat_id: str, role: str, content: str):
    """Add a message to conversation history.

    This is a compatibility wrapper for the new ConversationManager.
    """
    await conversation_manager.add_message(chat_id, role, content)


async def reset_conversation(chat_id: str):
    """Reset conversation but save it for potential restoration."""
    # Get current conversation
    messages = await redis_store.get_conversation(chat_id)

    if messages is not None:
        # Save to previous conversations with different key
        prev_key = f"prev:{chat_id}"
        await redis_store.save_conversation(prev_key, messages)
        # Delete current conversation
        await redis_store.delete_conversation(chat_id)


async def restore_conversation(chat_id: str) -> bool:
    """Restore previous conversation if available."""
    # Try to get previous conversation
    prev_key = f"prev:{chat_id}"
    messages = await redis_store.get_conversation(prev_key)

    if messages is not None:
        # Restore to current conversation
        await redis_store.save_conversation(chat_id, messages)
        # Delete the previous conversation backup
        await redis_store.delete_conversation(prev_key)
        return True
    return False


async def search_knowledge_base(
    query: str, chat_id: Optional[str] = None
) -> List[Dict]:
    """Search the vector knowledge base for relevant context with full document retrieval."""
    logger = logging.getLogger(__name__)
    try:
        # Use the new search_with_full_content method to get full documents
        # Note: search_with_full_content doesn't support namespace parameter yet
        # We need to use the regular search method with namespace
        results = await vector_store.search(
            query, top_k=3, include_metadata=True, namespace=""
        )
        logger.info(
            f"Vector search for '{query}' (namespace={chat_id}) returned {len(results)} results"
        )
        return results
    except Exception as e:
        logger.error(f"Vector search error for query '{query}': {e}")
        # Fallback to file search if vector search fails
        file_results = search_files(query)
        return [
            {"id": r["path"], "content": r.get("content", ""), "score": 0.5}
            for r in file_results[:3]
        ]


@async_benchmark("process_message")
async def process_message(user_message: str, chat_id: str = "default") -> str:
    """Process a user message using GPT-4o and execute any necessary file operations."""
    logger = logging.getLogger(__name__)
    logger.info(
        f"Processing message for chat_id={chat_id}: {(user_message or '')[:50]}..."
    )

    # Track conversation size
    monitor = get_performance_monitor()

    try:
        # First, search for relevant context
        search_results = await search_knowledge_base(user_message, chat_id)

        # Build context from search results
        context_parts = []
        source_documents = []

        for result in search_results:
            # Try to get content from multiple possible locations
            content = result.get("content")

            # If content is None or empty, try metadata.content_preview
            if not content and result.get("metadata"):
                content = result["metadata"].get("content_preview")

            # Only add to context if we have actual content
            if content and content.strip():
                # Build source info
                source_info = ""
                title = ""

                # Get title from various sources
                if result.get("metadata"):
                    title = result["metadata"].get("title", "")
                    if not title:
                        file_path = result["metadata"].get("file_path", "")
                        if file_path:
                            title = file_path.split("/")[-1].replace(".md", "")

                # Add document URL if available
                document_url = result.get("document_url")
                if document_url:
                    source_info = f"Source: {title} ({document_url})"
                    source_documents.append(
                        {
                            "title": title,
                            "url": document_url,
                            "score": result.get("score", 0),
                        }
                    )
                elif title:
                    source_info = f"Source: {title}"
                else:
                    source_info = f"Source: {result.get('id', 'unknown')}"

                context_parts.append(
                    f"[{source_info} - Score: {result.get('score', 0):.2f}]\n{content[:500]}..."
                )
            else:
                logger.warning(
                    f"Empty content for result: {result.get('id', 'unknown')}"
                )

        # Get conversation history
        messages = await get_conversation_history(chat_id)

        # Track conversation size
        monitor.track_conversation_size(chat_id, len(messages))

        # If we have relevant context, add it to the user message
        enhanced_message = user_message
        if context_parts:
            enhanced_message = f"{user_message}\n\n[System: Found relevant context from knowledge base]\n{chr(10).join(context_parts)}"

        # Add the new user message
        messages.append({"role": "user", "content": enhanced_message})
        await add_to_conversation_history(chat_id, "user", user_message)

        # Use resilient client for API call
        response = await resilient_client.chat_completion(
            messages=messages,
            model=GPT_MODEL,
            functions=FUNCTION_DEFINITIONS,
            function_call="auto",
            temperature=TEMPERATURE,
            max_tokens=MAX_TOKENS,
        )

        message = response.choices[0].message

        # If GPT wants to call a function
        if message.function_call:
            function_name = message.function_call.name
            function_args = json.loads(message.function_call.arguments)

            # Add chat_id to function args for namespace support
            function_args["chat_id"] = chat_id

            # Execute the function
            function_result = await execute_function(function_name, function_args)

            # Send the result back to GPT for a final response
            messages.append(message)
            messages.append(
                {
                    "role": "function",
                    "name": function_name,
                    "content": json.dumps(function_result),
                }
            )

            # Use resilient client for final response
            final_response = await resilient_client.chat_completion(
                messages=messages,
                model=GPT_MODEL,
                temperature=TEMPERATURE,
                max_tokens=MAX_TOKENS,
            )

            final_content = final_response.choices[0].message.content

            # Add source documents if available
            if source_documents:
                sources_text = "\n\n📚 Sources:\n" + "\n".join(
                    [f"• {doc['title']} - {doc['url']}" for doc in source_documents[:3]]
                )
                final_content += sources_text

            await add_to_conversation_history(chat_id, "assistant", final_content)
            return final_content

        # If no function call, return the direct response
        assistant_content = message.content

        # Add source documents if available
        if source_documents:
            sources_text = "\n\n📚 Sources:\n" + "\n".join(
                [f"• {doc['title']} - {doc['url']}" for doc in source_documents[:3]]
            )
            assistant_content += sources_text

        await add_to_conversation_history(chat_id, "assistant", assistant_content)
        return assistant_content

    except Exception as e:
        logger.error(f"Error processing message: {e}", exc_info=True)
        return f"I encountered an error processing your request: {str(e)}"


def is_uuid(value: str) -> bool:
    """Check if a string is a valid UUID."""
    uuid_pattern = re.compile(
        r"^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$", re.IGNORECASE
    )
    return bool(uuid_pattern.match(value))


async def resolve_document_reference(
    reference: str,
) -> Tuple[Optional[str], Optional[str], Optional[str]]:
    """Resolve a document reference to (file_path, document_id, content).

    Args:
        reference: Either a file path or a Supabase document ID

    Returns:
        Tuple of (file_path, document_id, content) - some may be None
    """
    logger = logging.getLogger(__name__)

    # Check if it's a UUID (Supabase document ID)
    if is_uuid(reference):
        logger.info(f"Detected Supabase document ID: {reference}")
        from src.storage.storage_service import document_storage

        if document_storage:
            try:
                doc = await document_storage.get_document_by_id(reference)
                if doc:
                    return doc.get("file_path"), reference, doc.get("content")
                else:
                    logger.warning(f"Document ID {reference} not found in Supabase")
            except Exception as e:
                logger.error(f"Error fetching document by ID: {e}")

        return None, reference, None

    # Otherwise, treat it as a file path
    elif reference.endswith(".md"):
        # It's already a file path
        return reference, None, None

    else:
        # It might be a title or partial path - search for it
        search_results = search_files(reference)
        if search_results:
            file_path = search_results[0]["path"]
            return file_path, None, None

        return None, None, None


async def execute_function(function_name: str, args: Dict[str, Any]) -> Dict[str, Any]:
    """Execute a function based on GPT's decision."""
    try:
        if function_name == "create_file":
            # Extract arguments with defaults
            title = args.get("title")
            content = args.get("content")
            folder = args.get("folder")
            doc_type = args.get("type", "note")
            tags = args.get("tags", [])

            file_path = create_file(title, content, folder, doc_type, tags)

            # Get chat_id from context if available
            chat_id = args.get("chat_id", "default")

            # Also store in vector database for semantic search
            doc_id = file_path.replace("/", "_").replace(".md", "")
            metadata = {
                "title": title,
                "type": doc_type,
                "tags": tags,
                "folder": folder or "root",
                "file_path": file_path,
            }
            await vector_store.embed_and_store(doc_id, content, metadata, namespace="")

            # Also store in Supabase
            from src.storage.storage_service import document_storage

            if document_storage:
                try:
                    # Convert chat_id to integer for telegram_chat_id, or None if not a valid integer
                    telegram_chat_id = None
                    if chat_id and chat_id != "default":
                        try:
                            telegram_chat_id = int(chat_id)
                        except ValueError:
                            # If chat_id is not a valid integer (e.g., "user1"), pass None
                            telegram_chat_id = None

                    await document_storage.store_document(
                        file_path=file_path,
                        content=content,
                        metadata=metadata,
                        category=folder,
                        tags=tags,
                        telegram_chat_id=telegram_chat_id,
                        created_by="bot",
                    )
                except Exception as e:
                    logger = logging.getLogger(__name__)
                    logger.error(f"Error storing document in Supabase: {e}")
                    # Don't fail the operation if Supabase is unavailable

            return {
                "success": True,
                "message": f"Created file: {file_path}",
                "file_path": file_path,
            }

        elif function_name == "append_to_file":
            reference = args.get("file_path")
            content = args.get("content")

            # Resolve the reference to file path and/or document ID
            file_path, document_id, existing_content = await resolve_document_reference(
                reference
            )

            if not file_path and not document_id:
                return {
                    "success": False,
                    "error": f"Could not find file or document matching '{reference}'",
                }

            # If we only have a document ID, we need to handle it differently
            if document_id and not file_path:
                # This is a Supabase-only document
                from src.storage.storage_service import document_storage

                if document_storage and existing_content is not None:
                    # Append to the existing content
                    updated_content = existing_content + "\n\n" + content

                    # Update in Supabase by ID
                    success = await document_storage.update_document_by_id(
                        document_id, updated_content
                    )

                    if success:
                        # Re-index in vector store
                        metadata = {
                            "document_id": document_id,
                            "last_updated": datetime.now().isoformat(),
                            "source_ids": [
                                document_id,
                                f"{document_id}_append_{datetime.now().timestamp()}",
                            ],
                            "operation": "merge",
                        }
                        await vector_store.embed_and_store(
                            document_id, updated_content, metadata, namespace=""
                        )

                        return {
                            "success": True,
                            "message": f"Updated Supabase document {document_id}",
                        }
                    else:
                        return {
                            "success": False,
                            "error": f"Failed to update Supabase document {document_id}",
                        }
                else:
                    return {
                        "success": False,
                        "error": f"Cannot append to Supabase document {document_id} - storage not available or content not found",
                    }

            # Standard file-based append
            updated_path = append_to_file(file_path, content)

            # Read the updated content
            try:
                updated_full_content = read_file(file_path)

                # Update in Supabase storage
                from src.storage.storage_service import document_storage

                if document_storage:
                    await document_storage.update_document(
                        file_path, updated_full_content
                    )

                # Re-index in vector store with updated content
                doc_id = file_path.replace("/", "_").replace(".md", "")
                # Add source tracking metadata
                metadata = {
                    "file_path": file_path,
                    "last_updated": datetime.now().isoformat(),
                    "source_ids": [
                        doc_id,
                        f"{doc_id}_append_{datetime.now().timestamp()}",
                    ],
                    "operation": "merge",
                }
                # Re-index ENTIRE updated content, not just the append
                # Use default namespace for MVP (all users share same vector space)
                await vector_store.embed_and_store(
                    doc_id,
                    updated_full_content,  # Full content, not just append
                    metadata,
                    namespace="",
                )

            except Exception as e:
                logger = logging.getLogger(__name__)
                logger.error(f"Error updating Supabase/vector store after append: {e}")
                # Still return success since filesystem update worked

            return {"success": True, "message": f"Appended to file: {updated_path}"}

        elif function_name == "read_file":
            reference = args.get("file_path")

            # Resolve the reference to file path and/or document ID
            file_path, document_id, content = await resolve_document_reference(
                reference
            )

            if not file_path and not document_id:
                return {
                    "success": False,
                    "error": f"Could not find file or document matching '{reference}'",
                }

            # If we have content from Supabase, use it
            if content is not None:
                return {"success": True, "content": content}

            # Otherwise, read from file system
            if file_path:
                content = read_file(file_path)
                return {"success": True, "content": content}

            return {
                "success": False,
                "error": f"Could not read content for '{reference}'",
            }

        elif function_name == "search_files":
            query = args.get("query")
            results = search_files(query)

            # If no results, try alternate search strategies
            if not results and query:
                # Try case variations
                if query.lower() != query:
                    results = search_files(query.lower())
                if not results and query.upper() != query:
                    results = search_files(query.title())

                # Try splitting multi-word queries
                if not results and " " in query:
                    words = query.split()
                    for word in words:
                        word_results = search_files(word)
                        if word_results:
                            results.extend(word_results)
                    # Remove duplicates
                    seen = set()
                    unique_results = []
                    for r in results:
                        if r["path"] not in seen:
                            seen.add(r["path"])
                            unique_results.append(r)
                    results = unique_results

            return {"success": True, "results": results, "count": len(results)}

        elif function_name == "list_all_files":
            files = list_all_files()
            return {"success": True, "files": files, "count": len(files)}

        else:
            return {"success": False, "error": f"Unknown function: {function_name}"}

    except Exception as e:
        return {"success": False, "error": str(e)}
