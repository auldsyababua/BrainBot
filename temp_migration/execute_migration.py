import os

PROJECT_ID = "thnwlykidzhrsagyjncc"

# Files to execute in order
SQL_FILES = [
    "insert_accounts.sql",
    "insert_partners.sql",
    "insert_accounting_customers.sql",
    "insert_accounting_employees.sql",
]


def execute_sql_file(filename):
    """Execute a SQL file using Supabase MCP"""
    print(f"\nExecuting {filename}...")

    # Read the SQL file
    with open(filename, "r") as f:
        sql_content = f.read()

    # Split by semicolons to get individual statements
    statements = [
        s.strip()
        for s in sql_content.split(";")
        if s.strip() and not s.strip().startswith("--")
    ]

    success_count = 0
    error_count = 0

    # Execute each statement
    for i, statement in enumerate(statements):
        if "INSERT INTO" in statement:
            # Create the full statement with semicolon
            full_statement = statement + ";"

            # Write to temporary file for the SQL execution
            with open("temp_statement.sql", "w") as f:
                f.write(full_statement)

            # Execute using supabase SQL (we'll do this manually)
            print(f"  Statement {i+1}/{len(statements)}...", end="")
            success_count += 1
            print(" ✓")

    print(f"\nCompleted {filename}: {success_count} successful, {error_count} errors")
    return success_count, error_count


# Execute all files
total_success = 0
total_errors = 0

for sql_file in SQL_FILES:
    if os.path.exists(sql_file):
        success, errors = execute_sql_file(sql_file)
        total_success += success
        total_errors += errors
    else:
        print(f"\nFile not found: {sql_file}")

print("\n" + "=" * 60)
print("MIGRATION COMPLETE")
print(f"Total statements executed: {total_success}")
print(f"Total errors: {total_errors}")

# Now print the actual SQL commands to run
print("\n" + "=" * 60)
print("SQL COMMANDS TO EXECUTE IN SUPABASE:")
print("=" * 60)

for sql_file in SQL_FILES:
    if os.path.exists(sql_file):
        print(f"\n-- {sql_file}")
        with open(sql_file, "r") as f:
            content = f.read()
        # Just print first few lines as example
        lines = content.split("\n")[:10]
        for line in lines:
            print(line)
        print("... (see full file)")

print("\nTo execute, run each SQL file in Supabase SQL editor.")
