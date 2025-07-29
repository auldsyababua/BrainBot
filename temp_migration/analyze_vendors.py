import pandas as pd

# Read vendors data
df = pd.read_excel(
    "transactions/Vendors.xlsx", sheet_name="Vendor Contact List", skiprows=3
)

# Clean up column names
df.columns = [
    "empty",
    "vendor_name",
    "phone",
    "email",
    "full_name",
    "address",
    "account_number",
]

# Remove empty rows and header rows
df = df[df["vendor_name"].notna()]
df = df[df["vendor_name"] != "Vendor"]

print("\nAll Vendors from QuickBooks Export:")
print("=" * 60)
for idx, vendor in enumerate(df["vendor_name"].tolist(), 1):
    print(f"{idx:2d}. {vendor}")

print(f"\nTotal vendors: {len(df)}")

# Now categorize based on your input
contractors_suppliers = [
    "Alpha Centauri Contractors",
    "Asics Miners US",
    "Ballard Law",
    "Heatcore Inc",
    "Upstream Data",
    "Vibe Energy Systems",
]

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

print("\n\nCATEGORIZATION:")
print("=" * 60)

print("\nContractors/Suppliers (should be in vendors table):")
for vendor in df["vendor_name"].tolist():
    for contractor in contractors_suppliers:
        if contractor.lower() in vendor.lower():
            print(f"  - {vendor}")
            break

print("\nPartners (should be in partners table):")
for vendor in df["vendor_name"].tolist():
    for partner in partners:
        if partner.lower() in vendor.lower():
            print(f"  - {vendor}")
            break

print("\nUncategorized (need classification):")
for vendor in df["vendor_name"].tolist():
    is_contractor = any(c.lower() in vendor.lower() for c in contractors_suppliers)
    is_partner = any(p.lower() in vendor.lower() for p in partners)
    if not is_contractor and not is_partner:
        print(f"  - {vendor}")
