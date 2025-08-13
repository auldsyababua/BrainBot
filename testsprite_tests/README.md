# FLRTS Testsprite Test Suite

## Overview
This directory contains comprehensive test plans and implementations for the FLRTS project, with special focus on anti-mesa pattern detection and prevention.

## Test Plans

### Backend Test Plan
- **File**: `backend_test_plan.md`
- **Coverage**: Core LLM processing, Smart Rails router, processors, webhooks, storage systems
- **Anti-Mesa Focus**: Prompt injection, routing manipulation, authorization bypass, resource exhaustion

### Frontend Test Plan
- **File**: `frontend_test_plan.md`
- **Coverage**: AppContainer, SmartRails commands, chat sync, offline/online transitions, UI components
- **Anti-Mesa Focus**: Command injection, state manipulation, data validation, authentication security

## Test Implementation

### Anti-Mesa Pattern Tests
- **File**: `anti_mesa_tests.py`
- **Purpose**: Comprehensive test suite for detecting and preventing unintended system behaviors
- **Categories**:
  - Prompt injection defense
  - Router manipulation prevention
  - Authorization bypass protection
  - Resource exhaustion mitigation
  - Frontend security validation

## Configuration

### Testsprite Configuration
- **File**: `testsprite_config.json`
- **Details**: Project structure, test frameworks, coverage targets, CI/CD settings

## Execution

### Local Testing

#### Run All Tests
```bash
chmod +x run_tests.sh
./run_tests.sh
```

#### Run Specific Test Suites
```bash
# Backend tests only
./run_tests.sh backend

# Frontend tests only
./run_tests.sh frontend

# Performance tests only
./run_tests.sh performance

# Generate report only
./run_tests.sh report
```

### CI/CD Pipeline

The GitHub Actions workflow (`.github/workflows/comprehensive_tests.yml`) automatically runs:
- On push to main/develop branches
- On pull requests to main
- Nightly at 2 AM UTC

#### Pipeline Stages
1. **Backend Tests**: Unit, integration, anti-mesa patterns
2. **Frontend Tests**: Linting, type checking, unit tests, build verification
3. **Performance Tests**: Benchmarks and load testing
4. **Security Scan**: Trivy and OWASP dependency check
5. **Anti-Mesa Validation**: Specific pattern compliance

## Critical Anti-Mesa Patterns

### Priority Testing Areas

1. **Prompt Injection Defense**
   - System prompt preservation
   - Function parameter validation
   - Conversation history integrity

2. **Command Routing Security**
   - Ambiguous command handling
   - Confidence threshold enforcement
   - Direct execution safeguards

3. **Authorization Bypass Prevention**
   - Cross-user data isolation
   - Privilege escalation blocking
   - Session validation

4. **Resource Exhaustion Protection**
   - Rate limiting effectiveness
   - Memory management
   - Batch operation limits

5. **State Manipulation Prevention**
   - Frontend state immutability
   - Backend data validation
   - Input sanitization

## Test Results

Results are saved to `testsprite_tests/results/` including:
- Coverage reports (HTML)
- Security scan results (JSON)
- Performance benchmarks (JSON)
- Bundle analysis (HTML)
- Test summary (Markdown)

## Coverage Targets

### Backend
- Overall: >80%
- Critical paths: >95%
- New code: >90%

### Frontend
- Overall: >85%
- Components: >90%
- Critical paths: >95%

## Tools Required

### Backend Testing
- Python 3.11+
- pytest, pytest-cov, pytest-asyncio
- bandit (security)
- mypy (type checking)
- locust (load testing)

### Frontend Testing
- Node.js 18+
- Vitest
- React Testing Library
- ESLint
- TypeScript

## Quick Start

1. **Install Backend Dependencies**:
```bash
cd /Users/colinaulds/Desktop/projects/flrts
pip install -r requirements.txt
pip install pytest pytest-cov pytest-asyncio pytest-benchmark bandit mypy
```

2. **Install Frontend Dependencies**:
```bash
cd telegram-mini-app
npm install
```

3. **Run Anti-Mesa Tests**:
```bash
python testsprite_tests/anti_mesa_tests.py
```

4. **Run Full Test Suite**:
```bash
./testsprite_tests/run_tests.sh
```

## Monitoring and Maintenance

### Weekly Tasks
- Review failed tests
- Update test fixtures
- Check coverage trends

### Monthly Tasks
- Coverage analysis
- Performance trend review
- Security audit

### Quarterly Tasks
- Test strategy review
- Tool evaluation
- Framework updates

## Support

For questions or issues with the test suite:
1. Check test output logs in `results/`
2. Review specific test plan documentation
3. Consult anti-mesa pattern test implementation

## Next Steps

1. **Immediate Actions**:
   - Run initial test suite to establish baseline
   - Fix any failing anti-mesa pattern tests
   - Set up CI/CD pipeline

2. **Short-term Goals**:
   - Achieve 80% backend coverage
   - Achieve 85% frontend coverage
   - Implement all critical anti-mesa tests

3. **Long-term Goals**:
   - Maintain >90% coverage
   - Zero critical security vulnerabilities
   - <5% test flakiness rate

---

**Note**: The anti-mesa pattern testing is critical for ensuring the FLRTS system behaves as intended and prevents exploitation or misalignment. These tests should be run before every deployment.