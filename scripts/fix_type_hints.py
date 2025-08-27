#!/usr/bin/env python3
"""Fix Python 3.9 compatibility issues with type hints."""

import re
from pathlib import Path


def fix_type_hints(file_path):
    """Fix union type hints for Python 3.9 compatibility."""
    with open(file_path) as f:
        content = f.read()

    # Check if Optional is imported
    has_optional = "from typing import" in content and "Optional" in content

    # Pattern to match X | None syntax
    pattern = r"\b(\w+)\s*\|\s*None\b"

    # Replace with Optional[X]
    new_content = re.sub(pattern, r"Optional[\1]", content)

    # If we made changes and Optional isn't imported, add it
    if new_content != content and not has_optional:
        # Find the typing import line
        import_match = re.search(r"from typing import ([^\n]+)", new_content)
        if import_match:
            imports = import_match.group(1)
            if "Optional" not in imports:
                # Add Optional to existing imports
                new_imports = imports.rstrip() + ", Optional"
                new_content = new_content.replace(
                    f"from typing import {imports}", f"from typing import {new_imports}"
                )
        else:
            # Add typing import at the top
            lines = new_content.split("\n")
            for i, line in enumerate(lines):
                if line.startswith("import ") or line.startswith("from "):
                    lines.insert(i, "from typing import Optional")
                    break
            new_content = "\n".join(lines)

    # Also fix list[X] -> List[X] and dict[X] -> Dict[X]
    new_content = re.sub(r"\blist\[", "List[", new_content)
    new_content = re.sub(r"\bdict\[", "Dict[", new_content)
    new_content = re.sub(r"\btuple\[", "Tuple[", new_content)

    # Ensure List, Dict, Tuple are imported if used
    if "List[" in new_content or "Dict[" in new_content or "Tuple[" in new_content:
        import_match = re.search(r"from typing import ([^\n]+)", new_content)
        if import_match:
            imports = import_match.group(1).split(", ")
            needed = []
            if "List[" in new_content and "List" not in imports:
                needed.append("List")
            if "Dict[" in new_content and "Dict" not in imports:
                needed.append("Dict")
            if "Tuple[" in new_content and "Tuple" not in imports:
                needed.append("Tuple")

            if needed:
                imports.extend(needed)
                new_imports = ", ".join(sorted(set(imports)))
                new_content = re.sub(
                    r"from typing import [^\n]+", f"from typing import {new_imports}", new_content
                )

    if new_content != content:
        with open(file_path, "w") as f:
            f.write(new_content)
        return True
    return False


def main():
    """Fix all Python files in src directory."""
    src_dir = Path("src")
    fixed_count = 0

    for py_file in src_dir.rglob("*.py"):
        if fix_type_hints(py_file):
            print(f"Fixed: {py_file}")
            fixed_count += 1

    print(f"\nFixed {fixed_count} files")


if __name__ == "__main__":
    main()
