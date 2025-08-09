#!/usr/bin/env python3
"""
🚀 Markdown Brain Bot - Main Entry Point

This is the primary entry point for the Markdown Brain Bot.

Mode Selection:
- For local development: Use `python scripts/local_dev.py` (interactive simulator)
- For production: This file runs the FastAPI webhook server

The bot now uses a webhook-only architecture for better performance,
scalability, and production reliability.

Production Usage (Render, etc.):
    python main.py

Local Development:
    python scripts/local_dev.py
"""

import logging
import os
import sys

# Add src to Python path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "src"))

# These imports must come after the path setup
import uvicorn  # noqa: E402
from bot.webhook_bot import create_webhook_bot  # noqa: E402
from core.config import TELEGRAM_BOT_TOKEN  # noqa: E402
from core.config import TELEGRAM_WEBHOOK_SECRET  # noqa: E402
from core.supabase_logger import setup_supabase_logging  # noqa: E402

# Set up logging
logging.basicConfig(
    format="%(asctime)s - %(name)s - %(levelname)s - %(message)s", level=logging.INFO
)
logger = logging.getLogger(__name__)

# Set up Supabase logging for real-time access
try:
    supabase_handler = setup_supabase_logging(level=logging.INFO)
    logger.info("✅ Supabase logging enabled - logs available for real-time queries")
except Exception as e:
    logger.warning(f"Could not enable Supabase logging: {e}")


def set_webhook():
    """Set webhook URL on startup for production deployment."""
    import requests

    # Get service URL from environment (Render sets this automatically)
    service_url = os.getenv("RENDER_EXTERNAL_URL")
    if not service_url:
        logger.warning("RENDER_EXTERNAL_URL not set - assuming local development")
        return True  # Don't fail in local development

    webhook_url = f"{service_url}/webhook"

    # Set webhook
    url = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/setWebhook"
    # Include secret token if configured for request validation
    data = {"url": webhook_url}
    if TELEGRAM_WEBHOOK_SECRET:
        data["secret_token"] = TELEGRAM_WEBHOOK_SECRET

    try:
        response = requests.post(url, json=data, timeout=10)
        result = response.json()

        if result.get("ok"):
            logger.info(f"✅ Webhook set successfully to: {webhook_url}")
            return True
        else:
            logger.error(f"❌ Failed to set webhook: {result}")
            return False
    except Exception as e:
        logger.error(f"❌ Error setting webhook: {e}")
        return False


def main():
    """Main entry point."""
    logger.info("🧠 Starting Markdown Brain Bot...")

    # Create the webhook bot
    bot = create_webhook_bot()
    app = bot.get_fastapi_app()

    # Set webhook for production (if RENDER_EXTERNAL_URL is available)
    if not set_webhook():
        logger.warning("Webhook setup failed, but continuing anyway...")

    # Get port from environment (Render sets this)
    port = int(os.getenv("PORT", 8000))

    logger.info(f"🚀 Starting FastAPI webhook server on port {port}")
    logger.info("🔗 Ready to receive webhook updates from Telegram")

    # Run the FastAPI server
    uvicorn.run(app, host="0.0.0.0", port=port)


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        logger.info("👋 Bot stopped by user")
    except Exception as e:
        logger.error(f"Unexpected error: {e}", exc_info=True)
        sys.exit(1)
