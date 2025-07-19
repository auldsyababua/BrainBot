"""
🏭 PRODUCTION: Webhook handler for Telegram bot

This module handles incoming webhook requests from Telegram in production.
Used by webhook_server.py when running on Render.

DO NOT run this directly - it's imported by webhook_server.py
"""

import logging
from contextlib import asynccontextmanager
from http import HTTPStatus

from fastapi import FastAPI, Request, Response
import uvicorn
from telegram import Update
from telegram.ext import (
    Application,
    CommandHandler,
    MessageHandler,
    filters,
    ContextTypes,
)

from src.core.config import TELEGRAM_BOT_TOKEN
from src.core.llm import process_message
from src.core.tools import ensure_index_exists

# Set up logging
logging.basicConfig(
    format="%(asctime)s - %(name)s - %(levelname)s - %(message)s", level=logging.INFO
)
logger = logging.getLogger(__name__)

# Ensure index exists on startup
ensure_index_exists()

# Initialize python telegram bot
ptb = (
    Application.builder()
    .updater(None)
    .token(TELEGRAM_BOT_TOKEN)
    .read_timeout(7)
    .get_updates_read_timeout(42)
    .build()
)


@asynccontextmanager
async def lifespan(_: FastAPI):
    """Manage the application lifecycle."""
    # Webhook URL will be set by set_webhook.py
    async with ptb:
        await ptb.start()
        yield
        await ptb.stop()


# Initialize FastAPI app
app = FastAPI(title="Markdown Brain Bot", lifespan=lifespan)


@app.get("/")
async def root():
    """Health check endpoint."""
    return {"status": "ok", "bot": "Markdown Brain Bot"}


@app.post("/webhook")
async def process_update(request: Request):
    """Handle incoming Telegram updates via webhook."""
    try:
        req = await request.json()
        logger.info(f"Received update: {req}")
        update = Update.de_json(req, ptb.bot)
        await ptb.process_update(update)
        return Response(status_code=HTTPStatus.OK)
    except Exception as e:
        logger.error(f"Error processing webhook: {e}", exc_info=True)
        return Response(status_code=HTTPStatus.INTERNAL_SERVER_ERROR)


# Handler functions
async def start_command(update: Update, _: ContextTypes.DEFAULT_TYPE):
    """Handle the /start command."""
    welcome_message = (
        "🧠 Welcome to the Markdown Brain Bot!\n\n"
        "I'm your shared knowledge assistant. I can help you:\n\n"
        "• Create notes and lists\n"
        "• Add information to existing notes\n"
        "• Search and retrieve information\n\n"
        "Just send me a message with what you'd like to do!\n\n"
        "Examples:\n"
        '- "Create a shopping list with milk, eggs, and bread"\n'
        '- "Add coffee to the shopping list"\n'
        '- "What\'s on my shopping list?"\n'
        '- "Create a note about project ideas"\n'
        '- "Find all notes about projects"'
    )
    await update.message.reply_text(welcome_message)


async def help_command(update: Update, _: ContextTypes.DEFAULT_TYPE):
    """Handle the /help command."""
    help_message = (
        "📚 **How to use the Markdown Brain Bot**\n\n"
        "**Creating content:**\n"
        '• "Create a [type] about [topic]" - Creates a new note\n'
        '• "Make a list of [items]" - Creates a new list\n\n'
        "**Adding content:**\n"
        '• "Add [content] to [note name]" - Appends to existing note\n\n'
        "**Reading content:**\n"
        '• "What\'s in [note name]?" - Shows note content\n'
        '• "Show me [note name]" - Shows note content\n\n'
        "**Searching:**\n"
        '• "Find notes about [topic]" - Searches all notes\n'
        '• "Search for [keyword]" - Searches all content\n\n'
        "**Listing:**\n"
        '• "List all notes" - Shows all stored notes\n'
        '• "What notes do we have?" - Shows all stored notes'
    )
    await update.message.reply_text(help_message, parse_mode="Markdown")


async def handle_message(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Handle incoming text messages."""
    try:
        user_message = update.message.text
        chat_id = update.effective_chat.id

        logger.info(f"Received message from {chat_id}: {user_message}")

        # Show typing indicator
        await context.bot.send_chat_action(chat_id=chat_id, action="typing")

        # Process the message with LLM
        response = await process_message(user_message, str(chat_id))

        # Send the response
        await update.message.reply_text(response, parse_mode="Markdown")

    except Exception as e:
        logger.error(f"Error handling message: {e}")
        error_message = (
            "😔 Sorry, I encountered an error processing your message. "
            "Please try again or contact the administrator if the problem persists."
        )
        await update.message.reply_text(error_message)


# Register handlers
ptb.add_handler(CommandHandler("start", start_command))
ptb.add_handler(CommandHandler("help", help_command))
ptb.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, handle_message))


if __name__ == "__main__":
    # Run the FastAPI server
    uvicorn.run(app, host="0.0.0.0", port=8000)
