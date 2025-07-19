#!/usr/bin/env python3
"""
Main entry point for Render deployment.
Runs the polling bot instead of webhook mode.
"""
import subprocess
import sys

if __name__ == "__main__":
    print("Starting BrainBot in polling mode for Render...")
    sys.exit(subprocess.call([sys.executable, "main_polling.py"]))
