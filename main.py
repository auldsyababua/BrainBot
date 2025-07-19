#!/usr/bin/env python3
"""
Main entry point for Render deployment.
Runs the polling bot instead of webhook mode.
"""
import subprocess
import sys
import os

if __name__ == "__main__":
    print("Starting BrainBot in polling mode for Render...")
    # Update Python path to include src directory
    sys.path.insert(0, os.path.join(os.path.dirname(__file__), "src"))
    sys.exit(subprocess.call([sys.executable, "src/bot/main_polling.py"]))
