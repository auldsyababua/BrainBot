import json
import logging
from typing import Dict, Any, List
from openai import OpenAI

from src.core.config import (
    OPENAI_API_KEY,
    GPT_MODEL,
    MAX_TOKENS,
    TEMPERATURE,
    SYSTEM_PROMPT,
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

# Initialize OpenAI client
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


async def get_conversation_history(
    chat_id: str, max_messages: int = 10
) -> List[Dict[str, str]]:
    """Get conversation history for a chat, creating new if needed."""
    # Try to get conversation from Redis
    messages = await redis_store.get_conversation(chat_id)

    # If no conversation exists, create a new one
    if messages is None:
        messages = [{"role": "system", "content": SYSTEM_PROMPT}]
        await redis_store.save_conversation(chat_id, messages)
    else:
        # Extend TTL on active conversation
        await redis_store.extend_conversation_ttl(chat_id)

    # Return recent messages (keep system prompt + last N messages)
    if len(messages) > max_messages + 1:  # +1 for system prompt
        return [messages[0]] + messages[-(max_messages):]
    return messages


async def add_to_conversation_history(chat_id: str, role: str, content: str):
    """Add a message to conversation history."""
    # Get existing conversation
    messages = await redis_store.get_conversation(chat_id)

    if messages is not None:
        # Add new message
        messages.append({"role": role, "content": content})
        # Save back to Redis
        await redis_store.save_conversation(chat_id, messages)


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


async def search_knowledge_base(query: str) -> List[Dict]:
    """Search the vector knowledge base for relevant context with full document retrieval."""
    logger = logging.getLogger(__name__)
    try:
        # Use the new search_with_full_content method to get full documents
        results = await vector_store.search_with_full_content(
            query, top_k=3, include_full_docs=True
        )
        logger.info(f"Vector search for '{query}' returned {len(results)} results")
        return results
    except Exception as e:
        logger.error(f"Vector search error for query '{query}': {e}")
        # Fallback to file search if vector search fails
        file_results = search_files(query)
        return [
            {"id": r["path"], "content": r.get("content", ""), "score": 0.5}
            for r in file_results[:3]
        ]


async def process_message(user_message: str, chat_id: str = "default") -> str:
    """Process a user message using GPT-4o and execute any necessary file operations."""
    logger = logging.getLogger(__name__)
    logger.info(f"Processing message for chat_id={chat_id}: {user_message[:50]}...")
    try:
        # First, search for relevant context
        search_results = await search_knowledge_base(user_message)

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
                    source_documents.append({
                        "title": title,
                        "url": document_url,
                        "score": result.get('score', 0)
                    })
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

        # If we have relevant context, add it to the user message
        enhanced_message = user_message
        if context_parts:
            enhanced_message = f"{user_message}\n\n[System: Found relevant context from knowledge base]\n{chr(10).join(context_parts)}"

        # Add the new user message
        messages.append({"role": "user", "content": enhanced_message})
        await add_to_conversation_history(chat_id, "user", user_message)

        response = client.chat.completions.create(
            model=GPT_MODEL,
            messages=messages,
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

            final_response = client.chat.completions.create(
                model=GPT_MODEL,
                messages=messages,
                temperature=TEMPERATURE,
                max_tokens=MAX_TOKENS,
            )

            final_content = final_response.choices[0].message.content
            
            # Add source documents if available
            if source_documents:
                sources_text = "\n\n📚 Sources:\n" + "\n".join([
                    f"• {doc['title']} - {doc['url']}" for doc in source_documents[:3]
                ])
                final_content += sources_text
                
            await add_to_conversation_history(chat_id, "assistant", final_content)
            return final_content

        # If no function call, return the direct response
        assistant_content = message.content
        
        # Add source documents if available
        if source_documents:
            sources_text = "\n\n📚 Sources:\n" + "\n".join([
                f"• {doc['title']} - {doc['url']}" for doc in source_documents[:3]
            ])
            assistant_content += sources_text
            
        await add_to_conversation_history(chat_id, "assistant", assistant_content)
        return assistant_content

    except Exception as e:
        return f"I encountered an error processing your request: {str(e)}"


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

            # Also store in vector database for semantic search
            doc_id = file_path.replace("/", "_").replace(".md", "")
            metadata = {
                "title": title,
                "type": doc_type,
                "tags": tags,
                "folder": folder or "root",
                "file_path": file_path,
            }
            await vector_store.embed_and_store(doc_id, content, metadata)

            return {
                "success": True,
                "message": f"Created file: {file_path}",
                "file_path": file_path,
            }

        elif function_name == "append_to_file":
            file_path = args.get("file_path")
            content = args.get("content")

            # If file_path is just a title, try to find the file
            if not file_path.endswith(".md"):
                search_results = search_files(file_path)
                if search_results:
                    file_path = search_results[0]["path"]
                else:
                    return {
                        "success": False,
                        "error": f"Could not find file matching '{file_path}'",
                    }

            updated_path = append_to_file(file_path, content)
            return {"success": True, "message": f"Appended to file: {updated_path}"}

        elif function_name == "read_file":
            file_path = args.get("file_path")

            # If file_path is just a title, try to find the file
            if not file_path.endswith(".md"):
                search_results = search_files(file_path)
                if search_results:
                    file_path = search_results[0]["path"]
                else:
                    return {
                        "success": False,
                        "error": f"Could not find file matching '{file_path}'",
                    }

            content = read_file(file_path)
            return {"success": True, "content": content}

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
