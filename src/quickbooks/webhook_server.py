"""QuickBooks Webhook Server for Real-time Sync"""

import os
import json
import hmac
import hashlib
from datetime import datetime, timedelta
from typing import Dict, Any, Optional
from fastapi import FastAPI, Request, HTTPException, Header
from fastapi.responses import JSONResponse
import httpx
from supabase import create_client, Client
from dotenv import load_dotenv
import logging

# Load environment variables
load_dotenv()

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Initialize FastAPI app
app = FastAPI(title="QuickBooks Webhook Server")

# Initialize Supabase client
supabase: Client = create_client(
    os.getenv("SUPABASE_URL"), os.getenv("SUPABASE_SERVICE_KEY")
)

# QuickBooks configuration
QB_CLIENT_ID = os.getenv("QB_CLIENT_ID")
QB_CLIENT_SECRET = os.getenv("QB_CLIENT_SECRET")
QB_WEBHOOK_TOKEN = os.getenv("QB_WEBHOOK_TOKEN")
QB_REDIRECT_URI = os.getenv("QB_REDIRECT_URI", "http://localhost:8000/callback")
QB_ENVIRONMENT = os.getenv("QB_ENVIRONMENT", "sandbox")  # 'sandbox' or 'production'

# QuickBooks API URLs
if QB_ENVIRONMENT == "production":
    QB_AUTH_URL = "https://appcenter.intuit.com/connect/oauth2"
    QB_API_URL = "https://quickbooks.api.intuit.com"
else:
    QB_AUTH_URL = "https://sandbox-quickbooks.api.intuit.com/connect/oauth2"
    QB_API_URL = "https://sandbox-quickbooks.api.intuit.com"


def verify_webhook_signature(payload: str, signature: str) -> bool:
    """Verify QuickBooks webhook signature"""
    if not QB_WEBHOOK_TOKEN:
        logger.error("QB_WEBHOOK_TOKEN not configured")
        return False

    expected_signature = hmac.new(
        QB_WEBHOOK_TOKEN.encode("utf-8"), payload.encode("utf-8"), hashlib.sha256
    ).hexdigest()

    return hmac.compare_digest(signature, expected_signature)


@app.post("/webhooks/quickbooks")
async def quickbooks_webhook(
    request: Request, intuit_signature: Optional[str] = Header(None)
):
    """Handle QuickBooks webhook events"""
    try:
        # Get raw payload
        payload = await request.body()
        payload_str = payload.decode("utf-8")

        # Verify signature
        if intuit_signature and not verify_webhook_signature(
            payload_str, intuit_signature
        ):
            logger.warning("Invalid webhook signature")
            raise HTTPException(status_code=401, detail="Invalid signature")

        # Parse webhook data
        webhook_data = json.loads(payload_str)

        # Process events
        for event_notification in webhook_data.get("eventNotifications", []):
            realm_id = event_notification.get("realmId")

            for entity_event in event_notification.get("dataChangeEvent", {}).get(
                "entities", []
            ):
                await process_entity_event(
                    realm_id=realm_id,
                    entity_name=entity_event.get("name"),
                    entity_id=entity_event.get("id"),
                    operation=entity_event.get("operation"),
                    last_updated=entity_event.get("lastUpdated"),
                )

        return JSONResponse({"status": "success"})

    except json.JSONDecodeError:
        logger.error("Invalid JSON in webhook payload")
        raise HTTPException(status_code=400, detail="Invalid JSON")
    except Exception as e:
        logger.error(f"Webhook processing error: {e}")
        raise HTTPException(status_code=500, detail=str(e))


