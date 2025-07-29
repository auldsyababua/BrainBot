#!/usr/bin/env python3
"""QuickBooks Connection Helper"""

import webbrowser
from src.quickbooks.quickbooks_api import QuickBooksAPI

# Create API instance
qb = QuickBooksAPI()

# Get auth URL
auth_url = qb.get_auth_url()

print("QuickBooks OAuth Connection")
print("==========================\n")
print("Step 1: Open this URL in your browser:\n")
print(auth_url)
print("\n" + "=" * 80 + "\n")

print("Step 2: After authorizing, you'll be redirected to:")
print(
    "https://developer.intuit.com/v2/OAuth2Playground/RedirectUrl?code=...&realmId=...\n"
)

print("Step 3: Copy the values from the URL:")
print("- The 'code' parameter (after ?code=)")
print("- The 'realmId' parameter (your Company ID)\n")

print("Step 4: Run this command with your values:")
print("python quickbooks_auth.py YOUR_CODE YOUR_REALM_ID\n")

print("Opening browser...")
webbrowser.open(auth_url)

print("\nExample:")
print(
    "python quickbooks_auth.py AB11234567890abcdef1234567890abcdef12345 123456789012345"
)
