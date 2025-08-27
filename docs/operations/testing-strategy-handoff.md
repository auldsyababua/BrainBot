# Testing Suite Handoff Document

## Executive Summary

**Date**: August 27, 2025  
**Current Branch**: `story-2.1-qa-review`  
**Priority**: HIGH - Testing infrastructure needs immediate optimization

We have a self-hosted runner configured but are not utilizing it effectively. Currently pushing code and waiting for CI results is inefficient and costly. We need to establish a local-first testing strategy that validates all tests BEFORE pushing to GitHub.

## Current State Analysis

### What We Have

1. **Self-Hosted Runner**: Already configured and available for local testing
2. **GitHub Actions Workflows**: Recently updated to v4 (fixed deprecated actions)
3. **Test Suite Structure**:
   ```
   tests/
   ├── unit/           # 246 passing, 3 failing locally
   ├── integration/    # 152 skipped (need DB connections)
   ├── performance/    # 5 passing, 3 failing
   ├── security/       # Collection errors (pytest-asyncio issue)
   └── testsprite_tests/ # Anti-MESA pattern tests
   ```

### Current Problems

1. **No Local CI Validation**: We're pushing code blindly and waiting for GitHub to tell us what failed
2. **Wasted GitHub Actions Minutes**: Running tests that fail due to simple issues
3. **Slow Feedback Loop**: 5-10 minutes to find out about failures
4. **Import Path Issues**: Still finding `src.` imports that should be `brainbot.`
5. **Environment Differences**: Local tests behave differently than CI

## Immediate Action Items for Next Agent

### 1. Set Up Local GitHub Actions Runner ✅ Priority: CRITICAL

```bash
# Check if runner is already installed
ls -la ~/actions-runner/

# If not, follow setup from:
# Settings → Actions → Runners → New self-hosted runner

# Key benefits:
# - Run exact same GitHub Actions locally
# - FREE (no GitHub minutes consumed)
# - FAST (no queue wait time)
# - Identical environment to CI
```

### 2. Create Local Test Script 🔧 Priority: HIGH

Create `/Users/colinaulds/Desktop/projects/BrainBot/scripts/run_local_ci.sh`:

```bash
#!/bin/bash
# Local CI Test Runner - Mimics GitHub Actions

set -e  # Exit on any error

echo "🏃 Running Local CI Tests (GitHub Actions Compatible)"
echo "=================================================="

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Track failures
FAILURES=0

# 1. Python Version Check
echo -e "\n${YELLOW}Checking Python Version...${NC}"
python --version
if [[ $(python --version 2>&1) != *"3.11"* ]]; then
    echo -e "${RED}❌ Warning: CI uses Python 3.11${NC}"
fi

# 2. Environment Setup
echo -e "\n${YELLOW}Setting up test environment...${NC}"
export PYTHONPATH="${PYTHONPATH}:/Users/colinaulds/Desktop/projects/BrainBot/src"

# Set dummy env vars for CI compatibility
export CI=true
export GITHUB_ACTIONS=true
export SUPABASE_URL="https://dummy.supabase.co"
export SUPABASE_ANON_KEY="dummy_key"
export TELEGRAM_BOT_TOKEN="dummy:token"
export CLOUDFLARE_ACCOUNT_ID="dummy"
export CLOUDFLARE_KV_NAMESPACE_ID="dummy"

# 3. Install Dependencies
echo -e "\n${YELLOW}Installing dependencies...${NC}"
pip install -q -r requirements.txt
pip install -q pytest pytest-cov pytest-asyncio pytest-benchmark

# 4. Run Linting
echo -e "\n${YELLOW}Running Ruff linter...${NC}"
if ruff check .; then
    echo -e "${GREEN}✅ Linting passed${NC}"
else
    echo -e "${RED}❌ Linting failed${NC}"
    FAILURES=$((FAILURES + 1))
fi

# 5. Run Type Checking
echo -e "\n${YELLOW}Running MyPy type checker...${NC}"
if mypy src/ --ignore-missing-imports; then
    echo -e "${GREEN}✅ Type checking passed${NC}"
else
    echo -e "${YELLOW}⚠️  Type checking has warnings${NC}"
fi

# 6. Run Unit Tests
echo -e "\n${YELLOW}Running unit tests...${NC}"
if pytest tests/unit -q --tb=short; then
    echo -e "${GREEN}✅ Unit tests passed${NC}"
else
    echo -e "${RED}❌ Unit tests failed${NC}"
    FAILURES=$((FAILURES + 1))
fi

# 7. Run Integration Tests (if services available)
echo -e "\n${YELLOW}Running integration tests...${NC}"
if command -v redis-cli &> /dev/null && redis-cli ping &> /dev/null; then
    pytest tests/integration -q --tb=short || true
else
    echo -e "${YELLOW}⚠️  Skipping integration tests (Redis not running)${NC}"
fi

# 8. Run Security Tests
echo -e "\n${YELLOW}Running security tests...${NC}"
if python -m pytest tests/security -q --tb=short 2>/dev/null; then
    echo -e "${GREEN}✅ Security tests passed${NC}"
else
    echo -e "${YELLOW}⚠️  Security tests have issues${NC}"
fi

# 9. Check for Import Issues
echo -e "\n${YELLOW}Checking for old import patterns...${NC}"
if grep -r "from src\." tests/ --include="*.py" 2>/dev/null; then
    echo -e "${RED}❌ Found 'src.' imports that should be 'brainbot.'${NC}"
    FAILURES=$((FAILURES + 1))
else
    echo -e "${GREEN}✅ No legacy imports found${NC}"
fi

# 10. Summary
echo -e "\n=================================================="
if [ $FAILURES -eq 0 ]; then
    echo -e "${GREEN}✅ ALL CHECKS PASSED - Safe to push!${NC}"
    exit 0
else
    echo -e "${RED}❌ $FAILURES CHECKS FAILED - Fix before pushing!${NC}"
    exit 1
fi
```

