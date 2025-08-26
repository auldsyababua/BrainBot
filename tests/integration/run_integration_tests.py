#!/usr/bin/env python
"""
Integration Test Runner for FLRTS Processors

Usage:
    python run_integration_tests.py                    # Run all integration tests
    python run_integration_tests.py --task            # Run only task processor tests
    python run_integration_tests.py --list            # Run only list processor tests
    python run_integration_tests.py --field-report    # Run only field report tests
    python run_integration_tests.py --e2e             # Run only E2E tests
    python run_integration_tests.py --performance     # Include performance tests
"""

import argparse
import subprocess
import sys
from pathlib import Path


def run_tests(test_files=None, include_performance=False, verbose=False):
    """Run integration tests with pytest."""

    # Base pytest command
    cmd = ["pytest", "-v" if verbose else "-q", "--run-integration"]

    # Add performance flag if requested
    if not include_performance:
        cmd.append("--skip-performance")

    # Add specific test files or run all
    if test_files:
        cmd.extend(test_files)
    else:
        # Run all integration tests
        cmd.append("tests/integration/")

    # Add coverage if available
    try:
        import coverage

        cmd.extend(["--cov=src", "--cov-report=term-missing"])
    except ImportError:
        print("Coverage not installed. Run: pip install coverage pytest-cov")

    # Execute tests
    print(f"Running: {' '.join(cmd)}")
    result = subprocess.run(cmd, cwd=Path(__file__).parent.parent.parent)

    return result.returncode


def main():
    parser = argparse.ArgumentParser(description="Run FLRTS integration tests")

    # Test selection options
    parser.add_argument("--task", action="store_true", help="Run TaskProcessor tests")
    parser.add_argument("--list", action="store_true", help="Run ListProcessor tests")
    parser.add_argument(
        "--field-report", action="store_true", help="Run FieldReportProcessor tests"
    )
    parser.add_argument("--e2e", action="store_true", help="Run E2E webhook tests")
    parser.add_argument("--all", action="store_true", help="Run all integration tests")

    # Test options
    parser.add_argument("--performance", action="store_true", help="Include performance tests")
    parser.add_argument("-v", "--verbose", action="store_true", help="Verbose output")
    parser.add_argument("--failfast", action="store_true", help="Stop on first failure")

    args = parser.parse_args()

    # Determine which tests to run
    test_files = []

    if args.task or args.all:
        test_files.append("tests/integration/test_task_processor_db.py")

    if args.list or args.all:
        test_files.append("tests/integration/test_list_processor_db.py")

    if args.field_report or args.all:
        test_files.append("tests/integration/test_field_report_processor_db.py")

    if args.e2e or args.all:
        test_files.append("tests/integration/test_e2e_webhook_to_db.py")

    # If no specific tests selected, run all
    if not test_files and not (args.task or args.list or args.field_report or args.e2e):
        test_files = None  # Will run all integration tests

    # Run the tests
    exit_code = run_tests(
        test_files=test_files,
        include_performance=args.performance,
        verbose=args.verbose,
    )

    # Report results
    if exit_code == 0:
        print("\n✅ All integration tests passed!")
    else:
        print("\n❌ Some integration tests failed.")

    sys.exit(exit_code)


if __name__ == "__main__":
    main()
