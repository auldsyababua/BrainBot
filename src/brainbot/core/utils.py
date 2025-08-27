"""Utility functions for the bot."""

from typing import Any, Dict, Tuple

import yaml


def parse_frontmatter(content: str) -> tuple[dict[str, Any], str]:
    """Parse YAML frontmatter from markdown content."""
    if content.startswith("---\n"):
        try:
            # Find the closing ---
            end = content.find("\n---\n", 4)
            if end != -1:
                frontmatter_str = content[4:end]
                body = content[end + 5 :]
                frontmatter = yaml.safe_load(frontmatter_str) or {}
                return frontmatter, body
        except yaml.YAMLError:
            pass
    return {}, content