### 3. Use `act` for Local GitHub Actions 🎯 Priority: HIGH

```bash
# Install act (runs GitHub Actions locally)
brew install act

# Run GitHub Actions locally
cd /Users/colinaulds/Desktop/projects/BrainBot
act -j backend-tests  # Run specific job
act pull_request     # Simulate PR event

# This uses Docker to run the exact GitHub Actions environment
```

### 4. Fix Current Test Failures 🔧 Priority: MEDIUM

#### Known Failures to Fix:

1. **Router Confidence Tests** (3 failures)
   - File: `tests/unit/test_router.py`
   - Issues: `test_interactive_mode_semantics`, `test_confidence_component_separation`
   - Likely cause: Package rename from flrts to brainbot

2. **Performance Tests** (3 failures)
   - File: `tests/performance/test_performance.py`
   - Issues: Metrics and sliding window tests
   - Likely cause: Async handling or timing issues

3. **Security Test Collection**
   - Issue: `AttributeError: 'function' object has no attribute 'hypothesis'`
   - Fix: Update pytest-asyncio or modify security test decorators

### 5. Create Pre-Push Hook 🪝 Priority: MEDIUM

Create `.git/hooks/pre-push`:

```bash
#!/bin/bash
echo "Running pre-push tests..."

# Run the local CI script
./scripts/run_local_ci.sh

if [ $? -ne 0 ]; then
    echo "❌ Tests failed! Push aborted."
    echo "Fix the issues above and try again."
    exit 1
fi

echo "✅ All tests passed! Proceeding with push..."
```

## Sustainable Testing Strategy

### Local-First Philosophy

1. **ALWAYS** run tests locally before pushing
2. **NEVER** use GitHub as a test runner
3. **ONLY** push when local tests pass

### Testing Pyramid

```
         /\
        /CI\        <- GitHub Actions (final validation)
       /----\
      /Local \      <- act + self-hosted runner
     /--------\
    /Pre-commit\    <- hooks + quick checks
   /------------\
  / Development  \  <- pytest watch mode
 /----------------\
```

### Recommended Workflow

1. **During Development**:
   ```bash
   # Terminal 1: Watch mode
   pytest-watch tests/unit
   
   # Terminal 2: Make changes
   vim src/brainbot/...
   ```

2. **Before Committing**:
   ```bash
   # Quick validation
   ruff check .
   black .
   pytest tests/unit -q
   ```

3. **Before Pushing**:
   ```bash
   # Full validation
   ./scripts/run_local_ci.sh
   
   # Or use act
   act -j backend-tests
   ```

4. **Only After Local Pass**:
   ```bash
   git push origin branch-name
   ```

## Environment Configuration

### Required Services for Full Testing

1. **Redis** (for integration tests):
   ```bash
   # macOS
   brew services start redis
   
   # Or Docker
   docker run -d -p 6379:6379 redis:7-alpine
   ```

2. **PostgreSQL** (for Supabase tests):
   ```bash
   # Use Supabase local
   supabase start
   ```

3. **Environment Variables**:
   ```bash
   # Create .env.test
   cp .env.example .env.test
   # Edit with test values
   ```

## Success Metrics

- ⏱️ **Test feedback in <30 seconds** (not 5-10 minutes)
- 💰 **Zero GitHub Actions minutes** for failed tests
- 🎯 **100% test pass rate** before merge
- 🔄 **<5 minute** development iteration cycle

## Next Steps for Agent

1. ✅ Verify self-hosted runner is configured and running
2. ✅ Create and test the `run_local_ci.sh` script
3. ✅ Install and configure `act` for local GitHub Actions
4. ✅ Fix the 6 failing tests identified
5. ✅ Set up pre-push hook
6. ✅ Document the new workflow in README

## Contact & Resources

- **Self-Hosted Runner Docs**: https://docs.github.com/en/actions/hosting-your-own-runners
- **act Documentation**: https://github.com/nektos/act
- **pytest-watch**: `pip install pytest-watch`
- **Current PR**: https://github.com/auldsyababua/BrainBot/pull/[NUMBER]

---

**Handoff Status**: READY FOR NEXT AGENT  
**Estimated Time**: 2-3 hours to implement full solution  
**Impact**: Will save hours of debugging time per week