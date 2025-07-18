import logging
from typing import Dict

from fastapi import FastAPI, Request, HTTPException
from fastapi.responses import JSONResponse
import uvicorn
from telegram import Update, Bot
from telegram.ext import Application, CommandHandler, MessageHandler, filters, ContextTypes

from config import TELEGRAM_BOT_TOKEN
from llm import process_message
from tools import ensure_index_exists

# Set up logging
logging.basicConfig(
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    level=logging.INFO
)
logger = logging.getLogger(__name__)

# Initialize FastAPI
app = FastAPI(title="Markdown Brain Bot")

# Initialize bot
bot = Bot(token=TELEGRAM_BOT_TOKEN)
application = Application.builder().token(TELEGRAM_BOT_TOKEN).build()

# Ensure index exists on startup
ensure_index_exists()


@app.on_event("startup")
async def startup_event():
    """Initialize the bot on startup."""
    await application.initialize()
    logger.info("Bot initialized successfully")


@app.on_event("shutdown")
async def shutdown_event():
    """Cleanup on shutdown."""
    await application.shutdown()
    logger.info("Bot shut down successfully")


@app.get("/")
async def root():
    """Health check endpoint."""
    return {"status": "ok", "bot": "Markdown Brain Bot"}


@app.post("/webhook")
async def webhook(request: Request):
    """Handle incoming Telegram updates via webhook."""
    try:
        data = await request.json()
        update = Update.de_json(data, bot)
        
        # Process the update
        await application.process_update(update)
        
        return {"status": "ok"}
    except Exception as e:
        logger.error(f"Error processing webhook: {e}")
        raise HTTPException(status_code=500, detail=str(e))


async def start_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Handle the /start command."""
    welcome_message = (
        "🧠 Welcome to the Markdown Brain Bot!\n\n"
        "I'm your shared knowledge assistant. I can help you:\n\n"
        "• Create notes and lists\n"
        "• Add information to existing notes\n"
        "• Search and retrieve information\n\n"
        "Just send me a message with what you'd like to do!\n\n"
        "Examples:\n"
        "- \"Create a shopping list with milk, eggs, and bread\"\n"
        "- \"Add coffee to the shopping list\"\n"
        "- \"What's on my shopping list?\"\n"
        "- \"Create a note about project ideas\"\n"
        "- \"Find all notes about projects\""
    )
    await update.message.reply_text(welcome_message)


async def help_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Handle the /help command."""
    help_message = (
        "📚 **How to use the Markdown Brain Bot**\n\n"
        "**Creating content:**\n"
        "• \"Create a [type] about [topic]\" - Creates a new note\n"
        "• \"Make a list of [items]\" - Creates a new list\n\n"
        "**Adding content:**\n"
        "• \"Add [content] to [note name]\" - Appends to existing note\n\n"
        "**Reading content:**\n"
        "• \"What's in [note name]?\" - Shows note content\n"
        "• \"Show me [note name]\" - Shows note content\n\n"
        "**Searching:**\n"
        "• \"Find notes about [topic]\" - Searches all notes\n"
        "• \"Search for [keyword]\" - Searches all content\n\n"
        "**Listing:**\n"
        "• \"List all notes\" - Shows all stored notes\n"
        "• \"What notes do we have?\" - Shows all stored notes"
    )
    await update.message.reply_text(help_message, parse_mode='Markdown')


async def handle_message(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Handle incoming text messages."""
    try:
        user_message = update.message.text
        chat_id = update.effective_chat.id
        
        logger.info(f"Received message from {chat_id}: {user_message}")
        
        # Show typing indicator
        await bot.send_chat_action(chat_id=chat_id, action="typing")
        
        # Process the message with LLM
        response = process_message(user_message)
        
        # Send the response
        await update.message.reply_text(response, parse_mode='Markdown')
        
    except Exception as e:
        logger.error(f"Error handling message: {e}")
        error_message = (
            "😔 Sorry, I encountered an error processing your message. "
            "Please try again or contact the administrator if the problem persists."
        )
        await update.message.reply_text(error_message)


# Register handlers
application.add_handler(CommandHandler("start", start_command))
application.add_handler(CommandHandler("help", help_command))
application.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, handle_message))


if __name__ == "__main__":
    # Run the FastAPI server
    uvicorn.run(app, host="0.0.0.0", port=8000)