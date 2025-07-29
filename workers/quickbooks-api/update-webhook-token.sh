#!/bin/bash

# Update webhook token
echo "Enter your QuickBooks webhook verification token:"
read -s WEBHOOK_TOKEN

echo "$WEBHOOK_TOKEN" | npx wrangler secret put QB_WEBHOOK_TOKEN --env production

echo "\n✅ Webhook token updated!"