#!/usr/bin/env python3
"""
⚠️ LEGACY FILE - This was used for polling mode on Render (OLD ARCHITECTURE)

DO NOT USE THIS FILE! It's kept for reference only.
- For local development: use run_bot.py
- For production: use webhook_server.py

This file should be renamed to legacy_polling_entry.py to avoid confusion.
"""
import subprocess
import sys
import os

if __name__ == "__main__":
    print("Starting BrainBot in polling mode for Render...")
    # Update Python path to include src directory
    sys.path.insert(0, os.path.join(os.path.dirname(__file__), "src"))
    sys.exit(subprocess.call([sys.executable, "src/bot/main_polling.py"]))
