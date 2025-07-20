#!/usr/bin/env python3
"""
🔗 Webhook Telegram Bot - Production-ready webhook architecture

This module implements a webhook-only bot architecture for production use.
For local development, use the local development simulator (scripts/local_dev.py).

Features:
- FastAPI webhook server
- Proper async/await handling
- Health check endpoints
- Production-ready logging
- Clean handler separation

Usage:
    from bot.webhook_bot import WebhookTelegramBot
    
    bot = WebhookTelegramBot()
    app = bot.get_fastapi_app()
    # Run with uvicorn
"""

import logging
from contextlib import asynccontextmanager
from http import HTTPStatus

from fastapi import FastAPI, Request, Response
from telegram import Update
from telegram.ext import (
    Application,
    CommandHandler,
    MessageHandler,
    filters,
)

from core.config import TELEGRAM_BOT_TOKEN
from bot.handlers import (
    start_command,
    help_command,
    reset_command,
    continue_command,
    version_command,
    handle_message,
    handle_document,
)

# Set up logging
logger = logging.getLogger(__name__)


class WebhookTelegramBot:
    """
    Webhook-only Telegram bot for production use.
    
    This bot is designed to run as a FastAPI webhook server and does not support
    polling mode. For local development, use the local development simulator
    at scripts/local_dev.py instead.
    """

    def __init__(self):
        """
        Initialize the webhook bot.
        """
        logger.info("Initializing Webhook Telegram Bot")
        
        # Initialize the application with webhook configuration
        self.application = (
            Application.builder()
            .updater(None)  # Disable updater for webhook mode
            .token(TELEGRAM_BOT_TOKEN)
            .read_timeout(7)
            .get_updates_read_timeout(42)
            .build()
        )
        
        # Register handlers
        self._register_handlers()
        
        # Initialize FastAPI app
        self.app = self._create_fastapi_app()

    def _register_handlers(self):
        """Register all bot handlers."""
        # Command handlers
        self.application.add_handler(CommandHandler("start", start_command))
        self.application.add_handler(CommandHandler("help", help_command))
        self.application.add_handler(CommandHandler("reset", reset_command))
        self.application.add_handler(CommandHandler("continue", continue_command))
        self.application.add_handler(CommandHandler("version", version_command))
        
        # Message handlers
        self.application.add_handler(
            MessageHandler(filters.TEXT & ~filters.COMMAND, handle_message)
        )
        self.application.add_handler(MessageHandler(filters.Document.ALL, handle_document))
        
        logger.info("Bot handlers registered successfully")

    def _create_fastapi_app(self) -> FastAPI:
        """Create FastAPI app for webhook mode."""
        @asynccontextmanager
        async def lifespan(_: FastAPI):
            """Manage the application lifecycle."""
            async with self.application:
                await self.application.start()
                yield
                await self.application.stop()

        # Initialize FastAPI app
        app = FastAPI(title="Markdown Brain Bot", lifespan=lifespan)

        @app.get("/")
        async def root():
            """Health check endpoint."""
            return {"status": "ok", "bot": "Markdown Brain Bot", "mode": "webhook"}

        @app.post("/webhook")
        async def process_update(request: Request):
            """Handle incoming Telegram updates via webhook."""
            try:
                req = await request.json()
                logger.info(f"📥 Received webhook update: {req.get('message', {}).get('text', 'Non-text update')}")
                update = Update.de_json(req, self.application.bot)
                await self.application.process_update(update)
                return Response(status_code=HTTPStatus.OK)
            except Exception as e:
                logger.error(f"Error processing webhook: {e}", exc_info=True)
                return Response(status_code=HTTPStatus.INTERNAL_SERVER_ERROR)

        return app

    def get_fastapi_app(self) -> FastAPI:
        """Get the FastAPI app for webhook server."""
        return self.app


# Convenience function for quick bot creation
def create_webhook_bot() -> WebhookTelegramBot:
    """
    Create a webhook bot instance.
    
    Returns:
        WebhookTelegramBot instance
    """
    return WebhookTelegramBot()
