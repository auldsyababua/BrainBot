#!/usr/bin/env python3
"""
🏭 PRODUCTION WEBHOOK SERVER - This is the main entry point for production on Render!

This FastAPI server receives webhook events from Telegram and processes them.
DO NOT use this for local development - use run_bot.py instead.

Render runs this automatically with: python webhook_server.py
"""

import os
import sys
import logging

# Add src to Python path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "src"))

import uvicorn  # noqa: E402

from bot.webhook_bot import create_webhook_bot  # noqa: E402
from core.config import TELEGRAM_BOT_TOKEN  # noqa: E402

# Set up logging
logging.basicConfig(
    format="%(asctime)s - %(name)s - %(levelname)s - %(message)s", level=logging.INFO
)
logger = logging.getLogger(__name__)


def set_webhook():
    """Set webhook URL on startup"""
    import requests

    # Get Render service URL from environment
    render_service_url = os.getenv("RENDER_EXTERNAL_URL")
    if not render_service_url:
        logger.error("RENDER_EXTERNAL_URL not set!")
        return False

    webhook_url = f"{render_service_url}/webhook"

    # Set webhook
    url = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/setWebhook"
    data = {"url": webhook_url}

    response = requests.post(url, json=data)
    result = response.json()

    if result.get("ok"):
        logger.info(f"✅ Webhook set successfully to: {webhook_url}")
        return True
    else:
        logger.error(f"❌ Failed to set webhook: {result}")
        return False


if __name__ == "__main__":
    # Create the webhook bot
    bot = create_webhook_bot()
    app = bot.get_fastapi_app()

    # Set webhook on startup
    if set_webhook():
        # Run the FastAPI server
        port = int(os.getenv("PORT", 10000))
        uvicorn.run(app, host="0.0.0.0", port=port)
    else:
        logger.error("Failed to set webhook, exiting...")
        sys.exit(1)
