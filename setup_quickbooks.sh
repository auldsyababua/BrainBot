#!/bin/bash

# QuickBooks Integration Setup Script

echo "QuickBooks Integration Setup for 10NetZero"
echo "=========================================="
echo ""

# Check if .env file exists
if [ ! -f .env ]; then
    echo "Error: .env file not found!"
    exit 1
fi

# Install Python dependencies
echo "Installing Python dependencies..."
pip install -r requirements_quickbooks.txt

# Check if we have Supabase credentials
if ! grep -q "SUPABASE_URL=https://" .env; then
    echo "Error: SUPABASE_URL not configured in .env"
    exit 1
fi

# Get company ID
echo ""
echo "First, we need to create or find your company in the database."
echo "Running company setup..."

python -c "
import os
import sys
from dotenv import load_dotenv
from supabase import create_client

load_dotenv()

supabase = create_client(
    os.getenv('SUPABASE_URL'),
    os.getenv('SUPABASE_SERVICE_KEY')
)

# Check if 10NetZero company exists
result = supabase.table('companies').select('*').eq('name', '10NetZero, Inc.').execute()

if result.data:
    company = result.data[0]
    print(f'Found existing company: {company[\"name\"]} (ID: {company[\"id\"]})')
else:
    # Create company
    company_data = {
        'company_id_display': '10NET',
        'name': '10NetZero, Inc.',
        'tax_id': 'YOUR-TAX-ID',
        'email': 'accounting@10netzero.com',
        'fiscal_year_end': '12/31'
    }
    result = supabase.table('companies').insert(company_data).execute()
    company = result.data[0]
    print(f'Created new company: {company[\"name\"]} (ID: {company[\"id\"]})')

print(f'\nAdd this to your .env file:')
print(f'DEFAULT_COMPANY_ID={company[\"id\"]}')
"

echo ""
echo "Next Steps:"
echo "1. Go to https://developer.intuit.com/ and create an app"
echo "2. Add these to your .env file:"
echo "   QB_CLIENT_ID=<your-client-id>"
echo "   QB_CLIENT_SECRET=<your-client-secret>"
echo "   QB_WEBHOOK_TOKEN=<your-webhook-token>"
echo "   DEFAULT_COMPANY_ID=<company-id-from-above>"
echo ""
echo "3. Run the database migration:"
echo "   psql \$DATABASE_URL < database_quickbooks_integration.sql"
echo ""
echo "4. Start the webhook server:"
echo "   python src/quickbooks/webhook_server.py"
echo ""
echo "5. Connect to QuickBooks:"
echo "   python src/quickbooks/quickbooks_sync.py connect <company-id>"
echo ""
echo "For detailed instructions, see: docs/QUICKBOOKS_INTEGRATION_SETUP.md"