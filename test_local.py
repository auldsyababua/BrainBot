#!/usr/bin/env python3
"""
Local testing script for the Markdown Brain Bot.
Tests the core functionality without needing Telegram.
"""

import asyncio
from llm import process_message
from tools import ensure_index_exists, list_all_files

# Test cases
test_messages = [
    "Create a shopping list with milk, eggs, and bread",
    "Add butter to the shopping list",
    "What's on the shopping list?",
    "Create a note about team meeting tomorrow at 3pm",
    "Find all notes about shopping",
    "List all notes",
]


async def test_bot():
    print("🧪 Testing Markdown Brain Bot locally...\n")

    # Ensure index exists
    ensure_index_exists()
    print("✅ Index file initialized\n")

    # Run test messages
    for i, message in enumerate(test_messages, 1):
        print(f"Test {i}: {message}")
        print("-" * 50)

        try:
            response = process_message(message)
            print(f"Response: {response}\n")
        except Exception as e:
            print(f"❌ Error: {e}\n")

        # Small delay between tests
        await asyncio.sleep(1)

    # Show final state
    print("\n📂 Final file list:")
    files = list_all_files()
    for file in files:
        print(f"  - {file['title']} ({file['path']})")


if __name__ == "__main__":
    asyncio.run(test_bot())
