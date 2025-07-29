#!/usr/bin/env python3
"""Save QuickBooks tokens directly"""

import json
from datetime import datetime, timedelta
from supabase import create_client
import os
from dotenv import load_dotenv

load_dotenv()

# Your tokens
REALM_ID = "9341453094722519"
REFRESH_TOKEN = "RT1-78-H0-1762478385rtbyfsdxkc6e6ahiuk12"
ACCESS_TOKEN = "eyJhbGciOiJkaXIiLCJlbmMiOiJBMTI4Q0JDLUhTMjU2IiwieC5vcmciOiJIMCJ9.._yg-4Sx1-K9rS4EnsGd_-Q.Z0Rmn5tmTsDqC4-BJVzS9VcCMdrimcFB4DA56t158IV-xf2CX_qjt6lRV_a2vihV9Mab3tJPirQXC5q91U04rsCvoqBCexD93FLTsZj8sv8Y2dELLNQXTnTw0jW0qYT9cB4sIclQttLV6tXTINbSdzEVj19X4OxEvnygz2_5Q48HyA5fFz_Ut6RFZIkKaEvM8kMF7S4k3iVqqLQaF82msA364wv9gc-dH-Mdp_gDYlkdTlB1klSVjRPyRpqOhQUE5Jz4HUWTTCv8s03gikpQVLTHglKF0Nf1o89xQcJgF4o6m9TcURm6-3_LmtdVM3x3VcDxgcJf3Dxf5_DNcT_iKn9_Dz-qMshfP37qKU3haSy0jkeyYjArNYJjF3kIHc3oTcYSDORAfiPnS2KbSx2JKX0YCnw8glJzq3P8gDbvftCgqGy0GzbQec7KywcTK0TKO2WXAywdmFn_qaAdagV7D4tXkhY9siiNg6NsK-sgNsH37oFCN4V2-AiwwbYEA5ZFA98smlaU49QHGcIAUsCa6aFbGapeIlIUgA1wOY5WmimBHcpwuQFT8-FNtnKmWEORy5GfwZ4AVrj09U8I0d9B5Sb-wean_WA7EuLD0pFLf2zQdPNCRwMqgjqPUVzimlK_.RCk9i725LTAw8JTSZPPAMA"

# Initialize Supabase
supabase = create_client(os.getenv("SUPABASE_URL"), os.getenv("SUPABASE_SERVICE_KEY"))

print("Setting up QuickBooks connection...")

# 1. Save tokens locally for the API
local_tokens = {
    "access_token": ACCESS_TOKEN,
    "refresh_token": REFRESH_TOKEN,
    "realm_id": REALM_ID,
    "token_expires_at": (
        datetime.now() + timedelta(hours=1)
    ).isoformat(),  # Access tokens typically expire in 1 hour
}

with open(".quickbooks_token.json", "w") as f:
    json.dump(local_tokens, f, indent=2)

print("✅ Saved tokens locally")

# 2. Create/update company in Supabase
company_data = {
    "company_id_display": "10NET",
    "name": "10NetZero, Inc.",
    "quickbooks_realm_id": REALM_ID,
    "quickbooks_sync_enabled": True,
}

# Check if company exists
existing_company = (
    supabase.table("companies")
    .select("*")
    .eq("quickbooks_realm_id", REALM_ID)
    .execute()
)

if existing_company.data:
    company_id = existing_company.data[0]["id"]
    # Update existing
    supabase.table("companies").update(company_data).eq("id", company_id).execute()
    print(f"✅ Updated existing company: {company_id}")
else:
    # Create new
    result = supabase.table("companies").insert(company_data).execute()
    company_id = result.data[0]["id"]
    print(f"✅ Created new company: {company_id}")

# 3. Save auth tokens to Supabase
auth_data = {
    "company_id": company_id,
    "realm_id": REALM_ID,
    "access_token": ACCESS_TOKEN,
    "refresh_token": REFRESH_TOKEN,
    "token_expires_at": (datetime.now() + timedelta(hours=1)).isoformat(),
    "is_active": True,
}

# Remove any existing auth for this company
supabase.table("quickbooks_auth").update({"is_active": False}).eq(
    "company_id", company_id
).execute()

# Insert new auth
result = supabase.table("quickbooks_auth").insert(auth_data).execute()
print(f"✅ Saved auth tokens to Supabase")

print(f"\n🎉 QuickBooks connection complete!")
print(f"Company ID: {company_id}")
print(f"Realm ID: {REALM_ID}")
print("\nYou can now test the connection with:")
print("python src/quickbooks/quickbooks_api.py company")
