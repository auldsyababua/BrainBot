# \!/usr/bin/env python3
"""Test the BrainBot webhook directly."""

import sys
import time
import requests
from datetime import datetime

# Bot configuration
BOT_TOKEN = "7742923819:AAFjSv7DEOCC8oFRwhhvAjH_EEo8uhe7JK8"
WEBHOOK_URL = "https://brainbot-v76n.onrender.com/webhook"
API_BASE = f"https://api.telegram.org/bot{BOT_TOKEN}"


def log(message, level="INFO"):
    """Print timestamped log message."""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    print(f"[{timestamp}] {level}: {message}")


def check_bot_status():
    """Check bot and webhook status."""
    log("=" * 60)
    log("BrainBot Status Check")
    log("=" * 60)

    # Check bot info
    try:
        response = requests.get(f"{API_BASE}/getMe")
        data = response.json()
        if data.get("ok"):
            bot_info = data["result"]
            log(f"✅ Bot connected: @{bot_info['username']} ({bot_info['first_name']})")
        else:
            log(f"❌ Failed to get bot info: {data.get('description')}", "ERROR")
            return False
    except Exception as e:
        log(f"❌ Error getting bot info: {e}", "ERROR")
        return False

    # Check webhook status
    try:
        response = requests.get(f"{API_BASE}/getWebhookInfo")
        data = response.json()
        if data.get("ok"):
            info = data["result"]
            webhook_url = info.get("url", "")
            if webhook_url:
                log("\n📡 Webhook Configuration:")
                log(f"   URL: {webhook_url}")
                log(f"   Pending updates: {info.get('pending_update_count', 0)}")
                log(f"   Max connections: {info.get('max_connections', 40)}")
                log(f"   IP address: {info.get('ip_address', 'N/A')}")

                if info.get("last_error_message"):
                    log("\n⚠️ Last webhook error:")
                    log(f"   Message: {info['last_error_message']}")
                    log(
                        f"   Date: {datetime.fromtimestamp(info.get('last_error_date', 0))}"
                    )

                if info.get("last_synchronization_error_date"):
                    log("\n⚠️ Last sync error:")
                    log(
                        f"   Date: {datetime.fromtimestamp(info.get('last_synchronization_error_date', 0))}"
                    )

            else:
                log("❌ No webhook URL configured\!", "ERROR")
                return False
        else:
            log(f"❌ Failed to check webhook: {data.get('description')}", "ERROR")
            return False
    except Exception as e:
        log(f"❌ Error checking webhook: {e}", "ERROR")
        return False

    return True


def test_webhook_endpoint():
    """Test the webhook endpoint directly."""
    log("\n" + "=" * 60)
    log("Testing Webhook Endpoint")
    log("=" * 60)

    # Test if webhook endpoint is accessible
    log(f"\nTesting webhook URL: {WEBHOOK_URL}")

    try:
        # Test GET request (should return method not allowed or similar)
        response = requests.get(WEBHOOK_URL, timeout=10)
        log(f"GET request status: {response.status_code}")
        if response.status_code == 405:
            log("✅ Webhook endpoint exists (Method Not Allowed for GET is expected)")
        elif response.status_code == 200:
            log("✅ Webhook endpoint is accessible")
        else:
            log(f"⚠️ Unexpected status code: {response.status_code}", "WARNING")

    except requests.exceptions.Timeout:
        log("❌ Webhook endpoint timed out", "ERROR")
        return False
    except Exception as e:
        log(f"❌ Error testing webhook: {e}", "ERROR")
        return False

    # Test sending a mock update
    log("\nSending test update to webhook...")

    test_update = {
        "update_id": 999999999,
        "message": {
            "message_id": 1,
            "date": int(time.time()),
            "chat": {
                "id": -1,
                "type": "private",
                "first_name": "Test",
                "username": "test_user",
            },
            "from": {
                "id": -1,
                "is_bot": False,
                "first_name": "Test",
                "username": "test_user",
            },
            "text": "/test_webhook",
        },
    }

    try:
        headers = {
            "Content-Type": "application/json",
            "X-Telegram-Bot-Api-Secret-Token": BOT_TOKEN,  # Some bots check this
        }

        response = requests.post(
            WEBHOOK_URL, json=test_update, headers=headers, timeout=10
        )

        log(f"POST request status: {response.status_code}")

        if response.status_code == 200:
            log("✅ Webhook accepted the test update")
            if response.text:
                log(f"Response: {response.text[:200]}")
        elif response.status_code == 401:
            log("⚠️ Webhook requires authentication", "WARNING")
        elif response.status_code == 404:
            log("❌ Webhook endpoint not found", "ERROR")
        else:
            log(f"⚠️ Unexpected response: {response.status_code}", "WARNING")
            if response.text:
                log(f"Response body: {response.text[:200]}")

    except Exception as e:
        log(f"❌ Error sending test update: {e}", "ERROR")
        return False

    return True


def check_render_health():
    """Check if the Render service is healthy."""
    log("\n" + "=" * 60)
    log("Checking Render Service Health")
    log("=" * 60)

    # Extract base URL from webhook
    base_url = WEBHOOK_URL.replace("/webhook", "")

    # Common health check endpoints
    health_endpoints = ["/health", "/", "/api/health", "/status"]

    for endpoint in health_endpoints:
        url = base_url + endpoint
        log(f"\nChecking {url}...")

        try:
            response = requests.get(url, timeout=5)
            if response.status_code == 200:
                log(f"✅ {endpoint} is accessible (Status: {response.status_code})")
                if response.text and len(response.text) < 500:
                    log(f"Response: {response.text}")
                return True
            elif response.status_code == 404:
                log(f"❌ {endpoint} not found")
            else:
                log(f"⚠️ {endpoint} returned status: {response.status_code}")
        except Exception as e:
            log(f"❌ Error checking {endpoint}: {e}")

    return False


def main():
    """Main test execution."""
    try:
        # Check bot status
        if not check_bot_status():
            log("\n❌ Bot status check failed", "ERROR")
            return

        # Test webhook endpoint
        if not test_webhook_endpoint():
            log("\n❌ Webhook test failed", "ERROR")
            return

        # Check Render health
        check_render_health()

        log("\n" + "=" * 60)
        log("Test Summary")
        log("=" * 60)

        log("\n✅ Bot is configured and webhook is set")
        log("⚠️ To fully test the bot's functionality:")
        log("1. Send messages directly through Telegram to @TenNetZeroAssistantBot")
        log("2. Check Render logs at: https://dashboard.render.com")
        log("3. Monitor the webhook errors using this script periodically")

    except KeyboardInterrupt:
        log("\n\nTest interrupted by user", "WARNING")
        sys.exit(1)
    except Exception as e:
        log(f"\n❌ Test failed with error: {e}", "ERROR")
        sys.exit(1)


if __name__ == "__main__":
    main()
