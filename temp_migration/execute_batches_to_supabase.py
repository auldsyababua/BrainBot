#!/usr/bin/env python3
"""
Execute all journal entry batches to Supabase
"""

import os
import sys
import time

# This script will output SQL commands to be executed
# The output can be piped to the mcp__supabase__execute_sql tool


def read_batch_file(batch_number):
    """Read a batch file and return its SQL content"""
    batch_file = f"batch_journal_final_{batch_number:02d}.sql"

    if os.path.exists(batch_file):
        with open(batch_file, "r") as f:
            return f.read()
    return None


def main():
    # Define which batches to execute
    start_batch = int(sys.argv[1]) if len(sys.argv) > 1 else 5
    end_batch = int(sys.argv[2]) if len(sys.argv) > 2 else 35

    print(f"-- Executing batches {start_batch} to {end_batch}")
    print(f"-- Generated at {time.strftime('%Y-%m-%d %H:%M:%S')}")
    print()

    successful = 0

    for batch_num in range(start_batch, end_batch + 1):
        sql_content = read_batch_file(batch_num)

        if sql_content:
            print(f"-- Batch {batch_num}")
            print(sql_content)
            print()
            successful += 1
        else:
            print(f"-- ERROR: Batch {batch_num} not found")
            print()

    print(f"-- Total batches processed: {successful}")


if __name__ == "__main__":
    main()
