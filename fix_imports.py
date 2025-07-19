#!/usr/bin/env python3
"""Fix all imports to use relative imports within the src package"""
import os
import re


def fix_imports(filepath):
    with open(filepath, "r") as f:
        content = f.read()

    original = content

    # Fix imports based on the file location
    if "/src/bot/" in filepath:
        # In bot module
        content = re.sub(r"from src\.core\.", "from ..core.", content)
        content = re.sub(r"from src\.storage\.", "from ..storage.", content)
        content = re.sub(r"from src\.migrations\.", "from ..migrations.", content)
        content = re.sub(r"from core\.", "from ..core.", content)
        content = re.sub(r"from storage\.", "from ..storage.", content)
    elif "/src/core/" in filepath:
        # In core module
        content = re.sub(r"from src\.core\.", "from .", content)
        content = re.sub(r"from src\.storage\.", "from ..storage.", content)
        content = re.sub(r"from src\.migrations\.", "from ..migrations.", content)
    elif "/src/storage/" in filepath:
        # In storage module
        content = re.sub(r"from src\.storage\.", "from .", content)
        content = re.sub(r"from src\.core\.", "from ..core.", content)
        content = re.sub(r"from src\.migrations\.", "from ..migrations.", content)
    elif "/src/migrations/" in filepath:
        # In migrations module
        content = re.sub(r"from src\.migrations\.", "from .", content)
        content = re.sub(r"from src\.core\.", "from ..core.", content)
        content = re.sub(r"from src\.storage\.", "from ..storage.", content)

    if content != original:
        with open(filepath, "w") as f:
            f.write(content)
        print(f"Fixed imports in {filepath}")


# Walk through all Python files in src
for root, dirs, files in os.walk("src"):
    for file in files:
        if file.endswith(".py"):
            filepath = os.path.join(root, file)
            fix_imports(filepath)
