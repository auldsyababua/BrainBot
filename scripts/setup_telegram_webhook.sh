#!/bin/bash

# Script to set up Telegram webhook to Cloudflare Worker
# This completes the Cloudflare migration by pointing Telegram to the new infrastructure

set -e

echo "🔧 Telegram Webhook Setup for Cloudflare"
echo "========================================"
echo ""

# Check if bot token is set
if [ -z "$TELEGRAM_BOT_TOKEN" ]; then
    echo "❌ TELEGRAM_BOT_TOKEN environment variable is not set"
    echo ""
    echo "Please run:"
    echo "export TELEGRAM_BOT_TOKEN='your_bot_token_here'"
    echo ""
    exit 1
fi

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo "📡 Current Webhook Status:"
echo "--------------------------"

# Get current webhook info
CURRENT_WEBHOOK=$(curl -s "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/getWebhookInfo")

if echo "$CURRENT_WEBHOOK" | grep -q '"ok":true'; then
    CURRENT_URL=$(echo "$CURRENT_WEBHOOK" | grep -o '"url":"[^"]*' | cut -d'"' -f4)
    if [ -z "$CURRENT_URL" ]; then
        echo "No webhook currently set"
    else
        echo "Current webhook: $CURRENT_URL"
    fi
else
    echo -e "${RED}❌ Failed to get webhook info${NC}"
    echo "$CURRENT_WEBHOOK"
    exit 1
fi

echo ""
echo "🚀 Setting Webhook to Cloudflare Worker:"
echo "----------------------------------------"

# Set the new webhook URL
WEBHOOK_URL="https://brainbot-webhook.colin-c4d.workers.dev"
echo "New webhook URL: $WEBHOOK_URL"

# Set the webhook
RESULT=$(curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/setWebhook" \
    -H "Content-Type: application/json" \
    -d "{\"url\": \"$WEBHOOK_URL\"}")

if echo "$RESULT" | grep -q '"ok":true'; then
    echo -e "${GREEN}✅ Webhook successfully set!${NC}"
    echo ""
    
    # Verify the webhook
    echo "🔍 Verifying Webhook Configuration:"
    echo "-----------------------------------"
    
    sleep 2
    VERIFY=$(curl -s "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/getWebhookInfo")
    
    if echo "$VERIFY" | grep -q "$WEBHOOK_URL"; then
        echo -e "${GREEN}✅ Webhook verified and active${NC}"
        
        # Extract webhook details
        PENDING=$(echo "$VERIFY" | grep -o '"pending_update_count":[0-9]*' | cut -d':' -f2)
        HAS_CERT=$(echo "$VERIFY" | grep -o '"has_custom_certificate":[^,]*' | cut -d':' -f2)
        
        echo "Pending updates: $PENDING"
        echo "Custom certificate: $HAS_CERT"
        
        # Check for errors
        LAST_ERROR=$(echo "$VERIFY" | grep -o '"last_error_message":"[^"]*' | cut -d'"' -f4)
        if [ -n "$LAST_ERROR" ] && [ "$LAST_ERROR" != "null" ]; then
            echo -e "${YELLOW}⚠️  Last error: $LAST_ERROR${NC}"
        fi
    else
        echo -e "${RED}❌ Webhook verification failed${NC}"
    fi
    
    echo ""
    echo "🎉 Cloudflare Migration Complete!"
    echo "================================="
    echo ""
    echo "Your bot is now running through Cloudflare Workers!"
    echo ""
    echo "Architecture:"
    echo "Telegram → Cloudflare Webhook → Queue → Consumer → Render Backend"
    echo ""
    echo "Next steps:"
    echo "1. Test the bot by sending /start command"
    echo "2. Configure Mini App in BotFather"
    echo "3. Monitor with: npx wrangler tail brainbot-webhook"
    
else
    echo -e "${RED}❌ Failed to set webhook${NC}"
    echo "$RESULT"
    exit 1
fi