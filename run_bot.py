#!/usr/bin/env python3
"""
🧪 LOCAL DEVELOPMENT ONLY - Run the bot using polling mode

This is for local testing only. Uses polling to check for updates.
For production, use webhook_server.py instead.

Usage: python run_bot.py
"""
import sys
import os

# Add src to Python path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "src"))

# Now import and run
from bot.main_polling import main  # noqa: E402

if __name__ == "__main__":
    main()
