#!/usr/bin/env python3
# /// script
# requires-python = ">=3.11"
# dependencies = []
# ///

import json
import sys
from datetime import datetime
from pathlib import Path


def main():
    # Read stdin for hook data
    hook_data = json.loads(sys.stdin.read())

    # Create logs directory if it doesn't exist
    logs_dir = Path("logs")
    logs_dir.mkdir(exist_ok=True)

    # Log the prompt
    log_entry = {
        "timestamp": datetime.now().isoformat(),
        "type": "user_prompt_submit",
        "prompt": hook_data.get("prompt", ""),
        "session_id": hook_data.get("session_id", ""),
    }

    # Append to log file
    log_file = logs_dir / "claude_hooks.jsonl"
    with open(log_file, "a") as f:
        f.write(json.dumps(log_entry) + "\n")

    # Pass through the original prompt
    print(hook_data.get("prompt", ""))


if __name__ == "__main__":
    main()
