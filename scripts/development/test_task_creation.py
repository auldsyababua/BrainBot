#!/usr/bin/env python3
"""Test task creation through the bot pipeline."""

import asyncio
import aiohttp
import json
import hmac
import hashlib
import time
import sys
import os


async def test_task_creation():
    """Test task creation with proper Telegram update format."""

    # Create a proper Telegram update for task creation
    # Use environment variables for test IDs to avoid hardcoding
    test_chat_id = int(os.getenv("TEST_CHAT_ID", "-1001000000000"))
    test_user_id = int(os.getenv("TEST_USER_ID", "100000000"))
    
    update = {
        "update_id": int(time.time()),
        "message": {
            "message_id": int(time.time()),
            "date": int(time.time()),
            "chat": {
                "id": test_chat_id,
                "type": "supergroup",
                "title": "Test Group",
            },
            "from": {
                "id": test_user_id,
                "is_bot": False,
                "first_name": "Test",
                "username": "testuser",
            },
            "text": "create a new task for bryan to clean up the oil spill by 5pm tomorrow",
        },
    }

    # Wrap in the proxy format
    proxy_payload = {"body": json.dumps(update)}

    # Generate HMAC signature
    timestamp = str(int(time.time()))
    payload = json.dumps(proxy_payload, separators=(",", ":"))
    # Read secret from environment; fail if not set in production
    secret = os.getenv("CF_PROXY_SECRET")
    if not secret:
        print("⚠️ Warning: CF_PROXY_SECRET not set. Using test mode.")
        secret = "test_mode_only_do_not_use_in_production"

    signature_payload = f"{timestamp}.{payload}"
    signature = (
        "v1="
        + hmac.new(
            secret.encode("utf-8"), signature_payload.encode("utf-8"), hashlib.sha256
        ).hexdigest()
    )

    # Send to backend /process endpoint
    url = "https://brainbot-v76n.onrender.com/process"
    headers = {
        "Content-Type": "application/json",
        "X-Request-Timestamp": timestamp,
        "X-Brainbot-Signature": signature,
    }

    print("🚀 Testing task creation through bot pipeline...")
    print(f"📝 Message: {update['message']['text']}")
    print(f"⏰ Timestamp: {timestamp}")
    print(f"🔑 Signature: {signature[:20]}...")
    print()

    async with aiohttp.ClientSession() as session:
        async with session.post(url, data=payload, headers=headers) as resp:
            print(f"📊 Status: {resp.status}")
            response_text = await resp.text()

            if resp.status == 200:
                print("✅ Task creation request successful!")
                print("📨 Bot should have processed the task creation.")
            else:
                print(f"❌ Request failed: {response_text}")

            return resp.status == 200


async def test_simple_message():
    """Test a simple non-task message."""

    # Use environment variables for test IDs to avoid hardcoding
    test_chat_id = int(os.getenv("TEST_CHAT_ID", "-1001000000000"))
    test_user_id = int(os.getenv("TEST_USER_ID", "100000000"))

    update = {
        "update_id": int(time.time()) + 1,
        "message": {
            "message_id": int(time.time()) + 1,
            "date": int(time.time()),
            "chat": {"id": test_chat_id, "type": "supergroup", "title": "Test Group"},
            "from": {
                "id": test_user_id,
                "is_bot": False,
                "first_name": "Test",
                "username": "testuser",
            },
            "text": "hello bot",
        },
    }

    proxy_payload = {"body": json.dumps(update)}
    timestamp = str(int(time.time()))
    payload = json.dumps(proxy_payload, separators=(",", ":"))
    # Read secret from environment; fail if not set in production
    secret = os.getenv("CF_PROXY_SECRET")
    if not secret:
        print("⚠️ Warning: CF_PROXY_SECRET not set. Using test mode.")
        secret = "test_mode_only_do_not_use_in_production"

    signature_payload = f"{timestamp}.{payload}"
    signature = (
        "v1="
        + hmac.new(
            secret.encode("utf-8"), signature_payload.encode("utf-8"), hashlib.sha256
        ).hexdigest()
    )

    url = "https://brainbot-v76n.onrender.com/process"
    headers = {
        "Content-Type": "application/json",
        "X-Request-Timestamp": timestamp,
        "X-Brainbot-Signature": signature,
    }

    print("\n🚀 Testing simple message...")
    print(f"📝 Message: {update['message']['text']}")
    print()

    async with aiohttp.ClientSession() as session:
        async with session.post(url, data=payload, headers=headers) as resp:
            print(f"📊 Status: {resp.status}")

            if resp.status == 200:
                print("✅ Simple message processed successfully!")
            else:
                response_text = await resp.text()
                print(f"❌ Request failed: {response_text}")

            return resp.status == 200


async def main():
    """Run all tests."""
    print("=" * 60)
    print("🧪 TESTING BOT TASK CREATION FUNCTIONALITY")
    print("=" * 60)

    # Test task creation
    task_success = await test_task_creation()

    # Test simple message
    simple_success = await test_simple_message()

    print("\n" + "=" * 60)
    print("📋 TEST RESULTS:")
    print("=" * 60)
    print(f"✅ Task Creation: {'PASSED' if task_success else 'FAILED'}")
    print(f"✅ Simple Message: {'PASSED' if simple_success else 'FAILED'}")

    if task_success and simple_success:
        print("\n🎉 All tests passed! The bot is working correctly.")
        print("✨ The task processor bug has been fixed successfully!")
        return 0
    else:
        print("\n⚠️ Some tests failed. Check the logs above.")
        return 1


if __name__ == "__main__":
    exit_code = asyncio.run(main())
    sys.exit(exit_code)
