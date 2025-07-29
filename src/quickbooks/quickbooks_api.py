"""Direct QuickBooks API Access - No webhooks needed"""

import os
import json
import webbrowser
from datetime import datetime, timedelta
from typing import Dict, Any, List, Optional
import httpx
from dotenv import load_dotenv
import logging

# Load environment variables
load_dotenv()

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# QuickBooks configuration
QB_CLIENT_ID = os.getenv("QB_CLIENT_ID")
QB_CLIENT_SECRET = os.getenv("QB_CLIENT_SECRET")
QB_ENVIRONMENT = os.getenv("QB_ENVIRONMENT", "sandbox")
QB_REDIRECT_URI = "https://developer.intuit.com/v2/OAuth2Playground/RedirectUrl"  # Use Intuit's OAuth playground

# QuickBooks API URLs
if QB_ENVIRONMENT == "production":
    QB_AUTH_URL = "https://oauth.platform.intuit.com/oauth2"
    QB_API_URL = "https://quickbooks.api.intuit.com"
else:
    QB_AUTH_URL = "https://oauth.platform.intuit.com/oauth2"
    QB_API_URL = "https://sandbox-quickbooks.api.intuit.com"

# Token storage (in production, store this securely)
TOKEN_FILE = ".quickbooks_token.json"