async def process_entity_event(
    realm_id: str, entity_name: str, entity_id: str, operation: str, last_updated: str
):
    """Process individual entity events from webhook"""
    try:
        # Log the event
        event_data = {
            "realm_id": realm_id,
            "entity_name": entity_name,
            "entity_id": entity_id,
            "operation": operation,
            "event_time": last_updated,
            "processing_status": "processing",
        }

        # Store webhook event
        result = (
            supabase.table("quickbooks_webhook_events").insert(event_data).execute()
        )
        event_record_id = result.data[0]["id"]

        # Get company by realm_id
        company_result = (
            supabase.table("companies")
            .select("*")
            .eq("quickbooks_realm_id", realm_id)
            .execute()
        )
        if not company_result.data:
            raise Exception(f"Company not found for realm_id: {realm_id}")

        company = company_result.data[0]

        # Get QuickBooks auth token
        auth_token = await get_valid_auth_token(company["id"])
        if not auth_token:
            raise Exception("No valid auth token available")

        # Fetch entity data from QuickBooks
        entity_data = await fetch_quickbooks_entity(
            auth_token=auth_token,
            realm_id=realm_id,
            entity_name=entity_name,
            entity_id=entity_id,
        )

        # Sync to Supabase based on entity type
        await sync_entity_to_supabase(
            company_id=company["id"],
            entity_name=entity_name,
            entity_id=entity_id,
            entity_data=entity_data,
            operation=operation,
        )

        # Update webhook event status
        supabase.table("quickbooks_webhook_events").update(
            {
                "processing_status": "completed",
                "processed_at": datetime.utcnow().isoformat(),
                "payload": entity_data,
            }
        ).eq("id", event_record_id).execute()

    except Exception as e:
        logger.error(f"Error processing entity event: {e}")
        # Update webhook event with error
        supabase.table("quickbooks_webhook_events").update(
            {
                "processing_status": "failed",
                "error_message": str(e),
                "processed_at": datetime.utcnow().isoformat(),
            }
        ).eq("id", event_record_id).execute()


async def get_valid_auth_token(company_id: str) -> Optional[str]:
    """Get valid QuickBooks auth token, refreshing if necessary"""
    try:
        # Get current auth record
        auth_result = (
            supabase.table("quickbooks_auth")
            .select("*")
            .eq("company_id", company_id)
            .eq("is_active", True)
            .execute()
        )

        if not auth_result.data:
            return None

        auth = auth_result.data[0]

        # Check if token is expired
        token_expires_at = datetime.fromisoformat(
            auth["token_expires_at"].replace("Z", "+00:00")
        )
        if datetime.utcnow() >= token_expires_at - timedelta(
            minutes=5
        ):  # Refresh 5 mins before expiry
            # Refresh token
            new_tokens = await refresh_quickbooks_token(auth["refresh_token"])
            if new_tokens:
                # Update auth record
                supabase.table("quickbooks_auth").update(
                    {
                        "access_token": new_tokens["access_token"],
                        "refresh_token": new_tokens["refresh_token"],
                        "token_expires_at": (
                            datetime.utcnow()
                            + timedelta(seconds=new_tokens["expires_in"])
                        ).isoformat(),
                        "updated_at": datetime.utcnow().isoformat(),
                    }
                ).eq("id", auth["id"]).execute()

                return new_tokens["access_token"]

        return auth["access_token"]

    except Exception as e:
        logger.error(f"Error getting auth token: {e}")
        return None


async def refresh_quickbooks_token(refresh_token: str) -> Optional[Dict[str, Any]]:
    """Refresh QuickBooks OAuth token"""
    try:
        async with httpx.AsyncClient() as client:
            response = await client.post(
                f"{QB_AUTH_URL}/tokens/bearer",
                data={"grant_type": "refresh_token", "refresh_token": refresh_token},
                auth=(QB_CLIENT_ID, QB_CLIENT_SECRET),
                headers={"Accept": "application/json"},
            )

            if response.status_code == 200:
                return response.json()
            else:
                logger.error(f"Token refresh failed: {response.text}")
                return None

    except Exception as e:
        logger.error(f"Error refreshing token: {e}")
        return None


async def fetch_quickbooks_entity(
    auth_token: str, realm_id: str, entity_name: str, entity_id: str
) -> Dict[str, Any]:
    """Fetch entity data from QuickBooks API"""
    try:
        # Map entity names to API endpoints
        entity_endpoints = {
            "Customer": "customer",
            "Vendor": "vendor",
            "Employee": "employee",
            "Account": "account",
            "Invoice": "invoice",
            "Bill": "bill",
            "JournalEntry": "journalentry",
            "Payment": "payment",
            "Deposit": "deposit",
            "Transfer": "transfer",
        }

        endpoint = entity_endpoints.get(entity_name, entity_name.lower())

        async with httpx.AsyncClient() as client:
            response = await client.get(
                f"{QB_API_URL}/v3/company/{realm_id}/{endpoint}/{entity_id}",
                headers={
                    "Authorization": f"Bearer {auth_token}",
                    "Accept": "application/json",
                },
            )

            if response.status_code == 200:
                return response.json()
            else:
                logger.error(f"Failed to fetch entity: {response.text}")
                raise Exception(f"Failed to fetch {entity_name} {entity_id}")

    except Exception as e:
        logger.error(f"Error fetching QuickBooks entity: {e}")
        raise


