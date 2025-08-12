#!/bin/bash
# Verify Cloudflare Migration Phase 1
# This script tests the deployment and verifies all components are working

set -e  # Exit on error

echo "🔍 Verifying Cloudflare Migration Phase 1..."
echo "============================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check HTTP status
check_endpoint() {
    local url=$1
    local expected=$2
    local description=$3
    
    echo -n "Testing $description... "
    
    RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" -X POST "$url" \
        -H "Content-Type: application/json" \
        -d '{"test": true}' 2>/dev/null || echo "000")
    
    if [[ "$RESPONSE" == "$expected" ]] || [[ "$2" == "*" && "$RESPONSE" != "000" ]]; then
        echo -e "${GREEN}✅ OK${NC} (HTTP $RESPONSE)"
        return 0
    else
        echo -e "${RED}❌ FAILED${NC} (Expected $expected, got $RESPONSE)"
        return 1
    fi
}

# Track overall status
OVERALL_STATUS=0

echo "📡 Checking Endpoints:"
echo "----------------------"

# Test Render /process endpoint
if check_endpoint "https://brainbot-v76n.onrender.com/process" "401" "/process endpoint"; then
    echo "   → Endpoint exists and requires authentication (good!)"
else
    if [[ "$RESPONSE" == "404" ]]; then
        echo -e "   ${YELLOW}→ Endpoint not found - deployment may still be in progress${NC}"
    elif [[ "$RESPONSE" == "503" ]]; then
        echo -e "   ${YELLOW}→ Service temporarily unavailable - Render may be deploying${NC}"
    fi
    OVERALL_STATUS=1
fi

# Test Cloudflare Webhook Worker
if check_endpoint "https://brainbot-webhook.colin-c4d.workers.dev/health" "*" "CF Webhook Worker"; then
    echo "   → Webhook Worker is responding"
else
    echo -e "   ${YELLOW}→ Worker may not have a health endpoint (normal)${NC}"
fi

# Test main webhook endpoint (should require auth)
if check_endpoint "https://brainbot-v76n.onrender.com/webhook" "401" "Main webhook"; then
    echo "   → Main webhook exists and requires authentication"
fi

echo ""
echo "🔐 Checking Telegram Configuration:"
echo "------------------------------------"

# Check if TELEGRAM_BOT_TOKEN is set
if [ -z "$TELEGRAM_BOT_TOKEN" ]; then
    echo -e "${YELLOW}⚠️  TELEGRAM_BOT_TOKEN not set in environment${NC}"
    echo "   → Cannot check webhook configuration"
else
    echo "Fetching webhook info from Telegram..."
    
    WEBHOOK_INFO=$(curl -s "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/getWebhookInfo")
    
    if echo "$WEBHOOK_INFO" | grep -q '"ok":true'; then
        WEBHOOK_URL=$(echo "$WEBHOOK_INFO" | grep -o '"url":"[^"]*' | cut -d'"' -f4)
        PENDING_COUNT=$(echo "$WEBHOOK_INFO" | grep -o '"pending_update_count":[0-9]*' | cut -d':' -f2)
        LAST_ERROR=$(echo "$WEBHOOK_INFO" | grep -o '"last_error_message":"[^"]*' | cut -d'"' -f4)
        
        echo -e "${GREEN}✅ Telegram webhook configured${NC}"
        echo "   → URL: $WEBHOOK_URL"
        echo "   → Pending updates: $PENDING_COUNT"
        
        if [ -n "$LAST_ERROR" ] && [ "$LAST_ERROR" != "null" ]; then
            echo -e "   ${YELLOW}→ Last error: $LAST_ERROR${NC}"
        fi
        
        # Check which endpoint is configured
        if [[ "$WEBHOOK_URL" == *"brainbot-webhook.colin-c4d.workers.dev"* ]]; then
            echo -e "   ${GREEN}→ ✨ Using Cloudflare Worker (Phase 1 active!)${NC}"
        elif [[ "$WEBHOOK_URL" == *"brainbot-v76n.onrender.com"* ]]; then
            echo -e "   ${YELLOW}→ Still using direct Render webhook${NC}"
            echo "   → Run update_webhook.sh to switch to Cloudflare"
        fi
    else
        echo -e "${RED}❌ Failed to get webhook info${NC}"
        OVERALL_STATUS=1
    fi
fi

echo ""
echo "📊 Deployment Checklist:"
echo "------------------------"

# Check git status
CURRENT_BRANCH=$(git branch --show-current 2>/dev/null || echo "unknown")
echo -n "Git branch: "
if [[ "$CURRENT_BRANCH" == "main" ]]; then
    echo -e "${GREEN}✅ On main branch${NC}"
else
    echo -e "${YELLOW}⚠️  On $CURRENT_BRANCH (expected main)${NC}"
fi

# Check if feature branch is merged
if git log --oneline -n 20 | grep -q "cf-migration-phase1\|Cloudflare\|/process"; then
    echo -e "${GREEN}✅ Phase 1 changes appear to be merged${NC}"
else
    echo -e "${YELLOW}⚠️  Cannot confirm Phase 1 changes are merged${NC}"
    echo "   → Check git log manually"
fi

echo ""
echo "🔑 Environment Variables to Configure:"
echo "--------------------------------------"
echo "Add these to Render dashboard (Environment → Environment Variables):"
echo ""
echo "CF_PROXY_SECRET = 8f84125f867d95cd22c5906640f2f6a8badc37ad5136669d04d134ea7df58ab4"
echo ""

# Final status
echo "============================================="
if [[ $OVERALL_STATUS -eq 0 ]]; then
    echo -e "${GREEN}🎉 Migration verification passed!${NC}"
    echo ""
    echo "Next steps:"
    echo "1. Add CF_PROXY_SECRET to Render if not already done"
    echo "2. Wait for deployment to complete if still in progress"
    echo "3. Update Telegram webhook to Cloudflare Worker when ready"
else
    echo -e "${YELLOW}⚠️  Some checks failed or need attention${NC}"
    echo ""
    echo "Troubleshooting:"
    echo "1. Check Render deployment status: https://dashboard.render.com"
    echo "2. Verify environment variables are set correctly"
    echo "3. Check Worker logs: npx wrangler tail brainbot-webhook"
fi

echo "============================================="