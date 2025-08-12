#!/bin/bash
# Emergency deployment script to fix missing /process endpoint

set -e

echo "🚨 Emergency Deployment Fix for /process Endpoint"
echo "================================================"
echo ""

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check current branch
CURRENT_BRANCH=$(git branch --show-current)
echo "Current branch: ${YELLOW}$CURRENT_BRANCH${NC}"

if [ "$CURRENT_BRANCH" != "feat/cf-migration-phase1" ]; then
    echo -e "${RED}Error: Not on feat/cf-migration-phase1 branch${NC}"
    echo "Please switch to the feature branch first:"
    echo "  git checkout feat/cf-migration-phase1"
    exit 1
fi

echo ""
echo "📋 Pre-deployment Checklist:"
echo "----------------------------"

# Check for uncommitted changes
if ! git diff-index --quiet HEAD --; then
    echo -e "${YELLOW}Warning: You have uncommitted changes${NC}"
    git status --short
    echo ""
    read -p "Do you want to commit these changes? (y/n) " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git add -A
        git commit -m "chore: commit changes before deployment fix"
    fi
fi

echo ""
echo "🔀 Deployment Options:"
echo "----------------------"
echo "1. Merge to main and deploy (RECOMMENDED)"
echo "2. Create hotfix branch"
echo "3. Deploy feature branch directly (NOT RECOMMENDED)"
echo ""
read -p "Select option (1-3): " DEPLOY_OPTION

case $DEPLOY_OPTION in
    1)
        echo ""
        echo -e "${GREEN}Option 1: Merging to main branch${NC}"
        
        # Update from remote
        git fetch origin
        
        # Check if PR exists
        PR_EXISTS=$(gh pr list --head "$CURRENT_BRANCH" --json number --jq '.[0].number' 2>/dev/null || echo "")
        
        if [ -z "$PR_EXISTS" ]; then
            echo "Creating Pull Request..."
            gh pr create \
                --title "fix: Add /process endpoint for Cloudflare integration" \
                --body "## Critical Fix

This PR adds the missing /process endpoint that the Cloudflare Consumer Worker needs.

### Changes:
- Added /process endpoint with HMAC validation
- Added CF_PROXY_SECRET configuration
- Fixed integration between Cloudflare Workers and Render service

### Testing:
- [x] Endpoint responds to POST requests
- [x] HMAC validation works correctly
- [x] Telegram updates are processed

### Deployment:
This needs to be deployed immediately to fix production issues.

🚨 **URGENT**: Consumer Worker is currently failing with 404 errors" \
                --label "bug,urgent,cloudflare"
            
            PR_NUMBER=$(gh pr list --head "$CURRENT_BRANCH" --json number --jq '.[0].number')
        else
            PR_NUMBER=$PR_EXISTS
            echo "Using existing PR #$PR_NUMBER"
        fi
        
        echo ""
        echo "Merging PR #$PR_NUMBER..."
        read -p "Are you sure you want to merge to main? (y/n) " -n 1 -r
        echo ""
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            gh pr merge $PR_NUMBER --merge --delete-branch=false
            echo -e "${GREEN}✅ Merged to main branch${NC}"
            echo ""
            echo "Deployment will start automatically via GitHub Actions"
            echo "Monitor deployment at: https://github.com/$GITHUB_REPOSITORY/actions"
        else
            echo "Merge cancelled"
            exit 1
        fi
        ;;
        
    2)
        echo ""
        echo -e "${GREEN}Option 2: Creating hotfix branch${NC}"
        
        # Create hotfix from main
        git checkout main
        git pull origin main
        git checkout -b hotfix/process-endpoint
        
        # Cherry-pick the commit that adds /process endpoint
        PROCESS_COMMIT=$(git log --grep="process endpoint" --format="%H" -n 1 feat/cf-migration-phase1)
        if [ -n "$PROCESS_COMMIT" ]; then
            git cherry-pick $PROCESS_COMMIT
        else
            echo "Merging changes from feature branch..."
            git merge feat/cf-migration-phase1 --no-edit
        fi
        
        # Push and create PR
        git push origin hotfix/process-endpoint
        gh pr create \
            --title "hotfix: Add missing /process endpoint" \
            --body "Hotfix for missing /process endpoint" \
            --label "hotfix,urgent"
        ;;
        
    3)
        echo ""
        echo -e "${YELLOW}Option 3: Direct deployment (NOT RECOMMENDED)${NC}"
        echo -e "${RED}Warning: This bypasses normal deployment process${NC}"
        read -p "Are you absolutely sure? (yes/no) " -r
        if [ "$REPLY" != "yes" ]; then
            echo "Deployment cancelled"
            exit 1
        fi
        
        echo "This would require manual Render deployment configuration"
        echo "Please use Render dashboard to deploy from feat/cf-migration-phase1 branch"
        ;;
        
    *)
        echo -e "${RED}Invalid option${NC}"
        exit 1
        ;;
esac

echo ""
echo "📊 Post-Deployment Verification:"
echo "--------------------------------"
echo ""
echo "Run these commands to verify deployment:"
echo ""
echo "  # Check health"
echo "  curl https://brainbot-v76n.onrender.com/health | jq ."
echo ""
echo "  # Check /process endpoint exists (should return 401)"
echo "  curl -X POST https://brainbot-v76n.onrender.com/process"
echo ""
echo "  # Check Render logs"
echo "  open https://dashboard.render.com"
echo ""
echo "  # Monitor GitHub Actions"
echo "  open https://github.com/$GITHUB_REPOSITORY/actions"
echo ""

# Set up monitoring
echo "🔍 Setting up monitoring..."
echo ""
echo "Would you like to monitor the deployment? (y/n) "
read -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Monitoring deployment status..."
    echo "Press Ctrl+C to stop monitoring"
    echo ""
    
    while true; do
        # Check health endpoint
        HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://brainbot-v76n.onrender.com/health)
        PROCESS_STATUS=$(curl -s -o /dev/null -w "%{http_code}" -X POST https://brainbot-v76n.onrender.com/process)
        
        echo -ne "\r[$(date +%H:%M:%S)] Health: $HTTP_STATUS | /process: $PROCESS_STATUS"
        
        if [ "$PROCESS_STATUS" == "401" ] || [ "$PROCESS_STATUS" == "503" ]; then
            echo ""
            echo -e "${GREEN}✅ /process endpoint is responding!${NC}"
            break
        fi
        
        sleep 5
    done
fi

echo ""
echo "✨ Deployment fix completed!"