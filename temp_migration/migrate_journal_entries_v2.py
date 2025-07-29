import pandas as pd
import re


def escape_sql(value):
    """Escape single quotes for SQL"""
    if pd.isna(value) or value is None:
        return None
    return str(value).replace("'", "''")


def parse_amount(value):
    """Parse amount from various formats"""
    if pd.isna(value) or value == "":
        return 0.0
    if isinstance(value, (int, float)):
        return float(value)
    cleaned = re.sub(r"[^0-9.-]", "", str(value))
    try:
        return float(cleaned) if cleaned else 0.0
    except:
        return 0.0


# Read the journal file
journal_df = pd.read_excel("transactions/Journal.xlsx", skiprows=2)

# Rename columns
journal_df.columns = [
    "Empty",
    "Date",
    "Transaction Type",
    "No.",
    "Name",
    "Memo",
    "Account",
    "Debit",
    "Credit",
]
journal_df = journal_df.drop("Empty", axis=1)

# Remove header row and empty rows
journal_df = journal_df[journal_df["Date"] != "Date"]
journal_df = journal_df[journal_df["Date"].notna()]

# Convert date column
journal_df["Date"] = pd.to_datetime(journal_df["Date"], errors="coerce")
journal_df = journal_df[journal_df["Date"].notna()]

# Parse amounts
journal_df["Debit"] = journal_df["Debit"].apply(parse_amount)
journal_df["Credit"] = journal_df["Credit"].apply(parse_amount)

# Get unique transaction numbers/groups
journal_df["Transaction_Group"] = journal_df["No."].fillna(method="ffill")

# Map account names to account IDs
account_mapping = {
    # Assets
    "1000 10NetZero Checking (2705) - 1": "ACC-1000",
    "1100 Accounts receivable (A/R)": "ACC-1100",
    "1200 Prepaid Expenses": "ACC-1200",
    "1300 Crypto Assets": "ACC-1300",
    "1310 Inventory Asset": "ACC-1310",
    "10310 Inventory Asset": "ACC-1310",  # Alternative name
    "1410 Hashhut#1": "ACC-1410",
    "1420 Hashhut #2": "ACC-1420",
    "1700 Accumulated depreciation": "ACC-1700",
    # Liabilities
    "2000 Accounts Payable (A/P)": "ACC-2000",
    "2200 Accrued Interest": "ACC-2200",
    "2300 Accrued Liabilities": "ACC-2300",
    "2400 Accrued Interest - Other": "ACC-2400",
    "2500 Long-term business loans": "ACC-2500",
    "2520 Long-term business loans:Notes Payable - Colin Aulds": "ACC-2520",
    "2530 Long-term business loans:Notes Payable - S. Bryan Aulds": "ACC-2530",
    "2540 Long-term business loans:Notes Payable - Scott Aulds Sr.": "ACC-2540",
    "2550 Long-term business loans:Notes Payable - Shawn Leary": "ACC-2550",
    "2610 Long-term loans from shareholders:Cash Loan from Bryan Aulds": "ACC-2610",
    "2620 Long-term loans from shareholders:Cash Loan from Colin Aulds": "ACC-2620",
    # Equity
    "3100 Common stock": "ACC-3100",
    "3110 Common stock:Common Stock - Bryan Aulds": "ACC-3110",
    "3120 Common stock:Common Stock - Colin Aulds": "ACC-3120",
    "3130 Common stock:Common Stock - Joel Fulford": "ACC-3130",
    "3140 Common stock:Common Stock - Shawn Leary": "ACC-3140",
    "3150 Common stock:Common Stock - Scott Aulds Sr": "ACC-3150",
    "3160 Common stock:Common Stock - Philip Stanley": "ACC-3160",
    "3200 Additional paid in capital": "ACC-3200",
    "3300 Dividends paid": "ACC-3300",
    # Income
    "5000 Site Equipment Sales": "ACC-5000",
    "5100 Services": "ACC-5100",
    "5110 Services:Consulting Income": "ACC-5110",
    "5120 Services:Power Sales - Mathis": "ACC-5120",
    "5200 Billable Expense Income": "ACC-5200",
    "5210 Billable Expense Income:Billable Expense Income - Tomball": "ACC-5210",
    # Expenses
    "6010 Cost of goods sold:Site Equipment Purchase Cost": "ACC-6010",
    "6100 Contract labor": "ACC-6100",
    "6200 Insurance": "ACC-6200",
    "6300 Repairs & maintenance": "ACC-6300",
    "6400 General business expenses": "ACC-6400",
    "6410 General business expenses:Bank fees & service charges": "ACC-6410",
    "6500 Legal & accounting services": "ACC-6500",
    "7370 Payroll expenses:Officers' salaries": "ACC-7370",
    "7500 Interest Expense": "ACC-7500",
    "7900 Taxes paid": "ACC-7900",
    "8000 Depreciation": "ACC-8000",
    # Special account for deposits
    "Payments to deposit": "ACC-1000",  # Map to checking account
}

