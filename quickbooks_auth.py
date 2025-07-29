#!/usr/bin/env python3
"""Complete QuickBooks OAuth Authentication"""

import sys
from src.quickbooks.quickbooks_api import QuickBooksAPI

if len(sys.argv) != 3:
    print("Usage: python quickbooks_auth.py <code> <realm_id>")
    print("\nExample:")
    print(
        "python quickbooks_auth.py AB11234567890abcdef1234567890abcdef12345 123456789012345"
    )
    sys.exit(1)

code = sys.argv[1]
realm_id = sys.argv[2]

print(f"\nAuthenticating with:")
print(f"Code: {code[:20]}...")
print(f"Company ID (realmId): {realm_id}")
print()

# Create API instance and exchange code
qb = QuickBooksAPI()
qb.exchange_code_for_tokens(code, realm_id)

print("\nTesting connection...")
try:
    # Test by getting company info
    company_info = qb.get_company_info()
    print(f"\n✅ Successfully connected to: {company_info.get('CompanyName')}")
    print(f"Legal Name: {company_info.get('LegalName')}")
    print(f"Country: {company_info.get('Country')}")
    print("\nYou can now use the QuickBooks API!")
except Exception as e:
    print(f"\n❌ Connection test failed: {e}")
    print("Please check your credentials and try again.")
