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

    # Log the tool response
    log_entry = {
        "timestamp": datetime.now().isoformat(),
        "type": "post_tool_use",
        "tool_name": hook_data.get("tool_name", ""),
        "tool_input": hook_data.get("tool_input", {}),
        "tool_response": hook_data.get("tool_response", ""),
    }

    # Append to log file
    log_file = logs_dir / "claude_hooks.jsonl"
    with open(log_file, "a") as f:
        f.write(json.dumps(log_entry) + "\n")


if __name__ == "__main__":
    main()
