#!/usr/bin/env python3
"""
Test the bot locally with proper imports
"""
import sys
import os

# Add src to path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "src"))

# Now we can import
from bot.main_polling import main  # noqa: E402

if __name__ == "__main__":
    main()
