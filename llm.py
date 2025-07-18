import json
import re
from typing import Dict, Any, Optional, List
from openai import OpenAI

from config import OPENAI_API_KEY, GPT_MODEL, MAX_TOKENS, TEMPERATURE
from tools import (
    create_file, append_to_file, read_file, search_files, 
    list_all_files, sanitize_filename
)

# Initialize OpenAI client
client = OpenAI(api_key=OPENAI_API_KEY)

SYSTEM_PROMPT = """You are a markdown-based memory assistant.

All content is stored in plain `.md` files inside a single folder structure.

When a user says:
* "create a list..." → create a new .md file with a list
* "add to X..." → append to the relevant file
* "what's in X..." → read and return that file's content
* "find/search X..." → search for files containing that information

You must always:
1. Update the global `index.md` with a link and summary of every new file or folder.
2. If a file is created inside a subfolder, update or create a `README.md` in that folder with its own local index.
3. Never mention filenames unless the user asks for them.
4. Use bullet lists for lists, and clean markdown formatting.
5. Respond naturally without exposing the technical details.

Files may optionally contain frontmatter (YAML) with metadata like:
```
---
title: groceries
type: list
created: 2025-01-18
tags: [shopping]
---
```

Maintain clean structure. Be consistent. Do not hallucinate files.

You have access to these functions:
- create_file(title, content, folder, type, tags): Creates a new markdown file
- append_to_file(file_path, content): Adds content to an existing file
- read_file(file_path): Reads content from a file
- search_files(query): Searches for files containing specific text
- list_all_files(): Lists all files in the system
"""

FUNCTION_DEFINITIONS = [
    {
        "name": "create_file",
        "description": "Create a new markdown file with content",
        "parameters": {
            "type": "object",
            "properties": {
                "title": {
                    "type": "string",
                    "description": "Title of the file (will be sanitized into filename)"
                },
                "content": {
                    "type": "string",
                    "description": "Markdown content of the file"
                },
                "folder": {
                    "type": "string",
                    "description": "Optional folder path to organize the file"
                },
                "type": {
                    "type": "string",
                    "description": "Type of document (note, list, recipe, etc)",
                    "default": "note"
                },
                "tags": {
                    "type": "array",
                    "items": {"type": "string"},
                    "description": "Optional tags for categorization"
                }
            },
            "required": ["title", "content"]
        }
    },
    {
        "name": "append_to_file",
        "description": "Append content to an existing markdown file",
        "parameters": {
            "type": "object",
            "properties": {
                "file_path": {
                    "type": "string",
                    "description": "Path to the file to append to"
                },
                "content": {
                    "type": "string",
                    "description": "Content to append"
                }
            },
            "required": ["file_path", "content"]
        }
    },
    {
        "name": "read_file",
        "description": "Read content from a markdown file",
        "parameters": {
            "type": "object",
            "properties": {
                "file_path": {
                    "type": "string",
                    "description": "Path to the file to read"
                }
            },
            "required": ["file_path"]
        }
    },
    {
        "name": "search_files",
        "description": "Search for files containing specific text",
        "parameters": {
            "type": "object",
            "properties": {
                "query": {
                    "type": "string",
                    "description": "Text to search for"
                }
            },
            "required": ["query"]
        }
    },
    {
        "name": "list_all_files",
        "description": "List all markdown files in the system",
        "parameters": {
            "type": "object",
            "properties": {}
        }
    }
]


def process_message(user_message: str) -> str:
    """Process a user message using GPT-4o and execute any necessary file operations."""
    try:
        # First, let GPT analyze the message and decide what to do
        messages = [
            {"role": "system", "content": SYSTEM_PROMPT},
            {"role": "user", "content": user_message}
        ]
        
        response = client.chat.completions.create(
            model=GPT_MODEL,
            messages=messages,
            functions=FUNCTION_DEFINITIONS,
            function_call="auto",
            temperature=TEMPERATURE,
            max_tokens=MAX_TOKENS
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
            messages.append({
                "role": "function",
                "name": function_name,
                "content": json.dumps(function_result)
            })
            
            final_response = client.chat.completions.create(
                model=GPT_MODEL,
                messages=messages,
                temperature=TEMPERATURE,
                max_tokens=MAX_TOKENS
            )
            
            return final_response.choices[0].message.content
        
        # If no function call, return the direct response
        return message.content
        
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
                "file_path": file_path
            }
            
        elif function_name == "append_to_file":
            file_path = args.get("file_path")
            content = args.get("content")
            
            # If file_path is just a title, try to find the file
            if not file_path.endswith('.md'):
                search_results = search_files(file_path)
                if search_results:
                    file_path = search_results[0]['path']
                else:
                    return {
                        "success": False,
                        "error": f"Could not find file matching '{file_path}'"
                    }
            
            updated_path = append_to_file(file_path, content)
            return {
                "success": True,
                "message": f"Appended to file: {updated_path}"
            }
            
        elif function_name == "read_file":
            file_path = args.get("file_path")
            
            # If file_path is just a title, try to find the file
            if not file_path.endswith('.md'):
                search_results = search_files(file_path)
                if search_results:
                    file_path = search_results[0]['path']
                else:
                    return {
                        "success": False,
                        "error": f"Could not find file matching '{file_path}'"
                    }
            
            content = read_file(file_path)
            return {
                "success": True,
                "content": content
            }
            
        elif function_name == "search_files":
            query = args.get("query")
            results = search_files(query)
            return {
                "success": True,
                "results": results,
                "count": len(results)
            }
            
        elif function_name == "list_all_files":
            files = list_all_files()
            return {
                "success": True,
                "files": files,
                "count": len(files)
            }
            
        else:
            return {
                "success": False,
                "error": f"Unknown function: {function_name}"
            }
            
    except Exception as e:
        return {
            "success": False,
            "error": str(e)
        }