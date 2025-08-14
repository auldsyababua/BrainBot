#!/usr/bin/env python3
"""
Set Telegram webhook for local testing with ngrok.
"""

import sys

import requests

from src.core.config import TELEGRAM_BOT_TOKEN, TELEGRAM_WEBHOOK_SECRET

if len(sys.argv) != 2:
    print("Usage: python set_webhook.py <ngrok_url>")
    print("Example: python set_webhook.py https://abc123.ngrok.io")
    sys.exit(1)

ngrok_url = sys.argv[1]
webhook_url = f"{ngrok_url}/webhook"

# Set webhook
url = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/setWebhook"
data = {"url": webhook_url}
if TELEGRAM_WEBHOOK_SECRET:
    data["secret_token"] = TELEGRAM_WEBHOOK_SECRET

response = requests.post(url, json=data)
result = response.json()

if result.get("ok"):
    print(f"✅ Webhook set successfully to: {webhook_url}")
    print("\nYour bot is now ready to receive messages!")
    print("\nBot username: @YourBotName")
    print("\nTry sending these messages to your bot:")
    print("  - /start")
    print("  - Create a shopping list")
    print("  - What notes do we have?")
else:
    print(f"❌ Failed to set webhook: {result}")

# Get webhook info
info_url = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/getWebhookInfo"
info_response = requests.get(info_url)
info = info_response.json()

if info.get("ok"):
    print(f"\nWebhook info: {info['result']}")
