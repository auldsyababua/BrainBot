# Testing Guide for Markdown Brain Bot

## 🧪 Overview

This guide covers all testing procedures for the Markdown Brain Bot, with special emphasis on performance testing and monitoring.

## 📋 Table of Contents

- [Quick Start](#quick-start)
- [Performance Testing](#performance-testing)
- [Integration Testing](#integration-testing)
- [Unit Testing](#unit-testing)
- [Local Development Testing](#local-development-testing)
- [Monitoring & Metrics](#monitoring--metrics)
- [Troubleshooting](#troubleshooting)

## 🚀 Quick Start

### Run All Tests
```bash
# Run the complete test suite
python tests/test_all_storage.py

# Run performance tests
python tests/test_performance.py

# Run specific test categories
python tests/integration/test_storage_integrations.py
python tests/unit/test_search_resilience.py
```

### Prerequisites
- Python 3.11+
- All environment variables configured (see `.env.example`)
- Redis instance running (Upstash Redis)
- Vector database configured (Upstash Vector)

## 📊 Performance Testing

### Running Performance Tests

```bash
# Full performance test suite
python tests/test_performance.py
```

This tests:
- ✅ Vector search caching (cache hits vs misses)
- ✅ LLM retry logic with exponential backoff
- ✅ Conversation sliding window management
- ✅ Performance metrics collection

### What to Look For

#### Cache Performance
```
🔍 Testing Vector Search Cache...
Query: How to implement OAuth2 authentication?
First search: 3 results in 0.523s (cache miss)
Second search: 3 results in 0.012s (cache hit)
✅ Cache is working! Second search was significantly faster.
```

**Expected**: Cache hits should be 10-50x faster than cache misses.

#### Sliding Window
```
🪟 Testing Conversation Sliding Window...
Final message count: 21
Expected max: 21 (including system prompt)
✅ Sliding window is working correctly
```

**Expected**: Conversation never exceeds max_messages + 1 (for system prompt).

#### Performance Metrics
```
📊 Testing Performance Metrics...
vector_search_duration:
  count: 5
  average: 0.234
  min: 0.012
  max: 0.523
  p50: 0.187
  p95: 0.498
```

**Expected**: Consistent metrics collection with reasonable percentiles.

### Performance Benchmarks

| Metric | Target | Acceptable | Critical |
|--------|--------|------------|----------|
| Vector Search (cached) | < 50ms | < 100ms | > 200ms |
| Vector Search (uncached) | < 500ms | < 1s | > 2s |
| LLM Response Time | < 2s | < 3s | > 5s |
| Message Processing | < 3s | < 5s | > 10s |
| Cache Hit Rate | > 80% | > 60% | < 40% |

## 🔄 Integration Testing

### Storage Integration Tests
```bash
python tests/integration/test_storage_integrations.py
```

Tests:
- Document storage in Supabase
- Vector indexing in Upstash Vector
- Redis conversation management
- S3 media storage (if configured)

### Key Integration Points

1. **Vector + Redis Cache**
   - Ensures cache invalidation works
   - Verifies TTL expiration
   - Tests concurrent access

2. **LLM + Retry Logic**
   - Simulates rate limits
   - Tests exponential backoff
   - Verifies token tracking

3. **Conversation + Redis**
   - Tests sliding window
   - Verifies TTL on conversations
   - Checks memory bounds

## 🧩 Unit Testing

### Context Awareness
```bash
python tests/unit/test_context_awareness.py
```

Tests knowledge retrieval and context building.

### Search Resilience
```bash
python tests/unit/test_search_resilience.py
```

Tests fallback mechanisms when services fail.

## 💻 Local Development Testing

### Using the Local Development Simulator

```bash
# Start the local development bot
python scripts/local_dev.py
```

This provides:
- Full bot functionality without webhooks
- Local performance monitoring
- Easy debugging with verbose logs

### Testing Workflow

1. **Start the bot**
   ```bash
   python scripts/local_dev.py
   ```

2. **Send test messages**
   - `/start` - Initialize conversation
   - `/help` - View commands
   - "Search for X" - Test vector search
   - "Create a note about Y" - Test file operations

3. **Monitor performance**
   - Watch console for timing logs
   - Check Redis for metrics
   - View cache hit rates

## 📈 Monitoring & Metrics

### Real-time Metrics Endpoint

When running the webhook server:

```bash
# Check metrics
curl http://localhost:8000/metrics
```

Returns:
```json
{
  "status": "ok",
  "metrics": {
    "vector_search_duration": {
      "count": 150,
      "average": 0.234,
      "min": 0.012,
      "max": 1.523,
      "p50": 0.187,
      "p95": 0.698,
      "p99": 1.234
    },
    "cache_hit_rate": 0.853,
    "total_tokens_used": 45678
  }
}
```

### Metrics to Monitor

1. **Performance Metrics**
   - `vector_search_duration` - Search latency
   - `llm_call_duration` - API response time
   - `http_request_duration` - Overall request time
   - `benchmark_process_message` - Full message processing

2. **Usage Metrics**
   - `cache_hit_rate` - Cache effectiveness
   - `total_tokens_used` - Cost tracking
   - `conversation_size` - Memory usage

3. **Error Metrics**
   - Retry counts per operation
   - Failed operations
   - Timeout occurrences

### Setting Up Alerts

```python
# Example alert thresholds
ALERTS = {
    "vector_search_p95": {"threshold": 1.0, "unit": "seconds"},
    "cache_hit_rate": {"threshold": 0.6, "operator": "less_than"},
    "llm_retry_rate": {"threshold": 0.1, "operator": "greater_than"},
    "memory_per_conversation": {"threshold": 50, "unit": "MB"}
}
```

## 🔍 Troubleshooting

### Common Issues

#### 1. Cache Not Working
```bash
# Check Redis connection
python -c "from src.storage.redis_store import redis_store; print(redis_store.redis.ping())"

# Verify cache is enabled
echo $VECTOR_CACHE_ENABLED  # Should be "true"
```

#### 2. Slow Performance
```bash
# Check specific metrics
curl http://localhost:8000/metrics | jq '.metrics.vector_search_duration'

# Review cache hit rate
curl http://localhost:8000/metrics | jq '.metrics.cache_hit_rate'
```

#### 3. Memory Issues
```bash
# Check conversation sizes
python -c "
import asyncio
from src.core.llm import conversation_manager
async def check():
    stats = await conversation_manager.get_conversation_stats('default')
    print(stats)
asyncio.run(check())
"
```

### Debug Mode

Enable detailed logging:
```python
# In your test or script
import logging
logging.basicConfig(level=logging.DEBUG)
```

### Performance Profiling

```python
# Profile specific operations
import cProfile
import pstats

cProfile.run('asyncio.run(test_vector_cache())', 'profile_stats')
stats = pstats.Stats('profile_stats')
stats.sort_stats('cumulative').print_stats(10)
```

## 📝 Writing New Tests

### Performance Test Template

```python
async def test_new_feature_performance():
    """Test performance of new feature."""
    print("\n🧪 Testing New Feature Performance...")
    
    # Setup
    monitor = get_performance_monitor()
    
    # Execute operation
    start = time.perf_counter()
    result = await your_operation()
    duration = time.perf_counter() - start
    
    # Track metrics
    monitor.track_metric("new_feature_duration", duration)
    
    # Assertions
    assert duration < 1.0, f"Operation too slow: {duration}s"
    print(f"✅ New feature completed in {duration:.3f}s")
```

### Integration Test Template

```python
async def test_service_integration():
    """Test integration between services."""
    # Test setup
    test_data = {"test": "data"}
    
    # Service A operation
    result_a = await service_a.operation(test_data)
    assert result_a.success
    
    # Service B should reflect changes
    result_b = await service_b.get_data(result_a.id)
    assert result_b.data == test_data
    
    # Cleanup
    await service_a.cleanup(result_a.id)
```

## 🚀 Continuous Integration

### GitHub Actions Example

```yaml
# .github/workflows/test.yml
name: Run Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Set up Python
        uses: actions/setup-python@v2
        with:
          python-version: '3.11'
      - name: Install dependencies
        run: |
          pip install -r requirements.txt
      - name: Run tests
        env:
          UPSTASH_REDIS_REST_URL: ${{ secrets.UPSTASH_REDIS_REST_URL }}
          UPSTASH_REDIS_REST_TOKEN: ${{ secrets.UPSTASH_REDIS_REST_TOKEN }}
          # ... other env vars
        run: |
          python tests/test_performance.py
          python tests/test_all_storage.py
```

## 📚 Additional Resources

- [Performance Monitoring Guide](../docs/MONITORING_GUIDE.md)
- [Architecture Documentation](../docs/ARCHITECTURE.md)
- [API Documentation](../docs/API.md)
- [Deployment Guide](../docs/DEPLOYMENT.md)

---

**Last Updated**: January 2025  
**Version**: 1.0.0