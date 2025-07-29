# QuickBooks Integration Setup Guide

## Overview

This guide will walk you through setting up the Intuit QuickBooks app in the Intuit Developer portal and connecting it to your Supabase database for real-time synchronization. The goal is to make Supabase the Single Source of Truth (SSOT) for your company data.

## Prerequisites

- Intuit QuickBooks account
- Supabase project (already configured)
- Node.js/Python environment for webhook server

## Step 1: Create Intuit Developer Account

1. Go to https://developer.intuit.com/
2. Click "Sign Up" if you don't have an account
3. Complete the registration process

## Step 2: Create a New App

1. Once logged in, go to the Dashboard
2. Click "Create an app"
3. Select the following options:

   **App Type** → QuickBooks Online and Payments

   **App Name** → 10NetZero Supabase Sync

   **Scope** → com.intuit.quickbooks.accounting

   **Customer-facing app name** → 10NetZero Accounting Integration

   **App description** → Real-time sync between QuickBooks and Supabase database for 10NetZero operations

## Step 3: Configure OAuth 2.0 Settings

### Development Settings

**Redirect URIs** (Add all of these):
- http://localhost:8000/callback
- http://localhost:3000/auth/quickbooks/callback
- https://your-production-domain.com/auth/quickbooks/callback

**Webhook URL**:
- Development: http://localhost:8000/webhooks/quickbooks
- Production: https://your-production-domain.com/webhooks/quickbooks

### Scopes Required

Ensure these scopes are selected:
- `com.intuit.quickbooks.accounting` - Full accounting access
- `com.intuit.quickbooks.payment` - Payment processing (if needed)
- `openid` - User authentication
- `profile` - User profile information
- `email` - User email address

## Step 4: Get Your App Credentials

After creating the app, you'll receive:

**Client ID** → [Your Client ID]

**Client Secret** → [Your Client Secret]

**App ID** → [Your App ID]

Save these securely - we'll need them for the integration.

## Step 5: Configure Webhooks

1. In your app settings, go to "Webhooks"
2. Enable the following webhook events:

   **Entity Events**:
   - Customer (Create, Update, Delete)
   - Vendor (Create, Update, Delete)
   - Employee (Create, Update, Delete)
   - Item (Create, Update, Delete)
   - Account (Create, Update, Delete)

   **Transaction Events**:
   - Invoice (Create, Update, Delete, Void)
   - Payment (Create, Update, Delete)
   - Bill (Create, Update, Delete)
   - Purchase (Create, Update, Delete)
   - JournalEntry (Create, Update, Delete)
   - Deposit (Create, Update, Delete)
   - Transfer (Create, Update, Delete)

3. Set your webhook endpoint URL
4. Copy the **Webhook Token** for verification

## Step 6: Database Schema Updates

We need to add QuickBooks-specific fields to our existing tables:

```bash
# Run the QuickBooks integration SQL script
psql $DATABASE_URL < database_quickbooks_integration.sql
```

## Step 7: Install Python Dependencies

```bash
# Install QuickBooks integration dependencies
pip install -r requirements_quickbooks.txt
```

## Step 8: Configure Environment Variables

Add these to your `.env` file:

```env
# QuickBooks OAuth App Credentials
QB_CLIENT_ID=YOUR_CLIENT_ID_HERE
QB_CLIENT_SECRET=YOUR_CLIENT_SECRET_HERE

# QuickBooks Webhook Verification Token
QB_WEBHOOK_TOKEN=YOUR_WEBHOOK_TOKEN_HERE

# QuickBooks Environment (sandbox or production)
QB_ENVIRONMENT=sandbox  # Change to 'production' when ready

# Company ID from your Supabase companies table
DEFAULT_COMPANY_ID=YOUR_COMPANY_UUID_HERE
```

## Step 9: Start the Webhook Server

```bash
# Start the webhook server
python src/quickbooks/webhook_server.py
```

This will start the server on http://localhost:8000

## Step 10: Connect Your QuickBooks Account

### Option 1: Using the CLI Tool