async def sync_entity_to_supabase(
    company_id: str,
    entity_name: str,
    entity_id: str,
    entity_data: Dict[str, Any],
    operation: str,
):
    """Sync QuickBooks entity to Supabase"""
    try:
        # Extract the actual entity data
        entity = entity_data.get(entity_name, {})

        if operation == "Delete":
            await handle_entity_deletion(company_id, entity_name, entity_id)
        else:
            # Map entity to Supabase table
            if entity_name == "Customer":
                await sync_customer(company_id, entity)
            elif entity_name == "Vendor":
                await sync_vendor(company_id, entity)
            elif entity_name == "Employee":
                await sync_employee(company_id, entity)
            elif entity_name == "Account":
                await sync_account(company_id, entity)
            elif entity_name == "JournalEntry":
                await sync_journal_entry(company_id, entity)
            else:
                logger.warning(f"Unhandled entity type: {entity_name}")

    except Exception as e:
        logger.error(f"Error syncing entity to Supabase: {e}")
        raise


async def sync_customer(company_id: str, customer: Dict[str, Any]):
    """Sync QuickBooks customer to Supabase"""
    try:
        customer_data = {
            "company_id": company_id,
            "quickbooks_customer_id": customer["Id"],
            "name": customer.get("DisplayName") or customer.get("CompanyName"),
            "full_name": customer.get("FullyQualifiedName"),
            "email": customer.get("PrimaryEmailAddr", {}).get("Address"),
            "phone": customer.get("PrimaryPhone", {}).get("FreeFormNumber"),
            "is_active": customer.get("Active", True),
            "quickbooks_sync_token": customer.get("SyncToken"),
            "quickbooks_last_sync": datetime.utcnow().isoformat(),
        }

        # Check if customer exists
        existing = (
            supabase.table("accounting_customers")
            .select("id")
            .eq("company_id", company_id)
            .eq("quickbooks_customer_id", customer["Id"])
            .execute()
        )

        if existing.data:
            # Update existing
            supabase.table("accounting_customers").update(customer_data).eq(
                "id", existing.data[0]["id"]
            ).execute()
        else:
            # Create new
            customer_data["customer_id_display"] = f"CUST-{customer['Id']}"
            supabase.table("accounting_customers").insert(customer_data).execute()

        # Update sync mapping
        await update_sync_mapping(
            company_id=company_id,
            local_table="accounting_customers",
            local_id=existing.data[0]["id"] if existing.data else None,
            quickbooks_entity_type="Customer",
            quickbooks_id=customer["Id"],
            sync_token=customer.get("SyncToken"),
        )

    except Exception as e:
        logger.error(f"Error syncing customer: {e}")
        raise


async def sync_account(company_id: str, account: Dict[str, Any]):
    """Sync QuickBooks account to Supabase chart of accounts"""
    try:
        account_data = {
            "company_id": company_id,
            "quickbooks_account_id": account["Id"],
            "account_number": account.get("AcctNum", ""),
            "account_name": account["Name"],
            "account_type": map_quickbooks_account_type(account["AccountType"]),
            "account_subtype": account.get("AccountSubType"),
            "is_active": account.get("Active", True),
            "description": account.get("Description"),
            "quickbooks_sync_token": account.get("SyncToken"),
            "quickbooks_last_sync": datetime.utcnow().isoformat(),
        }

        # Map QuickBooks classification to normal balance
        classification = account.get("Classification")
        if classification in ["Asset", "Expense"]:
            account_data["normal_balance"] = "Debit"
        else:
            account_data["normal_balance"] = "Credit"

        # Check if account exists
        existing = (
            supabase.table("chart_of_accounts")
            .select("id")
            .eq("company_id", company_id)
            .eq("quickbooks_account_id", account["Id"])
            .execute()
        )

        if existing.data:
            # Update existing
            supabase.table("chart_of_accounts").update(account_data).eq(
                "id", existing.data[0]["id"]
            ).execute()
        else:
            # Create new
            account_data["account_id_display"] = f"ACCT-{account['Id']}"
            supabase.table("chart_of_accounts").insert(account_data).execute()

    except Exception as e:
        logger.error(f"Error syncing account: {e}")
        raise


