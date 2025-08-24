#!/bin/bash
# Deploy Cloudflare Migration Phase 1
# This script merges the feat/cf-migration-phase1 branch to main and triggers deployment

set -e  # Exit on error

echo "🚀 Starting Cloudflare Migration Phase 1 Deployment..."
echo "=================================================="

# Check current branch
CURRENT_BRANCH=$(git branch --show-current)
echo "📍 Current branch: $CURRENT_BRANCH"

# Fetch latest changes
echo "📥 Fetching latest changes from remote..."
git fetch origin

# Check if feat/cf-migration-phase1 exists
if ! git show-ref --verify --quiet refs/heads/feat/cf-migration-phase1; then
    echo "❌ Error: Branch feat/cf-migration-phase1 not found locally"
    echo "💡 Trying to fetch from remote..."
    git fetch origin feat/cf-migration-phase1:feat/cf-migration-phase1
fi

# Check for uncommitted changes
if ! git diff-index --quiet HEAD --; then
    echo "⚠️  Warning: You have uncommitted changes"
    echo "Please commit or stash them before proceeding"
    read -p "Continue anyway? (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ Deployment cancelled"
        exit 1
    fi
fi

# Checkout main branch
echo "🔄 Switching to main branch..."
git checkout main

# Pull latest main
echo "📥 Pulling latest main..."
git pull origin main

# Merge feature branch
echo "🔀 Merging feat/cf-migration-phase1 into main..."
git merge feat/cf-migration-phase1 --no-edit

# Push to origin
echo "📤 Pushing to origin/main..."
git push origin main

echo ""
echo "✅ Code successfully deployed to main branch!"
echo "=================================================="
echo ""
echo "📋 Next Steps:"
echo "1. ⏳ Wait 2-3 minutes for Render auto-deployment"
echo "2. 🔗 Monitor deployment at: https://dashboard.render.com"
echo "3. 🔑 Add CF_PROXY_SECRET to Render environment variables:"
echo "   Key: CF_PROXY_SECRET"
echo "   Value: <redacted-example> (set a strong secret in Render; do not commit real values)"
echo "4. 🧪 Run verification script: ./scripts/verify_migration.sh"
echo ""
echo "🎉 Deployment script completed successfully!"