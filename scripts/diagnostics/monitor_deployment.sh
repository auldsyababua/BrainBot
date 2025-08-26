#!/bin/bash

echo "📊 Monitoring Render Deployment"
echo "==============================="
echo ""
echo "Watching for the fix to deploy..."
echo "Press Ctrl+C to stop monitoring"
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

FIXED=false
COUNT=0

while [ "$FIXED" = false ]; do
    COUNT=$((COUNT + 1))
    echo -n "Attempt $COUNT: "
    
    # Check health endpoint
    RESPONSE=$(curl -s https://brainbot-v76n.onrender.com/health)
    VECTOR_STATUS=$(echo "$RESPONSE" | jq -r '.services.database.vector_store.status' 2>/dev/null)
    VECTOR_ERROR=$(echo "$RESPONSE" | jq -r '.services.database.vector_store.error' 2>/dev/null)
    
    if [ "$VECTOR_STATUS" = "healthy" ]; then
        echo -e "${GREEN}✅ Vector store is healthy! Deployment complete!${NC}"
        FIXED=true
        
        # Test the bot
        echo ""
        echo "Testing bot responsiveness..."
        echo "1. Send /start to your bot"
        echo "2. Monitor with: cd cf/brainbot-webhook && npx wrangler tail"
        
    elif [[ "$VECTOR_ERROR" == *"InfoResult"* ]]; then
        echo -e "${YELLOW}⏳ Still old version (waiting for deployment)${NC}"
        sleep 10
    else
        echo -e "${YELLOW}Status: $VECTOR_STATUS | Error: $VECTOR_ERROR${NC}"
        sleep 10
    fi
    
    # Timeout after 5 minutes
    if [ $COUNT -gt 30 ]; then
        echo -e "${RED}❌ Timeout waiting for deployment${NC}"
        echo "Check Render dashboard for build status"
        exit 1
    fi
done

echo ""
echo -e "${GREEN}🎉 Bot backend is now healthy!${NC}"
echo "Your bot should be responding to messages now."