class QuickBooksAPI:
    def __init__(self):
        self.access_token = None
        self.refresh_token = None
        self.realm_id = None
        self.token_expires_at = None
        self.load_tokens()

    def load_tokens(self):
        """Load tokens from file if they exist"""
        if os.path.exists(TOKEN_FILE):
            try:
                with open(TOKEN_FILE, "r") as f:
                    data = json.load(f)
                    self.access_token = data.get("access_token")
                    self.refresh_token = data.get("refresh_token")
                    self.realm_id = data.get("realm_id")
                    self.token_expires_at = datetime.fromisoformat(
                        data.get("token_expires_at", "2000-01-01")
                    )
                    logger.info(f"Loaded tokens for company {self.realm_id}")
            except Exception as e:
                logger.error(f"Error loading tokens: {e}")

    def save_tokens(self):
        """Save tokens to file"""
        data = {
            "access_token": self.access_token,
            "refresh_token": self.refresh_token,
            "realm_id": self.realm_id,
            "token_expires_at": (
                self.token_expires_at.isoformat() if self.token_expires_at else None
            ),
        }
        with open(TOKEN_FILE, "w") as f:
            json.dump(data, f, indent=2)
        logger.info("Tokens saved")

    def get_auth_url(self) -> str:
        """Get the authorization URL for OAuth flow"""
        auth_url = (
            f"{QB_AUTH_URL}/authorize?"
            f"client_id={QB_CLIENT_ID}&"
            f"response_type=code&"
            f"scope=com.intuit.quickbooks.accounting openid profile email&"
            f"redirect_uri={QB_REDIRECT_URI}&"
            f"state=security_token"
        )
        return auth_url

    def connect(self):
        """Start OAuth connection flow"""
        auth_url = self.get_auth_url()
        print("\nTo connect to QuickBooks:")
        print("1. Open this URL in your browser:")
        print(f"\n{auth_url}\n")
        print("2. Authorize the application")
        print("3. Copy the authorization code from the redirect URL")
        print("   (It will be in the URL after 'code=')")
        print("\nOpening browser...")

        webbrowser.open(auth_url)

        code = input("\nEnter the authorization code: ").strip()
        realm_id = input("Enter the Company ID (realmId from the URL): ").strip()

        # Exchange code for tokens
        self.exchange_code_for_tokens(code, realm_id)

    def exchange_code_for_tokens(self, code: str, realm_id: str):
        """Exchange authorization code for access tokens"""
        try:
            response = httpx.post(
                f"{QB_AUTH_URL}/tokens/bearer",
                data={
                    "grant_type": "authorization_code",
                    "code": code,
                    "redirect_uri": QB_REDIRECT_URI,
                },
                auth=(QB_CLIENT_ID, QB_CLIENT_SECRET),
                headers={"Accept": "application/json"},
            )

            if response.status_code == 200:
                tokens = response.json()
                self.access_token = tokens["access_token"]
                self.refresh_token = tokens["refresh_token"]
                self.realm_id = realm_id
                self.token_expires_at = datetime.now() + timedelta(
                    seconds=tokens["expires_in"]
                )
                self.save_tokens()
                print("\n✅ Successfully connected to QuickBooks!")
                print(f"Company ID: {self.realm_id}")
            else:
                print(f"\n❌ Error: {response.text}")
        except Exception as e:
            print(f"\n❌ Error exchanging code: {e}")

    def ensure_valid_token(self):
        """Ensure we have a valid access token, refreshing if needed"""
        if not self.access_token or not self.refresh_token:
            raise Exception("Not authenticated. Run 'connect' first.")

        if datetime.now() >= self.token_expires_at - timedelta(minutes=5):
            self.refresh_access_token()

    def refresh_access_token(self):
        """Refresh the access token"""
        try:
            response = httpx.post(
                f"{QB_AUTH_URL}/tokens/bearer",
                data={
                    "grant_type": "refresh_token",
                    "refresh_token": self.refresh_token,
                },
                auth=(QB_CLIENT_ID, QB_CLIENT_SECRET),
                headers={"Accept": "application/json"},
            )

            if response.status_code == 200:
                tokens = response.json()
                self.access_token = tokens["access_token"]
                self.refresh_token = tokens["refresh_token"]
                self.token_expires_at = datetime.now() + timedelta(
                    seconds=tokens["expires_in"]
                )
                self.save_tokens()
                logger.info("Token refreshed successfully")
            else:
                raise Exception(f"Token refresh failed: {response.text}")
        except Exception as e:
            logger.error(f"Error refreshing token: {e}")
            raise

    def api_request(
        self,
        method: str,
        endpoint: str,
        data: Optional[Dict] = None,
        params: Optional[Dict] = None,
    ) -> Dict[str, Any]:
        """Make an API request to QuickBooks"""
        self.ensure_valid_token()

        url = f"{QB_API_URL}/v3/company/{self.realm_id}/{endpoint}"
        headers = {
            "Authorization": f"Bearer {self.access_token}",
            "Accept": "application/json",
            "Content-Type": "application/json",
        }

        response = httpx.request(
            method=method, url=url, headers=headers, json=data, params=params
        )

        response.raise_for_status()
        return response.json()

    # COMPANY INFO
    def get_company_info(self) -> Dict[str, Any]:
        """Get company information"""
        result = self.api_request("GET", "companyinfo/1")
        return result.get("CompanyInfo", {})

    # ACCOUNTS
    def get_accounts(self, active_only: bool = True) -> List[Dict[str, Any]]:
        """Get all accounts"""
        query = "SELECT * FROM Account"
        if active_only:
            query += " WHERE Active = true"
        query += " ORDERBY Name"

        result = self.api_request("GET", "query", params={"query": query})
        return result.get("QueryResponse", {}).get("Account", [])

    def create_account(
        self, name: str, account_type: str, account_sub_type: str
    ) -> Dict[str, Any]:
        """Create a new account"""
        data = {
            "Name": name,
            "AccountType": account_type,
            "AccountSubType": account_sub_type,
        }
        result = self.api_request("POST", "account", data=data)
        return result.get("Account", {})

    # CUSTOMERS
    def get_customers(self, active_only: bool = True) -> List[Dict[str, Any]]:
        """Get all customers"""
        query = "SELECT * FROM Customer"
        if active_only:
            query += " WHERE Active = true"
        query += " ORDERBY DisplayName"

        result = self.api_request("GET", "query", params={"query": query})
        return result.get("QueryResponse", {}).get("Customer", [])

    def get_customer(self, customer_id: str) -> Dict[str, Any]:
        """Get a specific customer"""
        result = self.api_request("GET", f"customer/{customer_id}")
        return result.get("Customer", {})

    def create_customer(
        self,
        display_name: str,
        email: Optional[str] = None,
        phone: Optional[str] = None,
    ) -> Dict[str, Any]:
        """Create a new customer"""
        data = {"DisplayName": display_name}

        if email:
            data["PrimaryEmailAddr"] = {"Address": email}
        if phone:
            data["PrimaryPhone"] = {"FreeFormNumber": phone}

        result = self.api_request("POST", "customer", data=data)
        return result.get("Customer", {})

    def update_customer(
        self, customer_id: str, updates: Dict[str, Any]
    ) -> Dict[str, Any]:
        """Update a customer"""
        # First get the current customer to get SyncToken
        customer = self.get_customer(customer_id)

        # Merge updates
        customer.update(updates)

        result = self.api_request("POST", "customer", data=customer)
        return result.get("Customer", {})

    # INVOICES
    def get_invoices(self, customer_id: Optional[str] = None) -> List[Dict[str, Any]]:
        """Get invoices, optionally filtered by customer"""
        query = "SELECT * FROM Invoice"
        if customer_id:
            query += f" WHERE CustomerRef = '{customer_id}'"
        query += " ORDERBY TxnDate DESC"

        result = self.api_request("GET", "query", params={"query": query})
        return result.get("QueryResponse", {}).get("Invoice", [])

    def create_invoice(
        self,
        customer_id: str,
        line_items: List[Dict[str, Any]],
        due_date: Optional[str] = None,
    ) -> Dict[str, Any]:
        """Create a new invoice"""
        data = {"CustomerRef": {"value": customer_id}, "Line": line_items}

        if due_date:
            data["DueDate"] = due_date

        result = self.api_request("POST", "invoice", data=data)
        return result.get("Invoice", {})

    # JOURNAL ENTRIES
    def get_journal_entries(
        self, start_date: Optional[str] = None
    ) -> List[Dict[str, Any]]:
        """Get journal entries"""
        query = "SELECT * FROM JournalEntry"
        if start_date:
            query += f" WHERE TxnDate >= '{start_date}'"
        query += " ORDERBY TxnDate DESC"

        result = self.api_request("GET", "query", params={"query": query})
        return result.get("QueryResponse", {}).get("JournalEntry", [])

    def create_journal_entry(
        self, date: str, lines: List[Dict[str, Any]], memo: Optional[str] = None
    ) -> Dict[str, Any]:
        """Create a journal entry"""
        data = {"TxnDate": date, "Line": lines}

        if memo:
            data["PrivateNote"] = memo

        result = self.api_request("POST", "journalentry", data=data)
        return result.get("JournalEntry", {})

    # REPORTS
    def get_balance_sheet(self, as_of_date: Optional[str] = None) -> Dict[str, Any]:
        """Get balance sheet report"""
        params = {}
        if as_of_date:
            params["date_macro"] = as_of_date

        return self.api_request("GET", "reports/BalanceSheet", params=params)

    def get_profit_and_loss(
        self, start_date: Optional[str] = None, end_date: Optional[str] = None
    ) -> Dict[str, Any]:
        """Get profit and loss report"""
        params = {}
        if start_date:
            params["start_date"] = start_date
        if end_date:
            params["end_date"] = end_date

        return self.api_request("GET", "reports/ProfitAndLoss", params=params)

    # UTILITY METHODS
    def query(self, query_string: str) -> Dict[str, Any]:
        """Run a custom query"""
        return self.api_request("GET", "query", params={"query": query_string})

    def get_entity(self, entity_type: str, entity_id: str) -> Dict[str, Any]:
        """Get any entity by type and ID"""
        result = self.api_request("GET", f"{entity_type.lower()}/{entity_id}")
        return result.get(entity_type, {})

    def delete_entity(
        self, entity_type: str, entity_id: str, sync_token: str
    ) -> Dict[str, Any]:
        """Delete an entity (actually marks as inactive)"""
        data = {"Id": entity_id, "SyncToken": sync_token, "Active": False}
        result = self.api_request("POST", entity_type.lower(), data=data)
        return result.get(entity_type, {})


