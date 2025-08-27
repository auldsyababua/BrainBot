#!/usr/bin/env python3
"""
Maintenance script for cleaning up test artifacts and temporary files.
Run monthly to maintain repository cleanliness.
"""

import logging
import os
import shutil
import sys
from datetime import datetime
from pathlib import Path
from typing import List, Tuple

# Setup logging
logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")
logger = logging.getLogger(__name__)


class ArtifactCleaner:
    """Handles cleanup of various artifact types in the repository."""

    def __init__(self, project_root: Path = None, dry_run: bool = False):
        """
        Initialize the cleaner.

        Args:
            project_root: Root directory of the project
            dry_run: If True, only log actions without making changes
        """
        self.project_root = project_root or Path.cwd()
        self.dry_run = dry_run
        self.removed_count = 0
        self.archived_count = 0

        if self.dry_run:
            logger.info("DRY RUN MODE - No files will be modified")

    def clean_python_artifacts(self) -> int:
        """Remove Python cache and compilation artifacts."""
        patterns = [
            "__pycache__",
            ".pytest_cache",
            ".coverage",
            ".coverage.*",
            "htmlcov",
            "*.pyc",
            "*.pyo",
            "*.pyd",
            ".Python",
            "*.so",
            ".mypy_cache",
            ".ruff_cache",
            ".hypothesis",
        ]

        count = 0
        for pattern in patterns:
            for path in self.project_root.rglob(pattern):
                if path.is_dir():
                    if self.dry_run:
                        logger.info(f"Would remove directory: {path}")
                    else:
                        shutil.rmtree(path, ignore_errors=True)
                        logger.info(f"Removed directory: {path}")
                else:
                    if self.dry_run:
                        logger.info(f"Would remove file: {path}")
                    else:
                        path.unlink(missing_ok=True)
                        logger.info(f"Removed file: {path}")
                count += 1

        return count

    def clean_test_artifacts(self) -> int:
        """Clean test-related temporary files."""
        test_dir = self.project_root / "tests"
        count = 0

        # Clean temporary test files
        patterns = ["*.db", "*.sqlite", "*.sqlite3", "test_*.log", ".testmondata", ".testmondata.*"]

        for pattern in patterns:
            for path in test_dir.rglob(pattern):
                # Skip migrations directory
                if "migrations" in str(path):
                    continue

                if self.dry_run:
                    logger.info(f"Would remove: {path}")
                else:
                    path.unlink(missing_ok=True)
                    logger.info(f"Removed: {path}")
                count += 1

        return count

    def archive_old_reports(self) -> int:
        """Archive old test reports and coverage data."""
        test_dir = self.project_root / "tests"
        archive_dir = test_dir / "archive"

        # Create archive structure
        archive_dir.mkdir(exist_ok=True)
        (archive_dir / "coverage").mkdir(exist_ok=True)
        (archive_dir / "reports").mkdir(exist_ok=True)
        (archive_dir / "test_results").mkdir(exist_ok=True)

        count = 0
        current_month = datetime.now().strftime("%Y-%m")

        # Archive test results
        test_results_dir = test_dir / "test_results"
        if test_results_dir.exists():
            for file in test_results_dir.glob("*.json"):
                archive_path = archive_dir / "test_results" / file.name
                if self.dry_run:
                    logger.info(f"Would archive: {file} -> {archive_path}")
                else:
                    shutil.move(str(file), str(archive_path))
                    logger.info(f"Archived: {file.name}")
                count += 1

        # Archive reports
        reports_dir = test_dir / "reports"
        if reports_dir.exists():
            for file in reports_dir.glob("*.md"):
                archive_path = archive_dir / "reports" / file.name
                if self.dry_run:
                    logger.info(f"Would archive: {file} -> {archive_path}")
                else:
                    shutil.move(str(file), str(archive_path))
                    logger.info(f"Archived: {file.name}")
                count += 1

        return count

    def clean_ide_files(self) -> int:
        """Remove IDE-specific files and directories."""
        patterns = [
            ".vscode",
            ".idea",
            "*.swp",
            "*.swo",
            "*~",
            ".DS_Store",
            "Thumbs.db",
            "desktop.ini",
        ]

        count = 0
        for pattern in patterns:
            for path in self.project_root.rglob(pattern):
                # Skip .vscode if it contains workspace settings
                if path.name == ".vscode" and (path / "settings.json").exists():
                    continue

                if path.is_dir():
                    if self.dry_run:
                        logger.info(f"Would remove directory: {path}")
                    else:
                        shutil.rmtree(path, ignore_errors=True)
                        logger.info(f"Removed directory: {path}")
                else:
                    if self.dry_run:
                        logger.info(f"Would remove file: {path}")
                    else:
                        path.unlink(missing_ok=True)
                        logger.info(f"Removed file: {path}")
                count += 1

        return count

    def clean_duplicate_files(self) -> int:
        """Remove duplicate files with ' 2' suffix."""
        count = 0

        for path in self.project_root.rglob("* 2.*"):
            # Skip node_modules and hidden directories
            if "node_modules" in str(path) or "/." in str(path):
                continue

            # Construct original filename
            original_name = str(path.name).replace(" 2.", ".")
            original_path = path.parent / original_name

            if original_path.exists():
                if self.dry_run:
                    logger.info(f"Would remove duplicate: {path}")
                else:
                    path.unlink()
                    logger.info(f"Removed duplicate: {path.name}")
                count += 1
            else:
                logger.warning(f"No original found for duplicate: {path}")

        return count

    def run_cleanup(self) -> tuple[int, int]:
        """
        Run all cleanup operations.

        Returns:
            Tuple of (total_removed, total_archived)
        """
        logger.info("=" * 60)
        logger.info("Starting cleanup operations...")
        logger.info("=" * 60)

        # Run cleanup operations
        operations = [
            ("Python artifacts", self.clean_python_artifacts),
            ("Test artifacts", self.clean_test_artifacts),
            ("Duplicate files", self.clean_duplicate_files),
            ("IDE files", self.clean_ide_files),
            ("Archive reports", self.archive_old_reports),
        ]

        total_removed = 0
        total_archived = 0

        for name, operation in operations:
            logger.info(f"\n{name}:")
            count = operation()

            if name == "Archive reports":
                total_archived += count
            else:
                total_removed += count

            logger.info(f"  Processed {count} items")

        return total_removed, total_archived


