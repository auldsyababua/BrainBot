#!/usr/bin/env python3
"""Script to safely remove duplicate files with ' 2' suffix."""

import hashlib
import os
import shutil
from pathlib import Path
from typing import List, Tuple


def get_file_hash(filepath: str) -> str:
    """Get SHA256 hash of a file."""
    hash_sha256 = hashlib.sha256()
    try:
        with open(filepath, "rb") as f:
            for chunk in iter(lambda: f.read(4096), b""):
                hash_sha256.update(chunk)
        return hash_sha256.hexdigest()
    except Exception as e:
        print(f"Error hashing {filepath}: {e}")
        return ""


def find_duplicate_files() -> list[tuple[str, str]]:
    """Find all duplicate files with ' 2' suffix and their originals."""
    duplicates = []

    # Find all files with ' 2.' pattern
    for root, dirs, files in os.walk("."):
        # Skip hidden directories and node_modules
        dirs[:] = [d for d in dirs if not d.startswith(".") and d != "node_modules"]

        for file in files:
            if " 2." in file:
                duplicate_path = os.path.join(root, file)
                # Construct original filename
                original_name = file.replace(" 2.", ".")
                original_path = os.path.join(root, original_name)

                if os.path.exists(original_path):
                    duplicates.append((duplicate_path, original_path))
                else:
                    # No original found - this might be the only copy
                    print(f"Warning: No original found for {duplicate_path}")

    return duplicates


def compare_and_remove_duplicates(duplicates: list[tuple[str, str]], dry_run: bool = True):
    """Compare duplicates with originals and remove if identical."""
    removed_count = 0
    kept_count = 0

    for dup_path, orig_path in duplicates:
        dup_hash = get_file_hash(dup_path)
        orig_hash = get_file_hash(orig_path)

        if dup_hash and orig_hash:
            if dup_hash == orig_hash:
                # Files are identical - safe to remove duplicate
                if dry_run:
                    print(f"Would remove (identical): {dup_path}")
                else:
                    os.remove(dup_path)
                    print(f"Removed (identical): {dup_path}")
                removed_count += 1
            else:
                # Files differ - need manual review
                dup_stat = os.stat(dup_path)
                orig_stat = os.stat(orig_path)

                # Check which is newer
                if dup_stat.st_mtime > orig_stat.st_mtime:
                    print(f"REVIEW NEEDED - Duplicate is newer: {dup_path}")
                    print(f"  Original: {orig_path}")
                    print(f"  Duplicate mtime: {dup_stat.st_mtime}")
                    print(f"  Original mtime: {orig_stat.st_mtime}")
                else:
                    # Original is newer or same time - safe to remove duplicate
                    if dry_run:
                        print(f"Would remove (original is newer): {dup_path}")
                    else:
                        os.remove(dup_path)
                        print(f"Removed (original is newer): {dup_path}")
                    removed_count += 1
                kept_count += 1

    return removed_count, kept_count


def main():
    """Main execution function."""
    import sys

    dry_run = "--dry-run" in sys.argv or "-n" in sys.argv

    if dry_run:
        print("DRY RUN MODE - No files will be deleted")
        print("=" * 60)

    print("Finding duplicate files...")
    duplicates = find_duplicate_files()
    print(f"Found {len(duplicates)} duplicate files with originals")

    if duplicates:
        print("\nComparing and removing duplicates...")
        removed, kept = compare_and_remove_duplicates(duplicates, dry_run)

        print("\n" + "=" * 60)
        print("Summary:")
        print(f"  Files to remove: {removed}")
        print(f"  Files needing review: {kept}")

        if dry_run:
            print("\nRun without --dry-run to actually remove files")
    else:
        print("No duplicates found!")


if __name__ == "__main__":
    main()
