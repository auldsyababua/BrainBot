#!/usr/bin/env python3
"""
Simple polling version for testing the bot locally.
"""

import logging
from telegram import Update
from telegram.ext import (
    Application,
    CommandHandler,
    MessageHandler,
    filters,
    ContextTypes,
)
import os
import tempfile

from core.config import TELEGRAM_BOT_TOKEN
from core.llm import process_message
from core.tools import ensure_index_exists, create_file
from storage.vector_store import vector_store
from core.version import VERSION, LATEST_CHANGES

# Set up logging
logging.basicConfig(
    format="%(asctime)s - %(name)s - %(levelname)s - %(message)s", level=logging.INFO
)
logger = logging.getLogger(__name__)

# Ensure index exists on startup
ensure_index_exists()


# Handler functions
async def start_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Handle the /start command."""
    welcome_message = (
        "🧠 Welcome to the Markdown Brain Bot!\n\n"
        "I'm your shared knowledge assistant. I can help you:\n\n"
        "• Create notes and lists\n"
        "• Add information to existing notes\n"
        "• Search and retrieve information\n\n"
        "**Available Commands:**\n"
        "• /start - Show this welcome message\n"
        "• /help - Show detailed help and examples\n"
        "• /reset - Start a new conversation (clears memory)\n"
        "• /continue - Restore previous conversation\n"
        "• /version - Show bot version and diagnostics\n\n"
        "Just send me a message with what you'd like to do!\n\n"
        "Examples:\n"
        '- "Create a shopping list with milk, eggs, and bread"\n'
        '- "Add coffee to the shopping list"\n'
        '- "What\'s on my shopping list?"\n'
        '- "Tell me what kind of GPU I have"\n'
        '- "Find all notes about projects"'
    )
    await update.message.reply_text(welcome_message)


async def help_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
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
        '• "What notes do we have?" - Shows all stored notes\n\n'
        "**Commands:**\n"
        "• /start - Welcome message\n"
        "• /help - Show this help\n"
        "• /reset - Start a new conversation\n"
        "• /continue - Restore previous conversation"
    )
    await update.message.reply_text(help_message, parse_mode="Markdown")


async def reset_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Handle the /reset command to start a new conversation."""
    chat_id = str(update.effective_chat.id)

    # Import the reset function from llm
    from src.core.llm import reset_conversation

    # Reset conversation for this chat
    await reset_conversation(chat_id)

    await update.message.reply_text(
        "🔄 Conversation reset! I've cleared my memory of our previous messages. "
        "Let's start fresh! How can I help you?"
    )


async def continue_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Handle the /continue command to restore previous conversation."""
    chat_id = str(update.effective_chat.id)

    # Import the restore function from llm
    from src.core.llm import restore_conversation

    # Try to restore conversation for this chat
    if await restore_conversation(chat_id):
        await update.message.reply_text(
            "✅ Previous conversation restored! I remember what we were talking about. "
            "You can continue where we left off."
        )
    else:
        await update.message.reply_text(
            "❌ No previous conversation found to restore. "
            "We're already in a fresh conversation!"
        )


async def version_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Handle the /version command to show bot version and capabilities."""
    version_message = (
        f"🤖 **Markdown Brain Bot v{VERSION}**\n\n" "**Latest Changes:**\n"
    )

    for change in LATEST_CHANGES:
        version_message += f"• {change}\n"

    version_message += (
        "\n**Diagnostic Info:**\n"
        f"• Vector search: {'✅ Enabled' if vector_store else '❌ Disabled'}\n"
        f"• Search method: Full document retrieval\n"
        f"• Chunk size: 1000 chars with 200 char overlap\n"
        "\nIf I'm not finding your documents, please ask your admin to:\n"
        "1. Check the vector store migration\n"
        "2. Run: `python diagnose_vector.py`"
    )

    await update.message.reply_text(version_message)


