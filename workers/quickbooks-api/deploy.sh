#!/bin/bash

# QuickBooks API Worker Deployment Script

echo "Deploying QuickBooks API to Cloudflare Workers..."

# Get credentials from parent .env file
if [ -f "../../.env" ]; then
    export $(cat ../../.env | grep -E '^QB_|^SUPABASE_' | xargs)
else
    echo "Error: .env file not found in parent directory"
    exit 1
fi

# Set secrets
echo "Setting secrets..."
echo "$QB_CLIENT_ID" | npx wrangler secret put QB_CLIENT_ID --env production
echo "$QB_CLIENT_SECRET" | npx wrangler secret put QB_CLIENT_SECRET --env production
echo "$QB_WEBHOOK_TOKEN" | npx wrangler secret put QB_WEBHOOK_TOKEN --env production
echo "$SUPABASE_URL" | npx wrangler secret put SUPABASE_URL --env production
echo "$SUPABASE_SERVICE_KEY" | npx wrangler secret put SUPABASE_SERVICE_KEY --env production

# Deploy
echo "\nDeploying worker..."
npx wrangler deploy --env production

echo "\n✅ Deployment complete!"
echo "\nYour QuickBooks webhook URL is: https://api.10nz.tools/webhooks/quickbooks"
echo "OAuth callback URL is: https://api.10nz.tools/callback"