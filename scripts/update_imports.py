#!/usr/bin/env python3
"""
Script to update all imports from old structure to new flrts_bmad package structure.
"""

import os
import re
from pathlib import Path


def update_imports_in_file(filepath):
    """Update imports in a single file."""
    with open(filepath) as f:
        content = f.read()
    
    original_content = content
    
    # Pattern replacements
    replacements = [
        # from src.module.submodule -> from flrts_bmad.module.submodule
        (r'^from src\.', 'from flrts_bmad.'),
        (r'^import src\.', 'import flrts_bmad.'),
        
        # from module.submodule -> from flrts_bmad.module.submodule (for core, bot, etc.)
        (r'^from (core|bot|storage|rails|health|monitoring|migrations)\.', r'from flrts_bmad.\1.'),
        (r'^import (core|bot|storage|rails|health|monitoring|migrations)\.', r'import flrts_bmad.\1.'),
        
        # Handle "from module import" patterns
        (r'^from (core|bot|storage|rails|health|monitoring|migrations) import', r'from flrts_bmad.\1 import'),
    ]
    
    # Apply replacements line by line
    lines = content.split('\n')
    updated_lines = []
    
    for line in lines:
        updated_line = line
        for pattern, replacement in replacements:
            updated_line = re.sub(pattern, replacement, updated_line, flags=re.MULTILINE)
        updated_lines.append(updated_line)
    
    content = '\n'.join(updated_lines)
    
    # Only write if changes were made
    if content != original_content:
        with open(filepath, 'w') as f:
            f.write(content)
        return True
    return False


def main():
    """Update all Python files in the project."""
    project_root = Path('/Users/colinaulds/Desktop/projects/flrts-bmad')
    
    # Directories to process
    directories = [
        project_root / 'src' / 'flrts_bmad',
        project_root / 'tests',
        project_root / 'scripts',
        project_root / 'testsprite_tests',
    ]
    
    updated_files = []
    
    for directory in directories:
        if not directory.exists():
            print(f"Skipping {directory} - does not exist")
            continue
            
        for py_file in directory.rglob('*.py'):
            if update_imports_in_file(py_file):
                updated_files.append(py_file)
                print(f"Updated: {py_file.relative_to(project_root)}")
    
    print(f"\nTotal files updated: {len(updated_files)}")


if __name__ == '__main__':
    main()