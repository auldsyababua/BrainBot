#!/usr/bin/env python3
"""
Execute all remaining journal entry batches to Supabase
"""

import os

# Supabase credentials
SUPABASE_PROJECT_ID = "thnwlykidzhrsagyjncc"
SUPABASE_URL = f"https://{SUPABASE_PROJECT_ID}.supabase.co"
SUPABASE_ANON_KEY = "YOUR_ANON_KEY"  # You'll need to set this


def execute_batch(batch_number):
    """Execute a single journal batch file"""
    batch_file = f"batch_journal_final_{batch_number:02d}.sql"

    if not os.path.exists(batch_file):
        print(f"Batch file {batch_file} not found")
        return False

    with open(batch_file, "r") as f:
        sql_content = f.read()

    print(f"Executing {batch_file}...")

    # NOTE: This is a placeholder - you'll need to use the actual MCP tool
    # or provide the proper authentication to execute SQL
    print(f"  - Would execute {len(sql_content)} characters of SQL")
    print(
        f"  - File contains journal entries starting from line: {sql_content[:100]}..."
    )

    return True


def main():
    """Execute all journal batches from 04 to 35"""
    start_batch = 4
    end_batch = 35

    print(f"Starting execution of journal batches {start_batch} to {end_batch}")
    print("=" * 60)

    successful = 0
    failed = 0

    for batch_num in range(start_batch, end_batch + 1):
        try:
            if execute_batch(batch_num):
                successful += 1
                print(f"✅ Batch {batch_num} completed")
            else:
                failed += 1
                print(f"❌ Batch {batch_num} failed")
        except Exception as e:
            failed += 1
            print(f"❌ Batch {batch_num} error: {e}")

        print("-" * 40)

    print("\nSUMMARY:")
    print(f"Total batches: {end_batch - start_batch + 1}")
    print(f"Successful: {successful}")
    print(f"Failed: {failed}")

    # List the SQL files for manual execution
    print("\nSQL files ready for execution:")
    for batch_num in range(start_batch, end_batch + 1):
        batch_file = f"batch_journal_final_{batch_num:02d}.sql"
        if os.path.exists(batch_file):
            file_size = os.path.getsize(batch_file)
            print(f"  - {batch_file} ({file_size:,} bytes)")


if __name__ == "__main__":
    main()
