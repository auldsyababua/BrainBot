# Test Mocking Guidelines for Smart Rails

## When to Use Mocks vs Real Data/API Calls

### 1. Unit Tests - ALWAYS Use Mocks

**Location**: `/tests/unit/`

**Purpose**: Test individual components in isolation

**Mock Requirements**:
- Mock ALL external dependencies (database, APIs, file system)
- Mock other internal modules when testing a specific class
- Use realistic mock data that matches production schemas

**Example**:
```python
# GOOD - Unit test with proper mocking
async def test_router_with_mock_supabase():
    mock_supabase = AsyncMock()
    mock_response = MagicMock()
    mock_response.data = [
        {"id": 1, "first_name": "Joel", "aliases": ["@joel"]}
    ]
    mock_supabase.table().select().execute.return_value = mock_response
    
    router = KeywordRouter(mock_supabase)
    # Test routing logic without real DB calls

# BAD - Unit test with real database
async def test_router_with_real_db():
    supabase = create_client(url, key)  # NO! This is not a unit test
    router = KeywordRouter(supabase)
```

### 2. Integration Tests - Mix of Mocks and Real Components

**Location**: `/tests/integration/`

**Purpose**: Test how components work together

**Guidelines**:
- Use real internal components (router + processors)
- Mock external services (Supabase, APIs)
- Use test databases/sandboxes when available

**Example**:
```python
# GOOD - Integration test with external mocks
async def test_rails_pipeline_integration():
    # Real router and processor instances
    router = KeywordRouter()
    processor = ListProcessor(mock_supabase)  # Mock external DB
    
    # Test the full pipeline
    route_result = router.route("add milk to list")
    process_result = await processor.process(route_result)
```

### 3. End-to-End (E2E) Tests - Use Real Services

**Location**: `/tests/e2e/`

**Purpose**: Test complete user workflows

**Guidelines**:
- Use real database (test instance)
- Use real API endpoints
- Clean up test data after each test
- Skip if credentials not available

**Example**:
```python
# GOOD - E2E test with real services
@pytest.mark.e2e
@pytest.mark.skipif(not os.getenv('SUPABASE_TEST_URL'), reason="No test DB configured")
async def test_complete_list_workflow():
    # Use test database
    supabase = create_client(
        os.getenv('SUPABASE_TEST_URL'),
        os.getenv('SUPABASE_TEST_KEY')
    )
    
    # Real workflow
    router = KeywordRouter(supabase)
    result = router.route("create shopping list")
    # ... complete workflow with real DB
    
    # Cleanup
    await supabase.table('lists').delete().eq('id', created_id).execute()
```

### 4. Performance Tests - Use Mocks for Consistency

**Location**: `/tests/performance/`

**Purpose**: Measure speed and resource usage

**Guidelines**:
- Mock external services to eliminate network variability
- Use consistent mock response times
- Test with realistic data volumes

### 5. Test Data Detection Patterns

**Problem**: Tests using hardcoded mock data that doesn't reflect reality

**Solution**: Create test to validate mock data matches real schemas

```python
# tests/test_mock_validation.py
import json
from typing import Dict, List

class MockDataValidator:
    """Validates that mock data matches production schemas."""
    
    def __init__(self, schema_file: str):
        with open(schema_file) as f:
            self.schema = json.load(f)
    
    def validate_mock_data(self, mock_data: Dict, entity_type: str) -> List[str]:
        """Returns list of validation errors."""
        errors = []
        
        # Check required fields
        required_fields = self.schema[entity_type]['required']
        for field in required_fields:
            if field not in mock_data:
                errors.append(f"Missing required field: {field}")
        
        # Check field types
        for field, value in mock_data.items():
            expected_type = self.schema[entity_type]['properties'].get(field, {}).get('type')
            if expected_type and not self._check_type(value, expected_type):
                errors.append(f"Field {field} has wrong type. Expected {expected_type}")
        
        return errors

# Test that validates all mocks in the codebase
def test_all_mocks_match_schema():
    validator = MockDataValidator('schema/supabase_schema.json')
    
    # Find all mock data in tests
    mock_locations = [
        ('tests/unit/test_router.py', 'personnel', [
            {"id": 1, "first_name": "Joel", "aliases": ["@joel"]}
        ]),
        # ... scan all test files
    ]
    
    for file, entity_type, mock_data_list in mock_locations:
        for mock_data in mock_data_list:
            errors = validator.validate_mock_data(mock_data, entity_type)
            assert not errors, f"Invalid mock in {file}: {errors}"
```

