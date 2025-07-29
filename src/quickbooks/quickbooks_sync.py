"""QuickBooks Data Sync Script - Pull and Push Data"""

import os
import json
import asyncio
from datetime import datetime, timedelta
from typing import Dict, Any, List, Optional
import httpx
from supabase import create_client, Client
from dotenv import load_dotenv
import logging
from rich.console import Console
from rich.table import Table
from rich.progress import track

# Load environment variables
load_dotenv()

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Rich console for pretty output
console = Console()

# Initialize Supabase client
supabase: Client = create_client(
    os.getenv("SUPABASE_URL"), os.getenv("SUPABASE_SERVICE_KEY")
)

# QuickBooks configuration
QB_CLIENT_ID = os.getenv("QB_CLIENT_ID")
QB_CLIENT_SECRET = os.getenv("QB_CLIENT_SECRET")
QB_ENVIRONMENT = os.getenv("QB_ENVIRONMENT", "sandbox")

# QuickBooks API URLs
if QB_ENVIRONMENT == "production":
    QB_API_URL = "https://quickbooks.api.intuit.com"
else:
    QB_API_URL = "https://sandbox-quickbooks.api.intuit.com"


class QuickBooksSync:
    def __init__(self, company_id: str):
        self.company_id = company_id
        self.access_token = None
        self.realm_id = None
        self.client = httpx.AsyncClient()

    async def __aenter__(self):
        await self.init_auth()
        return self

    async def __aexit__(self, exc_type, exc_val, exc_tb):
        await self.client.aclose()

    async def init_auth(self):
        """Initialize authentication"""
        # Get company and auth info
        company = (
            supabase.table("companies").select("*").eq("id", self.company_id).execute()
        )
        if not company.data:
            raise Exception(f"Company {self.company_id} not found")

        self.realm_id = company.data[0].get("quickbooks_realm_id")
        if not self.realm_id:
            raise Exception(
                "Company not connected to QuickBooks. Run connect_quickbooks() first."
            )

        # Get valid auth token
        auth = (
            supabase.table("quickbooks_auth")
            .select("*")
            .eq("company_id", self.company_id)
            .eq("is_active", True)
            .execute()
        )
        if not auth.data:
            raise Exception("No active QuickBooks authentication found")

        self.access_token = auth.data[0]["access_token"]

    async def query_api(
        self, endpoint: str, params: Optional[Dict] = None
    ) -> Dict[str, Any]:
        """Query QuickBooks API"""
        url = f"{QB_API_URL}/v3/company/{self.realm_id}/{endpoint}"
        headers = {
            "Authorization": f"Bearer {self.access_token}",
            "Accept": "application/json",
        }

        response = await self.client.get(url, headers=headers, params=params)

        if response.status_code == 401:
            # Token might be expired, try to refresh
            await self.refresh_token()
            headers["Authorization"] = f"Bearer {self.access_token}"
            response = await self.client.get(url, headers=headers, params=params)

        response.raise_for_status()
        return response.json()

    async def create_entity(
        self, entity_type: str, data: Dict[str, Any]
    ) -> Dict[str, Any]:
        """Create entity in QuickBooks"""
        url = f"{QB_API_URL}/v3/company/{self.realm_id}/{entity_type.lower()}"
        headers = {
            "Authorization": f"Bearer {self.access_token}",
            "Accept": "application/json",
            "Content-Type": "application/json",
        }

        response = await self.client.post(url, headers=headers, json=data)
        response.raise_for_status()
        return response.json()

    async def update_entity(
        self, entity_type: str, data: Dict[str, Any]
    ) -> Dict[str, Any]:
        """Update entity in QuickBooks"""
        url = f"{QB_API_URL}/v3/company/{self.realm_id}/{entity_type.lower()}"
        headers = {
            "Authorization": f"Bearer {self.access_token}",
            "Accept": "application/json",
            "Content-Type": "application/json",
        }

        response = await self.client.post(url, headers=headers, json=data)
        response.raise_for_status()
        return response.json()

    async def refresh_token(self):
        """Refresh the access token"""
        # Implementation would go here
        pass

    # PULL METHODS - Get data from QuickBooks

    async def pull_all_data(self):
        """Pull all data from QuickBooks to Supabase"""
        console.print("[bold green]Starting QuickBooks data pull...[/bold green]")

        # Pull in order of dependencies
        await self.pull_accounts()
        await self.pull_customers()
        await self.pull_vendors()
        await self.pull_employees()
        await self.pull_journal_entries()

        console.print("[bold green]✓ QuickBooks data pull complete![/bold green]")

    async def pull_accounts(self):
        """Pull Chart of Accounts from QuickBooks"""
        console.print("\n[yellow]Pulling Chart of Accounts...[/yellow]")

        # Query all accounts
        response = await self.query_api(
            "query", {"query": "SELECT * FROM Account WHERE Active = true"}
        )

        accounts = response.get("QueryResponse", {}).get("Account", [])

        for account in track(accounts, description="Syncing accounts"):
            await self.sync_account_to_supabase(account)

        console.print(f"[green]✓ Synced {len(accounts)} accounts[/green]")

    async def sync_account_to_supabase(self, account: Dict[str, Any]):
        """Sync single account to Supabase"""
        account_data = {
            "company_id": self.company_id,
            "quickbooks_account_id": account["Id"],
            "account_number": account.get("AcctNum", ""),
            "account_name": account["Name"],
            "account_type": self.map_account_type(account["AccountType"]),
            "account_subtype": account.get("AccountSubType"),
            "is_active": account.get("Active", True),
            "description": account.get("Description"),
            "quickbooks_sync_token": account.get("SyncToken"),
            "quickbooks_last_sync": datetime.utcnow().isoformat(),
            "opening_balance": float(account.get("CurrentBalance", 0)),
        }

        # Set normal balance based on classification
        classification = account.get("Classification")
        if classification in ["Asset", "Expense"]:
            account_data["normal_balance"] = "Debit"
        else:
            account_data["normal_balance"] = "Credit"

        # Check if exists
        existing = (
            supabase.table("chart_of_accounts")
            .select("id")
            .eq("company_id", self.company_id)
            .eq("quickbooks_account_id", account["Id"])
            .execute()
        )

        if existing.data:
            # Update
            supabase.table("chart_of_accounts").update(account_data).eq(
                "id", existing.data[0]["id"]
            ).execute()
        else:
            # Insert
            account_data["account_id_display"] = f"ACCT-{account['Id']}"
            supabase.table("chart_of_accounts").insert(account_data).execute()

    def map_account_type(self, qb_type: str) -> str:
        """Map QuickBooks account type to our schema"""
        type_mapping = {
            "Bank": "Asset",
            "Accounts Receivable": "Asset",
            "Other Current Asset": "Asset",
            "Fixed Asset": "Asset",
            "Other Asset": "Asset",
            "Accounts Payable": "Liability",
            "Credit Card": "Liability",
            "Long Term Liability": "Liability",
            "Other Current Liability": "Liability",
            "Equity": "Equity",
            "Income": "Income",
            "Other Income": "Income",
            "Cost of Goods Sold": "Expense",
            "Expense": "Expense",
            "Other Expense": "Expense",
        }
        return type_mapping.get(qb_type, "Asset")

    async def pull_customers(self):
        """Pull customers from QuickBooks"""
        console.print("\n[yellow]Pulling Customers...[/yellow]")

        response = await self.query_api(
            "query", {"query": "SELECT * FROM Customer WHERE Active = true"}
        )

        customers = response.get("QueryResponse", {}).get("Customer", [])

        for customer in track(customers, description="Syncing customers"):
            customer_data = {
                "company_id": self.company_id,
                "quickbooks_customer_id": customer["Id"],
                "name": customer.get("DisplayName") or customer.get("CompanyName"),
                "full_name": customer.get("FullyQualifiedName"),
                "email": customer.get("PrimaryEmailAddr", {}).get("Address"),
                "phone": customer.get("PrimaryPhone", {}).get("FreeFormNumber"),
                "is_active": customer.get("Active", True),
                "quickbooks_sync_token": customer.get("SyncToken"),
                "quickbooks_last_sync": datetime.utcnow().isoformat(),
            }

            # Get billing address
            bill_addr = customer.get("BillAddr", {})
            if bill_addr:
                customer_data["billing_address"] = self.format_address(bill_addr)

            # Check if exists
            existing = (
                supabase.table("accounting_customers")
                .select("id")
                .eq("company_id", self.company_id)
                .eq("quickbooks_customer_id", customer["Id"])
                .execute()
            )

            if existing.data:
                supabase.table("accounting_customers").update(customer_data).eq(
                    "id", existing.data[0]["id"]
                ).execute()
            else:
                customer_data["customer_id_display"] = f"CUST-{customer['Id']}"
                supabase.table("accounting_customers").insert(customer_data).execute()

        console.print(f"[green]✓ Synced {len(customers)} customers[/green]")

    def format_address(self, addr: Dict[str, Any]) -> str:
        """Format QuickBooks address to string"""
        parts = [
            addr.get("Line1"),
            addr.get("Line2"),
            addr.get("Line3"),
            addr.get("Line4"),
            addr.get("Line5"),
            f"{addr.get('City', '')}, {addr.get('CountrySubDivisionCode', '')} {addr.get('PostalCode', '')}".strip(),
            addr.get("Country"),
        ]
        return "\n".join(filter(None, parts))

    async def pull_journal_entries(self):
        """Pull journal entries from QuickBooks"""
        console.print("\n[yellow]Pulling Journal Entries...[/yellow]")

        # Get journal entries from the last 90 days
        start_date = (datetime.now() - timedelta(days=90)).strftime("%Y-%m-%d")

        response = await self.query_api(
            "query",
            {
                "query": f"SELECT * FROM JournalEntry WHERE TxnDate >= '{start_date}' ORDERBY TxnDate DESC"
            },
        )

        entries = response.get("QueryResponse", {}).get("JournalEntry", [])

        for entry in track(entries, description="Syncing journal entries"):
            await self.sync_journal_entry_to_supabase(entry)

        console.print(f"[green]✓ Synced {len(entries)} journal entries[/green]")

    async def sync_journal_entry_to_supabase(self, entry: Dict[str, Any]):
        """Sync journal entry to Supabase"""
        # Create main journal entry
        je_data = {
            "company_id": self.company_id,
            "quickbooks_journal_entry_id": entry["Id"],
            "entry_date": entry["TxnDate"],
            "transaction_type": "Journal Entry",
            "reference_number": entry.get("DocNumber"),
            "memo": entry.get("PrivateNote"),
            "quickbooks_sync_token": entry.get("SyncToken"),
            "quickbooks_last_sync": datetime.utcnow().isoformat(),
        }

        # Check if exists
        existing = (
            supabase.table("journal_entries")
            .select("id")
            .eq("company_id", self.company_id)
            .eq("quickbooks_journal_entry_id", entry["Id"])
            .execute()
        )

        if existing.data:
            je_id = existing.data[0]["id"]
            supabase.table("journal_entries").update(je_data).eq("id", je_id).execute()
            # Delete existing lines to replace
            supabase.table("journal_entry_lines").delete().eq(
                "journal_entry_id", je_id
            ).execute()
        else:
            je_data["journal_entry_id_display"] = f"JE-{entry['Id']}"
            result = supabase.table("journal_entries").insert(je_data).execute()
            je_id = result.data[0]["id"]

        # Create journal entry lines
        for idx, line in enumerate(entry.get("Line", [])):
            if line.get("JournalEntryLineDetail"):
                detail = line["JournalEntryLineDetail"]
                account_ref = detail.get("AccountRef")

                if account_ref:
                    # Get account ID from QuickBooks ID
                    account = (
                        supabase.table("chart_of_accounts")
                        .select("id")
                        .eq("company_id", self.company_id)
                        .eq("quickbooks_account_id", account_ref["value"])
                        .execute()
                    )

                    if account.data:
                        line_data = {
                            "journal_entry_id": je_id,
                            "account_id": account.data[0]["id"],
                            "line_number": idx + 1,
                            "description": line.get("Description", ""),
                        }

                        # Set debit or credit
                        posting_type = detail.get("PostingType")
                        amount = float(line.get("Amount", 0))

                        if posting_type == "Debit":
                            line_data["debit"] = amount
                            line_data["credit"] = 0
                        else:
                            line_data["debit"] = 0
                            line_data["credit"] = amount

                        supabase.table("journal_entry_lines").insert(
                            line_data
                        ).execute()

    # PUSH METHODS - Send data to QuickBooks

    async def push_customer(self, customer_id: str):
        """Push customer from Supabase to QuickBooks"""
        # Get customer from Supabase
        customer = (
            supabase.table("accounting_customers")
            .select("*")
            .eq("id", customer_id)
            .execute()
        )
        if not customer.data:
            raise Exception("Customer not found")

        cust = customer.data[0]

        # Prepare QuickBooks customer data
        qb_customer = {
            "DisplayName": cust["name"],
            "Active": cust.get("is_active", True),
        }

        if cust.get("email"):
            qb_customer["PrimaryEmailAddr"] = {"Address": cust["email"]}

        if cust.get("phone"):
            qb_customer["PrimaryPhone"] = {"FreeFormNumber": cust["phone"]}

        # Create or update in QuickBooks
        if cust.get("quickbooks_customer_id"):
            # Update existing
            qb_customer["Id"] = cust["quickbooks_customer_id"]
            qb_customer["SyncToken"] = cust.get("quickbooks_sync_token", "0")
            result = await self.update_entity("Customer", qb_customer)
        else:
            # Create new
            result = await self.create_entity("Customer", qb_customer)

        # Update Supabase with QuickBooks ID
        if result:
            customer_entity = result.get("Customer", {})
            supabase.table("accounting_customers").update(
                {
                    "quickbooks_customer_id": customer_entity["Id"],
                    "quickbooks_sync_token": customer_entity["SyncToken"],
                    "quickbooks_last_sync": datetime.utcnow().isoformat(),
                }
            ).eq("id", customer_id).execute()

        return result

    async def push_journal_entry(self, journal_entry_id: str):
        """Push journal entry from Supabase to QuickBooks"""
        # Get journal entry with lines
        je = (
            supabase.table("journal_entries")
            .select("*, journal_entry_lines(*)")
            .eq("id", journal_entry_id)
            .execute()
        )
        if not je.data:
            raise Exception("Journal entry not found")

        entry = je.data[0]

        # Prepare QuickBooks journal entry
        qb_je = {
            "TxnDate": entry["entry_date"],
            "PrivateNote": entry.get("memo", ""),
            "Line": [],
        }

        if entry.get("reference_number"):
            qb_je["DocNumber"] = entry["reference_number"]

        # Add lines
        for line in entry.get("journal_entry_lines", []):
            # Get account QuickBooks ID
            account = (
                supabase.table("chart_of_accounts")
                .select("quickbooks_account_id")
                .eq("id", line["account_id"])
                .execute()
            )

            if account.data and account.data[0].get("quickbooks_account_id"):
                qb_line = {
                    "Amount": str(
                        line["debit"] if line["debit"] > 0 else line["credit"]
                    ),
                    "Description": line.get("description", ""),
                    "JournalEntryLineDetail": {
                        "PostingType": "Debit" if line["debit"] > 0 else "Credit",
                        "AccountRef": {
                            "value": account.data[0]["quickbooks_account_id"]
                        },
                    },
                }
                qb_je["Line"].append(qb_line)

        # Create or update in QuickBooks
        if entry.get("quickbooks_journal_entry_id"):
            # Update existing
            qb_je["Id"] = entry["quickbooks_journal_entry_id"]
            qb_je["SyncToken"] = entry.get("quickbooks_sync_token", "0")
            result = await self.update_entity("JournalEntry", qb_je)
        else:
            # Create new
            result = await self.create_entity("JournalEntry", qb_je)

        # Update Supabase with QuickBooks ID
        if result:
            je_entity = result.get("JournalEntry", {})
            supabase.table("journal_entries").update(
                {
                    "quickbooks_journal_entry_id": je_entity["Id"],
                    "quickbooks_sync_token": je_entity["SyncToken"],
                    "quickbooks_last_sync": datetime.utcnow().isoformat(),
                }
            ).eq("id", journal_entry_id).execute()

        return result

    # UTILITY METHODS

    async def list_accounts(self) -> List[Dict[str, Any]]:
        """List all accounts in QuickBooks"""
        response = await self.query_api(
            "query", {"query": "SELECT * FROM Account ORDERBY Name"}
        )
        return response.get("QueryResponse", {}).get("Account", [])

    async def get_company_info(self) -> Dict[str, Any]:
        """Get QuickBooks company info"""
        response = await self.query_api("companyinfo/1")
        return response.get("CompanyInfo", {})

    async def show_sync_status(self):
        """Show sync status between QuickBooks and Supabase"""
        console.print("\n[bold]QuickBooks Sync Status[/bold]\n")

        # Get counts from QuickBooks
        qb_accounts = await self.query_api(
            "query", {"query": "SELECT COUNT(*) FROM Account"}
        )
        qb_customers = await self.query_api(
            "query", {"query": "SELECT COUNT(*) FROM Customer"}
        )
        qb_vendors = await self.query_api(
            "query", {"query": "SELECT COUNT(*) FROM Vendor"}
        )

        # Get counts from Supabase
        sb_accounts = (
            supabase.table("chart_of_accounts")
            .select("id", count="exact")
            .eq("company_id", self.company_id)
            .execute()
        )
        sb_customers = (
            supabase.table("accounting_customers")
            .select("id", count="exact")
            .eq("company_id", self.company_id)
            .execute()
        )

        # Create status table
        table = Table(title="Entity Sync Status")
        table.add_column("Entity", style="cyan")
        table.add_column("QuickBooks", style="green")
        table.add_column("Supabase", style="blue")
        table.add_column("Status", style="yellow")

        # Add rows
        qb_acct_count = qb_accounts.get("QueryResponse", {}).get("totalCount", 0)
        sb_acct_count = sb_accounts.count if sb_accounts.count else 0
        table.add_row(
            "Accounts",
            str(qb_acct_count),
            str(sb_acct_count),
            "✓ Synced" if qb_acct_count == sb_acct_count else "⚠ Out of sync",
        )

        qb_cust_count = qb_customers.get("QueryResponse", {}).get("totalCount", 0)
        sb_cust_count = sb_customers.count if sb_customers.count else 0
        table.add_row(
            "Customers",
            str(qb_cust_count),
            str(sb_cust_count),
            "✓ Synced" if qb_cust_count == sb_cust_count else "⚠ Out of sync",
        )

        console.print(table)


