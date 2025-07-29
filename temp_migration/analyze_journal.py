import pandas as pd
import numpy as np

# Read the journal file
journal_df = pd.read_excel("transactions/Journal.xlsx", header=None)

# Find the actual header row
for i in range(10):
    row = journal_df.iloc[i]
    if "Date" in str(row.values):
        header_row = i
        break

print(f"Header row found at index: {header_row}")
print(f"Header values: {journal_df.iloc[header_row].values}")

# Read with proper header
journal_df = pd.read_excel("transactions/Journal.xlsx", skiprows=header_row)

# Rename columns based on content
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

# Drop empty column
journal_df = journal_df.drop("Empty", axis=1)

# Remove total rows and empty rows
journal_df = journal_df[journal_df["Date"].notna()]
journal_df = journal_df[~journal_df["Date"].astype(str).str.contains("Total")]

print("\nCleaned Journal Entries:")
print(journal_df.head(20))
print(f"\nTotal entries: {len(journal_df)}")

# Group by transaction to understand structure
print("\nTransaction types:")
print(journal_df["Transaction Type"].value_counts())

# Check account references
print("\nSample accounts used:")
print(journal_df["Account"].value_counts().head(20))
