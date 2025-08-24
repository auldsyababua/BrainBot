#!/bin/bash

# Test Result History Viewer
# Shows historical test results with timestamps

echo "📊 Test Result History"
echo "═══════════════════════"

# Change to project root
cd "$(dirname "$0")/.."

# Check if test results exist
if [ ! -d "tests/test_results" ] || [ -z "$(ls -A tests/test_results 2>/dev/null)" ]; then
    echo "❌ No test results found. Run tests first:"
    echo "   ./scripts/ai_change_check.sh"
    echo "   ./scripts/test_ai_babysitter.sh"
    exit 1
fi

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Function to show summary of a JSON report
show_test_summary() {
    local file="$1"
    local filename=$(basename "$file")
    
    if [ ! -f "$file" ]; then
        return
    fi
    
    # Extract key info from JSON (using python for JSON parsing)
    python3 - <<EOF
import json
import sys
from datetime import datetime

try:
    with open('$file', 'r') as f:
        data = json.load(f)
    
    # Extract timestamp from filename or report
    timestamp = '$filename'.replace('.json', '').replace('_', ' ')
    if 'created' in data:
        timestamp = data['created']
    
    # Test summary
    summary = data.get('summary', {})
    total = summary.get('total', 0)
    passed = summary.get('passed', 0) 
    failed = summary.get('failed', 0)
    
    # Status color
    status = '✅ PASSED' if failed == 0 else f'❌ {failed} FAILED'
    
    print(f"\n${BLUE}📅 {timestamp}${NC}")
    print(f"   {status} ({passed}/{total} tests)")
    
    # Show failed tests if any
    if failed > 0 and 'tests' in data:
        failed_tests = [test for test in data['tests'] if test.get('outcome') == 'failed']
        if failed_tests:
            print(f"   ${RED}Failed tests:${NC}")
            for test in failed_tests[:3]:  # Show first 3 failures
                test_name = test.get('nodeid', '').split('::')[-1]
                print(f"     • {test_name}")
            if len(failed_tests) > 3:
                print(f"     ... and {len(failed_tests) - 3} more")

except Exception as e:
    print(f"Error reading {file}: {e}")
EOF
}

# Show recent test runs (last 10)
echo -e "${YELLOW}Recent Test Runs:${NC}"
ls -t tests/test_results/*.json 2>/dev/null | head -10 | while read file; do
    show_test_summary "$file"
done

echo ""
echo "💡 Commands:"
echo "   ./scripts/ai_change_check.sh     - Quick smoke test"
echo "   ./scripts/test_ai_babysitter.sh  - Full test suite"
echo "   ls tests/test_results/           - View all result files"