# CLI Commands
async def connect_quickbooks(company_id: str):
    """Generate QuickBooks connection URL"""
    import webbrowser

    # Get OAuth URL from webhook server
    async with httpx.AsyncClient() as client:
        response = await client.get(
            f"http://localhost:8000/auth/quickbooks?company_id={company_id}"
        )
        data = response.json()
        auth_url = data["auth_url"]

    console.print("\n[bold]QuickBooks Authorization[/bold]")
    console.print(f"\nOpening browser to: [blue]{auth_url}[/blue]")
    console.print(
        "\n[yellow]Please authorize the application and complete the connection.[/yellow]"
    )

    webbrowser.open(auth_url)


async def sync_from_quickbooks(company_id: str):
    """Pull all data from QuickBooks"""
    async with QuickBooksSync(company_id) as sync:
        await sync.pull_all_data()


async def sync_to_quickbooks(company_id: str, entity_type: str, entity_id: str):
    """Push specific entity to QuickBooks"""
    async with QuickBooksSync(company_id) as sync:
        if entity_type == "customer":
            result = await sync.push_customer(entity_id)
        elif entity_type == "journal_entry":
            result = await sync.push_journal_entry(entity_id)
        else:
            raise Exception(f"Unsupported entity type: {entity_type}")

        console.print(
            f"\n[green]✓ Successfully synced {entity_type} to QuickBooks[/green]"
        )
        console.print(json.dumps(result, indent=2))