# Simple CLI interface
if __name__ == "__main__":
    import sys

    qb = QuickBooksAPI()

    if len(sys.argv) < 2:
        print("QuickBooks API CLI")
        print("==================")
        print("")
        print("Commands:")
        print("  connect                    - Connect to QuickBooks")
        print("  company                    - Show company info")
        print("  accounts                   - List all accounts")
        print("  customers                  - List all customers")
        print("  invoices [customer_id]     - List invoices")
        print("  journal_entries            - List recent journal entries")
        print("  balance_sheet              - Get balance sheet")
        print("  profit_loss                - Get P&L report")
        print("  query <SQL>                - Run custom query")
        sys.exit(1)

    command = sys.argv[1]

    try:
        if command == "connect":
            qb.connect()

        elif command == "company":
            info = qb.get_company_info()
            print(f"\nCompany: {info.get('CompanyName')}")
            print(f"Legal Name: {info.get('LegalName')}")
            print(f"Address: {info.get('CompanyAddr', {}).get('Line1')}")
            print(f"Country: {info.get('Country')}")
            print(f"Fiscal Year Start: {info.get('FiscalYearStartMonth')}")

        elif command == "accounts":
            accounts = qb.get_accounts()
            print(f"\nFound {len(accounts)} accounts:\n")
            for acc in accounts:
                print(
                    f"  {acc['AccountType']:20} {acc['Name']:30} Balance: ${acc.get('CurrentBalance', 0):,.2f}"
                )

        elif command == "customers":
            customers = qb.get_customers()
            print(f"\nFound {len(customers)} customers:\n")
            for cust in customers:
                balance = float(cust.get("Balance", 0))
                print(f"  {cust['DisplayName']:30} Balance: ${balance:,.2f}")

        elif command == "invoices":
            customer_id = sys.argv[2] if len(sys.argv) > 2 else None
            invoices = qb.get_invoices(customer_id)
            print(f"\nFound {len(invoices)} invoices:\n")
            for inv in invoices:
                print(
                    f"  #{inv['DocNumber']:10} {inv['TxnDate']} ${float(inv.get('TotalAmt', 0)):,.2f} - Customer: {inv['CustomerRef']['name']}"
                )

        elif command == "journal_entries":
            entries = qb.get_journal_entries()
            print(f"\nFound {len(entries)} journal entries:\n")
            for entry in entries[:10]:  # Show only first 10
                total = sum(
                    float(line.get("Amount", 0))
                    for line in entry.get("Line", [])
                    if line.get("JournalEntryLineDetail", {}).get("PostingType")
                    == "Debit"
                )
                print(
                    f"  {entry['TxnDate']} #{entry.get('DocNumber', 'N/A'):10} ${total:,.2f}"
                )

        elif command == "balance_sheet":
            report = qb.get_balance_sheet()
            print("\nBalance Sheet")
            print("=============")
            print(json.dumps(report, indent=2))

        elif command == "profit_loss":
            report = qb.get_profit_and_loss()
            print("\nProfit & Loss")
            print("=============")
            print(json.dumps(report, indent=2))

        elif command == "query" and len(sys.argv) > 2:
            query = " ".join(sys.argv[2:])
            result = qb.query(query)
            print(json.dumps(result, indent=2))

        else:
            print(f"Unknown command: {command}")

    except Exception as e:
        print(f"\nError: {e}")
        if "Not authenticated" in str(e):
            print("\nRun 'python quickbooks_api.py connect' to authenticate first.")
