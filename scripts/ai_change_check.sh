#!/bin/bash

# AI Change Check - Run this after every AI code change
# Quickly checks if AI broke core functionality

echo "🤖 Checking what the AI might have broken..."
echo "═══════════════════════════════════════════════"

# Change to project root
cd "$(dirname "$0")/.."

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Track failures
FAILED_TESTS=()

# Function to run a test and track results
run_test() {
    local test_name="$1"
    local description="$2"
    
    echo -e "\n${YELLOW}Testing:${NC} $description"
    
    if pytest "tests/test_ai_babysitter.py::$test_name" -v --tb=short -q; then
        echo -e "${GREEN}✅ PASSED${NC}"
    else
        echo -e "${RED}❌ FAILED${NC}"
        FAILED_TESTS+=("$description")
    fi
}

# Core functionality tests (run these after every AI change)
echo "\n🎯 Testing Core Features (most likely to break)"
run_test "test_bot_saves_and_retrieves_notes" "Save and retrieve notes"
run_test "test_cache_actually_works" "Caching system"
run_test "test_conversation_history_not_growing_infinitely" "Memory management"

echo "\n🔍 Testing AI-Specific Issues"
run_test "test_no_unreachable_code" "Dead code detection"
run_test "test_retry_config_actually_applied" "Config usage"
run_test "test_new_feature_didnt_break_old_features" "Feature interference"

echo "\n💰 Testing Efficiency"
run_test "test_not_burning_api_credits" "API call efficiency"
run_test "test_response_time_reasonable" "Response speed"

echo "\n🔒 Testing Multi-User Safety"
run_test "test_multiple_users_dont_interfere" "User isolation"
run_test "test_data_survives_restart" "Data persistence"

# Final summary
echo "\n═══════════════════════════════════════════════"

if [ ${#FAILED_TESTS[@]} -eq 0 ]; then
    echo -e "${GREEN}🎉 All core features still work!${NC}"
    echo "✅ AI changes look safe to proceed"
    echo ""
    echo "💡 Tip: Run full test suite before deploying:"
    echo "   ./scripts/test_ai_babysitter.sh"
else
    echo -e "${RED}⚠️  AI broke something! Failed tests:${NC}"
    for test in "${FAILED_TESTS[@]}"; do
        echo -e "   ${RED}•${NC} $test"
    done
    echo ""
    echo -e "${YELLOW}🤖 What to tell the AI:${NC}"
    echo "   'The following tests are failing after your changes:'"
    for test in "${FAILED_TESTS[@]}"; do
        echo "   - $test"
    done
    echo "   'Please fix these issues before proceeding.'"
    echo ""
    echo "📋 Run full diagnostic:"
    echo "   pytest tests/test_ai_babysitter.py -v"
    
    exit 1
fi