async def show_quickbooks_data(company_id: str):
    """Show QuickBooks data and sync status"""
    async with QuickBooksSync(company_id) as sync:
        # Show company info
        company_info = await sync.get_company_info()
        console.print(
            f"\n[bold]QuickBooks Company:[/bold] {company_info.get('CompanyName')}"
        )
        console.print(f"[bold]Legal Name:[/bold] {company_info.get('LegalName')}")
        console.print(f"[bold]Country:[/bold] {company_info.get('Country')}")

        # Show sync status
        await sync.show_sync_status()

        # Show recent activity
        console.print("\n[bold]Recent QuickBooks Activity[/bold]\n")

        # Get recent journal entries
        response = await sync.query_api(
            "query",
            {
                "query": "SELECT * FROM JournalEntry ORDERBY MetaData.LastUpdatedTime DESC MAXRESULTS 5"
            },
        )

        entries = response.get("QueryResponse", {}).get("JournalEntry", [])
        if entries:
            table = Table(title="Recent Journal Entries")
            table.add_column("Date", style="cyan")
            table.add_column("Doc Number", style="green")
            table.add_column("Total", style="yellow")
            table.add_column("Last Updated", style="blue")

            for entry in entries:
                total = sum(
                    float(line.get("Amount", 0))
                    for line in entry.get("Line", [])
                    if line.get("JournalEntryLineDetail", {}).get("PostingType")
                    == "Debit"
                )
                table.add_row(
                    entry["TxnDate"],
                    entry.get("DocNumber", "N/A"),
                    f"${total:,.2f}",
                    entry["MetaData"]["LastUpdatedTime"],
                )

            console.print(table)


if __name__ == "__main__":
    import sys

    if len(sys.argv) < 3:
        console.print(
            "[red]Usage: python quickbooks_sync.py <command> <company_id> [options][/red]"
        )
        console.print("\nCommands:")
        console.print("  connect <company_id>              - Connect to QuickBooks")
        console.print(
            "  pull <company_id>                 - Pull all data from QuickBooks"
        )
        console.print("  push <company_id> <type> <id>     - Push entity to QuickBooks")
        console.print("  status <company_id>               - Show sync status")
        sys.exit(1)

    command = sys.argv[1]
    company_id = sys.argv[2]

    if command == "connect":
        asyncio.run(connect_quickbooks(company_id))
    elif command == "pull":
        asyncio.run(sync_from_quickbooks(company_id))
    elif command == "push" and len(sys.argv) >= 5:
        asyncio.run(sync_to_quickbooks(company_id, sys.argv[3], sys.argv[4]))
    elif command == "status":
        asyncio.run(show_quickbooks_data(company_id))
    else:
        console.print("[red]Invalid command or missing arguments[/red]")
