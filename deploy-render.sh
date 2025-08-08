#!/bin/bash

# Render Deployment Script for Telegram Mini App
# This script uses Render's REST API to deploy the Mini App

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 Deploying Telegram Mini App to Render${NC}"

# Check if RENDER_API_KEY is set
if [ -z "$RENDER_API_KEY" ]; then
    echo -e "${RED}❌ Error: RENDER_API_KEY environment variable is not set${NC}"
    echo "Get your API key from: https://dashboard.render.com/account/api-keys"
    echo "Then run: export RENDER_API_KEY=your_api_key_here"
    exit 1
fi

# Configuration
REPO_URL="https://github.com/auldsyababua/BrainBot"
BRANCH="deploy-telegram-mini-app-production"
SERVICE_NAME="telegram-mini-app"

echo -e "${YELLOW}📋 Configuration:${NC}"
echo "Repository: $REPO_URL"
echo "Branch: $BRANCH"
echo "Service Name: $SERVICE_NAME"

# Create the static site service
echo -e "${YELLOW}🏗️  Creating static site service...${NC}"

SERVICE_CONFIG=$(cat <<EOF
{
  "name": "$SERVICE_NAME",
  "type": "static_site",
  "repo": "$REPO_URL",
  "branch": "$BRANCH",
  "buildCommand": "cd telegram-mini-app && npm install && npm run build",
  "publishPath": "telegram-mini-app/dist",
  "pullRequestPreviewsEnabled": true,
  "autoDeploy": true,
  "envVars": [
    {
      "key": "NODE_VERSION",
      "value": "20"
    },
    {
      "key": "VITE_API_URL", 
      "value": "https://brainbot-v76n.onrender.com"
    },
    {
      "key": "VITE_TELEGRAM_BOT_USERNAME",
      "value": "${TELEGRAM_BOT_USERNAME:-your_bot_username}"
    },
    {
      "key": "VITE_TELEGRAM_WEB_APP_URL",
      "value": "https://telegram-mini-app.onrender.com"
    }
  ],
  "headers": [
    {
      "path": "/*",
      "name": "X-Frame-Options",
      "value": "SAMEORIGIN"
    },
    {
      "path": "/*", 
      "name": "X-Content-Type-Options",
      "value": "nosniff"
    },
    {
      "path": "/*",
      "name": "X-XSS-Protection", 
      "value": "1; mode=block"
    },
    {
      "path": "/*",
      "name": "Referrer-Policy",
      "value": "strict-origin-when-cross-origin"
    },
    {
      "path": "/assets/*",
      "name": "Cache-Control",
      "value": "public, max-age=31536000, immutable"
    }
  ],
  "routes": [
    {
      "type": "rewrite",
      "source": "/*",
      "destination": "/index.html"
    }
  ]
}
EOF
)

# Make API request to create service
RESPONSE=$(curl -s -w "\n%{http_code}" -X POST \
  -H "Authorization: Bearer $RENDER_API_KEY" \
  -H "Content-Type: application/json" \
  -d "$SERVICE_CONFIG" \
  "https://api.render.com/v1/services")

HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
RESPONSE_BODY=$(echo "$RESPONSE" | head -n -1)

if [ "$HTTP_CODE" -eq 201 ]; then
    echo -e "${GREEN}✅ Service created successfully!${NC}"
    SERVICE_ID=$(echo "$RESPONSE_BODY" | grep -o '"id":"[^"]*' | cut -d'"' -f4)
    SERVICE_URL=$(echo "$RESPONSE_BODY" | grep -o '"url":"[^"]*' | cut -d'"' -f4)
    
    echo -e "${GREEN}📡 Service Details:${NC}"
    echo "Service ID: $SERVICE_ID"
    echo "Service URL: $SERVICE_URL"
    
    echo -e "${YELLOW}⏳ Deployment in progress...${NC}"
    echo "You can monitor the deployment at: https://dashboard.render.com/static/$SERVICE_ID"
    
    # Update the environment variable with the actual URL
    if [ -n "$SERVICE_URL" ] && [ "$SERVICE_URL" != "null" ]; then
        echo -e "${YELLOW}🔧 Updating VITE_TELEGRAM_WEB_APP_URL...${NC}"
        
        UPDATE_CONFIG=$(cat <<EOF
{
  "envVars": [
    {
      "key": "VITE_TELEGRAM_WEB_APP_URL",
      "value": "$SERVICE_URL"
    }
  ]
}
EOF
)
        
        UPDATE_RESPONSE=$(curl -s -w "\n%{http_code}" -X PATCH \
          -H "Authorization: Bearer $RENDER_API_KEY" \
          -H "Content-Type: application/json" \
          -d "$UPDATE_CONFIG" \
          "https://api.render.com/v1/services/$SERVICE_ID")
        
        UPDATE_HTTP_CODE=$(echo "$UPDATE_RESPONSE" | tail -n1)
        
        if [ "$UPDATE_HTTP_CODE" -eq 200 ]; then
            echo -e "${GREEN}✅ Environment variable updated successfully!${NC}"
        else
            echo -e "${YELLOW}⚠️  Could not update environment variable automatically${NC}"
            echo "Please update VITE_TELEGRAM_WEB_APP_URL to: $SERVICE_URL"
        fi
    fi
    
    echo -e "${GREEN}🎉 Deployment initiated successfully!${NC}"
    echo -e "${YELLOW}Next steps:${NC}"
    echo "1. Wait for deployment to complete (5-10 minutes)"
    echo "2. Test the Mini App at: $SERVICE_URL"
    echo "3. Configure your Telegram Bot with the Mini App URL"
    echo "4. Set up the Telegram Bot menu button using @BotFather"
    
else
    echo -e "${RED}❌ Failed to create service${NC}"
    echo "HTTP Code: $HTTP_CODE"
    echo "Response: $RESPONSE_BODY"
    exit 1
fi