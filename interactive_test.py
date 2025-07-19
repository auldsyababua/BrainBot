#!/usr/bin/env python3
"""
Interactive testing script - simulates Telegram messages locally.
"""

from llm import process_message
from tools import ensure_index_exists, list_all_files

# Ensure index exists
ensure_index_exists()

print("🧠 Markdown Brain Bot - Interactive Test Mode")
print("Type 'quit' to exit, 'list' to see all files\n")

while True:
    try:
        user_input = input("💬 You: ").strip()

        if user_input.lower() == "quit":
            print("Goodbye!")
            break

        if user_input.lower() == "list":
            files = list_all_files()
            if files:
                print("\n📂 Current files:")
                for file in files:
                    print(f"  - {file['title']} ({file['path']})")
            else:
                print("\nNo files yet.")
            print()
            continue

        if user_input:
            print("\n🤖 Bot: ", end="")
            response = process_message(user_input)
            print(response)
            print()

    except KeyboardInterrupt:
        print("\n\nGoodbye!")
        break
    except Exception as e:
        print(f"\n❌ Error: {e}\n")
