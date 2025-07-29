# mem0 Environment Configuration Guide

This guide explains all the environment variables you can use to configure mem0's behavior, including pre-seeding memories, user-specific settings, and webhooks.

## Basic Configuration

```bash
# LLM Model for memory extraction (default: gpt-4o-mini)
MEM0_LLM_MODEL=gpt-4o-mini

# Memory threshold - minimum confidence for storing memories (0.0-1.0)
MEM0_MEMORY_THRESHOLD=0.7
```

## Pre-seeded Memories

You can pre-seed memories that will be loaded when the bot starts:

```bash
# Initial memories (JSON array)
MEM0_INITIAL_MEMORIES='[
  {
    "user_id": "system",
    "content": "The company uses Eagle Lake pumps for all water systems",
    "category": "equipment"
  },
  {
    "user_id": "colin",
    "content": "Colin prefers morning reports at 8 AM",
    "category": "preference"
  },
  {
    "user_id": "bryan",
    "content": "Bryan manages the northern site operations",
    "category": "role"
  }
]'
```

## User-Specific Configuration

Configure memory behavior per user:

```bash
# For user "colin" (use uppercase in env var)
# Retention policy - how long to keep memories (days)
MEM0_USER_COLIN_RETENTION_DAYS=90

# Allowed memory categories (comma-separated)
MEM0_USER_COLIN_CATEGORIES=preference,equipment,location

# Auto-extract memories from conversations (true/false)
MEM0_USER_COLIN_AUTO_EXTRACT=true

# For user "bryan"
MEM0_USER_BRYAN_RETENTION_DAYS=180
MEM0_USER_BRYAN_CATEGORIES=all
MEM0_USER_BRYAN_AUTO_EXTRACT=false
```

## Webhook Configuration

Get notifications when memories are created, updated, or accessed:

```bash
# Webhook endpoint
MEM0_WEBHOOK_URL=https://your-server.com/webhooks/mem0

# Optional: Authentication token
MEM0_WEBHOOK_TOKEN=your-webhook-secret-token
```

### Webhook Events

The webhook will receive POST requests with this payload:

```json
{
  "event": "memory_added",  // or "memory_updated", "memory_deleted"
  "user_id": "colin",
  "data": {
    "memory": "Colin prefers morning reports at 8 AM",
    "metadata": {
      "type": "preference",
      "category": "reporting"
    }
  },
  "timestamp": "2024-01-29T08:00:00Z"
}
```

## Advanced Features

### Memory Rules

Define rules for automatic memory management:

```bash
# Auto-tag memories based on content
MEM0_AUTO_TAG_RULES='{
  "pump": ["equipment", "maintenance"],
  "report": ["reporting", "schedule"],
  "site": ["location", "facility"]
}'

# Memory priority levels (for retention)
MEM0_PRIORITY_KEYWORDS='{
  "critical": ["password", "emergency", "safety"],
  "high": ["deadline", "important", "urgent"],
  "normal": ["prefer", "usually", "sometimes"]
}'
```

### Integration with External Systems

```bash
# Sync memories with external database
MEM0_SYNC_ENABLED=true
MEM0_SYNC_INTERVAL=3600  # seconds
MEM0_SYNC_ENDPOINT=https://api.yourcompany.com/memories

# Export memories to analytics
MEM0_ANALYTICS_ENABLED=true
MEM0_ANALYTICS_ENDPOINT=https://analytics.yourcompany.com/events
```

## Example .env Configuration

```bash
# Basic mem0 settings
MEM0_LLM_MODEL=gpt-4o-mini
MEM0_MEMORY_THRESHOLD=0.7

# Pre-seed system knowledge
MEM0_INITIAL_MEMORIES='[
  {"user_id": "system", "content": "All pump maintenance happens on Mondays", "category": "schedule"},
  {"user_id": "system", "content": "Emergency contact: 555-0123", "category": "contact"}
]'

# User-specific settings
MEM0_USER_COLIN_RETENTION_DAYS=90
MEM0_USER_COLIN_CATEGORIES=preference,equipment,location
MEM0_USER_BRYAN_AUTO_EXTRACT=false

# Webhook for memory events
MEM0_WEBHOOK_URL=https://n8n.yourcompany.com/webhook/mem0-events
MEM0_WEBHOOK_TOKEN=secret-webhook-token-123

# Auto-tagging rules
MEM0_AUTO_TAG_RULES='{"pump": ["equipment"], "Eagle Lake": ["location"]}'
```

## Usage in Code

The bot automatically loads these configurations on startup:

1. **Initial memories** are seeded when the bot starts
2. **User configs** are applied when processing messages from specific users
3. **Webhooks** fire automatically on memory events
4. **Rules** are applied during memory extraction

## Testing Your Configuration

1. **Check loaded memories**:
   ```
   /memories
   ```

2. **Test webhook**:
   ```
   /remember Test webhook notification
   ```

3. **Verify user-specific settings**:
   ```
   # As different users, check if auto-extract works
   "I prefer email reports"  # Should create memory if auto-extract=true
   ```

## Security Notes

- Store sensitive webhook tokens in environment variables
- Use HTTPS for webhook endpoints
- Rotate webhook tokens regularly
- Consider IP whitelisting for webhook endpoints
- Sanitize user IDs in environment variable names