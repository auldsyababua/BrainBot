#!/bin/bash

echo "🔍 Debugging Backend Issues"
echo "=========================="

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
log_success() { echo -e "${GREEN}✅ $1${NC}"; }
log_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
log_error() { echo -e "${RED}❌ $1${NC}"; }

echo ""
log_info "Step 1: Check backend endpoints"
echo "-------------------------------"

# Health check
log_info "Testing /health endpoint..."
HEALTH=$(curl -s -w "HTTP_CODE:%{http_code}" https://brainbot-v76n.onrender.com/health)
echo "Response: $HEALTH"

# Process endpoint (should return 401 without auth)
log_info "Testing /process endpoint..."
PROCESS=$(curl -s -w "HTTP_CODE:%{http_code}" -X POST https://brainbot-v76n.onrender.com/process \
  -H "Content-Type: application/json" \
  -d '{"test": "data"}')
echo "Response: $PROCESS"

echo ""
log_info "Step 2: Check consumer worker configuration"
echo "------------------------------------------"

cd cf/brainbot-consumer
log_info "Current wrangler.toml PROCESS_URL:"
grep "PROCESS_URL" wrangler.toml

echo ""
log_info "Step 3: Test with proper HMAC signature"
echo "---------------------------------------"

# Generate proper HMAC signature
PAYLOAD='{"update_id":1,"message":{"text":"debug test","chat":{"id":123},"date":1700000000}}'
TIMESTAMP=$(date +%s)
SECRET="your-secret-here"  # You'll need to replace this

log_info "Testing with HMAC signature..."
log_warning "Note: This will fail without the correct CF_PROXY_SECRET"

# This would need the actual secret to work
curl -s -w "HTTP_CODE:%{http_code}" -X POST https://brainbot-v76n.onrender.com/process \
  -H "Content-Type: application/json" \
  -H "X-Request-Timestamp: $TIMESTAMP" \
  -H "X-BrainBot-Signature: v1=placeholder" \
  -d "$PAYLOAD"

echo ""
echo ""
log_info "Step 4: Check if backend is actually running"
echo "--------------------------------------------"

log_info "Checking Render service status..."
log_warning "You need to check your Render dashboard for:"
echo "  - Service status (running/sleeping/failed)"
echo "  - Recent logs"
echo "  - Environment variables"
echo "  - Build/deploy status"

echo ""
log_info "Step 5: Manual wake-up attempt"
echo "------------------------------"

log_info "Attempting to wake up backend with multiple requests..."
for i in {1..5}; do
    echo -n "Request $i: "
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://brainbot-v76n.onrender.com/health)
    echo "HTTP $STATUS"
    sleep 2
done

echo ""
log_warning "If all requests return 503, the backend may be:"
echo "  1. Crashed/failed to start"
echo "  2. Missing environment variables"
echo "  3. Python dependency issues"
echo "  4. Port binding problems"

echo ""
log_info "Next steps:"
echo "1. Check Render dashboard logs"
echo "2. Verify environment variables are set"
echo "3. Check if main.py is the correct entry point"
echo "4. Verify requirements.txt dependencies"