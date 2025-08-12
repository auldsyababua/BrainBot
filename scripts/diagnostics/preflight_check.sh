#!/bin/bash
# Pre-flight check for Cloudflare Migration Phase 1
# Run this before deployment to ensure everything is ready

set -e  # Exit on error

echo "🚀 Cloudflare Migration Phase 1 - Pre-flight Check"
echo "==================================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Track overall status
PREFLIGHT_PASSED=true

# Function to check command exists
check_command() {
    if command -v $1 &> /dev/null; then
        echo -e "${GREEN}✅${NC} $2"
        return 0
    else
        echo -e "${RED}❌${NC} $2 (missing: $1)"
        PREFLIGHT_PASSED=false
        return 1
    fi
}

# Function to check environment variable
check_env() {
    if [ -n "${!1}" ]; then
        echo -e "${GREEN}✅${NC} $2 is set"
        return 0
    else
        echo -e "${YELLOW}⚠️${NC} $2 not set (optional)"
        return 1
    fi
}

# Function to check file exists
check_file() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}✅${NC} $2 exists"
        return 0
    else
        echo -e "${RED}❌${NC} $2 missing: $1"
        PREFLIGHT_PASSED=false
        return 1
    fi
}

# Function to check URL is accessible
check_url() {
    local url=$1
    local description=$2
    
    echo -n "   Checking $description... "
    
    RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" "$url" 2>/dev/null || echo "000")
    
    if [[ "$RESPONSE" != "000" ]] && [[ "$RESPONSE" != "500" ]] && [[ "$RESPONSE" != "502" ]]; then
        echo -e "${GREEN}✅${NC} (HTTP $RESPONSE)"
        return 0
    else
        echo -e "${RED}❌${NC} (HTTP $RESPONSE)"
        PREFLIGHT_PASSED=false
        return 1
    fi
}

echo -e "${BLUE}1. Checking Required Tools${NC}"
echo "-----------------------------"
check_command git "Git CLI"
check_command curl "cURL"
check_command jq "jq JSON processor"
check_command npx "Node.js/npx (optional for Worker debugging)"
echo ""

echo -e "${BLUE}2. Checking Git Repository${NC}"
echo "-----------------------------"

# Check we're in a git repo
if git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${GREEN}✅${NC} In a git repository"
else
    echo -e "${RED}❌${NC} Not in a git repository"
    PREFLIGHT_PASSED=false
fi

# Check current branch
CURRENT_BRANCH=$(git branch --show-current)
echo -e "📍 Current branch: ${YELLOW}$CURRENT_BRANCH${NC}"

# Check if feature branch exists
if git show-ref --verify --quiet refs/heads/feat/cf-migration-phase1; then
    echo -e "${GREEN}✅${NC} Feature branch exists: feat/cf-migration-phase1"
else
    echo -e "${RED}❌${NC} Feature branch not found: feat/cf-migration-phase1"
    PREFLIGHT_PASSED=false
fi

# Check for uncommitted changes
if git diff-index --quiet HEAD -- 2>/dev/null; then
    echo -e "${GREEN}✅${NC} No uncommitted changes"
else
    echo -e "${YELLOW}⚠️${NC} You have uncommitted changes (consider committing first)"
fi

# Check if main is up to date
git fetch origin main --dry-run 2>&1 | grep -q "up to date" && \
    echo -e "${GREEN}✅${NC} Main branch is up to date" || \
    echo -e "${YELLOW}⚠️${NC} Main branch may need updating"

echo ""

echo -e "${BLUE}3. Checking Required Files${NC}"
echo "-----------------------------"
check_file "src/bot/webhook_bot.py" "Python webhook bot"
check_file "cf/brainbot-webhook/src/webhook.ts" "Webhook Worker source"
check_file "cf/brainbot-consumer/src/consumer.ts" "Consumer Worker source"
check_file "render.yaml" "Render configuration"
check_file ".github/workflows/deploy.yml" "GitHub deployment workflow"
check_file ".github/workflows/cloudflare.yml" "Cloudflare deployment workflow"
echo ""

echo -e "${BLUE}4. Checking Deployment Scripts${NC}"
echo "--------------------------------"
check_file "scripts/deploy_phase1.sh" "Deployment script"
check_file "scripts/verify_migration.sh" "Verification script"
check_file "scripts/rollback_phase1.sh" "Rollback script"

