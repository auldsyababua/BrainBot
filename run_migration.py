#!/usr/bin/env python3
"""Run QuickBooks database migration"""

from supabase import create_client
import os
from dotenv import load_dotenv

load_dotenv()

supabase = create_client(os.getenv("SUPABASE_URL"), os.getenv("SUPABASE_SERVICE_KEY"))

print("Running QuickBooks database migration...")

# Read and execute migration SQL
with open("database_quickbooks_integration.sql", "r") as f:
    sql_content = f.read()

# Split by semicolons and execute each statement
statements = [
    stmt.strip()
    for stmt in sql_content.split(";")
    if stmt.strip() and not stmt.strip().startswith("--")
]

for i, statement in enumerate(statements):
    if statement:
        try:
            print(f"Executing statement {i+1}/{len(statements)}...")
            # Use the SQL editor endpoint directly
            from supabase._async.client import create_client as create_async_client
            import asyncio

            async def run_sql():
                async_supabase = create_async_client(
                    os.getenv("SUPABASE_URL"), os.getenv("SUPABASE_SERVICE_KEY")
                )
                result = await async_supabase.rpc(
                    "run_sql", {"sql": statement}
                ).execute()
                return result

            # For now, let's just print what we would execute
            print(f"Would execute: {statement[:100]}...")

        except Exception as e:
            print(f"Error in statement {i+1}: {e}")
            print(f"Statement: {statement[:200]}...")

print(
    "\nMigration statements prepared. You may need to run these manually in Supabase SQL editor."
)
print("\nKey tables to create:")
print("1. Add QuickBooks fields to companies table")
print("2. Create quickbooks_auth table")
print("3. Create quickbooks_webhook_events table")
print("4. Create quickbooks_sync_mapping table")
print("5. Create quickbooks_sync_queue table")
