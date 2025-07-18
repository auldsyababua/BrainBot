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
NOTES_FOLDER = "notes"
INDEX_FILE = "index.md"
README_FILE = "README.md"

# GPT model configuration
GPT_MODEL = "gpt-4o"
MAX_TOKENS = 2000
TEMPERATURE = 0.7

# Ensure notes folder exists
os.makedirs(NOTES_FOLDER, exist_ok=True)