# Make scripts executable
for script in scripts/deploy_phase1.sh scripts/verify_migration.sh scripts/rollback_phase1.sh; do
    if [ -f "$script" ] && [ ! -x "$script" ]; then
        chmod +x "$script"
        echo -e "${YELLOW}ℹ️${NC}  Made $script executable"
    fi
done
echo ""

echo -e "${BLUE}5. Checking Cloudflare Workers${NC}"
echo "---------------------------------"
check_url "https://brainbot-webhook.colin-c4d.workers.dev" "Webhook Worker"
check_url "https://brainbot-consumer.colin-c4d.workers.dev" "Consumer Worker"
echo ""

echo -e "${BLUE}6. Checking Render Service${NC}"
echo "-----------------------------"
check_url "https://brainbot-v76n.onrender.com/health" "Bot health endpoint"
check_url "https://brainbot-v76n.onrender.com/webhook" "Current webhook"

# Test if /process endpoint exists (should fail pre-deployment)
echo -n "   Checking /process endpoint... "
PROCESS_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" -X POST \
    "https://brainbot-v76n.onrender.com/process" \
    -H "Content-Type: application/json" \
    -d '{"test": true}' 2>/dev/null || echo "000")

if [[ "$PROCESS_RESPONSE" == "404" ]]; then
    echo -e "${YELLOW}⚠️${NC} Not yet deployed (expected before merge)"
elif [[ "$PROCESS_RESPONSE" == "401" ]]; then
    echo -e "${GREEN}✅${NC} Already deployed!"
else
    echo -e "${RED}❌${NC} Unexpected response: $PROCESS_RESPONSE"
fi
echo ""

echo -e "${BLUE}7. Checking Environment Variables${NC}"
echo "-----------------------------------"
check_env "TELEGRAM_BOT_TOKEN" "TELEGRAM_BOT_TOKEN"
check_env "CLOUDFLARE_API_TOKEN" "CLOUDFLARE_API_TOKEN"
check_env "RENDER_API_KEY" "RENDER_API_KEY"
echo ""

echo -e "${BLUE}8. Checking Python Dependencies${NC}"
echo "----------------------------------"
if [ -f "requirements.txt" ]; then
    echo -e "${GREEN}✅${NC} requirements.txt exists"
    
    # Check for FastAPI (required for /process endpoint)
    if grep -q "fastapi" requirements.txt; then
        echo -e "${GREEN}✅${NC} FastAPI in requirements"
    else
        echo -e "${RED}❌${NC} FastAPI not in requirements"
        PREFLIGHT_PASSED=false
    fi
    
    # Check for httpx (for webhook operations)
    if grep -q "httpx" requirements.txt; then
        echo -e "${GREEN}✅${NC} httpx in requirements"
    else
        echo -e "${YELLOW}⚠️${NC} httpx not in requirements (might be needed)"
    fi
else
    echo -e "${RED}❌${NC} requirements.txt missing"
    PREFLIGHT_PASSED=false
fi
echo ""

echo -e "${BLUE}9. Configuration Summary${NC}"
echo "--------------------------"
echo "   Repository: flrts"
echo "   Target branch: main"
echo "   Feature branch: feat/cf-migration-phase1"
echo "   Render service: brainbot-v76n"
echo "   Webhook Worker: brainbot-webhook.colin-c4d.workers.dev"
echo "   Consumer Worker: brainbot-consumer.colin-c4d.workers.dev"
echo "   CF_PROXY_SECRET: 8f84125f867d95cd22c5906640f2f6a8badc37ad5136669d04d134ea7df58ab4"
echo ""

# Final verdict
echo "==================================================="
if [ "$PREFLIGHT_PASSED" = true ]; then
    echo -e "${GREEN}✅ PRE-FLIGHT CHECK PASSED!${NC}"
    echo ""
    echo "Ready for deployment. Next steps:"
    echo "1. Run: ./scripts/deploy_phase1.sh"
    echo "2. Add CF_PROXY_SECRET to Render environment"
    echo "3. Run: ./scripts/verify_migration.sh"
else
    echo -e "${RED}❌ PRE-FLIGHT CHECK FAILED${NC}"
    echo ""
    echo "Please fix the issues above before proceeding."
    echo "Critical items must be resolved, warnings are optional."
    exit 1
fi

echo "==================================================="