```bash
# Connect QuickBooks account
python src/quickbooks/quickbooks_sync.py connect YOUR_COMPANY_ID
```

This will open your browser to authorize the connection.

### Option 2: Manual Connection

1. Visit: http://localhost:8000/auth/quickbooks?company_id=YOUR_COMPANY_ID
2. Log in to your QuickBooks account
3. Authorize the application
4. You'll be redirected back to the callback URL

## Step 11: Initial Data Sync

Pull all data from QuickBooks to populate your Supabase database:

```bash
# Pull all data from QuickBooks
python src/quickbooks/quickbooks_sync.py pull YOUR_COMPANY_ID
```

## Step 12: Test the Integration

### Check Sync Status

```bash
# Show sync status and recent activity
python src/quickbooks/quickbooks_sync.py status YOUR_COMPANY_ID
```

### Test Real-time Sync

1. Make a change in QuickBooks (create a customer, invoice, etc.)
2. Check the webhook logs in your terminal
3. Verify the data appears in Supabase

### Push Data to QuickBooks

```bash
# Push a customer to QuickBooks
python src/quickbooks/quickbooks_sync.py push YOUR_COMPANY_ID customer CUSTOMER_ID

# Push a journal entry to QuickBooks
python src/quickbooks/quickbooks_sync.py push YOUR_COMPANY_ID journal_entry JOURNAL_ENTRY_ID
```

## Using the Integration

### For CLI Access

I can help you manage your QuickBooks data using the sync script:

1. **Pull Data**: `python src/quickbooks/quickbooks_sync.py pull YOUR_COMPANY_ID`
2. **Push Data**: `python src/quickbooks/quickbooks_sync.py push YOUR_COMPANY_ID entity_type entity_id`
3. **Check Status**: `python src/quickbooks/quickbooks_sync.py status YOUR_COMPANY_ID`

### Programmatic Access

```python
from src.quickbooks.quickbooks_sync import QuickBooksSync

async def sync_data():
    async with QuickBooksSync(company_id) as sync:
        # Pull all data
        await sync.pull_all_data()
        
        # Push specific customer
        await sync.push_customer(customer_id)
        
        # Get QuickBooks data
        accounts = await sync.list_accounts()
```

## Production Deployment

### 1. Update Redirect URIs

In your Intuit app settings, add your production redirect URI:
- https://your-domain.com/auth/quickbooks/callback

### 2. Update Webhook URL

Set your production webhook URL:
- https://your-domain.com/webhooks/quickbooks

### 3. Deploy Webhook Server

Deploy the webhook server to your production environment (Render, AWS, etc.)

### 4. Enable SSL

Ensure your webhook endpoint uses HTTPS for security.

### 5. Set Production Environment

Update your `.env`:
```env
QB_ENVIRONMENT=production
```

## Troubleshooting

### Common Issues

1. **401 Unauthorized**: Token expired - the sync script will auto-refresh
2. **Webhook signature invalid**: Check your QB_WEBHOOK_TOKEN
3. **Company not found**: Ensure DEFAULT_COMPANY_ID exists in your companies table
4. **SSL Error in sandbox**: This is normal for sandbox - it uses self-signed certs

### Debugging

- Check webhook events: `SELECT * FROM quickbooks_webhook_events ORDER BY created_at DESC;`
- Check sync queue: `SELECT * FROM quickbooks_sync_queue WHERE status = 'failed';`
- View auth status: `SELECT * FROM quickbooks_auth WHERE company_id = 'YOUR_COMPANY_ID';`

## Security Best Practices

1. **Never commit credentials**: Keep `.env` in `.gitignore`
2. **Use service keys**: Use Supabase service keys for server-side operations
3. **Validate webhooks**: Always verify webhook signatures
4. **Limit scopes**: Only request necessary QuickBooks scopes
5. **Monitor access**: Regularly review QuickBooks app connections

## Next Steps

1. Set up automated sync schedules
2. Implement error notifications
3. Add support for more QuickBooks entities (Bills, Invoices, etc.)
4. Create dashboards for monitoring sync status
5. Implement conflict resolution for two-way sync