import json
from typing import Dict, Any, List
from openai import OpenAI
from datetime import datetime, timedelta

from config import OPENAI_API_KEY, GPT_MODEL, MAX_TOKENS, TEMPERATURE, SYSTEM_PROMPT
from tools import create_file, append_to_file, read_file, search_files, list_all_files

# Initialize OpenAI client
client = OpenAI(api_key=OPENAI_API_KEY)

# Store conversation history in memory
# Format: {chat_id: {"messages": [...], "last_updated": datetime}}
conversation_history = {}

# Store previous conversations when reset
# Format: {chat_id: {"messages": [...], "last_updated": datetime}}
previous_conversations = {}

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


def get_conversation_history(
    chat_id: str, max_messages: int = 10
) -> List[Dict[str, str]]:
    """Get conversation history for a chat, creating new if needed."""
    # Clean up old conversations (inactive for more than 1 hour)
    current_time = datetime.now()
    inactive_chats = [
        cid
        for cid, data in conversation_history.items()
        if current_time - data["last_updated"] > timedelta(hours=1)
    ]
    for cid in inactive_chats:
        del conversation_history[cid]

    # Get or create conversation for this chat
    if chat_id not in conversation_history:
        conversation_history[chat_id] = {
            "messages": [{"role": "system", "content": SYSTEM_PROMPT}],
            "last_updated": current_time,
        }
    else:
        conversation_history[chat_id]["last_updated"] = current_time

    # Return recent messages (keep system prompt + last N messages)
    messages = conversation_history[chat_id]["messages"]
    if len(messages) > max_messages + 1:  # +1 for system prompt
        return [messages[0]] + messages[-(max_messages):]
    return messages


def add_to_conversation_history(chat_id: str, role: str, content: str):
    """Add a message to conversation history."""
    if chat_id in conversation_history:
        conversation_history[chat_id]["messages"].append(
            {"role": role, "content": content}
        )
        conversation_history[chat_id]["last_updated"] = datetime.now()


def reset_conversation(chat_id: str):
    """Reset conversation but save it for potential restoration."""
    if chat_id in conversation_history:
        # Save current conversation before resetting
        previous_conversations[chat_id] = {
            "messages": conversation_history[chat_id]["messages"].copy(),
            "last_updated": conversation_history[chat_id]["last_updated"],
        }
        del conversation_history[chat_id]


def restore_conversation(chat_id: str) -> bool:
    """Restore previous conversation if available."""
    if chat_id in previous_conversations:
        conversation_history[chat_id] = {
            "messages": previous_conversations[chat_id]["messages"].copy(),
            "last_updated": datetime.now(),  # Update timestamp to current
        }
        del previous_conversations[chat_id]
        return True
    return False


def process_message(user_message: str, chat_id: str = "default") -> str:
    """Process a user message using GPT-4o and execute any necessary file operations."""
    try:
        # Get conversation history
        messages = get_conversation_history(chat_id)

        # Add the new user message
        messages.append({"role": "user", "content": user_message})
        add_to_conversation_history(chat_id, "user", user_message)

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
            function_result = execute_function(function_name, function_args)

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
            add_to_conversation_history(chat_id, "assistant", final_content)
            return final_content

        # If no function call, return the direct response
        assistant_content = message.content
        add_to_conversation_history(chat_id, "assistant", assistant_content)
        return assistant_content

    except Exception as e:
        return f"I encountered an error processing your request: {str(e)}"


def execute_function(function_name: str, args: Dict[str, Any]) -> Dict[str, Any]:
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
