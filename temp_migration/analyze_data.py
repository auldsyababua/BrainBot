import pandas as pd
import os

# Define the directories
transactions_dir = "transactions"
lists_dir = "lists"


# Function to analyze Excel file structure
def analyze_excel_file(filepath, label):
    print(f"\n{'='*60}")
    print(f"Analyzing: {label} - {os.path.basename(filepath)}")
    print(f"{'='*60}")

    try:
        # Read all sheets
        xlsx = pd.ExcelFile(filepath)

        for sheet_name in xlsx.sheet_names:
            print(f"\nSheet: {sheet_name}")
            df = pd.read_excel(filepath, sheet_name=sheet_name)

            print(f"Shape: {df.shape}")
            print(f"\nColumns: {list(df.columns)}")

            # Show data types
            print("\nData Types:")
            for col in df.columns:
                print(f"  - {col}: {df[col].dtype}")

            # Show first few rows
            print("\nFirst 3 rows:")
            print(df.head(3).to_string())

            # Check for nulls
            null_counts = df.isnull().sum()
            if null_counts.any():
                print("\nNull values:")
                for col, count in null_counts[null_counts > 0].items():
                    print(f"  - {col}: {count} nulls")

    except Exception as e:
        print(f"Error reading file: {e}")


# Analyze all files
for filename in os.listdir(transactions_dir):
    if filename.endswith(".xlsx"):
        filepath = os.path.join(transactions_dir, filename)
        analyze_excel_file(filepath, "TRANSACTIONS")

for filename in os.listdir(lists_dir):
    if filename.endswith(".xlsx"):
        filepath = os.path.join(lists_dir, filename)
        analyze_excel_file(filepath, "LISTS")
