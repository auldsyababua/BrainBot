# Testing Strategy

This document outlines the comprehensive testing strategy for the BrainBot FLRTS project, covering test organization, frameworks, standards, and best practices.

## Test Organization

### Directory Structure
```
tests/
├── unit/                 # Unit tests for individual components
│   ├── test_*.py        # Test files matching module names
│   └── conftest.py      # Shared pytest fixtures
├── integration/         # Integration tests for service interactions
│   ├── test_*_integration.py
│   └── conftest.py      
├── fixtures/            # Test data and mock objects
│   ├── mock_data/       # JSON/YAML test data files
│   └── sample_files/    # Sample documents for testing
├── archive/             # Archived test reports and old tests
│   ├── coverage/        # Historical coverage reports
│   └── reports/         # Historical test reports
└── README.md           # Test suite documentation
```

### File Naming Conventions

**Backend (Python):**
- Unit tests: `test_{module_name}.py` (matches source file name)
- Integration tests: `test_{feature}_integration.py`
- Test classes: `Test{ClassName}` (PascalCase)
- Test methods: `test_{method_name}_{scenario}` (snake_case)

**Frontend (TypeScript):**
- Component tests: `{ComponentName}.test.tsx`
- Service tests: `{serviceName}.test.ts`
- Utility tests: `{utilName}.test.ts`

## Testing Frameworks & Tools

### Backend Testing Stack
- **Framework:** Pytest 7.x
- **Mocking:** `unittest.mock` and `pytest-mock`
- **Coverage:** `pytest-cov` with 80% minimum coverage requirement
- **Fixtures:** Pytest fixtures for reusable test data
- **Async Testing:** `pytest-asyncio` for async function testing

### Frontend Testing Stack
- **Framework:** Vitest
- **Component Testing:** React Testing Library
- **Coverage:** Built-in Vitest coverage with 85% minimum requirement
- **Mocking:** Vitest mocking capabilities

## Test Categories

### Unit Tests
**Purpose:** Test individual functions, methods, and classes in isolation

**Standards:**
- Each source file should have a corresponding test file
- Mock all external dependencies
- Test both success and failure paths
- Include edge cases and boundary conditions
- Tests should be fast (<100ms per test)

**Example Structure:**
```python
# tests/unit/test_router.py
class TestKeywordRouter:
    def test_route_with_valid_keyword(self, mock_dependencies):
        # Arrange
        router = KeywordRouter()
        # Act
        result = router.route("test_keyword")
        # Assert
        assert result == expected_value
    
    def test_route_with_invalid_keyword(self):
        # Test error handling
        pass
```

### Integration Tests
**Purpose:** Test interactions between multiple components

**Standards:**
- Test service boundaries and API contracts
- Use real dependencies where possible, mock external services
- Can use test databases/caches
- Longer execution time acceptable (1-5 seconds)

**Focus Areas:**
- Database operations with Supabase
- Redis/KV cache interactions
- Telegram API webhook processing
- LLM service integration
- Vector search functionality

### End-to-End Tests (Future)
**Purpose:** Test complete user workflows

**Note:** Currently not implemented but planned for future phases

## Testing Standards

### Test Structure
All tests should follow the AAA pattern:
1. **Arrange:** Set up test data and conditions
2. **Act:** Execute the function/method being tested
3. **Assert:** Verify the results

### Assertion Guidelines
- Use specific assertions (`assert x == 5` not `assert x`)
- One logical assertion per test (multiple assert statements OK if testing one concept)
- Use descriptive assertion messages for debugging

### Mock and Fixture Best Practices
- Create fixtures in `conftest.py` for shared test data
- Use `@pytest.fixture` for reusable test components
- Mock at the boundary (external services, not internal methods)
- Name mocks clearly: `mock_telegram_api`, `mock_openai_client`

### Test Data Management
- Store large test data in `tests/fixtures/`
- Use factories for generating test objects
- Never use production data in tests
- Clean up test data after test completion

## Coverage Requirements

### Minimum Coverage Thresholds
- **Overall:** 80% line coverage
- **Core modules:** 90% coverage (`src/core/`, `src/rails/`)
- **New code:** 85% coverage for all new features
- **Frontend components:** 85% coverage

### Coverage Exclusions
- Migration scripts
- Development utilities
- Test files themselves
- Type definitions

## CI/CD Integration

### GitHub Actions Workflow
Tests run automatically on:
- Push to main branch
- Pull request creation/updates
- Scheduled nightly runs

### Test Execution Order
1. Linting and formatting checks
2. Unit tests
3. Integration tests
4. Coverage report generation
5. Coverage threshold validation

### Self-Hosted Runner
- Tests execute on Mac Mini M4 runner
- Full test suite should complete in <5 minutes
- Parallel test execution enabled with `pytest-xdist`

## Test Commands

### Backend Testing
```bash
# Run all tests
pytest

# Run with coverage
pytest --cov=src --cov-report=html

# Run specific test category
pytest tests/unit/
pytest tests/integration/

# Run with verbose output
pytest -v

# Run specific test file
pytest tests/unit/test_router.py

# Run tests matching pattern
pytest -k "test_keyword"
```

### Frontend Testing
```bash
# Run all tests
npm test

# Run with coverage
npm run test:coverage

# Run in watch mode
npm run test:watch

# Run specific test file
npm test ChatView.test.tsx
```

## Performance Testing Guidelines

### Response Time Targets
- Unit tests: <100ms per test
- Integration tests: <5s per test
- API endpoints: <500ms response time
- LLM operations: <10s timeout

### Load Testing (Future)
- Target: 100 concurrent users
- Response time: <2s for 95th percentile
- Error rate: <1%

## Test Maintenance

### Regular Maintenance Tasks
- Remove obsolete tests when features are removed
- Update tests when requirements change
- Archive old test reports monthly
- Review and update test data quarterly

### Test Documentation
- Each test file should have a module docstring
- Complex test logic should be commented
- Document test dependencies and prerequisites
- Maintain test README with setup instructions

## Anti-Patterns to Avoid

1. **Test Interdependence:** Tests should not depend on execution order
2. **Testing Implementation:** Test behavior, not implementation details
3. **Overmocking:** Don't mock everything, test real interactions where practical
4. **Ignored Tests:** Don't use `@pytest.mark.skip` long-term, fix or remove
5. **Hardcoded Values:** Use fixtures and constants, not magic numbers
6. **Testing Framework Code:** Don't test third-party libraries

## Quality Gates

### PR Merge Requirements
- All tests must pass
- Coverage thresholds must be met
- No new linting errors
- Performance benchmarks maintained

### Definition of Done
A feature is considered complete when:
- Unit tests written and passing
- Integration tests written and passing
- Coverage requirements met
- Documentation updated
- PR approved by reviewer