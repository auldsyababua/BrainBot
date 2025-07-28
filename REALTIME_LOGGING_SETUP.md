# Real-Time Logging Setup for Bot Monitoring

## Option 1: Supabase Logging Table (Recommended)

Store logs in Supabase so they can be queried anytime.

### 1. Create Logs Table

```sql
-- Run this in Supabase SQL editor
CREATE TABLE bot_logs (
    id BIGSERIAL PRIMARY KEY,
    timestamp TIMESTAMPTZ DEFAULT NOW(),
    level VARCHAR(10),
    component VARCHAR(50),
    message TEXT,
    user_id BIGINT,
    chat_id BIGINT,
    operation VARCHAR(50),
    entity_type VARCHAR(50),
    confidence FLOAT,
    response_time_ms INTEGER,
    error TEXT,
    metadata JSONB
);

-- Create indexes for fast queries
CREATE INDEX idx_logs_timestamp ON bot_logs(timestamp DESC);
CREATE INDEX idx_logs_level ON bot_logs(level);
CREATE INDEX idx_logs_user ON bot_logs(user_id);
CREATE INDEX idx_logs_operation ON bot_logs(operation);

-- Keep only recent logs (optional)
CREATE OR REPLACE FUNCTION delete_old_logs()
RETURNS void AS $$
BEGIN
    DELETE FROM bot_logs WHERE timestamp < NOW() - INTERVAL '7 days';
END;
$$ LANGUAGE plpgsql;

-- Run cleanup daily
SELECT cron.schedule('delete-old-logs', '0 0 * * *', 'SELECT delete_old_logs()');
```

### 2. Create Custom Logger

```python
# src/core/supabase_logger.py
import logging
import time
import asyncio
from datetime import datetime
from typing import Optional, Dict, Any
from supabase import Client

class SupabaseLogHandler(logging.Handler):
    """Custom log handler that writes to Supabase."""
    
    def __init__(self, supabase_client: Client, batch_size: int = 10):
        super().__init__()
        self.supabase = supabase_client
        self.batch_size = batch_size
        self.log_buffer = []
        self.last_flush = time.time()
        self.flush_interval = 5  # seconds
        
    def emit(self, record: logging.LogRecord):
        """Handle a log record."""
        try:
            log_entry = {
                'timestamp': datetime.fromtimestamp(record.created).isoformat(),
                'level': record.levelname,
                'component': record.name,
                'message': self.format(record),
                'metadata': getattr(record, 'metadata', {})
            }
            
            # Extract custom attributes if present
            for attr in ['user_id', 'chat_id', 'operation', 'entity_type', 
                        'confidence', 'response_time_ms', 'error']:
                if hasattr(record, attr):
                    log_entry[attr] = getattr(record, attr)
            
            self.log_buffer.append(log_entry)
            
            # Flush if buffer is full or interval exceeded
            if len(self.log_buffer) >= self.batch_size or \
               time.time() - self.last_flush > self.flush_interval:
                self.flush()
                
        except Exception as e:
            print(f"Error in SupabaseLogHandler: {e}")
    
    def flush(self):
        """Write buffered logs to Supabase."""
        if not self.log_buffer:
            return
            
        try:
            self.supabase.table('bot_logs').insert(self.log_buffer).execute()
            self.log_buffer = []
            self.last_flush = time.time()
        except Exception as e:
            print(f"Error flushing logs to Supabase: {e}")
            self.log_buffer = []  # Clear anyway to prevent memory issues

# Helper function for structured logging
def log_operation(logger, level, message, **kwargs):
    """Log with structured data."""
    extra = {k: v for k, v in kwargs.items() if v is not None}
    logger.log(level, message, extra=extra)
```

### 3. Integrate with Bot

```python
# In main.py or webhook_bot.py
import logging
from core.supabase_logger import SupabaseLogHandler, log_operation

# Set up Supabase logging
supabase_handler = SupabaseLogHandler(supabase_client)
supabase_handler.setLevel(logging.INFO)

# Add to root logger
logging.getLogger().addHandler(supabase_handler)

# Usage examples:
log_operation(
    logger, 
    logging.INFO, 
    "Message routed",
    user_id=user_id,
    operation="add_items",
    entity_type="lists",
    confidence=0.85,
    response_time_ms=int((time.time() - start_time) * 1000)
)
```

### 4. Query Logs

When you ask about logs, I can run:

