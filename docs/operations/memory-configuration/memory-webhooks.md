# Memory Webhooks System

The markdown-brain-bot includes a comprehensive webhook system for memory operations, allowing real-time notifications and integrations with external systems when memory events occur.

## Overview

The memory webhook system provides:

- **Outgoing Webhooks**: Notifications sent when memory operations occur (add, delete, search, etc.)
- **Incoming Webhooks**: Endpoints to receive memory-related notifications from external systems
- **Event Filtering**: Configure which events trigger webhooks
- **Retry Logic**: Automatic retry with exponential backoff for failed webhook deliveries
- **Security**: Token-based authentication and signature validation
- **Monitoring**: Status endpoints and comprehensive logging

## Webhook Events

The system supports the following webhook events:

| Event | Description | Trigger |
|-------|-------------|----------|
| `memory_added` | New memory created | `remember_from_conversation()`, `store_preference()` |
| `memory_searched` | Memory search performed | `recall_context()`, `hybrid_search_with_graph()` |
| `memory_deleted` | Memory deleted | `forget_memories()` |
| `memory_updated` | Memory modified | Memory update operations |
| `preference_stored` | User preference saved | `store_preference()` |
| `correction_stored` | User correction saved | `store_correction()` |
| `relationship_added` | Graph relationship created | `store_entity_relationship()` |
| `relationship_deleted` | Graph relationship removed | Relationship deletion |
| `graph_built` | Knowledge graph constructed | `build_knowledge_graph()` |
| `memory_optimized` | Memory optimization completed | `optimize_memories()` |
| `batch_operation_completed` | Batch operation finished | `batch_add_memories()` |
| `memory_error` | Memory operation failed | Any memory operation error |

## Configuration

### Environment Variables

```bash
# Webhook URL - where to send notifications
MEM0_WEBHOOK_URL=https://your-server.com/webhooks/memory

# Authentication token (Bearer token)
MEM0_WEBHOOK_TOKEN=your-secret-token

# Webhook signing secret for payload validation
MEM0_WEBHOOK_SECRET=your-signing-secret

# Timeout for webhook requests (seconds)
MEM0_WEBHOOK_TIMEOUT=30

# Number of retry attempts for failed webhooks
MEM0_WEBHOOK_RETRY_COUNT=3

# Initial retry delay (seconds, exponential backoff)
MEM0_WEBHOOK_RETRY_DELAY=1.0

# Events to send webhooks for (comma-separated or 'all' or 'none')
MEM0_WEBHOOK_EVENTS=all
# Examples:
# MEM0_WEBHOOK_EVENTS=memory_added,memory_deleted,relationship_added
# MEM0_WEBHOOK_EVENTS=none

# Bot version to include in webhook payloads
BOT_VERSION=1.0.0
```

### Event Filtering

You can control which events trigger webhooks:

- `all` (default): All events trigger webhooks
- `none`: No webhooks are sent
- Comma-separated list: Only specified events trigger webhooks

```bash
# Only send webhooks for memory additions and deletions
MEM0_WEBHOOK_EVENTS=memory_added,memory_deleted

# Send webhooks for all relationship events
MEM0_WEBHOOK_EVENTS=relationship_added,relationship_deleted,graph_built

# Disable all webhooks
MEM0_WEBHOOK_EVENTS=none
```

## Outgoing Webhooks

### Payload Structure

All outgoing webhooks use a standardized payload structure:

```json
{
  "event": "memory_added",
  "user_id": "user123",
  "data": {
    "memory_id": "mem_456",
    "content": "User prefers morning meetings",
    "category": "preference"
  },
  "timestamp": "2024-01-15T10:30:00.123456",
  "source": "markdown-brain-bot",
  "bot_version": "1.0.0",
  "request_id": "req_789"
}
```

### Payload Fields

- `event`: The webhook event type (see events table above)
- `user_id`: ID of the user associated with the memory operation
- `data`: Event-specific data (varies by event type)
- `timestamp`: ISO 8601 timestamp when the event occurred
- `source`: Always "markdown-brain-bot"
- `bot_version`: Version of the bot (from `BOT_VERSION` env var)
- `request_id`: Optional request tracking ID

### Event-Specific Data Examples

#### Memory Added
```json
{
  "event": "memory_added",
  "data": {
    "result": {
      "id": "mem_123",
      "content": "User works at Austin facility",
      "metadata": {
        "type": "preference",
        "category": "location"
      }
    }
  }
}
```

#### Memory Searched
```json
{
  "event": "memory_searched",
  "data": {
    "query": "facilities in Austin",
    "limit": 5,
    "results_count": 3,
    "memories": [...] // First 3 results
  }
}
```