def map_quickbooks_account_type(qb_type: str) -> str:
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


async def handle_entity_deletion(company_id: str, entity_name: str, entity_id: str):
    """Handle entity deletion from QuickBooks"""
    # For now, we'll just mark entities as inactive rather than deleting
    # This preserves historical data
    pass


async def update_sync_mapping(
    company_id: str,
    local_table: str,
    local_id: str,
    quickbooks_entity_type: str,
    quickbooks_id: str,
    sync_token: str,
):
    """Update or create sync mapping record"""
    try:
        mapping_data = {
            "company_id": company_id,
            "local_table": local_table,
            "local_id": local_id,
            "quickbooks_entity_type": quickbooks_entity_type,
            "quickbooks_id": quickbooks_id,
            "quickbooks_sync_token": sync_token,
            "last_synced_at": datetime.utcnow().isoformat(),
        }

        # Try to update existing mapping
        existing = (
            supabase.table("quickbooks_sync_mapping")
            .select("id")
            .eq("company_id", company_id)
            .eq("quickbooks_entity_type", quickbooks_entity_type)
            .eq("quickbooks_id", quickbooks_id)
            .execute()
        )

        if existing.data:
            supabase.table("quickbooks_sync_mapping").update(mapping_data).eq(
                "id", existing.data[0]["id"]
            ).execute()
        else:
            supabase.table("quickbooks_sync_mapping").insert(mapping_data).execute()

    except Exception as e:
        logger.error(f"Error updating sync mapping: {e}")


# OAuth endpoints
@app.get("/auth/quickbooks")
async def quickbooks_auth(company_id: str):
    """Initiate QuickBooks OAuth flow"""
    # Store company_id in session or state parameter
    state = f"{company_id}:{os.urandom(16).hex()}"

    auth_url = (
        f"{QB_AUTH_URL}/authorize?"
        f"client_id={QB_CLIENT_ID}&"
        f"response_type=code&"
        f"scope=com.intuit.quickbooks.accounting openid profile email&"
        f"redirect_uri={QB_REDIRECT_URI}&"
        f"state={state}"
    )

    return JSONResponse({"auth_url": auth_url})


@app.get("/callback")
async def quickbooks_callback(code: str, state: str, realm_id: str):
    """Handle QuickBooks OAuth callback"""
    try:
        # Extract company_id from state
        company_id = state.split(":")[0]

        # Exchange code for tokens
        async with httpx.AsyncClient() as client:
            response = await client.post(
                f"{QB_AUTH_URL}/tokens/bearer",
                data={
                    "grant_type": "authorization_code",
                    "code": code,
                    "redirect_uri": QB_REDIRECT_URI,
                },
                auth=(QB_CLIENT_ID, QB_CLIENT_SECRET),
                headers={"Accept": "application/json"},
            )

            if response.status_code != 200:
                raise HTTPException(
                    status_code=400, detail="Failed to exchange code for tokens"
                )

            tokens = response.json()

        # Store tokens in database
        auth_data = {
            "company_id": company_id,
            "realm_id": realm_id,
            "access_token": tokens["access_token"],
            "refresh_token": tokens["refresh_token"],
            "token_expires_at": (
                datetime.utcnow() + timedelta(seconds=tokens["expires_in"])
            ).isoformat(),
        }

        # Deactivate any existing auth for this company
        supabase.table("quickbooks_auth").update({"is_active": False}).eq(
            "company_id", company_id
        ).execute()

        # Insert new auth record
        supabase.table("quickbooks_auth").insert(auth_data).execute()

        # Update company with realm_id
        supabase.table("companies").update(
            {"quickbooks_realm_id": realm_id, "quickbooks_sync_enabled": True}
        ).eq("id", company_id).execute()

        return JSONResponse(
            {"status": "success", "message": "QuickBooks connected successfully"}
        )

    except Exception as e:
        logger.error(f"OAuth callback error: {e}")
        raise HTTPException(status_code=500, detail=str(e))


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=8000)