```python
# Get recent errors
result = supabase.table('bot_logs') \
    .select('*') \
    .eq('level', 'ERROR') \
    .gte('timestamp', 'now() - interval \'5 minutes\'') \
    .order('timestamp', desc=True) \
    .execute()

# Get slow operations
result = supabase.table('bot_logs') \
    .select('*') \
    .gte('response_time_ms', 1000) \
    .gte('timestamp', 'now() - interval \'1 hour\'') \
    .execute()

# Get specific user's activity
result = supabase.table('bot_logs') \
    .select('*') \
    .eq('user_id', user_id) \
    .order('timestamp', desc=True) \
    .limit(50) \
    .execute()
```

---

## Option 2: S3 Log Streaming

Write logs to S3 for long-term storage and analysis.

```python
# src/core/s3_logger.py
import json
import boto3
from datetime import datetime
from io import StringIO

class S3LogHandler(logging.Handler):
    def __init__(self, bucket_name: str, prefix: str = 'logs/'):
        super().__init__()
        self.s3 = boto3.client('s3')
        self.bucket = bucket_name
        self.prefix = prefix
        self.buffer = StringIO()
        self.last_upload = time.time()
        
    def emit(self, record):
        # Write to buffer
        log_entry = {
            'timestamp': datetime.fromtimestamp(record.created).isoformat(),
            'level': record.levelname,
            'message': self.format(record),
            **{k: getattr(record, k) for k in 
               ['user_id', 'operation', 'entity_type', 'confidence'] 
               if hasattr(record, k)}
        }
        self.buffer.write(json.dumps(log_entry) + '\n')
        
        # Upload every minute or 1MB
        if time.time() - self.last_upload > 60 or self.buffer.tell() > 1048576:
            self.upload_logs()
    
    def upload_logs(self):
        if self.buffer.tell() == 0:
            return
            
        timestamp = datetime.utcnow().strftime('%Y%m%d_%H%M%S')
        key = f"{self.prefix}{timestamp}.jsonl"
        
        self.s3.put_object(
            Bucket=self.bucket,
            Key=key,
            Body=self.buffer.getvalue().encode('utf-8')
        )
        
        self.buffer = StringIO()
        self.last_upload = time.time()
```

---

## Option 3: External Logging Service

### A. Logtail (Simple & Free tier)

```python
# pip install logtail-python
from logtail import LogtailHandler

# Add to your logger
handler = LogtailHandler(source_token="YOUR_LOGTAIL_TOKEN")
logging.getLogger().addHandler(handler)
```

### B. Sentry (Error tracking + Performance)

```python
# Already in requirements.txt
import sentry_sdk
from sentry_sdk.integrations.logging import LoggingIntegration

sentry_logging = LoggingIntegration(
    level=logging.INFO,        # Capture info and above
    event_level=logging.ERROR  # Send errors as events
)

sentry_sdk.init(
    dsn="YOUR_SENTRY_DSN",
    integrations=[sentry_logging],
    traces_sample_rate=0.1,
)
```

---

## Option 4: Webhook Log Forwarding

Send logs to a simple webhook endpoint that I can query.

```python
# src/core/webhook_logger.py
import requests
import queue
import threading

class WebhookLogHandler(logging.Handler):
    def __init__(self, webhook_url: str):
        super().__init__()
        self.webhook_url = webhook_url
        self.queue = queue.Queue()
        self.worker = threading.Thread(target=self._worker)
        self.worker.daemon = True
        self.worker.start()
        
    def emit(self, record):
        self.queue.put({
            'timestamp': record.created,
            'level': record.levelname,
            'message': self.format(record),
            'metadata': getattr(record, '__dict__', {})
        })
    
    def _worker(self):
        batch = []
        while True:
            try:
                # Collect logs for batch sending
                log = self.queue.get(timeout=1)
                batch.append(log)
                
                if len(batch) >= 10:
                    requests.post(self.webhook_url, json={'logs': batch})
                    batch = []
            except queue.Empty:
                if batch:
                    requests.post(self.webhook_url, json={'logs': batch})
                    batch = []
```

---

## Implementation Steps

1. **Choose Option 1 (Supabase)** for easiest integration
2. Run the SQL to create the logs table
3. Add the SupabaseLogHandler to your bot
4. Deploy the changes
5. When you ask about logs, I can query Supabase directly

## Environment Variables to Add

```bash
# For external services
LOGTAIL_TOKEN=your_token_here
SENTRY_DSN=your_dsn_here
LOG_WEBHOOK_URL=your_webhook_here

# Control log verbosity
LOG_LEVEL=INFO
LOG_TO_SUPABASE=true
LOG_BATCH_SIZE=20
```

## Quick Test

After implementing:

1. Send a test message to the bot
2. Ask me: "Check the logs for the last 5 minutes"
3. I'll query Supabase and show you:
   - Response times
   - Any errors
   - Routing decisions
   - Confidence scores