#### Relationship Added
```json
{
  "event": "relationship_added",
  "data": {
    "source": "North Austin Facility",
    "relationship": "HAS_PARTNER",
    "target": "GreenEnergy Capital",
    "result": {
      "id": "rel_456",
      "confidence": 1.0
    }
  }
}
```

#### Memory Error
```json
{
  "event": "memory_error",
  "data": {
    "operation": "batch_add_memories",
    "error": "Connection timeout to vector store",
    "items_count": 25
  }
}
```

### Authentication

Webhooks support Bearer token authentication. Include your token in the `MEM0_WEBHOOK_TOKEN` environment variable:

```bash
MEM0_WEBHOOK_TOKEN=your-secret-token
```

Webhooks will include the Authorization header:

```
Authorization: Bearer your-secret-token
```

### Signature Validation

For additional security, webhooks can include a signature for payload validation:

```bash
MEM0_WEBHOOK_SECRET=your-signing-secret
```

Webhooks will include the signature header:

```
X-Webhook-Secret: your-signing-secret
```

### Retry Logic

Webhooks implement intelligent retry logic:

- **Success**: HTTP 200 responses are considered successful
- **Client Errors**: HTTP 4xx responses are not retried (permanent failures)
- **Server Errors**: HTTP 5xx responses trigger retries
- **Timeouts**: Network timeouts trigger retries
- **Backoff**: Exponential backoff between retries (1s, 2s, 4s, etc.)

## Incoming Webhooks

The bot provides endpoints to receive webhook notifications from external systems.

### Endpoints

#### Memory Webhook Handler
```
POST /webhooks/memory
```

Receives memory-related webhook notifications from external systems.

**Request Body:**
```json
{
  "event": "memory_added",
  "user_id": "user123",
  "data": {
    "memory_id": "external_mem_456",
    "content": "External system data"
  },
  "timestamp": "2024-01-15T10:30:00Z"
}
```

**Response:**
```json
{
  "status": "processed",
  "action": "memory_logged"
}
```

#### Webhook Status
```
GET /webhooks/memory/status
```

Returns webhook configuration and status information.

**Response:**
```json
{
  "status": "ok",
  "webhook_config": {
    "enabled": true,
    "webhook_url": "https://your-server.com/webhook",
    "timeout": 30,
    "retry_count": 3,
    "enabled_events": ["memory_added", "memory_deleted"],
    "has_token": true,
    "has_secret": true
  }
}
```

#### Test Webhook
```
POST /webhooks/memory/test
```

Sends a test webhook to verify configuration.

**Response:**
```json
{
  "status": "ok",
  "test_sent": true,
  "webhook_enabled": true,
  "webhook_url": "https://your-server.com/webhook"
}
```

## Usage Examples

### Basic Setup

```bash
# Set webhook URL
export MEM0_WEBHOOK_URL="https://myapp.com/memory-notifications"

# Set authentication token
export MEM0_WEBHOOK_TOKEN="my-secret-token"

# Enable all events
export MEM0_WEBHOOK_EVENTS="all"
```

### Receiving Webhooks (Express.js Example)

```javascript
const express = require('express');
const app = express();

app.use(express.json());

app.post('/memory-notifications', (req, res) => {
  const { event, user_id, data, timestamp } = req.body;
  
  // Verify authorization
  const authHeader = req.headers.authorization;
  if (authHeader !== 'Bearer my-secret-token') {
    return res.status(401).send('Unauthorized');
  }
  
  console.log(`Received ${event} for user ${user_id}:`, data);
  
  // Process the webhook based on event type
  switch (event) {
    case 'memory_added':
      handleMemoryAdded(user_id, data);
      break;
    case 'relationship_added':
      handleRelationshipAdded(user_id, data);
      break;
    default:
      console.log('Unknown event:', event);
  }
  
  res.json({ status: 'processed' });
});

function handleMemoryAdded(userId, data) {
  // Update external CRM or database
  console.log(`New memory for ${userId}:`, data.result.content);
}

function handleRelationshipAdded(userId, data) {
  // Update knowledge graph in external system
  console.log(`New relationship: ${data.source} -> ${data.relationship} -> ${data.target}`);
}

app.listen(3000, () => {
  console.log('Webhook server listening on port 3000');
});
```

### Python Flask Example

