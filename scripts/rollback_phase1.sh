#!/bin/bash
# Rollback Cloudflare Migration Phase 1
# Emergency rollback script if Phase 1 causes issues

set -e  # Exit on error

echo "🔙 Starting Cloudflare Migration Phase 1 Rollback..."
echo "=================================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check current branch
CURRENT_BRANCH=$(git branch --show-current)
echo "📍 Current branch: $CURRENT_BRANCH"

# Save current work if needed
if ! git diff-index --quiet HEAD --; then
    echo -e "${YELLOW}⚠️  You have uncommitted changes${NC}"
    echo "Stashing changes..."
    git stash push -m "Rollback stash: $(date +%Y%m%d_%H%M%S)"
fi

# Fetch latest changes
echo "📥 Fetching latest changes from remote..."
git fetch origin

# Get the last commit before the merge
echo "🔍 Finding last commit before Phase 1 merge..."
LAST_SAFE_COMMIT=$(git log --oneline main | grep -v "cf-migration-phase1\|Cloudflare\|/process" | head -1 | awk '{print $1}')

if [ -z "$LAST_SAFE_COMMIT" ]; then
    echo -e "${RED}❌ Could not find a safe commit to rollback to${NC}"
    echo "Please manually specify a commit hash"
    exit 1
fi

echo "Found safe commit: $LAST_SAFE_COMMIT"
git log --oneline -n 1 $LAST_SAFE_COMMIT

# Confirm rollback
echo ""
echo -e "${YELLOW}⚠️  WARNING: This will rollback main branch${NC}"
echo "This action will:"
echo "1. Reset main branch to before Phase 1 changes"
echo "2. Force push to origin (requires permissions)"
echo "3. Trigger automatic redeployment on Render"
echo ""
read -p "Are you sure you want to proceed? Type 'ROLLBACK' to confirm: " CONFIRM

if [ "$CONFIRM" != "ROLLBACK" ]; then
    echo -e "${RED}❌ Rollback cancelled${NC}"
    exit 1
fi

# Checkout main
echo "🔄 Switching to main branch..."
git checkout main

# Reset to safe commit
echo "⏮️ Resetting to safe commit..."
git reset --hard $LAST_SAFE_COMMIT

# Force push (with lease for safety)
echo "📤 Force pushing to origin/main..."
git push origin main --force-with-lease

echo ""
echo -e "${GREEN}✅ Rollback completed successfully!${NC}"
echo "=================================================="
echo ""
echo "📋 Post-Rollback Actions:"
echo "1. ⏳ Wait for Render to redeploy (2-3 minutes)"
echo "2. 🔗 Monitor deployment at: https://dashboard.render.com"
echo "3. 🧪 Verify bot is working: send a test message"
echo "4. 📝 Document what went wrong for debugging"
echo ""
echo "🔧 To restore Phase 1 later:"
echo "   git checkout feat/cf-migration-phase1"
echo "   Fix the issues"
echo "   Run deploy_phase1.sh again"
echo ""
echo -e "${YELLOW}⚠️  Note: CF_PROXY_SECRET in Render can remain set${NC}"
echo "   It won't affect the rolled-back version"