#!/usr/bin/env python3
"""Save QuickBooks connection to Supabase directly"""

import json
from datetime import datetime, timedelta
from supabase import create_client
import os
from dotenv import load_dotenv

load_dotenv()

# Your realm ID from the OAuth flow
REALM_ID = "9341453094722519"

# Initialize Supabase
supabase = create_client(os.getenv("SUPABASE_URL"), os.getenv("SUPABASE_SERVICE_KEY"))

# First, let's create the company if it doesn't exist
company_data = {
    "company_id_display": "10NET",
    "name": "10NetZero, Inc.",
    "quickbooks_realm_id": REALM_ID,
    "quickbooks_sync_enabled": True,
}

print("Setting up 10NetZero company...")

# Check if company exists
existing_company = (
    supabase.table("companies")
    .select("*")
    .eq("quickbooks_realm_id", REALM_ID)
    .execute()
)

if existing_company.data:
    company_id = existing_company.data[0]["id"]
    print(f"Found existing company: {company_id}")
else:
    # Create company
    result = supabase.table("companies").insert(company_data).execute()
    company_id = result.data[0]["id"]
    print(f"Created new company: {company_id}")

print(f"\nCompany ID: {company_id}")
print(f"Realm ID: {REALM_ID}")
print("\nTo complete the connection, you'll need to provide fresh OAuth tokens.")
print("The tokens from your previous OAuth flow have expired.")
print("\nRun this to get new tokens:")
print(f"python quickbooks_connect.py")
print("\nThen once you get the code and realm ID:")
print(f"python quickbooks_auth.py YOUR_NEW_CODE {REALM_ID}")
