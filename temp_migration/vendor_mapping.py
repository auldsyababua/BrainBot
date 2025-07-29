#!/usr/bin/env python3
"""
QuickBooks to Supabase Vendor Mapping
Categorizes 84 QuickBooks vendors into operational vendors vs service vendors
"""

import pandas as pd
import uuid


def load_vendors():
    """Load vendors from QuickBooks export"""
    df = pd.read_excel(
        "lists/Vendors.xlsx", sheet_name="Vendor Contact List", skiprows=3
    )
    df.columns = [
        "empty",
        "vendor_name",
        "phone",
        "email",
        "full_name",
        "address",
        "account_number",
    ]
    df = df[df["vendor_name"].notna()]
    df = df[df["vendor_name"] != "Vendor"]
    return df


def categorize_vendors():
    """Categorize vendors into operational, service, and low-priority groups"""

    # HIGH PRIORITY - Core operational vendors (should be in vendors table)
    # Categories must match Supabase constraint: Hardware, Software, Consumables, Services, Logistics, Other
    operational_vendors = {
        "Upstream Data": {
            "category": "Hardware",
            "priority": "high",
            "description": "Bitcoin mining equipment supplier",
        },
        "United Oilfield Services": {
            "category": "Services",
            "priority": "high",
            "description": "Oilfield operations and maintenance",
        },
        "GT Oilfield Repairs, Inc.": {
            "category": "Services",
            "priority": "high",
            "description": "Equipment repair and maintenance",
        },
        "Encore Oilfield Services, LLC": {
            "category": "Services",
            "priority": "high",
            "description": "Oilfield operations services",
        },
        "TriC Resources": {
            "category": "Services",
            "priority": "high",
            "description": "Technical consulting services",
        },
        "Martin Legal PLLC": {
            "category": "Services",
            "priority": "high",
            "description": "Legal counsel",
        },
        "Unchained Capital": {
            "category": "Services",
            "priority": "high",
            "description": "Bitcoin financial services",
        },
        "Barbee Crane": {
            "category": "Services",
            "priority": "medium",
            "description": "Crane services",
        },
        "Bobcat Crane": {
            "category": "Services",
            "priority": "medium",
            "description": "Crane services",
        },
        "GT Crane": {
            "category": "Services",
            "priority": "medium",
            "description": "Crane services",
        },
        "F3X Energy Services": {
            "category": "Services",
            "priority": "medium",
            "description": "Energy consulting/services",
        },
        "Giga Energy Inc.": {
            "category": "Services",
            "priority": "medium",
            "description": "Energy services",
        },
        "McKain Power Systems": {
            "category": "Hardware",
            "priority": "medium",
            "description": "Power generation equipment",
        },
        "Schillereff Power Generation": {
            "category": "Services",
            "priority": "medium",
            "description": "Power generation services",
        },
        "Cactus Tanks": {
            "category": "Hardware",
            "priority": "medium",
            "description": "Tank equipment",
        },
        "Hard Core Supply LLC": {
            "category": "Consumables",
            "priority": "medium",
            "description": "Industrial supplies",
        },
        "Single Source Supply LLC": {
            "category": "Consumables",
            "priority": "medium",
            "description": "Industrial supplies",
        },
        "Spindletop Energy Products": {
            "category": "Consumables",
            "priority": "medium",
            "description": "Energy products supplier",
        },
        "Petroleum Producing Services": {
            "category": "Services",
            "priority": "medium",
            "description": "Petroleum production services",
        },
        "Kebo Oil and Gas": {
            "category": "Services",
            "priority": "medium",
            "description": "Oil and gas services",
        },
        "Murillo Lease Service LLC": {
            "category": "Services",
            "priority": "medium",
            "description": "Lease management services",
        },
        "Maarschalk Valuations Inc": {
            "category": "Services",
            "priority": "medium",
            "description": "Asset valuation services",
        },
        "Holt CAT": {
            "category": "Hardware",
            "priority": "medium",
            "description": "Caterpillar equipment dealer",
        },
        "Mustang CAT": {
            "category": "Hardware",
            "priority": "medium",
            "description": "Caterpillar equipment dealer",
        },
    }

    # MEDIUM PRIORITY - Important service vendors
    service_vendors = {
        "AT&T": {"category": "Telecommunications", "priority": "medium"},
        "Chase Bank": {"category": "Banking", "priority": "medium"},
        "Gusto": {"category": "Payroll Services", "priority": "medium"},
        "FedEx": {"category": "Shipping", "priority": "medium"},
        "UPS": {"category": "Shipping", "priority": "medium"},
        "Express Transport": {"category": "Transportation", "priority": "medium"},
        "Enterprise Rent-A-Car": {"category": "Vehicle Rental", "priority": "medium"},
        "QuickBooks Payments": {"category": "Payment Processing", "priority": "medium"},
        "Adobe": {"category": "Software", "priority": "low"},
        "LinkedIn": {"category": "Software", "priority": "low"},
        "Expedia": {"category": "Travel", "priority": "low"},
    }

    # LOW PRIORITY - Retail/restaurants (probably not needed in vendors table)
    retail_vendors = [
        "Academy Sports",
        "Amazon",
        "AutoZone",
        "Best Buy",
        "Home Depot",
        "Lowe's",
        "Harbor Freight Tools",
        "Tractor Supply",
        "Target",
        "Walmart",
        "Sam's Club",
        "Dollar General",
        "Costco Gas",
        "Zoro Tools",
    ]

    restaurant_vendors = [
        "Arby's",
        "Chick-Fil-A",
        "Chipotle",
        "Jack in the Box",
        "Jersey Mike's",
        "Panda Express",
        "Papa John's",
        "Sonic",
        "Starbucks",
        "Subway",
        "Taco Bell",
        "Whataburger",
        "Zaxby's",
    ]

    gas_station_vendors = [
        "BP",
        "Chevron",
        "Circle K",
        "Exxon",
        "Flying J",
        "Kroger Fuel",
        "Love's Country Stores",
        "Murphy Express",
        "Pilot",
        "Shell",
        "Sunoco",
    ]

    return (
        operational_vendors,
        service_vendors,
        retail_vendors,
        restaurant_vendors,
        gas_station_vendors,
    )