### 6. Mock Detection Anti-Patterns

**BAD Patterns to Detect**:

```python
# 1. Mock returning mock - circular mocking
mock_supabase.table.return_value = mock_supabase  # NO!

# 2. Mock with unrealistic data
mock_response.data = [{"id": "not_a_number"}]  # ID should be int

# 3. Mock ignoring error cases
mock_supabase.table().select().execute.return_value = mock_response  # Always succeeds?

# 4. Over-mocking internal components
@patch('src.rails.router.KeywordRouter')  # Don't mock what you're testing!
def test_router(mock_router):
    pass
```

### 7. Test Organization by Mock Usage

```
tests/
├── unit/                   # 100% mocked external deps
│   ├── test_router.py      # Mock Supabase
│   ├── test_processors.py  # Mock Supabase
│   └── test_confidence.py  # No external deps
├── integration/            # Mock external, real internal
│   ├── test_rails_integration.py
│   └── test_pipeline.py
├── e2e/                    # No mocks (test environment)
│   ├── test_user_workflows.py
│   └── test_system_behavior.py
├── performance/            # Controlled mocks
│   └── test_routing_speed.py
└── fixtures/               # Shared test data
    ├── mock_data.py        # Centralized mock data
    └── schemas.json        # Real schema definitions
```

### 8. Mock Usage Validation Tests

```python
# tests/test_mock_usage.py
import ast
import os
from pathlib import Path

class MockUsageValidator:
    """Detects incorrect mock usage in tests."""
    
    def check_file(self, filepath: Path) -> List[str]:
        """Check a test file for mock usage issues."""
        issues = []
        
        with open(filepath) as f:
            tree = ast.parse(f.read())
        
        test_type = self._determine_test_type(filepath)
        
        for node in ast.walk(tree):
            if isinstance(node, ast.FunctionDef) and node.name.startswith('test_'):
                has_mock = self._uses_mock(node)
                has_real_db = self._uses_real_database(node)
                
                # Validation rules
                if test_type == 'unit' and has_real_db:
                    issues.append(f"{node.name}: Unit test uses real database")
                
                if test_type == 'unit' and not has_mock:
                    issues.append(f"{node.name}: Unit test doesn't mock external deps")
                
                if test_type == 'e2e' and has_mock:
                    issues.append(f"{node.name}: E2E test uses mocks")
        
        return issues

def test_mock_usage_across_codebase():
    """Validate all tests use mocks appropriately."""
    validator = MockUsageValidator()
    
    for test_file in Path('tests').rglob('test_*.py'):
        issues = validator.check_file(test_file)
        assert not issues, f"Mock usage issues in {test_file}: {issues}"
```

## Summary Rules

1. **Unit Tests**: Always mock external dependencies
2. **Integration Tests**: Mock external services, use real internal components
3. **E2E Tests**: Use real services in test environment
4. **Performance Tests**: Mock for consistency
5. **Never mock what you're testing**
6. **Always validate mock data matches real schemas**
7. **Centralize mock data for consistency**
8. **Use dependency injection to make mocking easier**

## Red Flags in Tests

- Unit test with `create_client()` or real DB connections
- E2E test with `Mock()` or `AsyncMock()`
- Mock data that doesn't match production schema
- Tests that pass with any mock data (not validating behavior)
- Circular mocking (mock returns itself)
- Over-mocking (mocking the component being tested)
