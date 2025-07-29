import pandas as pd

# Read customers data
df = pd.read_excel(
    "transactions/Customers.xlsx", sheet_name="Customer Contact List", skiprows=3
)

# Clean up column names
df.columns = [
    "empty",
    "customer_name",
    "phone",
    "email",
    "full_name",
    "billing_address",
    "shipping_address",
]

# Remove empty rows
df = df[df["customer_name"].notna()]
df = df[df["customer_name"] != "Customer"]

print("\nAll Customers from QuickBooks Export:")
print("=" * 60)
for idx, customer in enumerate(df["customer_name"].tolist(), 1):
    print(f"{idx:2d}. {customer}")

print(f"\nTotal customers: {len(df)}")

# Check for partners in customers
partners = [
    "Flober LLC",
    "Malama Energy",
    "Operation Orange",
    "Operation Orange LLC",
    "Scott Aulds",
    "Shawn Leary",
    "WasteWatt Ventures LLC",
    "Zapata II, LLC",
]

print("\n\nPartners found in Customers list:")
for customer in df["customer_name"].tolist():
    for partner in partners:
        if partner.lower() in customer.lower():
            print(f"  - {customer}")
