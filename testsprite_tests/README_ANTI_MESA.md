# Anti-Mesa Pattern Test Suite for FLRTS Processors

## Overview

This test suite implements comprehensive anti-mesa patterns for the FLRTS processor modules, ensuring robustness against adversarial inputs, maintaining idempotence, and validating system invariants.

## Test Coverage

### 1. TaskProcessor (`test_task_processor_anti_mesa.py`)

**Critical Test Areas:**
- ✅ Supabase client instantiation bug regression
- ✅ SQL injection and XSS prevention
- ✅ Idempotence testing (f(f(x)) = f(x))
- ✅ Property-based testing with Hypothesis
- ✅ Metamorphic testing (input perturbations)
- ✅ Database failure injection (timeouts, 500s)
- ✅ Concurrent task operations
- ✅ Buffer overflow and unicode edge cases
- ✅ State consistency invariants

**Key Invariants Tested:**
- No partial writes on failure
- Valid state transitions only
- Consistent validation results
- Bounded confidence scores (0-1)

### 2. ListProcessor (`test_list_processor_anti_mesa.py`)

**Critical Test Areas:**
- ✅ Site-specific list protection validation
- ✅ Concurrent list modifications
- ✅ Invalid list reference handling
- ✅ Idempotence for all operations
- ✅ Database failure injection
- ✅ Authorization bypass attempts
- ✅ Massive item list handling
- ✅ Role escalation prevention

**Key Invariants Tested:**
- Site lists cannot be deleted
- Operations are atomic (all or nothing)
- Consistent state after concurrent ops
- Admin-only operations enforced

### 3. FieldReportProcessor (`test_field_report_processor_anti_mesa.py`)

**Critical Test Areas:**
- ✅ Site name validation against database
- ✅ Status transition validation
- ✅ Report type enumeration handling
- ✅ Partial update failure scenarios
- ✅ Concurrent report submissions
- ✅ Data consistency after retries
- ✅ Long content handling
- ✅ Invalid status/type rejection

**Key Invariants Tested:**
- Valid sites only
- Valid status transitions only
- Valid report types only
- Atomic followup additions

## Test Patterns Implemented

### Anti-Mesa Patterns

1. **Adversarial Testing**: Every success case has corresponding failure/attack cases
2. **Idempotence**: Operations can be safely retried (f(f(x)) = f(x))
3. **Property-Based**: Random inputs always produce valid outputs
4. **Metamorphic**: Input variations yield semantically equivalent results
5. **Chaos Engineering**: Random failure injection during operations
6. **Stateful Testing**: State machine validates invariants across operations

### Failure Modes Tested

- **Database Failures**: Timeouts, 500 errors, connection drops
- **Partial Writes**: Ensuring no partial state on failure
- **Concurrent Access**: Race conditions, deadlocks
- **Malicious Input**: SQL injection, XSS, buffer overflows
- **Authorization**: Bypass attempts, privilege escalation
- **Resource Exhaustion**: Large inputs, memory limits

## Running the Tests

### Run All Anti-Mesa Tests
```bash
python testsprite_tests/run_anti_mesa_tests.py
```

### Run Specific Test Categories
```bash
# Property-based tests only
python testsprite_tests/run_anti_mesa_tests.py --property

# Concurrent tests only
python testsprite_tests/run_anti_mesa_tests.py --concurrent

# Specific test by name
python testsprite_tests/run_anti_mesa_tests.py --test test_idempotent_task_creation
```

### Run Individual Test Files
```bash
# TaskProcessor tests
pytest testsprite_tests/test_task_processor_anti_mesa.py -v

# ListProcessor tests
pytest testsprite_tests/test_list_processor_anti_mesa.py -v

# FieldReportProcessor tests
pytest testsprite_tests/test_field_report_processor_anti_mesa.py -v
```

### Generate Coverage Report
```bash
pytest testsprite_tests/test_*_anti_mesa.py \
  --cov=src.rails.processors \
  --cov-report=html:htmlcov_anti_mesa \
  --cov-report=term-missing
```

## Test Fixtures

The `fixtures_anti_mesa.py` module provides:

- **MockSupabaseClient**: Advanced mock with failure injection
- **MockRedisStore**: Mock caching with TTL support
- **DataFuzzer**: Generate malformed/edge case inputs
- **ConcurrentTestHarness**: Test concurrent operations
- **chaos_testing**: Context manager for random failures

## Test Statistics

### Coverage Goals
- **Line Coverage**: ≥ 80%
- **Branch Coverage**: ≥ 70%
- **Mutation Score**: ≥ 60%

### Performance Benchmarks
- **Concurrent Operations**: 10+ simultaneous
- **Large Input Handling**: 1M+ characters
- **Retry Resilience**: 3+ attempts
- **Latency Tolerance**: 500ms+ delays

## Common Failure Scenarios

### 1. Database Unavailable
```python
# Tests verify graceful degradation when DB is down
mock_client.execute.side_effect = TimeoutError("Database timeout")
```

### 2. Partial Write Failure
```python
# Tests ensure no partial state on failure
if call_count > 1:
    raise Exception("Write failed after partial success")
```

### 3. Concurrent Modifications
```python
# Tests verify no race conditions
tasks = [processor.validate(data) for _ in range(10)]
results = await asyncio.gather(*tasks)
```

### 4. Malicious Input
```python
# Tests verify injection prevention
data = {"task_title": "'; DROP TABLE tasks; --"}
```

## Integration with CI/CD

### GitHub Actions Example
```yaml
- name: Run Anti-Mesa Tests
  run: |
    pip install -r requirements-test.txt
    python testsprite_tests/run_anti_mesa_tests.py
    
- name: Upload Coverage
  uses: codecov/codecov-action@v3
  with:
    file: ./coverage.xml
    flags: anti-mesa
```

## Best Practices

1. **Always test the negative path**: For every success case, test failure
2. **Use property-based testing**: Let Hypothesis find edge cases
3. **Inject failures deliberately**: Use chaos engineering principles
4. **Test at scale**: Concurrent operations reveal race conditions
5. **Validate invariants**: State should always be consistent
6. **Mock at the right level**: Not too high, not too low

## Troubleshooting

### Common Issues

1. **Import Errors**: Ensure PYTHONPATH includes project root
2. **Async Warnings**: Use `pytest-asyncio` for async tests
3. **Hypothesis Deadlines**: Increase deadline for slow tests
4. **Coverage Gaps**: Check branch coverage, not just line coverage

### Debug Mode
```bash
# Run with verbose output and full traceback
pytest testsprite_tests/test_task_processor_anti_mesa.py -vvv --tb=long

# Run with pdb on failure
pytest testsprite_tests/test_task_processor_anti_mesa.py --pdb
```

## Future Enhancements

- [ ] Mutation testing with `mutmut`
- [ ] Load testing with `locust`
- [ ] Fuzz testing with `atheris`
- [ ] Contract testing between services
- [ ] Performance regression testing
- [ ] Security scanning integration

## Contributing

When adding new tests:
1. Follow the anti-mesa pattern (test negative cases)
2. Add property-based tests for new operations
3. Include concurrent execution tests
4. Document invariants being tested
5. Update this README with new patterns

## References

- [Anti-Mesa Patterns](https://www.hillelwayne.com/post/metamorphic-testing/)
- [Property-Based Testing](https://hypothesis.readthedocs.io/)
- [Chaos Engineering](https://principlesofchaos.org/)
- [Idempotence Patterns](https://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/)