def main():
    """Main entry point for the script."""
    import argparse

    parser = argparse.ArgumentParser(description="Clean up test artifacts and temporary files")
    parser.add_argument(
        "--dry-run",
        "-n",
        action="store_true",
        help="Show what would be done without making changes",
    )
    parser.add_argument("--verbose", "-v", action="store_true", help="Show verbose output")

    args = parser.parse_args()

    if args.verbose:
        logging.getLogger().setLevel(logging.DEBUG)

    # Find project root (look for pyproject.toml or .git)
    current_dir = Path.cwd()
    project_root = current_dir

    while project_root.parent != project_root:
        if (project_root / "pyproject.toml").exists() or (project_root / ".git").exists():
            break
        project_root = project_root.parent
    else:
        project_root = current_dir

    logger.info(f"Project root: {project_root}")

    # Run cleanup
    cleaner = ArtifactCleaner(project_root, dry_run=args.dry_run)
    removed, archived = cleaner.run_cleanup()

    # Summary
    logger.info("\n" + "=" * 60)
    logger.info("CLEANUP SUMMARY")
    logger.info("=" * 60)
    logger.info(f"  Files removed: {removed}")
    logger.info(f"  Files archived: {archived}")
    logger.info(f"  Total processed: {removed + archived}")

    if args.dry_run:
        logger.info("\nThis was a dry run. No files were actually modified.")
        logger.info("Run without --dry-run to perform actual cleanup.")

    return 0


if __name__ == "__main__":
    sys.exit(main())
