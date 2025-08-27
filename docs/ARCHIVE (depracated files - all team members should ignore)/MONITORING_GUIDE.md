# 📈 Monitoring Guide for Markdown Brain Bot

## Overview

This guide covers monitoring, metrics collection, and observability for the Markdown Brain Bot in production.

## Table of Contents

1. [Current Metrics Storage](#current-metrics-storage)
2. [Historical Data Storage](#historical-data-storage)
3. [Monitoring Solutions](#monitoring-solutions)
4. [Setting Up Monitoring](#setting-up-monitoring)
5. [Alerting Configuration](#alerting-configuration)
6. [Dashboard Examples](#dashboard-examples)
7. [Best Practices](#best-practices)

## Current Metrics Storage

### Redis-Based Metrics (7-day retention)

Currently, all metrics are stored in Upstash Redis with a 7-day TTL:

```python
# Metrics are stored as Redis sorted sets
metrics:vector_search_duration    # Time series data
metrics:llm_call_duration        # Time series data
metrics:conversation_size        # Time series data
metrics:http_request_duration    # Time series data

# Aggregated statistics
stats:vector_search_duration     # Hash with count, sum, min, max
stats:llm_call_duration         # Hash with count, sum, min, max

# Counters
metrics:vector_cache_hits       # Simple counter
metrics:vector_searches_total   # Simple counter
metrics:total_tokens_used       # Token usage counter
```

### Accessing Current Metrics

#### Via HTTP Endpoint
```bash
curl http://your-bot-url/metrics
```

#### Via Redis CLI
```bash
# Get recent vector search times
redis-cli ZRANGE metrics:vector_search_duration -10 -1 WITHSCORES

# Get aggregated stats
redis-cli HGETALL stats:vector_search_duration

# Get cache hit rate
redis-cli GET metrics:vector_cache_hits
redis-cli GET metrics:vector_searches_total
```

## Historical Data Storage

### Problem: Redis Only Keeps 7 Days

The current implementation only retains metrics for 7 days. For long-term analysis, you need persistent storage.

### Solution 1: Time-Series Database

#### **Recommended: InfluxDB Cloud**

```python
# Add to requirements.txt
influxdb-client==1.38.0

# Create influx_exporter.py
import asyncio
from influxdb_client import InfluxDBClient, Point
from influxdb_client.client.write_api import SYNCHRONOUS
from src.core.benchmarks import get_performance_monitor

class MetricsExporter:
    def __init__(self):
        self.client = InfluxDBClient(
            url="https://us-east-1-1.aws.cloud2.influxdata.com",
            token=os.getenv("INFLUXDB_TOKEN"),
            org=os.getenv("INFLUXDB_ORG")
        )
        self.write_api = self.client.write_api(write_options=SYNCHRONOUS)
        self.bucket = os.getenv("INFLUXDB_BUCKET", "brainbot-metrics")
    
    async def export_metrics(self):
        """Export metrics from Redis to InfluxDB."""
        monitor = get_performance_monitor()
        summary = monitor.get_performance_summary()
        
        for metric_name, data in summary.items():
            if isinstance(data, dict):
                point = Point(metric_name)
                for key, value in data.items():
                    point.field(key, float(value))
                point.time(datetime.utcnow())
                
                self.write_api.write(self.bucket, self.org, point)
    
    async def run_periodic_export(self, interval_minutes=5):
        """Run export every N minutes."""
        while True:
            await self.export_metrics()
            await asyncio.sleep(interval_minutes * 60)
```

#### **Alternative: Prometheus + Grafana**

```python
# Add Prometheus endpoint
from prometheus_client import Counter, Histogram, Gauge, generate_latest

# Define metrics
vector_search_duration = Histogram(
    'vector_search_duration_seconds',
    'Time spent on vector searches'
)
cache_hit_rate = Gauge(
    'vector_cache_hit_rate',
    'Cache hit rate for vector searches'
)

@app.get("/prometheus-metrics")
async def prometheus_metrics():
    # Update Prometheus metrics from Redis
    monitor = get_performance_monitor()
    summary = monitor.get_performance_summary()
    
    cache_hit_rate.set(summary.get('cache_hit_rate', 0))
    
    return Response(content=generate_latest(), media_type="text/plain")
```

### Solution 2: CloudWatch (AWS)

```python
# For AWS deployments
import boto3
from datetime import datetime

class CloudWatchExporter:
    def __init__(self):
        self.client = boto3.client('cloudwatch', region_name='us-east-1')
        self.namespace = 'BrainBot/Performance'
    
    async def put_metrics(self):
        monitor = get_performance_monitor()
        summary = monitor.get_performance_summary()
        
        metric_data = []
        
        # Cache hit rate
        metric_data.append({
            'MetricName': 'CacheHitRate',
            'Value': summary.get('cache_hit_rate', 0) * 100,
            'Unit': 'Percent',
            'Timestamp': datetime.utcnow()
        })
        
        # Vector search latency
        if 'vector_search_duration' in summary:
            metric_data.append({
                'MetricName': 'VectorSearchLatency',
                'Value': summary['vector_search_duration']['p95'],
                'Unit': 'Seconds',
                'Timestamp': datetime.utcnow()
            })
        
        self.client.put_metric_data(
            Namespace=self.namespace,
            MetricData=metric_data
        )
```

### Solution 3: Simple Database Export

```python
# Export to PostgreSQL/Supabase
CREATE TABLE bot_metrics (
    id SERIAL PRIMARY KEY,
    timestamp TIMESTAMPTZ DEFAULT NOW(),
    metric_name VARCHAR(100),
    metric_value FLOAT,
    metric_type VARCHAR(50),
    metadata JSONB
);

# Create index for time-series queries
CREATE INDEX idx_metrics_timestamp ON bot_metrics(timestamp);
CREATE INDEX idx_metrics_name ON bot_metrics(metric_name);
```

## Monitoring Solutions

### 1. **Cloudflare Analytics** (If using Cloudflare)

```javascript
// Add to your bot's response headers
response.headers['CF-Analytics'] = JSON.stringify({
    'cache_hit': cache_hit,
    'response_time': duration,
    'tokens_used': tokens
});
```

Cloudflare provides:
- Request analytics
- Response time tracking
- Geographic distribution
- Error rates

### 2. **Upstash Monitoring** (Built-in)

Upstash provides monitoring for:
- Redis operations per second
- Memory usage
- Command latency
- Vector search performance

Access at: https://console.upstash.com

### 3. **Better Stack (Recommended for Simplicity)**

```python
# Install Better Stack
pip install logtail-python

# Add to your bot
import logging
from logtail import LogtailHandler

handler = LogtailHandler(source_token=os.getenv('LOGTAIL_TOKEN'))
logging.getLogger().addHandler(handler)

# Log metrics as structured data
logger.info("metric.recorded", extra={
    "metric_name": "vector_search",
    "duration": 0.234,
    "cache_hit": True
})
```

### 4. **DataDog (Enterprise)**

```python
from datadog import initialize, statsd

initialize(
    api_key=os.getenv('DATADOG_API_KEY'),
    app_key=os.getenv('DATADOG_APP_KEY')
)

# Track metrics
statsd.histogram('bot.vector_search.duration', duration)
statsd.increment('bot.cache.hits')
statsd.gauge('bot.conversations.active', active_count)
```

## Setting Up Monitoring

### Step 1: Choose Your Stack

| Solution | Best For | Cost | Setup Time |
|----------|----------|------|------------|
| InfluxDB Cloud | Time-series data | Free tier available | 30 mins |
| Prometheus + Grafana | Self-hosted | Free (hosting costs) | 2 hours |
| CloudWatch | AWS deployments | Pay per metric | 1 hour |
| Better Stack | Quick setup | $10/mo | 15 mins |
| DataDog | Enterprise | $15/host/mo | 1 hour |

### Step 2: Implement Metric Export

```python
# Add to your main bot file
from src.monitoring.exporter import MetricsExporter

# Start exporter in background
exporter = MetricsExporter()
asyncio.create_task(exporter.run_periodic_export())
```

### Step 3: Create Dashboards

#### Grafana Dashboard JSON
```json
{
  "dashboard": {
    "title": "BrainBot Performance",
    "panels": [
      {
        "title": "Cache Hit Rate",
        "targets": [{
          "query": "SELECT mean(cache_hit_rate) FROM metrics WHERE $timeFilter GROUP BY time($interval)"
        }]
      },
      {
        "title": "Response Time P95",
        "targets": [{
          "query": "SELECT percentile(vector_search_duration, 95) FROM metrics WHERE $timeFilter"
        }]
      }
    ]
  }
}
```

## Alerting Configuration

### Critical Alerts

```yaml
# alerts.yml
alerts:
  - name: "High Response Time"
    condition: "vector_search_p95 > 2.0"
    severity: "critical"
    notify: ["ops-team@company.com"]
    
  - name: "Low Cache Hit Rate"
    condition: "cache_hit_rate < 0.5"
    severity: "warning"
    notify: ["dev-team@company.com"]
    
  - name: "High Token Usage"
    condition: "tokens_per_hour > 100000"
    severity: "warning"
    notify: ["billing@company.com"]
    
  - name: "Memory Limit Approaching"
    condition: "redis_memory_used_percent > 80"
    severity: "critical"
    notify: ["ops-team@company.com"]
```

### PagerDuty Integration

```python
import pdpyras

def send_alert(metric_name, value, threshold):
    session = pdpyras.APISession(
        os.getenv('PAGERDUTY_API_KEY')
    )
    
    session.trigger_incident(
        service_id=os.getenv('PAGERDUTY_SERVICE_ID'),
        description=f"{metric_name} exceeded threshold: {value} > {threshold}",
        details={
            'metric': metric_name,
            'value': value,
            'threshold': threshold,
            'timestamp': datetime.utcnow().isoformat()
        }
    )
```

## Dashboard Examples

### Key Metrics Dashboard

```
┌─────────────────────────────────────────────────────────┐
│                  BrainBot Performance                    │
├─────────────────────┬───────────────────────────────────┤
│ Cache Hit Rate      │ ████████████████░░░░  85.3%     │
│ Avg Response Time   │ 0.234s (↓ 15%)                  │
│ P95 Response Time   │ 0.687s                          │
│ Total Requests/min  │ 127                             │
│ Active Conversations│ 43                              │
│ Tokens Used Today   │ 45,678 ($0.92)                  │
└─────────────────────┴───────────────────────────────────┘
```

### Real-time Monitoring Script

```python
#!/usr/bin/env python3
import asyncio
import os
from datetime import datetime
from rich.console import Console
from rich.table import Table
from rich.live import Live

console = Console()

async def display_metrics():
    with Live(console=console, refresh_per_second=1) as live:
        while True:
            table = Table(title=f"BrainBot Metrics - {datetime.now().strftime('%H:%M:%S')}")
            table.add_column("Metric", style="cyan")
            table.add_column("Value", style="green")
            table.add_column("Status", style="yellow")
            
            # Fetch metrics
            monitor = get_performance_monitor()
            summary = monitor.get_performance_summary()
            
            # Add rows
            cache_rate = summary.get('cache_hit_rate', 0)
            table.add_row(
                "Cache Hit Rate",
                f"{cache_rate:.1%}",
                "🟢" if cache_rate > 0.8 else "🟡" if cache_rate > 0.6 else "🔴"
            )
            
            live.update(table)
            await asyncio.sleep(5)

if __name__ == "__main__":
    asyncio.run(display_metrics())
```

## Best Practices

### 1. **Metric Naming Convention**
```
{service}.{component}.{measurement}.{unit}

Examples:
brainbot.vector.search.duration.seconds
brainbot.cache.hits.count
brainbot.llm.tokens.total
```

### 2. **Sampling Strategy**
```python
# Don't track every request in high-volume scenarios
import random

if random.random() < 0.1:  # Sample 10% of requests
    monitor.track_metric("sampled_metric", value)
```

### 3. **Metric Cardinality**
```python
# BAD: High cardinality
monitor.track_metric("request_duration", duration, {
    "user_id": user_id,  # Thousands of unique values
    "message": message   # Infinite unique values
})

# GOOD: Low cardinality
monitor.track_metric("request_duration", duration, {
    "endpoint": "/webhook",
    "status_code": "200",
    "cache_hit": "true"
})
```

### 4. **Cost Management**

| Service | Free Tier | Cost After |
|---------|-----------|------------|
| InfluxDB | 10GB storage, 5GB transfer | $0.002/GB/hr |
| CloudWatch | 10 custom metrics | $0.30/metric/month |
| DataDog | 5 hosts | $15/host/month |
| Better Stack | 1GB logs | $0.25/GB |

### 5. **Data Retention Policy**

```sql
-- Example retention policy
CREATE POLICY "cleanup_old_metrics" ON bot_metrics
FOR DELETE USING (timestamp < NOW() - INTERVAL '90 days');

-- Downsample old data
INSERT INTO bot_metrics_daily
SELECT 
    DATE_TRUNC('day', timestamp) as day,
    metric_name,
    AVG(metric_value) as avg_value,
    MIN(metric_value) as min_value,
    MAX(metric_value) as max_value,
    COUNT(*) as sample_count
FROM bot_metrics
WHERE timestamp < NOW() - INTERVAL '7 days'
GROUP BY DATE_TRUNC('day', timestamp), metric_name;
```

## Quick Start Recommendations

### For Simple Deployments
1. Use the built-in `/metrics` endpoint
2. Set up Better Stack for logging ($10/mo)
3. Create alerts in Better Stack
4. Export daily summaries to Supabase

### For Production Deployments
1. Use InfluxDB Cloud for time-series data
2. Set up Grafana for dashboards
3. Configure PagerDuty for critical alerts
4. Export to S3 for long-term storage

### For Enterprise Deployments
1. Use DataDog for comprehensive monitoring
2. Integrate with existing APM tools
3. Set up custom dashboards per team
4. Implement SLOs and error budgets

---

**Next Steps**: 
1. Choose your monitoring stack
2. Implement metric export (see code examples)
3. Set up dashboards
4. Configure alerts
5. Document runbooks for common issues