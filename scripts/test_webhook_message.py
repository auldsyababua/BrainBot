#!/usr/bin/env python3
"""Send a test message directly to the webhook to simulate Telegram."""

import requests
import time

# Webhook URL
WEBHOOK_URL = "https://brainbot-v76n.onrender.com/webhook"

# Create a fake Telegram update that looks like Colin's message
fake_update = {
    "update_id": int(time.time()),
    "message": {
        "message_id": 999,
        "from": {
            "id": 5751758169,  # Colin's actual user ID
            "is_bot": False,
            "first_name": "Colin Aulds | 10NetZero.com",
            "username": "Colin_10NetZero",
            "language_code": "en",
        },
        "chat": {
            "id": 5751758169,
            "first_name": "Colin Aulds | 10NetZero.com",
            "username": "Colin_10NetZero",
            "type": "private",
        },
        "date": int(time.time()),
        "text": "/start",
    },
}

print("🚀 Sending test message to webhook...")
print(f"📍 URL: {WEBHOOK_URL}")
print("👤 User: Colin_10NetZero (ID: 5751758169)")
print("💬 Message: /start")
print("-" * 50)

try:
    response = requests.post(
        WEBHOOK_URL,
        json=fake_update,
        headers={"Content-Type": "application/json"},
        timeout=10,
    )

    print(f"📡 Response Status: {response.status_code}")
    print(f"📄 Response Headers: {dict(response.headers)}")

    if response.text:
        print(f"📝 Response Body: {response.text}")

    if response.status_code == 200:
        print("\n✅ Webhook accepted the message!")
        print("Check Render logs to see if it was processed correctly.")
    else:
        print(f"\n❌ Webhook returned error: {response.status_code}")

except requests.exceptions.Timeout:
    print("⏱️ Request timed out - webhook might be processing slowly")
except Exception as e:
    print(f"❌ Error: {e}")