def generate_vendor_sql():
    """Generate SQL INSERT statements for operational vendors"""
    df = load_vendors()
    (
        operational_vendors,
        service_vendors,
        retail_vendors,
        restaurant_vendors,
        gas_station_vendors,
    ) = categorize_vendors()

    sql_statements = []
    vendor_id_counter = 1

    # Process operational vendors
    for vendor_name in df["vendor_name"].tolist():
        if vendor_name in operational_vendors:
            vendor_info = operational_vendors[vendor_name]
            vendor_row = df[df["vendor_name"] == vendor_name].iloc[0]

            vendor_id = f"VEND-{vendor_id_counter:04d}"
            uuid_val = str(uuid.uuid4())

            # Clean up data - handle pandas NaN values
            phone = str(vendor_row.get("phone", "")).replace("nan", "")
            email = str(vendor_row.get("email", "")).replace("nan", "")
            address = str(vendor_row.get("address", "")).replace("nan", "")

            sql = f"""INSERT INTO vendors (
    id, vendor_id_display, vendor_name, vendor_category, 
    primary_contact_phone, primary_contact_email, 
    preferred_vendor, is_active, created_at, updated_at
) VALUES (
    '{uuid_val}',
    '{vendor_id}',
    '{vendor_name}',
    '{vendor_info["category"]}',
    '{phone}',
    '{email}',
    {vendor_info["priority"] == "high"},
    true,
    NOW(),
    NOW()
) ON CONFLICT DO NOTHING;"""

            sql_statements.append(sql)
            vendor_id_counter += 1

    return sql_statements


