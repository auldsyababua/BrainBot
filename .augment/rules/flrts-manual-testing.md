# @testing - Comprehensive Testing Guidelines
**Trigger:** Manual (use @testing to activate)  
**Description:** Testing strategies and requirements for FLRTS

## Testing Strategy

### Test Categories

#### Unit Tests (tests/unit/)
- Test individual functions/methods
- Mock all external dependencies
- Fast execution (<1s per test)
- High code coverage (>80%)

#### Integration Tests (tests/integration/)
- Test component interactions
- Use test databases
- Verify API contracts
- Test Smart Rails pipeline

#### System Tests (tests/system/)
- End-to-end workflows
- Real external services (test accounts)
- Performance benchmarks
- Load testing

## Smart Rails Testing

```python
# Test confidence scoring
def test_confidence_scoring():
    # Test command (100% confidence)
    assert calculate_confidence("/newtask") == 100
    
    # Test mention extraction (high confidence)
    assert calculate_confidence("task for @john") >= 80
    
    # Test natural language (variable confidence)
    confidence = calculate_confidence("maybe create something")
    assert 0 <= confidence < 80

# Test token savings
def test_token_savings():
    result = process_with_smart_rails("/newtask for @john")
    assert result['tokens_used'] == 0
    assert result['tokens_saved'] >= 200
```

## Testing Checklist

### Before Writing Tests
- [ ] Understand the requirement
- [ ] Identify test boundaries
- [ ] Plan test data
- [ ] Consider edge cases
- [ ] Review existing tests

### Test Structure
```python
import pytest
from unittest.mock import Mock, patch

class TestSmartRails:
    @pytest.fixture
    def mock_llm(self):
        """Mock LLM for testing."""
        return Mock()
    
    def test_command_processing(self, mock_llm):
        """Test that commands bypass LLM."""
        # Arrange
        message = "/newtask Check generator"
        
        # Act
        result = process_message(message)
        
        # Assert
        assert mock_llm.called is False
        assert result['confidence'] == 100
        assert result['tokens_used'] == 0
```

## Mock Strategies

### External Services
```python
@patch('src.storage.vector_store.search')
def test_with_mock_vector(mock_search):
    mock_search.return_value = [
        {'text': 'relevant doc', 'score': 0.95}
    ]
    # Test code here
```

### Database Operations
```python
@pytest.fixture
def test_db():
    """Provide test database connection."""
    db = create_test_database()
    yield db
    db.cleanup()
```

## Performance Testing

```python
import time

def test_response_time():
    start = time.time()
    result = process_message("/newtask")
    duration = time.time() - start
    
    assert duration < 0.05  # 50ms for commands

def test_token_optimization():
    messages = [
        "/newtask",  # Should use 0 tokens
        "Create task for @john",  # Should use <100 tokens
        "I need help with something"  # May use full tokens
    ]
    
    for msg in messages:
        result = process_message(msg)
        if msg.startswith('/'):
            assert result['tokens_used'] == 0
```

## Test Data Management

### Fixtures
```python
@pytest.fixture
def sample_task():
    return {
        'title': 'Check generator',
        'assignee': '@john',
        'due_date': '2024-01-20',
        'site': 'Eagle Lake'
    }

@pytest.fixture
def authorized_user():
    return {
        'id': 12345,
        'username': 'test_user',
        'is_authorized': True
    }
```

## Coverage Requirements

```bash
# Run with coverage
pytest --cov=src --cov-report=html tests/

# Check coverage
coverage report --fail-under=80
```

## Test Commands

```bash
# Run all tests
pytest tests/

# Run specific test file
pytest tests/unit/test_processors.py

# Run specific test
pytest tests/unit/test_processors.py::test_task_processor

# Run with verbose output
pytest -v tests/

# Run only marked tests
pytest -m "not slow" tests/

# Run with debugging
pytest --pdb tests/
```

## Frontend Testing (Vitest)

```typescript
import { render, screen, fireEvent } from '@testing-library/react';
import { TaskCreator } from '../TaskCreator';

describe('TaskCreator', () => {
  it('should create task with Smart Rails', async () => {
    // Arrange
    render(<TaskCreator />);
    
    // Act
    const input = screen.getByRole('textbox');
    fireEvent.change(input, { 
      target: { value: '/newtask for @john' } 
    });
    fireEvent.submit(input.closest('form'));
    
    // Assert
    await screen.findByText('Task created');
    expect(screen.getByTestId('tokens-saved')).toHaveTextContent('200');
  });
});
```

## Load Testing

```python
# tests/performance/locustfile.py
from locust import HttpUser, task, between

class BotUser(HttpUser):
    wait_time = between(1, 3)
    
    @task
    def process_command(self):
        self.client.post("/api/process", json={
            "message": "/newtask Test task",
            "user_id": 12345
        })
    
    @task(3)  # 3x more frequent
    def process_natural(self):
        self.client.post("/api/process", json={
            "message": "Create a new task",
            "user_id": 12345
        })
```

## Test Quality Checklist
- [ ] Tests are independent
- [ ] Tests are deterministic
- [ ] Tests have clear names
- [ ] Tests check one thing
- [ ] Mocks are properly cleaned up
- [ ] Edge cases covered
- [ ] Error paths tested
- [ ] Performance validated