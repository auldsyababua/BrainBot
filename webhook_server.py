#!/usr/bin/env python3
"""
Webhook server for Render deployment.
Handles incoming Telegram updates via webhooks.
"""

import os
import sys
import logging

# Add src to Python path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "src"))

import uvicorn  # noqa: E402

from bot.main_webhook import app  # noqa: E402
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
    # Set webhook on startup
    if set_webhook():
        # Run the FastAPI server
        port = int(os.getenv("PORT", 10000))
        uvicorn.run(app, host="0.0.0.0", port=port)
    else:
        logger.error("Failed to set webhook, exiting...")
        sys.exit(1)