def print_categorization_report():
    """Print detailed categorization report"""
    df = load_vendors()
    (
        operational_vendors,
        service_vendors,
        retail_vendors,
        restaurant_vendors,
        gas_station_vendors,
    ) = categorize_vendors()

    print("QUICKBOOKS TO SUPABASE VENDOR MAPPING REPORT")
    print("=" * 60)
    print(f"Total QuickBooks Vendors: {len(df)}")

    print("\n🏭 OPERATIONAL VENDORS (Import to vendors table)")
    print("-" * 50)
    high_priority = []
    medium_priority = []

    for vendor_name in df["vendor_name"].tolist():
        if vendor_name in operational_vendors:
            vendor_info = operational_vendors[vendor_name]
            if vendor_info["priority"] == "high":
                high_priority.append((vendor_name, vendor_info))
            else:
                medium_priority.append((vendor_name, vendor_info))

    print(f"\nHIGH PRIORITY ({len(high_priority)} vendors):")
    for name, info in high_priority:
        print(f"  ✅ {name} - {info['category']}")

    print(f"\nMEDIUM PRIORITY ({len(medium_priority)} vendors):")
    for name, info in medium_priority:
        print(f"  📋 {name} - {info['category']}")

    print(
        f"\n💼 SERVICE VENDORS ({len([v for v in df['vendor_name'] if v in service_vendors])} vendors):"
    )
    for vendor_name in df["vendor_name"].tolist():
        if vendor_name in service_vendors:
            print(f"  📞 {vendor_name} - {service_vendors[vendor_name]['category']}")

    print(
        f"\n🛒 RETAIL VENDORS ({len([v for v in df['vendor_name'] if v in retail_vendors])} vendors):"
    )
    for vendor_name in df["vendor_name"].tolist():
        if vendor_name in retail_vendors:
            print(f"  🏪 {vendor_name}")

    print(
        f"\n🍔 RESTAURANT VENDORS ({len([v for v in df['vendor_name'] if v in restaurant_vendors])} vendors):"
    )
    for vendor_name in df["vendor_name"].tolist():
        if vendor_name in restaurant_vendors:
            print(f"  🍽️ {vendor_name}")

    print(
        f"\n⛽ GAS STATION VENDORS ({len([v for v in df['vendor_name'] if v in gas_station_vendors])} vendors):"
    )
    for vendor_name in df["vendor_name"].tolist():
        if vendor_name in gas_station_vendors:
            print(f"  ⛽ {vendor_name}")

    # Uncategorized
    all_categorized = (
        set(operational_vendors.keys())
        | set(service_vendors.keys())
        | set(retail_vendors)
        | set(restaurant_vendors)
        | set(gas_station_vendors)
    )
    uncategorized = [v for v in df["vendor_name"].tolist() if v not in all_categorized]

    print(f"\n❓ UNCATEGORIZED ({len(uncategorized)} vendors):")
    for vendor_name in uncategorized:
        print(f"  ❓ {vendor_name}")

    total_operational = len([v for v in df["vendor_name"] if v in operational_vendors])
    print(f"\n📊 SUMMARY:")
    print(f"  Operational vendors to import: {total_operational}")
    print(
        f"  Service vendors (optional): {len([v for v in df['vendor_name'] if v in service_vendors])}"
    )
    print(
        f"  Low-priority vendors: {len(retail_vendors) + len(restaurant_vendors) + len(gas_station_vendors)}"
    )
    print(f"  Uncategorized: {len(uncategorized)}")


if __name__ == "__main__":
    print_categorization_report()

    print("\n" + "=" * 60)
    print("GENERATING SQL STATEMENTS FOR OPERATIONAL VENDORS")
    print("=" * 60)

    sql_statements = generate_vendor_sql()

    with open("insert_vendors.sql", "w") as f:
        f.write("-- Insert operational vendors into Supabase vendors table\n")
        f.write("-- Generated from QuickBooks vendor export\n\n")
        for sql in sql_statements:
            f.write(sql + "\n\n")

    print(f"Generated {len(sql_statements)} SQL INSERT statements")
    print("Saved to: insert_vendors.sql")
