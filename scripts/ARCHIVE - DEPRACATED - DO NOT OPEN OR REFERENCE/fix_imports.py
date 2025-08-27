#!/usr/bin/env python3
"""Fix all import issues in test files - replace src. imports with flrts."""

import re
from pathlib import Path


def fix_imports_in_file(filepath):
    """Fix imports in a single file."""
    with open(filepath) as f:
        content = f.read()

    original = content

    # Replace various import patterns
    replacements = [
        # Direct module imports
        (r"from src\.core\.", "from brainbot.core."),
        (r"from src\.storage\.", "from brainbot.storage."),
        (r"from src\.rails\.", "from brainbot.rails."),
        (r"from src\.flrts\.", "from brainbot."),
        # Import statements
        (r"import src\.core\.", "import brainbot.core."),
        (r"import src\.storage\.", "import brainbot.storage."),
        (r"import src\.rails\.", "import brainbot.rails."),
        (r"import src\.flrts\.", "import brainbot."),
    ]

    for pattern, replacement in replacements:
        content = re.sub(pattern, replacement, content)

    # Write back if changed
    if content != original:
        with open(filepath, "w") as f:
            f.write(content)
        return True
    return False


def main():
    """Fix all imports in test files."""
    test_files = [
        "tests/unit/test_graph_memory.py",
        "tests/unit/test_neo4j_setup.py",
        "tests/unit/test_processor_constructor_regression.py",
        "tests/unit/test_memory_webhooks.py",
        "tests/unit/test_memory_without_deps.py",
        "tests/security/test_anti_mesa_patterns.py",
        "tests/integration/test_graph_memory_integration.py",
        "tests/integration/test_llm_conversations.py",
        "tests/test_cloudflare_vector_store.py",
        "tests/system/test_all_storage.py",
    ]

    fixed_files = []
    for file in test_files:
        filepath = Path(file)
        if filepath.exists():
            if fix_imports_in_file(filepath):
                fixed_files.append(file)
                print(f"Fixed imports in: {file}")
        else:
            print(f"File not found: {file}")

    print(f"\nFixed {len(fixed_files)} files")
    return fixed_files


if __name__ == "__main__":
    main()
