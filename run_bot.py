#!/usr/bin/env python3
"""Run the bot with proper imports"""
import sys
import os

# Add src to Python path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "src"))

# Now import and run
from bot.main_polling import main  # noqa: E402

if __name__ == "__main__":
    main()
