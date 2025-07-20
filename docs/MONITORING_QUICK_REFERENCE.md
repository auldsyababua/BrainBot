# 📊 Monitoring Quick Reference

## Real-Time Monitoring

### Check Current Metrics
```bash
# View all metrics
curl http://localhost:8000/metrics | jq .

# Check specific metric
curl http://localhost:8000/metrics | jq '.metrics.cache_hit_rate'

# Monitor in terminal
watch -n 5 'curl -s http://localhost:8000/metrics | jq .metrics.cache_hit_rate'
```

### Key Metrics to Watch

| Metric | Good | Warning | Critical | Check Command |
|--------|------|---------|----------|---------------|
| Cache Hit Rate | >80% | 60-80% | <60% | `curl -s /metrics \| jq '.metrics.cache_hit_rate'` |
| Vector Search P95 | <500ms | 500ms-1s | >1s | `curl -s /metrics \| jq '.metrics.vector_search_duration.p95'` |
| LLM Response P95 | <3s | 3-5s | >5s | `curl -s /metrics \| jq '.metrics.llm_call_duration.p95'` |
| Avg Conversation Size | <15 | 15-20 | >20 | `curl -s /metrics \| jq '.metrics.conversation_size.average'` |

## Redis Monitoring

### Direct Redis Queries
```bash
# Check cache entries
redis-cli KEYS "vector_cache:*" | wc -l

# Get recent search times
redis-cli ZRANGE metrics:vector_search_duration -10 -1

# Check total token usage
redis-cli GET metrics:total_tokens_used

# Monitor cache hit rate
redis-cli MGET metrics:vector_cache_hits metrics:vector_searches_total
```

### Upstash Console
1. Go to https://console.upstash.com
2. Select your Redis database
3. Check "Data Browser" for metrics
4. Monitor "Usage" tab for operations

## Performance Testing

### Quick Performance Check
```bash
# Run performance test suite
python tests/test_performance.py

# Test specific feature
python -c "import asyncio; from tests.test_performance import test_vector_cache; asyncio.run(test_vector_cache())"
```

### Load Testing
```bash
# Simple load test (10 concurrent requests)
for i in {1..10}; do
  curl -X POST http://localhost:8000/webhook \
    -H "Content-Type: application/json" \
    -d '{"message": {"text": "Test message '$i'"}}' &
done
wait
```

## Export Metrics

### Manual Export
```bash
# Export to JSON
python scripts/export_metrics.py

# Export location
ls -la metrics_export/
```

### Automated Export (Cron)
```bash
# Add to crontab for hourly exports
0 * * * * cd /path/to/bot && python scripts/export_metrics.py
```

## Quick Debugging

### Check if Caching is Working
```python
# Python one-liner
python -c "
from src.storage.vector_store import vector_store
print(f'Cache enabled: {vector_store.cache_enabled}')
print(f'Cache TTL: {vector_store.cache_ttl}s')
"
```

### View Recent Errors
```bash
# Check bot logs
tail -f logs/bot.log | grep ERROR

# Check specific operation
grep "vector_search" logs/bot.log | tail -20
```

## Alert Commands

### Check Alert Conditions
```bash
# High response time check
if [ $(curl -s /metrics | jq '.metrics.vector_search_duration.p95') > 1.0 ]; then
  echo "ALERT: High vector search latency!"
fi

# Low cache hit rate
CACHE_RATE=$(curl -s /metrics | jq '.metrics.cache_hit_rate')
if (( $(echo "$CACHE_RATE < 0.6" | bc -l) )); then
  echo "ALERT: Low cache hit rate: $CACHE_RATE"
fi
```

## Production Monitoring Setup

### 1. InfluxDB Cloud (Recommended)
```bash
# Install client
pip install influxdb-client

# Test connection
influx ping --host https://us-east-1-1.aws.cloud2.influxdata.com
```

### 2. Grafana Dashboard
```json
// Import this dashboard JSON
{
  "id": null,
  "title": "BrainBot Metrics",
  "panels": [
    {
      "title": "Cache Hit Rate",
      "targets": [{
        "query": "from(bucket: \"brainbot\") |> range(start: -1h) |> filter(fn: (r) => r._measurement == \"cache_hit_rate\")"
      }]
    }
  ]
}
```

### 3. CloudWatch (AWS)
```bash
# Send custom metric
aws cloudwatch put-metric-data \
  --namespace "BrainBot" \
  --metric-name "CacheHitRate" \
  --value 0.85 \
  --unit "Percent"
```

## Useful Aliases

Add to your `.bashrc` or `.zshrc`:

```bash
# BrainBot monitoring aliases
alias bbmetrics='curl -s http://localhost:8000/metrics | jq .'
alias bbcache='curl -s http://localhost:8000/metrics | jq .metrics.cache_hit_rate'
alias bbperf='python tests/test_performance.py'
alias bbexport='python scripts/export_metrics.py'
alias bblogs='tail -f logs/bot.log'
```

## Emergency Commands

### If Bot is Slow
```bash
# 1. Check cache
curl -s /metrics | jq '.metrics.cache_hit_rate'

# 2. Clear cache if needed
redis-cli --scan --pattern "vector_cache:*" | xargs redis-cli DEL

# 3. Check conversation sizes
redis-cli --scan --pattern "conversation:*" | head -10 | xargs -I {} redis-cli LLEN {}

# 4. Restart bot
supervisorctl restart brainbot
```

### If Metrics Missing
```bash
# Check Redis connection
redis-cli PING

# Check if metrics are being written
redis-cli MONITOR | grep metrics

# Manually trigger metric collection
python -c "from src.core.benchmarks import get_performance_monitor; print(get_performance_monitor().get_performance_summary())"
```

---

**Pro Tip**: Set up a monitoring dashboard on your phone using Grafana Mobile or create a Telegram bot that sends you daily metric summaries!