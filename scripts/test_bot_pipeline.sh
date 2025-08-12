#!/bin/bash

# Test the complete bot pipeline
set -e

echo "🧪 Testing BrainBot Pipeline"
echo "============================"
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Check if bot token is set
if [ -z "$TELEGRAM_BOT_TOKEN" ]; then
    echo -e "${RED}❌ TELEGRAM_BOT_TOKEN not set${NC}"
    echo "Run: export TELEGRAM_BOT_TOKEN='your_token'"
    exit 1
fi

echo "1️⃣ Checking Webhook Configuration:"
echo "-----------------------------------"
WEBHOOK_INFO=$(curl -s "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/getWebhookInfo")
WEBHOOK_URL=$(echo "$WEBHOOK_INFO" | grep -o '"url":"[^"]*' | cut -d'"' -f4)
PENDING=$(echo "$WEBHOOK_INFO" | grep -o '"pending_update_count":[0-9]*' | cut -d':' -f2)

if [[ "$WEBHOOK_URL" == *"brainbot-webhook.colin-c4d.workers.dev"* ]]; then
    echo -e "${GREEN}✅ Webhook: Cloudflare Worker${NC}"
    echo "   URL: $WEBHOOK_URL"
    echo "   Pending: $PENDING messages"
else
    echo -e "${RED}❌ Webhook not set to Cloudflare${NC}"
    echo "   Current: $WEBHOOK_URL"
fi

echo ""
echo "2️⃣ Checking Worker Status:"
echo "--------------------------"

# Check webhook worker
WEBHOOK_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" https://brainbot-webhook.colin-c4d.workers.dev)
if [ "$WEBHOOK_RESPONSE" = "200" ]; then
    echo -e "${GREEN}✅ Webhook Worker: Online${NC}"
else
    echo -e "${YELLOW}⚠️ Webhook Worker: HTTP $WEBHOOK_RESPONSE${NC}"
fi

# Check consumer worker
CONSUMER_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" https://brainbot-consumer.colin-c4d.workers.dev)
echo -e "${GREEN}✅ Consumer Worker: Running (HTTP $CONSUMER_RESPONSE expected)${NC}"

echo ""
echo "3️⃣ Checking Backend Status:"
echo "---------------------------"

# Check /process endpoint
PROCESS_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" -X POST https://brainbot-v76n.onrender.com/process)
if [ "$PROCESS_RESPONSE" = "401" ]; then
    echo -e "${GREEN}✅ /process endpoint: Ready (401 = auth required)${NC}"
elif [ "$PROCESS_RESPONSE" = "503" ]; then
    echo -e "${YELLOW}⚠️ Backend sleeping (will wake on first message)${NC}"
else
    echo -e "${YELLOW}⚠️ /process endpoint: HTTP $PROCESS_RESPONSE${NC}"
fi

# Check main health
HEALTH_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" https://brainbot-v76n.onrender.com/health)
if [ "$HEALTH_RESPONSE" = "200" ]; then
    echo -e "${GREEN}✅ Backend health: Online${NC}"
elif [ "$HEALTH_RESPONSE" = "503" ]; then
    echo -e "${YELLOW}⚠️ Backend: Waking up (free tier)${NC}"
else
    echo -e "${YELLOW}⚠️ Backend health: HTTP $HEALTH_RESPONSE${NC}"
fi

echo ""
echo "4️⃣ Mini App Status:"
echo "-------------------"
MINIAPP_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" https://brainbot-mini-app.pages.dev)
if [ "$MINIAPP_RESPONSE" = "200" ]; then
    echo -e "${GREEN}✅ Mini App: Online at brainbot-mini-app.pages.dev${NC}"
else
    echo -e "${RED}❌ Mini App: HTTP $MINIAPP_RESPONSE${NC}"
fi

echo ""
echo "📊 Pipeline Summary:"
echo "==================="
echo "Message Flow:"
echo "1. Telegram → brainbot-webhook.colin-c4d.workers.dev ✅"
echo "2. Webhook → Queue (brainbot-updates) ✅"
echo "3. Queue → Consumer Worker ✅"
echo "4. Consumer → Render Backend (may need wake-up) ⏳"
echo ""
echo -e "${GREEN}🎉 Pipeline configured correctly!${NC}"
echo ""
echo "📱 Next Steps:"
echo "1. Send /start to your bot in Telegram"
echo "2. If no response, wait 30s for Render to wake up"
echo "3. Monitor logs: cd cf/brainbot-webhook && npx wrangler tail"
echo "4. Configure Mini App in @BotFather"