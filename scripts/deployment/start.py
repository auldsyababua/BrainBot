#!/usr/bin/env python3
"""
Start script for Render deployment.
Ensures the polling bot runs correctly.
"""
import subprocess
import sys

if __name__ == "__main__":
    print("Starting BrainBot in polling mode...")
    sys.exit(subprocess.call([sys.executable, "main_polling.py"]))
