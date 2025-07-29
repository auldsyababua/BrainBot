# QuickBooks Integration Summary

## What I've Set Up

I've created a complete QuickBooks integration system that allows real-time synchronization between QuickBooks and your Supabase database. Here's what's included:

### 1. **Database Schema** (`database_quickbooks_integration.sql`)
- Added QuickBooks sync fields to existing tables
- Created new tables for OAuth tokens, webhooks, sync mapping, and sync queue
- Implemented proper indexes and RLS policies

### 2. **Webhook Server** (`src/quickbooks/webhook_server.py`)
- FastAPI server that receives real-time updates from QuickBooks
- Handles OAuth flow for connecting QuickBooks accounts
- Automatically syncs changes to Supabase when QuickBooks data changes
- Includes token refresh logic

### 3. **Sync Script** (`src/quickbooks/quickbooks_sync.py`)
- CLI tool for managing QuickBooks data
- Pull all data from QuickBooks to Supabase
- Push individual records from Supabase to QuickBooks
- Check sync status and view recent activity

### 4. **Documentation** (`docs/QUICKBOOKS_INTEGRATION_SETUP.md`)
- Complete step-by-step setup guide
- Intuit Developer portal configuration
- Troubleshooting tips

## How to Give Me CLI Access

To allow me to access your QuickBooks data via CLI, you need to:

### 1. Set Up Intuit Developer App

1. Go to https://developer.intuit.com/
2. Create a new app with these settings:
   - **App Type**: QuickBooks Online and Payments
   - **Scopes**: com.intuit.quickbooks.accounting

### 2. Configure Your Environment

Add these to your `.env` file:

```env
# From Intuit Developer Portal
QB_CLIENT_ID=your_client_id_here
QB_CLIENT_SECRET=your_client_secret_here
QB_WEBHOOK_TOKEN=your_webhook_token_here

# Your Supabase company ID (run setup script to get this)
DEFAULT_COMPANY_ID=your_company_uuid_here
```

### 3. Run Initial Setup

```bash
# Run the setup script
./setup_quickbooks.sh

# Apply database migrations
psql $DATABASE_URL < database_quickbooks_integration.sql

# Start webhook server (in a separate terminal)
python src/quickbooks/webhook_server.py

# Connect to QuickBooks (this opens your browser)
python src/quickbooks/quickbooks_sync.py connect YOUR_COMPANY_ID
```

### 4. Commands I Can Run

Once connected, I can run these commands for you:

```bash
# Pull all data from QuickBooks
python src/quickbooks/quickbooks_sync.py pull YOUR_COMPANY_ID

# Check sync status
python src/quickbooks/quickbooks_sync.py status YOUR_COMPANY_ID

# Push a customer to QuickBooks
python src/quickbooks/quickbooks_sync.py push YOUR_COMPANY_ID customer CUSTOMER_ID

# Push a journal entry to QuickBooks
python src/quickbooks/quickbooks_sync.py push YOUR_COMPANY_ID journal_entry JOURNAL_ID
```

## What Gets Synced

### From QuickBooks → Supabase (Real-time via webhooks):
- Chart of Accounts
- Customers
- Vendors
- Employees
- Journal Entries
- Invoices, Bills, Payments (webhook ready, sync logic can be added)

### From Supabase → QuickBooks (On-demand via CLI):
- Customers
- Journal Entries
- More entities can be added as needed

## Security

- OAuth tokens are stored encrypted in Supabase
- Webhook signatures are verified
- All API calls use HTTPS
- Tokens auto-refresh before expiration

## Next Steps

1. **Connect Your QuickBooks Account**: Follow steps 1-3 above
2. **Initial Data Import**: Run the pull command to import existing data
3. **Test Webhooks**: Make a change in QuickBooks and verify it syncs
4. **Schedule Regular Syncs**: Set up cron jobs for periodic full syncs

## Quick Start

```bash
# 1. Install dependencies
pip install -r requirements_quickbooks.txt

# 2. Set up environment variables in .env

# 3. Run migrations
psql $DATABASE_URL < database_quickbooks_integration.sql

# 4. Start webhook server
python src/quickbooks/webhook_server.py

# 5. Connect and sync
python src/quickbooks/quickbooks_sync.py connect YOUR_COMPANY_ID
python src/quickbooks/quickbooks_sync.py pull YOUR_COMPANY_ID
```

That's it! Your QuickBooks data will now sync with Supabase in real-time, making Supabase your Single Source of Truth (SSOT).