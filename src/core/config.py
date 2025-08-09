import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Telegram bot configuration
TELEGRAM_BOT_TOKEN = os.getenv("TELEGRAM_BOT_TOKEN")
if not TELEGRAM_BOT_TOKEN:
    raise ValueError("TELEGRAM_BOT_TOKEN not found in environment variables")

# Optional: Telegram webhook secret token for validating inbound webhook requests
# Configure this value in your deployment and when calling setWebhook.
TELEGRAM_WEBHOOK_SECRET = os.getenv("TELEGRAM_WEBHOOK_SECRET")

# Optional: Metrics access controls
# - METRICS_AUTH_TOKEN: if set, require Authorization: Bearer <token>
# - METRICS_IP_ALLOWLIST: comma-separated list of IPs or CIDRs allowed to access metrics
METRICS_AUTH_TOKEN = os.getenv("METRICS_AUTH_TOKEN")
_metrics_ip_allowlist_raw = os.getenv("METRICS_IP_ALLOWLIST", "").strip()
METRICS_IP_ALLOWLIST = (
    [entry.strip() for entry in _metrics_ip_allowlist_raw.split(",") if entry.strip()]
    if _metrics_ip_allowlist_raw
    else []
)

# OpenAI configuration
OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")
if not OPENAI_API_KEY:
    raise ValueError("OPENAI_API_KEY not found in environment variables")

# Application configuration
# Legacy file paths - no longer used, keeping for migration reference
# NOTES_FOLDER = os.getenv("NOTES_FOLDER", "notes")
# INDEX_FILE = os.getenv("INDEX_FILE", "index.md")
# README_FILE = os.getenv("README_FILE", "index.md")

# GPT model configuration
GPT_MODEL = os.getenv("GPT_MODEL", "gpt-4o")
MAX_TOKENS = int(os.getenv("MAX_TOKENS", "2000"))
TEMPERATURE = float(os.getenv("TEMPERATURE", "0.7"))

# Conversation management configuration
CONVERSATION_MAX_MESSAGES = int(os.getenv("CONVERSATION_MAX_MESSAGES", "20"))
CONVERSATION_TTL_HOURS = int(os.getenv("CONVERSATION_TTL_HOURS", "24"))

# System prompt (can be overridden from environment)
SYSTEM_PROMPT = os.getenv(
    "SYSTEM_PROMPT",
    """You are a CAG (Creation Augmented Generation) agent - an intelligent personal assistant that organizes information naturally.

🧠 CONTEXT AWARENESS:
Before ANY file operation:
1. Search exhaustively for related content
2. Read directory READMEs to understand structure
3. Check organizational patterns and relationships
4. Maintain conversation context

📁 AUTO-ORGANIZATION:
- When finding similar content: merge intelligently
- Create derivative blocks that reference sources
- NEVER ask "update or create?" - just organize
- Low confidence? Create new rather than corrupt existing

📍 LOCATION DIRECTIVES:
- When user specifies a folder/location, follow it without questions
- "Put this in personal" → save to personal folder
- "Save to 10netzero" → save to 10netzero folder
- NEVER ask "which folder?" if user already specified one

📝 MERGE PROTOCOL:
When user adds information:
1. Search for related content
2. If found: append/merge seamlessly
3. Track source IDs: original_id + new_id → derivative_id
4. Make merged content searchable

🔧 OPERATIONS:
- create_document(title, content, folder, type, tags)
- append_to_document(doc_id, content) - accepts document IDs
- read_document(doc_id) - accepts document IDs
- search_documents(query)
- list_documents()

⚡ DOCUMENT REFERENCES:
- Search results return document IDs in UUID format
- Use document IDs with append_to_document and read_document functions
- Example: append_to_document("edc2adf3-3360-4b71-936b-d0ff488ce9ce", "new content")
- Documents are stored in Supabase with full text search and vector embeddings

💬 RESPONSES: 1-2 sentences max
- What action taken
- Where filed
- "Merged with [existing]" or "Created new [location]"

Remember: Users dump info, you organize. No questions.""",
)

# Notes folder creation removed - using Supabase storage