async def handle_message(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Handle incoming text messages."""
    try:
        user_message = update.message.text
        chat_id = update.effective_chat.id

        logger.info(f"Received message from {chat_id}: {user_message}")

        # Show typing indicator
        await context.bot.send_chat_action(chat_id=chat_id, action="typing")

        # Process the message with LLM (pass chat_id for conversation memory)
        response = await process_message(user_message, str(chat_id))

        # Send the response
        await update.message.reply_text(response, parse_mode="Markdown")

    except Exception as e:
        logger.error(f"Error handling message: {e}")
        error_message = (
            "😔 Sorry, I encountered an error processing your message. "
            "Please try again or contact the administrator if the problem persists.\n\n"
            "💡 Tip: Use /help to see available commands and examples."
        )
        await update.message.reply_text(error_message)


async def handle_document(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Handle incoming document files."""
    try:
        document = update.message.document
        chat_id = update.effective_chat.id

        # Check if it's a markdown file
        if document.file_name and (
            document.file_name.endswith(".md")
            or document.file_name.endswith(".markdown")
        ):
            logger.info(f"Received markdown file from {chat_id}: {document.file_name}")

            # Show typing indicator
            await context.bot.send_chat_action(chat_id=chat_id, action="typing")

            # Download the file
            file = await context.bot.get_file(document.file_id)

            # Create temporary file to store the content
            with tempfile.NamedTemporaryFile(
                mode="w+", suffix=".md", delete=False
            ) as tmp_file:
                await file.download_to_drive(tmp_file.name)
                tmp_file_path = tmp_file.name

            # Read the file content
            with open(tmp_file_path, "r", encoding="utf-8") as f:
                content = f.read()

            # Clean up temp file
            os.unlink(tmp_file_path)

            # Extract title from filename (remove extension)
            title = os.path.splitext(document.file_name)[0]

            # Determine if this should go in a specific folder based on the filename
            folder = None
            if "network" in title.lower() or "infrastructure" in title.lower():
                folder = "hardware"
            elif "config" in title.lower() or "setup" in title.lower():
                folder = "development"

            # Create the file
            file_path = create_file(
                title=title,
                content=content,
                folder=folder,
                doc_type="note",
                tags=["imported", "telegram-attachment"],
            )

            # Store in vector database for semantic search
            doc_id = file_path.replace("/", "_").replace(".md", "")
            metadata = {
                "title": title,
                "type": "note",
                "tags": ["imported", "telegram-attachment"],
                "folder": folder or "root",
                "file_path": file_path,
                "source": "telegram-upload",
            }
            await vector_store.embed_and_store(doc_id, content, metadata)

            # Let the LLM know about the imported file
            llm_message = f"I just imported a markdown file called '{document.file_name}' to {file_path}. The file contains:\n\n{content[:500]}..."
            llm_response = await process_message(llm_message, str(chat_id))

            response = f"✅ Successfully imported '{document.file_name}' to {file_path}\n\n{llm_response}"
            await update.message.reply_text(response)

        else:
            await update.message.reply_text(
                "📎 I can only process markdown files (.md or .markdown). "
                "Please send a markdown file to import it into the knowledge base."
            )

    except Exception as e:
        logger.error(f"Error handling document: {e}")
        error_message = (
            "😔 Sorry, I encountered an error processing your file. "
            "Please try again or contact the administrator if the problem persists."
        )
        await update.message.reply_text(error_message)


def main():
    """Start the bot."""
    logger.info("Starting Telegram bot with polling...")

    # Create the Application
    application = Application.builder().token(TELEGRAM_BOT_TOKEN).build()

    # Register handlers
    application.add_handler(CommandHandler("start", start_command))
    application.add_handler(CommandHandler("help", help_command))
    application.add_handler(CommandHandler("reset", reset_command))
    application.add_handler(CommandHandler("continue", continue_command))
    application.add_handler(CommandHandler("version", version_command))
    application.add_handler(
        MessageHandler(filters.TEXT & ~filters.COMMAND, handle_message)
    )
    application.add_handler(MessageHandler(filters.Document.ALL, handle_document))

    # Run the bot until the user presses Ctrl-C
    logger.info("Bot is polling for updates...")
    application.run_polling(allowed_updates=Update.ALL_TYPES)


if __name__ == "__main__":
    main()
