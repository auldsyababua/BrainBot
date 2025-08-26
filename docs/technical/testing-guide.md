# FLRTS-BMAD Testing Guide

## Overview

This guide covers all testing procedures for the FLRTS-BMAD project, including unit tests, integration tests, performance tests, and live bot testing.

## Test Structure

```
tests/
├── unit/              # Unit tests for individual components
├── integration/       # Integration tests for API and services
├── performance/       # Performance and load testing
├── manual/           # Manual testing scripts
├── fixtures/         # Test data and mocks
└── conftest.py       # Pytest configuration

testsprite_tests/     # TestSprite framework tests
├── anti_mesa_tests.py # Anti-MESA test suite
└── ui_test.js        # UI automation tests
```

## Running Tests

### Quick Start
```bash
# Run all Python tests
pytest

# Run with coverage
pytest --cov=src --cov-report=html

# Run specific test category
pytest tests/unit/
pytest tests/integration/
pytest tests/performance/

# Run TestSprite tests
cd testsprite_tests && ./run_tests.sh
```

### Test Categories

#### Unit Tests
Fast, isolated tests for individual functions and classes:
```bash
pytest tests/unit/ -v
```

Key test files:
- `test_router.py` - Smart Rails router logic
- `test_processors.py` - Task/List/Report processors
- `test_auth.py` - Authentication and authorization
- `test_chunking_edge_cases.py` - Document chunking

#### Integration Tests
Tests that verify component interactions:
```bash
pytest tests/integration/ -v
```

Key test files:
- `test_webhook_endpoints.py` - API endpoint testing
- `test_storage_integrations.py` - Database operations
- `test_smart_rails_integration_proper.py` - Full routing pipeline
- `test_document_storage.py` - Document management

#### Performance Tests
Load and performance testing:
```bash
# Run locust for load testing
locust -f tests/performance/locustfile.py

# Run performance benchmarks
pytest tests/performance/test_performance.py
```

### Frontend Tests

For Telegram Mini App:
```bash
cd telegram-mini-app

# Run unit tests
npm test

# Run with coverage
npm run test:coverage

# Run in watch mode
npm run test:watch
```

## Test Configuration

### Environment Setup
```bash
# Copy test environment
cp .env.test .env

# Key test variables
TEST_MODE=true
MOCK_LLM=true
MOCK_EXTERNAL_APIS=true
```

### Pytest Configuration
```python
# conftest.py provides:
- Database fixtures
- Mock services
- Test data generators
- Cleanup utilities
```

## Writing Tests

### Unit Test Example
```python
def test_router_high_confidence():
    """Test that router returns 100% confidence for clear commands"""
    router = KeywordRouter()
    result = router.route("/newtask Buy groceries")
    
    assert result.confidence == 100
    assert result.entity_type == "task"
    assert result.operation == "create"
```

### Integration Test Example
```python
@pytest.mark.asyncio
async def test_webhook_processing():
    """Test full webhook message processing pipeline"""
    async with AsyncClient(app=app, base_url="http://test") as client:
        response = await client.post(
            "/webhook/telegram",
            json={"message": {"text": "/newtask Test task"}}
        )
        assert response.status_code == 200
```

## Test Data

### Fixtures
Located in `tests/fixtures/`:
- `database.py` - Database test data
- `pdf_content.json` - Sample document data

### Test Sites
- Eagle Lake (test site)
- Crockett (test site)
- Mathis (test site)

## Mocking Guidelines

### External Services
```python
# Mock OpenAI
@patch('openai.ChatCompletion.create')
def test_with_mock_llm(mock_create):
    mock_create.return_value = {"choices": [...]}
    
# Mock Supabase
@patch('supabase.Client')
def test_with_mock_db(mock_client):
    mock_client.table().insert().execute.return_value = ...
```

### Best Practices
1. Mock external APIs in unit tests
2. Use real services in integration tests (with test data)
3. Clean up test data after each test
4. Use fixtures for common test setups

## CI/CD Testing

### Self-Hosted Runner on Mac Mini M4
We use a **self-hosted GitHub Actions runner** for instant test execution:
- **Location**: Mac Mini M4 (local machine)
- **Benefits**: Zero queue time, tests start immediately
- **Performance**: Much faster than GitHub's free runners

#### Managing the Runner
```bash
# Check if runner is running
ps aux | grep Runner.Listener

# Start runner (if stopped)
cd ~/actions-runner && ./run.sh

# View runner logs
cd ~/actions-runner && tail -f runner.log

# Stop runner
cd ~/actions-runner && ./svc.sh stop
```

### GitHub Actions Workflows
Tests run automatically on:
- Pull requests to `develop` or `main`
- Push to `develop` or `main`
- Uses self-hosted runner (no more 15+ minute queues!)

### Required Checks
- Black formatting must pass
- Unit tests must pass (integration tests currently categorized)
- Ruff linting (temporarily relaxed rules in `.ruff.toml`)
- Security scanning via Semgrep

## Live Bot Testing

### Test Bot Setup
1. Create test bot with @BotFather
2. Configure test webhook
3. Use test database

### Test Scenarios
Located in `docs/operations/testing-procedures.md`:
- User authentication
- Command processing
- Smart Rails routing
- Error handling
- Performance under load

## Debugging Tests

### Verbose Output
```bash
# Show detailed test output
pytest -vvs

# Show only failed tests
pytest --lf

# Debug specific test
pytest -k test_name --pdb
```

### Common Issues
1. **Database conflicts**: Ensure test database is clean
2. **API rate limits**: Use mocks or add delays
3. **Async issues**: Use proper async fixtures
4. **Import errors**: Check PYTHONPATH

## Performance Benchmarks

Target metrics:
- Response time < 2s (95th percentile)
- Token usage < 100 for high-confidence
- Cache hit rate > 80%
- Concurrent users: 20+

## Test Maintenance

### Regular Tasks
- Update test data monthly
- Review and update mocks
- Prune obsolete tests
- Update coverage targets

### Test Review Checklist
- [ ] Tests are deterministic
- [ ] Tests are independent
- [ ] Tests clean up after themselves
- [ ] Tests use appropriate mocks
- [ ] Tests have clear assertions
- [ ] Tests follow naming conventions