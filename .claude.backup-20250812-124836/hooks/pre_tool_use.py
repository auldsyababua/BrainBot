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

    # Log the tool use
    log_entry = {
        "timestamp": datetime.now().isoformat(),
        "type": "pre_tool_use",
        "tool_name": hook_data.get("tool_name", ""),
        "tool_input": hook_data.get("tool_input", {}),
    }

    # Append to log file
    log_file = logs_dir / "claude_hooks.jsonl"
    with open(log_file, "a") as f:
        f.write(json.dumps(log_entry) + "\n")

    # Block dangerous commands
    tool_name = hook_data.get("tool_name", "")
    tool_input = hook_data.get("tool_input", {})

    if tool_name == "Bash":
        command = tool_input.get("command", "")
        dangerous_patterns = ["rm -rf /", "rm -rf ~", "format", "mkfs"]
        if any(pattern in command for pattern in dangerous_patterns):
            print(f"BLOCKED: Dangerous command attempted: {command}", file=sys.stderr)
            sys.exit(1)

    # Allow the tool use
    sys.exit(0)


if __name__ == "__main__":
    main()