print(f"Found {len(account_mapping)} accounts in mapping")

# Group journal entries by transaction
transaction_groups = journal_df.groupby(
    ["Date", "Transaction_Group", "Transaction Type"]
)

company_id = "4e3daa5f-9015-4ae8-a79c-620ccc45757f"

# Generate SQL for journal entries
with open("insert_journal_entries_v2.sql", "w") as f:
    f.write("-- Insert Journal Entries\n\n")

    entry_count = 0
    line_count = 0
    unmapped_accounts = set()

    for (date, trans_group, trans_type), group_df in transaction_groups:
        entry_count += 1
        entry_id = f"JE-{entry_count:04d}"

        # Get first entity name if available
        entity_name = None
        for name in group_df["Name"]:
            if pd.notna(name) and str(name).strip():
                entity_name = escape_sql(str(name))
                break

        # Get description from first non-empty memo
        memo = None
        for m in group_df["Memo"]:
            if pd.notna(m) and str(m).strip():
                memo = escape_sql(str(m))
                break
        if not memo:
            memo = escape_sql(f"{trans_type} - {date.strftime('%Y-%m-%d')}")

        # Get reference number
        ref_num = str(trans_group) if pd.notna(trans_group) else None

        # Insert journal entry
        f.write(
            f"""INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    '{entry_id}', '{company_id}', '{date.strftime('%Y-%m-%d')}',
    '{escape_sql(trans_type)}',
    {f"'{escape_sql(ref_num)}'" if ref_num else 'NULL'},
    {f"'{entity_name}'" if entity_name else 'NULL'},
    '{memo}'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;
\n"""
        )

        # Insert journal lines
        line_entries = []
        for idx, line in group_df.iterrows():
            # Map account name to ID
            account_name = str(line["Account"])
            account_id = None

            # Try exact match first
            if account_name in account_mapping:
                account_id = account_mapping[account_name]
            else:
                # Try partial match
                for acc_name, acc_id in account_mapping.items():
                    if account_name in acc_name or acc_name in account_name:
                        account_id = acc_id
                        break

            if not account_id:
                unmapped_accounts.add(account_name)
                continue

            debit_amount = line["Debit"] if line["Debit"] > 0 else 0
            credit_amount = line["Credit"] if line["Credit"] > 0 else 0

            memo = escape_sql(str(line["Memo"])) if pd.notna(line["Memo"]) else ""

            line_entries.append(
                {
                    "account_id": account_id,
                    "memo": memo,
                    "debit_amount": debit_amount,
                    "credit_amount": credit_amount,
                }
            )

        # Write journal lines
        for le in line_entries:
            line_count += 1
            line_id = f"JL-{line_count:06d}"

            f.write(
                f"""INSERT INTO public.journal_entry_lines (
    journal_entry_line_id_display, journal_entry_id, account_id,
    memo, debit_amount, credit_amount
) VALUES (
    '{line_id}',
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = '{entry_id}'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = '{le['account_id']}'),
    '{le['memo']}',
    {le['debit_amount']}, {le['credit_amount']}
) ON CONFLICT (journal_entry_line_id_display) DO NOTHING;
\n"""
            )

print(f"\nGenerated SQL for {entry_count} journal entries with {line_count} lines")
print(f"\nUnmapped accounts ({len(unmapped_accounts)}):")
for acc in sorted(unmapped_accounts):
    print(f"  - {acc}")
print("\nOutput saved to: insert_journal_entries_v2.sql")
