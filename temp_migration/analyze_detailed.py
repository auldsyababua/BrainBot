import pandas as pd
import os

# Define the directories
transactions_dir = "transactions"
lists_dir = "lists"


# Function to analyze specific files with proper headers
def analyze_journal():
    print("\nAnalyzing Journal Data...")
    df = pd.read_excel(
        os.path.join(transactions_dir, "Journal.xlsx"), sheet_name="Journal", skiprows=3
    )
    print(f"Shape: {df.shape}")
    print("\nActual data sample (after skipping header rows):")
    print(df.head(5).to_string())
    return df


def analyze_general_ledger():
    print("\nAnalyzing General Ledger Data...")
    df = pd.read_excel(
        os.path.join(transactions_dir, "General_ledger.xlsx"),
        sheet_name="General Ledger",
        skiprows=3,
    )
    print(f"Shape: {df.shape}")
    print("\nActual data sample (after skipping header rows):")
    print(df.head(5).to_string())
    return df


def analyze_customers():
    print("\nAnalyzing Customer Data...")
    df = pd.read_excel(
        os.path.join(transactions_dir, "Customers.xlsx"),
        sheet_name="Customer Contact List",
        skiprows=3,
    )
    print(f"Shape: {df.shape}")
    print("\nActual data sample (after skipping header rows):")
    print(df.head(5).to_string())
    return df


def analyze_vendors():
    print("\nAnalyzing Vendor Data...")
    df = pd.read_excel(
        os.path.join(transactions_dir, "Vendors.xlsx"),
        sheet_name="Vendor Contact List",
        skiprows=3,
    )
    print(f"Shape: {df.shape}")
    print("\nActual data sample (after skipping header rows):")
    print(df.head(5).to_string())
    return df


def analyze_employees():
    print("\nAnalyzing Employee Data...")
    df = pd.read_excel(
        os.path.join(transactions_dir, "Employees.xlsx"),
        sheet_name="Employee Contact List",
        skiprows=3,
    )
    print(f"Shape: {df.shape}")
    print("\nActual data sample (after skipping header rows):")
    print(df.head(5).to_string())
    return df


def analyze_trial_balance():
    print("\nAnalyzing Trial Balance Data...")
    df = pd.read_excel(
        os.path.join(transactions_dir, "Trial_balance.xlsx"),
        sheet_name="Trial Balance",
        skiprows=3,
    )
    print(f"Shape: {df.shape}")
    print("\nActual data sample (after skipping header rows):")
    print(df.head(5).to_string())
    return df


def analyze_balance_sheet():
    print("\nAnalyzing Balance Sheet Data...")
    df = pd.read_excel(
        os.path.join(transactions_dir, "Balance_sheet.xlsx"),
        sheet_name="Balance Sheet",
        skiprows=3,
    )
    print(f"Shape: {df.shape}")
    print("\nActual data sample (after skipping header rows):")
    print(df.head(5).to_string())
    return df


def analyze_profit_loss():
    print("\nAnalyzing Profit & Loss Data...")
    df = pd.read_excel(
        os.path.join(transactions_dir, "Profit_and_loss.xlsx"),
        sheet_name="Profit and Loss",
        skiprows=3,
    )
    print(f"Shape: {df.shape}")
    print("\nActual data sample (after skipping header rows):")
    print(df.head(5).to_string())
    return df


# Run analysis
if __name__ == "__main__":
    print("=" * 80)
    print("DETAILED DATA ANALYSIS")
    print("=" * 80)

    journal_df = analyze_journal()
    gl_df = analyze_general_ledger()
    customers_df = analyze_customers()
    vendors_df = analyze_vendors()
    employees_df = analyze_employees()
    trial_balance_df = analyze_trial_balance()
    balance_sheet_df = analyze_balance_sheet()
    profit_loss_df = analyze_profit_loss()
