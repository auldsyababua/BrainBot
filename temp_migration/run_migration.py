# I'll create a consolidated SQL file that can be executed all at once
import os

# Read all SQL files and combine them
sql_files = [
    'insert_accounts.sql',
    'insert_partners.sql',
    'insert_accounting_customers.sql',
    'insert_accounting_employees.sql'
]

consolidated_sql = """-- QuickBooks Data Migration
-- This file contains all SQL statements to import QuickBooks data

"""

for sql_file in sql_files:
    if os.path.exists(sql_file):
        with open(sql_file, 'r') as f:
            content = f.read()
        consolidated_sql += f"\n-- ============ {sql_file} ============\n"
        consolidated_sql += content
        consolidated_sql += "\n\n"

# Write consolidated file
with open('consolidated_migration.sql', 'w') as f:
    f.write(consolidated_sql)

print("Created consolidated_migration.sql")
print(f"Total size: {len(consolidated_sql)} characters")
print("\nTo execute:")
print("1. Copy the contents of consolidated_migration.sql")
print("2. Paste into Supabase SQL editor")
print("3. Execute the query")

# Also create smaller batch files for easier execution
print("\n\nCreating batch files for easier execution...")

# Read accounts and split into batches
with open('insert_accounts.sql', 'r') as f:
    accounts_content = f.read()

statements = [s.strip() for s in accounts_content.split(';') if s.strip() and 'INSERT' in s]

# Create batches of 20 statements each
batch_size = 20
for i in range(0, len(statements), batch_size):
    batch_statements = statements[i:i+batch_size]
    batch_sql = "\n".join([s + ";" for s in batch_statements])
    
    with open(f'batch_accounts_{i//batch_size + 1}.sql', 'w') as f:
        f.write(f"-- Accounts Batch {i//batch_size + 1}\n\n")
        f.write(batch_sql)
    
    print(f"Created batch_accounts_{i//batch_size + 1}.sql with {len(batch_statements)} statements")

print("\nBatch files created for easier execution!")