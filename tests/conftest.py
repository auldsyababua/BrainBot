import shutil
from pathlib import Path

import pytest


@pytest.fixture(autouse=True)
async def cleanup_test_data():
    """
    Clean up test data after each test.

    This fixture runs automatically after every test to prevent
    test contamination from leftover data.
    """
    # Run test
    yield

    # Cleanup after test
    # 1. Remove any notes in tests/ folder
    test_notes = Path("notes/tests")
    if test_notes.exists():
        shutil.rmtree(test_notes)

    # 2. Remove specific test notes patterns
    notes_path = Path("notes")
    if notes_path.exists():
        # Patterns that indicate test data
        test_patterns = [
            "*test*",
            "*Test*",  # General test files
            "user-*",
            "User*",  # User-specific test files
            "*-test-*",
            "*_test_*",  # Test variations
            "Core feature test*",  # Specific test from test_ai_babysitter
            "Project deadline*",  # Another test note
        ]

        for pattern in test_patterns:
            for file in notes_path.rglob(pattern):
                # Only remove files that are NOT in 10NetZero
                if file.is_file() and "10NetZero" not in str(file):
                    try:
                        file.unlink()
                        print(f"Cleaned up test file: {file}")
                    except Exception as e:
                        print(f"Failed to remove {file}: {e}")

            # Also check for directories matching the pattern
            for dir_path in notes_path.rglob(pattern):
                if dir_path.is_dir() and "10NetZero" not in str(dir_path):
                    try:
                        shutil.rmtree(dir_path)
                        print(f"Cleaned up test directory: {dir_path}")
                    except Exception as e:
                        print(f"Failed to remove directory {dir_path}: {e}")

    # 3. Clean up any orphaned folders created during tests
    # Look for empty folders that aren't 10NetZero
    if notes_path.exists():
        for folder in notes_path.iterdir():
            if folder.is_dir() and folder.name != "10NetZero":
                # Check if folder is empty or only contains test files
                try:
                    if not any(folder.iterdir()):
                        folder.rmdir()
                        print(f"Removed empty folder: {folder}")
                except Exception:
                    # Folder might not be empty, that's okay
                    pass


@pytest.fixture
async def clean_start():
    """
    Ensure a clean start for tests that need it.

    This fixture can be used explicitly by tests that need
    to start with a completely clean state.
    """
    # Clean before test
    notes_path = Path("notes")
    if notes_path.exists():
        # Remove everything except 10NetZero
        for item in notes_path.iterdir():
            if item.name != "10NetZero":
                if item.is_file():
                    item.unlink()
                elif item.is_dir():
                    shutil.rmtree(item)

    yield

    # Cleanup is handled by the autouse fixture
