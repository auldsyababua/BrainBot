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
from core.benchmarks import PerformanceMiddleware
from bot.handlers import (
    start_command,
    help_command,
    reset_command,
    continue_command,
    version_command,
    report_command,
    handle_message,
    handle_document,
    remember_command,
    correct_command,
    memories_command,
    forget_command,
    graph_command,
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
        self.application.add_handler(CommandHandler("report", report_command))

        # Memory commands
        self.application.add_handler(CommandHandler("remember", remember_command))
        self.application.add_handler(CommandHandler("correct", correct_command))
        self.application.add_handler(CommandHandler("memories", memories_command))
        self.application.add_handler(CommandHandler("forget", forget_command))
        self.application.add_handler(CommandHandler("graph", graph_command))

        # Message handlers
        self.application.add_handler(
            MessageHandler(filters.TEXT & ~filters.COMMAND, handle_message)
        )
        self.application.add_handler(
            MessageHandler(filters.Document.ALL, handle_document)
        )

        logger.info("Bot handlers registered successfully")

    def _create_fastapi_app(self) -> FastAPI:
        """Create FastAPI app for webhook mode."""

        @asynccontextmanager
        async def lifespan(_: FastAPI):
            """Manage the application lifecycle."""
            async with self.application:
                await self.application.start()
                
                # Seed initial memories if configured
                from src.core.memory import seed_initial_memories
                try:
                    await seed_initial_memories()
                    logger.info("Initial memories seeded successfully")
                except Exception as e:
                    logger.error(f"Failed to seed initial memories: {e}")
                
                yield
                await self.application.stop()

        # Initialize FastAPI app
        app = FastAPI(title="Markdown Brain Bot", lifespan=lifespan)

        # Add performance monitoring middleware
        perf_middleware = PerformanceMiddleware()
        app.middleware("http")(perf_middleware)

        @app.get("/")
        async def root():
            """Health check endpoint."""
            return {"status": "ok", "bot": "Markdown Brain Bot", "mode": "webhook"}

        @app.get("/metrics")
        async def get_metrics():
            """Get performance metrics summary."""
            from src.core.benchmarks import get_performance_monitor

            monitor = get_performance_monitor()

            # Get comprehensive performance summary
            summary = monitor.get_performance_summary(
                metric_names=[
                    "vector_search_duration",
                    "llm_call_duration",
                    "conversation_size",
                    "http_request_duration",
                    "benchmark_process_message",
                ],
                time_range_minutes=60,
            )

            return {
                "status": "ok",
                "metrics": summary,
                "description": {
                    "cache_hit_rate": "Percentage of vector searches served from cache",
                    "total_tokens_used": "Total OpenAI API tokens consumed",
                    "vector_search_duration": "Time taken for vector searches (seconds)",
                    "llm_call_duration": "Time taken for LLM API calls (seconds)",
                    "conversation_size": "Number of messages in conversations",
                    "http_request_duration": "Time taken for HTTP requests (seconds)",
                },
            }

        @app.post("/webhook")
        async def process_update(request: Request):
            """Handle incoming Telegram updates via webhook."""
            logger.info("🔄 Webhook endpoint called")
            try:
                logger.info("📋 Getting JSON from request")
                req = await request.json()
                logger.info(
                    f"📥 Received webhook update: {req.get('message', {}).get('text', 'Non-text update')}"
                )

                logger.info("🔧 Creating Update object from JSON")
                # Create Update object
                update = Update.de_json(req, self.application.bot)
                if not update:
                    logger.error("❌ Failed to deserialize update")
                    return Response(status_code=HTTPStatus.BAD_REQUEST)

                logger.info(f"🎯 Processing update ID: {update.update_id}")

                # Process the update
                logger.info("⚡ Calling application.process_update")
                await self.application.process_update(update)

                logger.info("✅ Update processed successfully")
                return Response(status_code=HTTPStatus.OK)
            except Exception as e:
                logger.error(f"💥 Error processing webhook: {e}", exc_info=True)
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
