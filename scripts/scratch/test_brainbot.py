# \!/usr/bin/env python3
"""Test the BrainBot by sending messages and checking responses."""

import sys
import time
import requests
from datetime import datetime

# Bot configuration
BOT_TOKEN = "7742923819:AAFjSv7DEOCC8oFRwhhvAjH_EEo8uhe7JK8"
BOT_USERNAME = "@TenNetZeroAssistantBot"
API_BASE = f"https://api.telegram.org/bot{BOT_TOKEN}"


def log(message, level="INFO"):
    """Print timestamped log message."""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    print(f"[{timestamp}] {level}: {message}")


def get_bot_info():
    """Get basic bot information."""
    try:
        response = requests.get(f"{API_BASE}/getMe")
        data = response.json()
        if data.get("ok"):
            bot_info = data["result"]
            log(f"✅ Bot connected: @{bot_info['username']} ({bot_info['first_name']})")
            return bot_info
        else:
            log(f"❌ Failed to get bot info: {data.get('description')}", "ERROR")
            return None
    except Exception as e:
        log(f"❌ Error getting bot info: {e}", "ERROR")
        return None


def check_webhook():
    """Check current webhook configuration."""
    try:
        response = requests.get(f"{API_BASE}/getWebhookInfo")
        data = response.json()
        if data.get("ok"):
            info = data["result"]
            webhook_url = info.get("url", "")
            if webhook_url:
                log(f"📡 Webhook URL: {webhook_url}")
                log(f"   Pending updates: {info.get('pending_update_count', 0)}")
                if info.get("last_error_message"):
                    log(f"   ⚠️ Last error: {info['last_error_message']}", "WARNING")
                return True
            else:
                log("❌ No webhook URL configured", "WARNING")
                return False
        else:
            log(f"❌ Failed to check webhook: {data.get('description')}", "ERROR")
            return False
    except Exception as e:
        log(f"❌ Error checking webhook: {e}", "ERROR")
        return False


def get_updates(offset=None):
    """Get updates using long polling (for testing without webhook)."""
    try:
        params = {"timeout": 5}
        if offset:
            params["offset"] = offset

        response = requests.get(f"{API_BASE}/getUpdates", params=params, timeout=10)
        data = response.json()

        if data.get("ok"):
            return data.get("result", [])
        else:
            log(f"Failed to get updates: {data.get('description')}", "ERROR")
            return []
    except Exception as e:
        log(f"Error getting updates: {e}", "ERROR")
        return []


def send_message(chat_id, text):
    """Send a message to a specific chat."""
    try:
        payload = {"chat_id": chat_id, "text": text}
        response = requests.post(f"{API_BASE}/sendMessage", json=payload)
        data = response.json()

        if data.get("ok"):
            log("✅ Message sent successfully")
            return data["result"]
        else:
            log(f"❌ Failed to send message: {data.get('description')}", "ERROR")
            return None
    except Exception as e:
        log(f"❌ Error sending message: {e}", "ERROR")
        return None


def test_bot_response():
    """Test the bot by sending messages and checking responses."""
    log("=" * 60)
    log("Starting BrainBot Test")
    log("=" * 60)

    # Step 1: Check bot info
    bot_info = get_bot_info()
    if not bot_info:
        log("Cannot proceed without bot connection", "ERROR")
        return False

    # Step 2: Check webhook status
    log("\nChecking webhook configuration...")
    has_webhook = check_webhook()

    if has_webhook:
        log("⚠️ Bot has webhook configured. Testing via webhook is limited.", "WARNING")
        log("For full testing, you may need to:")
        log("1. Send messages directly through Telegram app")
        log("2. Or temporarily disable webhook for polling tests")

    # Step 3: Try to get recent updates to find a chat to test with
    log("\nChecking for recent updates...")
    updates = get_updates()

    test_chat_id = None
    if updates:
        for update in updates:
            if "message" in update:
                test_chat_id = update["message"]["chat"]["id"]
                chat_info = update["message"]["chat"]
                log(
                    f"Found chat: {chat_info.get('first_name', 'Unknown')} (ID: {test_chat_id})"
                )
                break

    if not test_chat_id:
        log("⚠️ No recent chats found. Cannot send test messages.", "WARNING")
        log(
            "Please send a message to the bot first through Telegram, then run this test again."
        )
        return False

    # Step 4: Send test messages
    log("\n" + "=" * 60)
    log("Sending test messages...")
    log("=" * 60)

    test_messages = [
        ("/start", "Testing /start command"),
        ("/help", "Testing /help command"),
        ("/version", "Testing /version command"),
        ("create new test list", "Testing list creation"),
        ("add item1, item2, item3 to test list", "Testing adding items"),
        ("/lists", "Testing interactive lists"),
        ("@colin create task to test bot", "Testing task creation with user mention"),
        (
            "new field report for Test Site: All systems operational",
            "Testing field report",
        ),
        ("/reset", "Testing reset command"),
    ]

    for message, description in test_messages:
        log(f"\n{description}")
        log(f"Sending: '{message}'")

        result = send_message(test_chat_id, message)
        if result:
            log(f"Message ID: {result['message_id']}")

        # Wait a bit for processing
        time.sleep(2)

        # Check for responses
        log("Checking for bot response...")
        updates = get_updates()

        response_found = False
        for update in updates[-5:]:  # Check last 5 updates
            if "message" in update:
                msg = update["message"]
                if msg.get("from", {}).get("is_bot"):
                    log(f"🤖 Bot response: {msg.get('text', '')[:100]}...")
                    response_found = True
                    break

        if not response_found:
            log("⚠️ No immediate response detected", "WARNING")

    log("\n" + "=" * 60)
    log("Test completed\!")
    log("=" * 60)

    return True


def main():
    """Main test execution."""
    try:
        success = test_bot_response()

        if success:
            log("\n✅ Test execution completed successfully")
        else:
            log("\n⚠️ Test execution completed with warnings")

    except KeyboardInterrupt:
        log("\n\nTest interrupted by user", "WARNING")
        sys.exit(1)
    except Exception as e:
        log(f"\n❌ Test failed with error: {e}", "ERROR")
        sys.exit(1)


if __name__ == "__main__":
    main()
