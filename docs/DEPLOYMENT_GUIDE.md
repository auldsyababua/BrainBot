# BrainBot Deployment & Management Guide

## Overview

BrainBot is a Telegram bot that serves as a shared knowledge management system using markdown files, Redis for conversation persistence, and vector search for enhanced responses.

## Current Deployment Status

- **Platform**: Render.com (Background Worker)
- **Repository**: github.com/auldsyababua/BrainBot
- **Mode**: Polling (no webhooks required)
- **Features**: 
  -  Persistent conversations (Redis)
  -  Semantic search (Vector DB)
  -  Smart todo lists with checkboxes
  -  Markdown file management

## Render CLI Management

The Render CLI is installed locally for managing deployments and logs.

**Note**: When using Render CLI in scripts or non-interactive environments, add `-o json` flag.

### View Logs
```bash
# List all services
render services list
render services list -o json  # For scripts/automation

# Watch live logs
render logs <service-name> --tail

# View recent logs
render logs <service-name> --since 1h
```

### Manage Deployments
```bash
# Trigger manual deploy
render deploy <service-name>

# View deployment status
render deploys list <service-name>

# Cancel a deployment
render deploys cancel <deploy-id>
```

### Environment Variables
```bash
# List all env vars
render env list <service-name>

# Set an env var
render env set <service-name> KEY=value

# Remove an env var
render env unset <service-name> KEY
```

## Required Environment Variables

```bash
# Core Bot Configuration
TELEGRAM_BOT_TOKEN=your_telegram_bot_token
OPENAI_API_KEY=your_openai_api_key

# Redis Configuration (Upstash)
UPSTASH_REDIS_REST_URL=https://your-redis-instance.upstash.io
UPSTASH_REDIS_REST_TOKEN=your_redis_token

# Vector Database (Upstash)
UPSTASH_VECTOR_REST_URL=https://your-vector-instance.upstash.io
UPSTASH_VECTOR_REST_TOKEN=your_vector_token

# Optional Configuration
VECTOR_NAMESPACE=your_namespace      # Default: empty
MIGRATION_FOLDER=YourDocsFolder      # For migration script
VECTOR_TOP_K=5                       # Search results count
```

## Local Development & Testing

### Run Locally
```bash
# Install dependencies
pip install -r requirements.txt

# Copy and configure environment
cp .env.example .env
# Edit .env with your credentials

# Run the bot
python main_polling.py
```

### Test Vector Search
```bash
# Run migration for a specific folder
python migrate_to_vector.py

# Test search functionality
python test_vector_search.py
```

### Bot Commands
- `/start` - Welcome message
- `/help` - Show commands and examples
- `/reset` - Clear conversation memory
- `/continue` - Restore previous conversation

## Monitoring & Troubleshooting

### Common Issues

1. **Bot Not Responding**
   ```bash
   # Check if service is running
   render services info <service-name>
   
   # Check logs for errors
   render logs <service-name> --tail
   ```

2. **Redis Connection Issues**
   - Verify UPSTASH_REDIS_REST_URL and TOKEN are correct
   - Check Upstash dashboard for connection limits

3. **Vector Search Not Working**
   - Ensure migration script was run
   - Verify UPSTASH_VECTOR credentials
   - Check namespace configuration

### Health Checks
```bash
# Check service status
render services info <service-name>

# View resource usage
render metrics <service-name>
```

## Deployment Workflow

1. **Code Changes**
   ```bash
   # Make changes locally
   git add .
   git commit -m "Your changes"
   git push origin main
   ```

2. **Auto-Deploy** (if enabled)
   - Render automatically deploys on push to main

3. **Manual Deploy**
   ```bash
   render deploy <service-name>
   ```

4. **Monitor Deployment**
   ```bash
   render logs <service-name> --tail
   ```

## Data Management

### Backup Conversations
Redis conversations expire after 1 hour by default. For permanent storage:
- Export important conversations to markdown files
- Use the bot to create permanent notes

### Vector Database
- Documents are permanently stored in vector DB
- Run migration script to add new folders
- Use environment variable to control which folders to index

## Security Notes

- Never commit `.env` files
- Rotate API keys regularly
- Keep company-specific data in local `notes/` folder only
- Use environment variables for all sensitive configuration

## Quick Commands Reference

```bash
# Service Management
render services list                    # List all services
render services info <name>            # Service details
render services restart <name>         # Restart service

# Logs
render logs <name> --tail             # Live logs
render logs <name> --since 1h         # Last hour
render logs <name> --grep ERROR       # Filter logs

# Environment
render env list <name>                # List vars
render env set <name> KEY=value       # Set var
render env unset <name> KEY           # Remove var

# Deployments
render deploy <name>                  # Manual deploy
render deploys list <name>            # Deploy history
render deploys cancel <id>            # Cancel deploy
```

## Contact & Support

- **Repository**: github.com/auldsyababua/BrainBot
- **Telegram Bot**: @YourBotUsername
- **Render Dashboard**: dashboard.render.com

---

Last Updated: 2025-01-18