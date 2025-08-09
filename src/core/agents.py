"""Lightweight agent prompt loader for local `.claude/agents` integration.

Allows selecting a specialized prompt ("sub-agent") by name in a message
using prefixes like `@agent-name:` or `/agent agent-name:`.
"""

from __future__ import annotations

import os
import re
from typing import List, Optional, Tuple


def _get_project_root() -> str:
    """Return the project root directory path.

    Resolves from this file (src/core/agents.py) up two levels to repo root.
    """
    return os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))


def get_agents_directory() -> str:
    """Return absolute path to the `.claude/agents` directory.

    Can be overridden via `CLAUDE_AGENTS_DIR` environment variable.
    """
    custom_dir = os.getenv("CLAUDE_AGENTS_DIR")
    if custom_dir:
        return custom_dir
    return os.path.join(_get_project_root(), ".claude", "agents")


def list_agents() -> List[str]:
    """List available agent names (filenames without `.md`)."""
    agents_dir = get_agents_directory()
    try:
        entries = os.listdir(agents_dir)
    except FileNotFoundError:
        return []

    names: List[str] = []
    for name in entries:
        if name.lower().endswith(".md"):
            names.append(name[:-3])
    return sorted(names)


def load_agent_prompt(agent_name: str) -> Optional[str]:
    """Load agent prompt content from `.md` file by name.

    Returns None if not found or unreadable.
    """
    agents_dir = get_agents_directory()
    file_path = os.path.join(agents_dir, f"{agent_name}.md")
    try:
        with open(file_path, "r", encoding="utf-8") as f:
            return f.read()
    except (FileNotFoundError, OSError):
        return None


_AT_AGENT_PATTERN = re.compile(r"^@([a-zA-Z0-9_\-]+)\s*[:\-]?\s*(.*)$", re.DOTALL)
_SLASH_AGENT_PATTERN = re.compile(r"^/agent\s+([a-zA-Z0-9_\-]+)\s*[:\-]?\s*(.*)$", re.DOTALL)


def detect_agent_in_message(message: str) -> Tuple[Optional[str], str]:
    """Detect explicit agent selection in a user message.

    Supports two syntaxes:
    - `@agent-name: rest of message`
    - `/agent agent-name: rest of message`

    Returns a tuple of (agent_name or None, cleaned_message).
    If no agent is specified, returns (None, original_message).
    """
    if not message:
        return None, message

    m = _AT_AGENT_PATTERN.match(message.strip())
    if m:
        return m.group(1), m.group(2).strip()

    m = _SLASH_AGENT_PATTERN.match(message.strip())
    if m:
        return m.group(1), m.group(2).strip()

    return None, message


