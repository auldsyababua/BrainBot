import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Telegram bot configuration
TELEGRAM_BOT_TOKEN = os.getenv("TELEGRAM_BOT_TOKEN")
if not TELEGRAM_BOT_TOKEN:
    raise ValueError("TELEGRAM_BOT_TOKEN not found in environment variables")

# OpenAI configuration
OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")
if not OPENAI_API_KEY:
    raise ValueError("OPENAI_API_KEY not found in environment variables")

# Application configuration
NOTES_FOLDER = os.getenv("NOTES_FOLDER", "notes")
INDEX_FILE = os.getenv("INDEX_FILE", "index.md")
README_FILE = os.getenv("README_FILE", "README.md")

# GPT model configuration
GPT_MODEL = os.getenv("GPT_MODEL", "gpt-4o")
MAX_TOKENS = int(os.getenv("MAX_TOKENS", "2000"))
TEMPERATURE = float(os.getenv("TEMPERATURE", "0.7"))

# System prompt (can be overridden from environment)
SYSTEM_PROMPT = os.getenv(
    "SYSTEM_PROMPT",
    """You are a markdown-based memory assistant.

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
""",
)

# Ensure notes folder exists
os.makedirs(NOTES_FOLDER, exist_ok=True)
