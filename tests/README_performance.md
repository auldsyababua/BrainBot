# Performance Testing Guide

This guide explains how to test the performance optimizations implemented in Issue #6.

## Running the Tests

To run the performance tests:

```bash
cd /path/to/markdown-brain-bot
python tests/test_performance.py
```

## What the Tests Check

### 1. Vector Search Caching
- Performs the same search twice
- Verifies the second search is significantly faster (cache hit)
- Ensures cached results are identical to original

### 2. LLM Retry Logic
- Tests the resilient OpenAI client
- Verifies retry functionality works correctly
- Handles API failures gracefully

### 3. Conversation Sliding Window
- Creates a conversation with more messages than the window size
- Verifies messages are trimmed to maintain the window limit
- Ensures system prompt is always preserved

### 4. Performance Metrics
- Runs a full message processing flow
- Collects and displays performance metrics
- Shows cache hit rates and token usage

## Expected Output

A successful test run should show:
- ✅ Cache working with faster second search
- ✅ LLM calls successful
- ✅ Sliding window maintaining message limits
- ✅ Performance metrics being collected

## Monitoring Performance

After running tests, you can check the metrics endpoint:
- Health check: `GET /`
- Performance metrics: `GET /metrics`

The metrics endpoint provides:
- Cache hit rates
- Response time percentiles (p50, p95, p99)
- Token usage statistics
- Request duration by endpoint