```python
from flask import Flask, request, jsonify
import hmac
import hashlib
import json

app = Flask(__name__)
WEBHOOK_SECRET = "my-secret-token"

@app.route('/memory-notifications', methods=['POST'])
def handle_memory_webhook():
    # Verify authorization
    auth_header = request.headers.get('Authorization', '')
    if not auth_header.startswith('Bearer ') or auth_header[7:] != WEBHOOK_SECRET:
        return jsonify({'error': 'Unauthorized'}), 401
    
    data = request.json
    event = data.get('event')
    user_id = data.get('user_id')
    event_data = data.get('data')
    
    print(f"Received {event} for user {user_id}: {event_data}")
    
    if event == 'memory_added':
        handle_memory_added(user_id, event_data)
    elif event == 'memory_searched':
        handle_memory_searched(user_id, event_data)
    elif event == 'memory_error':
        handle_memory_error(user_id, event_data)
    
    return jsonify({'status': 'processed'})

def handle_memory_added(user_id, data):
    # Log to analytics system
    print(f"Memory added for {user_id}: {data.get('result', {}).get('content')}")

def handle_memory_searched(user_id, data):
    # Track search patterns
    print(f"User {user_id} searched for: {data.get('query')}")

def handle_memory_error(user_id, data):
    # Alert monitoring system
    print(f"Memory error for {user_id}: {data.get('error')}")

if __name__ == '__main__':
    app.run(port=3000)
```

### Testing Webhooks

```bash
# Test webhook configuration
curl -X POST http://localhost:8000/webhooks/memory/test

# Check webhook status
curl http://localhost:8000/webhooks/memory/status

# Send test webhook to your endpoint
curl -X POST https://myapp.com/memory-notifications \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer my-secret-token" \
  -d '{
    "event": "memory_added",
    "user_id": "test_user",
    "data": {
      "test": true,
      "content": "Test memory"
    },
    "timestamp": "2024-01-15T10:30:00Z"
  }'
```

## Monitoring and Debugging

### Logging

Webhook operations are logged with different levels:

- **INFO**: Successful webhook deliveries
- **WARNING**: Retry attempts and non-fatal errors
- **ERROR**: Failed webhook deliveries after all retries

### Common Issues

1. **Webhook Not Sending**
   - Check `MEM0_WEBHOOK_URL` is set
   - Verify `MEM0_WEBHOOK_EVENTS` includes the event
   - Check logs for configuration errors

2. **Authentication Failures**
   - Verify `MEM0_WEBHOOK_TOKEN` matches receiving endpoint
   - Check Authorization header format

3. **Timeout Issues**
   - Increase `MEM0_WEBHOOK_TIMEOUT`
   - Check network connectivity
   - Verify receiving endpoint response time

4. **Retry Exhaustion**
   - Check receiving endpoint is returning proper HTTP status codes
   - Increase `MEM0_WEBHOOK_RETRY_COUNT` if needed
   - Fix issues causing 5xx responses

### Performance Considerations

- Webhooks are sent asynchronously to avoid blocking memory operations
- Batch operations send a single completion webhook rather than individual webhooks per item
- Failed webhooks don't affect memory operation success
- Consider webhook endpoint performance impact on bot response time

## Security Best Practices

1. **Use HTTPS** for webhook URLs
2. **Validate signatures** when using webhook secrets
3. **Implement rate limiting** on receiving endpoints
4. **Log webhook activity** for audit trails
5. **Use environment variables** for sensitive configuration
6. **Validate webhook payloads** before processing
7. **Implement proper error handling** in webhook receivers

## Integration Examples

### CRM Integration

Update customer records when memory preferences are stored:

```python
@app.route('/webhooks/memory', methods=['POST'])
def memory_webhook():
    data = request.json
    
    if data['event'] == 'preference_stored':
        user_id = data['user_id']
        preference = data['data']['preference']
        category = data['data']['category']
        
        # Update CRM
        crm_client.update_customer_preference(
            customer_id=user_id,
            preference=preference,
            category=category
        )
    
    return {'status': 'processed'}
```

### Analytics Integration

Track memory usage patterns:

```javascript
app.post('/webhooks/memory', (req, res) => {
  const { event, user_id, data } = req.body;
  
  // Send to analytics
  analytics.track(user_id, 'Memory Event', {
    event_type: event,
    ...data
  });
  
  res.json({ status: 'processed' });
});
```

### Notification Integration

Send alerts for memory errors:

```python
def handle_memory_error(user_id, data):
    error_message = data.get('error')
    operation = data.get('operation')
    
    # Send to Slack/Discord/email
    alert_service.send_alert(
        f"Memory error for user {user_id}:\n"
        f"Operation: {operation}\n"
        f"Error: {error_message}"
    )
```

This webhook system provides a powerful foundation for integrating the markdown-brain-bot's memory capabilities with external systems, enabling real-time data synchronization, monitoring, and advanced workflow automation.
