import json
import logging
import re
import gc
import time
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

# Legacy tools.py imports removed - production only uses Supabase + Vector
# from src.core.tools import (...) - REMOVED
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
        "name": "create_document",
        "description": "Create a new document in Supabase with vector indexing",
        "parameters": {
            "type": "object",
            "properties": {
                "title": {
                    "type": "string",
                    "description": "Title of the document",
                },
                "content": {
                    "type": "string",
                    "description": "Markdown content of the document",
                },
                "folder": {
                    "type": "string",
                    "description": "Optional folder/category to organize the document",
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
        "name": "append_to_document",
        "description": "Append content to an existing document by ID or title",
        "parameters": {
            "type": "object",
            "properties": {
                "document_reference": {
                    "type": "string",
                    "description": "Document ID (UUID) or document title to append to",
                },
                "content": {"type": "string", "description": "Content to append"},
            },
            "required": ["document_reference", "content"],
        },
    },
    {
        "name": "read_document",
        "description": "Read content from a document by ID or title",
        "parameters": {
            "type": "object",
            "properties": {
                "document_reference": {
                    "type": "string",
                    "description": "Document ID (UUID) or document title to read",
                }
            },
            "required": ["document_reference"],
        },
    },
    {
        "name": "search_documents",
        "description": "Search for documents containing specific text using Supabase",
        "parameters": {
            "type": "object",
            "properties": {
                "query": {"type": "string", "description": "Text to search for"}
            },
            "required": ["query"],
        },
    },
    {
        "name": "list_documents",
        "description": "List documents from Supabase with optional filtering",
        "parameters": {
            "type": "object",
            "properties": {
                "category": {
                    "type": "string",
                    "description": "Optional category filter",
                },
                "limit": {
                    "type": "integer",
                    "description": "Optional limit (default 20)",
                },
            },
        },
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
        # Memory optimization: Use weak references and limit object retention
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

        # Memory optimization: Return copy to prevent external modifications
        return [msg.copy() for msg in messages]

    async def add_message(self, chat_id: str, role: str, content: str):
        """Add a message to conversation with automatic sliding window."""
        # Memory optimization: Limit string retention and use efficient updates
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

            # Memory optimization: Clear large content references
            del content

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

# Cache for function results and schemas with memory limits
_function_result_cache = {}
_function_schema_cache = None
_MAX_CACHE_SIZE = 100
_CACHE_TTL_SECONDS = 3600
_cache_timestamps = {}


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
        # Fallback to Supabase search if vector search fails
        try:
            from src.storage.storage_service import document_storage

            if document_storage:
                supabase_results = await document_storage.search_documents(query)
                return [
                    {
                        "id": r.get("id", ""),
                        "content": r.get("content", ""),
                        "score": 0.5,
                        "metadata": r.get("metadata", {}),
                    }
                    for r in supabase_results[:3]
                ]
        except Exception as fallback_error:
            logger.error(f"Fallback search also failed: {fallback_error}")

        # Return empty results if both searches fail
        return []


@async_benchmark("process_message")
async def process_message(user_message: str, chat_id: str = "default") -> str:
    """Process a user message using GPT-4o and execute any necessary document operations."""
    logger = logging.getLogger(__name__)
    logger.info(
        f"Processing message for chat_id={chat_id}: {(user_message or '')[:50]}..."
    )

    # Track conversation size
    monitor = get_performance_monitor()

    try:
        # Memory optimization: Limit context size and use generators
        search_results = await search_knowledge_base(user_message, chat_id)

        # Build context from search results with size limits
        context_parts = []
        source_documents = []
        max_context_length = 2000  # Limit total context size

        for result in search_results:
            # Memory optimization: Use efficient content extraction
            content = result.get("content", "")
            if not content and result.get("metadata"):
                content = result["metadata"].get("content_preview", "")

            if content and content.strip():
                # Memory optimization: Limit string operations
                title = result.get("metadata", {}).get("title", "")
                if not title:
                    file_path = result.get("metadata", {}).get("file_path", "")
                    title = (
                        file_path.split("/")[-1].replace(".md", "")
                        if file_path
                        else "unknown"
                    )

                # Memory optimization: Use string formatting efficiently
                source_info = f"Source: {title}"
                if result.get("document_url"):
                    source_info += f" ({result['document_url']})"
                    source_documents.append(
                        {
                            "title": title,
                            "url": result["document_url"],
                            "score": result.get("score", 0),
                        }
                    )

                # Memory optimization: Limit content preview size
                preview = content[: min(500, max_context_length // len(search_results))]
                context_parts.append(
                    f"[{source_info} - Score: {result.get('score', 0):.2f}]\n{preview}..."
                )

                # Memory optimization: Early exit if context is large enough
                if sum(len(part) for part in context_parts) > max_context_length:
                    break

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

        # Use optimized function definitions (cached and filtered)
        functions_to_send = _get_optimized_functions(messages)

        response = await resilient_client.chat_completion(
            messages=messages,
            model=GPT_MODEL,
            functions=functions_to_send,
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

            # Execute the function with caching and memory management
            cache_key = f"{function_name}:{json.dumps(function_args, sort_keys=True)}"

            # Clean expired cache entries
            _cleanup_expired_cache()

            if cache_key in _function_result_cache:
                function_result = _function_result_cache[cache_key]
            else:
                function_result = await execute_function(function_name, function_args)
                _function_result_cache[cache_key] = function_result
                _cache_timestamps[cache_key] = time.time()

                # Enforce cache size limit
                _enforce_cache_size_limit()

                # Explicit cleanup of large objects
                if hasattr(function_result, "__dict__"):
                    # Use weak references for large objects
                    function_result = _create_weakref_safe_copy(function_result)

            # Send the result back to GPT for a final response
            messages.append(message)
            messages.append(
                {
                    "role": "function",
                    "name": function_name,
                    "content": json.dumps(function_result, separators=(",", ":")),
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

            # Memory optimization: Explicit cleanup of large objects
            del search_results
            del context_parts
            del source_documents
            del messages
            del response
            del final_response

            # Force garbage collection for large objects
            gc.collect()

            return final_content

        # If no function call, return the direct response
        assistant_content = message.content

        # Add source documents if available (optimized string building)
        if source_documents:
            sources_text = "\n\n📚 Sources:\n" + "\n".join(
                [f"• {doc['title']} - {doc['url']}" for doc in source_documents[:3]]
            )
            assistant_content += sources_text

        await add_to_conversation_history(chat_id, "assistant", assistant_content)

        # Memory optimization: Explicit cleanup
        del search_results
        del context_parts
        del source_documents
        del messages
        del response

        # Force garbage collection
        gc.collect()

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
        # It might be a title - search for it in Supabase
        try:
            from src.storage.storage_service import document_storage

            if document_storage:
                search_results = await document_storage.search_documents(reference)
                if search_results:
                    doc = search_results[0]
                    return doc.get("file_path"), doc.get("id"), doc.get("content")
        except Exception as e:
            logger.error(f"Error searching for document by title: {e}")

        return None, None, None


def _get_optimized_functions(messages: List[Dict[str, str]]) -> List[Dict[str, Any]]:
    """Return optimized function definitions based on context."""
    global _function_schema_cache

    if _function_schema_cache is None:
        # Cache the full schema once
        _function_schema_cache = FUNCTION_DEFINITIONS

    # For now, return all functions - can be enhanced to filter based on context
    return _function_schema_cache


def _cleanup_expired_cache():
    """Remove expired cache entries."""
    import time

    current_time = time.time()
    expired_keys = [
        key
        for key, timestamp in _cache_timestamps.items()
        if current_time - timestamp > _CACHE_TTL_SECONDS
    ]

    for key in expired_keys:
        if key in _function_result_cache:
            del _function_result_cache[key]
        del _cache_timestamps[key]


def _enforce_cache_size_limit():
    """Enforce maximum cache size."""
    if len(_function_result_cache) > _MAX_CACHE_SIZE:
        # Remove oldest entries
        sorted_keys = sorted(
            _cache_timestamps.keys(), key=lambda k: _cache_timestamps[k]
        )
        keys_to_remove = sorted_keys[: len(sorted_keys) - _MAX_CACHE_SIZE]

        for key in keys_to_remove:
            if key in _function_result_cache:
                del _function_result_cache[key]
            if key in _cache_timestamps:
                del _cache_timestamps[key]


def _create_weakref_safe_copy(obj):
    """Create a memory-efficient copy of large objects."""
    if isinstance(obj, dict):
        return {k: v for k, v in obj.items() if not callable(v)}
    elif isinstance(obj, list):
        return [item for item in obj if not callable(item)]
    return obj


async def execute_function(function_name: str, args: Dict[str, Any]) -> Dict[str, Any]:
    """Execute a function based on GPT's decision."""
    try:
        if function_name == "create_document":
            # Extract arguments with defaults
            title = args.get("title")
            content = args.get("content")
            folder = args.get("folder")
            doc_type = args.get("type", "note")
            tags = args.get("tags", [])

            # Get chat_id from context if available
            chat_id = args.get("chat_id", "default")

            # Store in Supabase (primary storage)
            from src.storage.storage_service import document_storage

            if not document_storage:
                return {
                    "success": False,
                    "error": "Document storage not available",
                }

            try:
                # Convert chat_id to integer for telegram_chat_id, or None if not a valid integer
                telegram_chat_id = None
                if chat_id and chat_id != "default":
                    try:
                        telegram_chat_id = int(chat_id)
                    except ValueError:
                        # If chat_id is not a valid integer (e.g., "user1"), pass None
                        telegram_chat_id = None

                # Create synthetic file_path for compatibility
                file_path = (
                    f"{folder}/{title.lower().replace(' ', '-')}.md"
                    if folder
                    else f"{title.lower().replace(' ', '-')}.md"
                )

                metadata = {
                    "title": title,
                    "type": doc_type,
                    "tags": tags,
                    "folder": folder or "root",
                    "file_path": file_path,
                }

                # Store in Supabase with async connection handling
                doc_id = await document_storage.store_document(
                    file_path=file_path,
                    content=content,
                    metadata=metadata,
                    category=folder,
                    tags=tags,
                    telegram_chat_id=telegram_chat_id,
                    created_by="bot",
                )

                # doc_id is returned directly as a string
                if not doc_id:
                    doc_id = file_path.replace("/", "_").replace(".md", "")

                # Store in vector database for semantic search
                await vector_store.embed_and_store(
                    str(doc_id), content, metadata, namespace=""
                )

                return {
                    "success": True,
                    "message": f"Created document: {title}",
                    "document_id": doc_id,
                    "file_path": file_path,
                }

            except Exception as e:
                logger = logging.getLogger(__name__)
                logger.error(f"Error creating document: {e}")
                return {
                    "success": False,
                    "error": f"Failed to create document: {str(e)}",
                }

        elif function_name == "append_to_document":
            reference = args.get("document_reference")
            content = args.get("content")

            # Resolve the reference to document ID and existing content
            file_path, document_id, existing_content = await resolve_document_reference(
                reference
            )

            if not document_id and not file_path:
                return {
                    "success": False,
                    "error": f"Could not find document matching '{reference}'",
                }

            from src.storage.storage_service import document_storage

            if not document_storage:
                return {
                    "success": False,
                    "error": "Document storage not available",
                }

            try:
                # Append to the existing content
                updated_content = (existing_content or "") + "\n\n" + content

                # Update in Supabase
                if document_id:
                    success = await document_storage.update_document_by_id(
                        document_id, updated_content
                    )
                    doc_ref = document_id
                else:
                    # Use file path for backward compatibility
                    success = await document_storage.update_document(
                        file_path, updated_content
                    )
                    doc_ref = file_path.replace("/", "_").replace(".md", "")

                if success:
                    # Re-index in vector store
                    metadata = {
                        "document_id": document_id or doc_ref,
                        "file_path": file_path,
                        "last_updated": datetime.now().isoformat(),
                        "source_ids": [
                            doc_ref,
                            f"{doc_ref}_append_{datetime.now().timestamp()}",
                        ],
                        "operation": "merge",
                    }
                    await vector_store.embed_and_store(
                        doc_ref, updated_content, metadata, namespace=""
                    )

                    return {
                        "success": True,
                        "message": f"Updated document: {reference}",
                    }
                else:
                    return {
                        "success": False,
                        "error": f"Failed to update document: {reference}",
                    }

            except Exception as e:
                logger = logging.getLogger(__name__)
                logger.error(f"Error updating document: {e}")
                return {
                    "success": False,
                    "error": f"Failed to append to document: {str(e)}",
                }

        elif function_name == "read_document":
            reference = args.get("document_reference")

            # Resolve the reference to document ID and content
            file_path, document_id, content = await resolve_document_reference(
                reference
            )

            if not document_id and not file_path:
                return {
                    "success": False,
                    "error": f"Could not find document matching '{reference}'",
                }

            # If we have content from Supabase, use it
            if content is not None:
                return {"success": True, "content": content}

            # Try to get content from Supabase if we have an ID
            if document_id:
                from src.storage.storage_service import document_storage

                if document_storage:
                    try:
                        doc = await document_storage.get_document_by_id(document_id)
                        if doc and doc.get("content"):
                            return {"success": True, "content": doc["content"]}
                    except Exception as e:
                        logger = logging.getLogger(__name__)
                        logger.error(f"Error reading document from Supabase: {e}")

            return {
                "success": False,
                "error": f"Could not read content for document '{reference}'",
            }

        elif function_name == "search_documents":
            query = args.get("query")

            from src.storage.storage_service import document_storage

            if not document_storage:
                return {
                    "success": False,
                    "error": "Document storage not available",
                }

            try:
                # Search documents in Supabase
                results = await document_storage.search_documents(query)

                # Convert to expected format
                formatted_results = []
                for doc in results:
                    formatted_results.append(
                        {
                            "id": doc.get("id"),
                            "title": doc.get("metadata", {}).get("title", "Untitled"),
                            "snippet": (
                                doc.get("content", "")[:200] + "..."
                                if len(doc.get("content", "")) > 200
                                else doc.get("content", "")
                            ),
                            "path": doc.get("file_path", ""),
                            "category": doc.get("category"),
                            "tags": doc.get("tags", []),
                        }
                    )

                return {
                    "success": True,
                    "results": formatted_results,
                    "count": len(formatted_results),
                }

            except Exception as e:
                logger = logging.getLogger(__name__)
                logger.error(f"Error searching documents: {e}")
                return {
                    "success": False,
                    "error": f"Search failed: {str(e)}",
                }

        elif function_name == "list_documents":
            category = args.get("category")
            limit = args.get("limit", 20)

            from src.storage.storage_service import document_storage

            if not document_storage:
                return {
                    "success": False,
                    "error": "Document storage not available",
                }

            try:
                # List documents from Supabase
                documents = await document_storage.list_documents(
                    category=category, limit=limit
                )

                # Convert to expected format
                formatted_docs = []
                for doc in documents:
                    formatted_docs.append(
                        {
                            "id": doc.get("id"),
                            "title": doc.get("metadata", {}).get("title", "Untitled"),
                            "type": doc.get("metadata", {}).get("type", "note"),
                            "category": doc.get("category"),
                            "created": doc.get("created_at"),
                            "path": doc.get("file_path", ""),
                            "tags": doc.get("tags", []),
                        }
                    )

                return {
                    "success": True,
                    "files": formatted_docs,
                    "count": len(formatted_docs),
                }

            except Exception as e:
                logger = logging.getLogger(__name__)
                logger.error(f"Error listing documents: {e}")
                return {
                    "success": False,
                    "error": f"List failed: {str(e)}",
                }

        else:
            return {"success": False, "error": f"Unknown function: {function_name}"}

    except Exception as e:
        return {"success": False, "error": str(e)}
