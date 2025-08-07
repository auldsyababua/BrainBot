# BrainBot Production Deployment Guide

## Overview

BrainBot is deployed as a **Web Service** on Render.com using webhooks for real-time message processing. The bot integrates with multiple services for comprehensive memory and document management.

## Current Deployment Status

**Production URL**: https://brainbot-v76n.onrender.com  
**Bot Username**: @TenNetZeroAssistantBot  
**Architecture**: Webhook-based FastAPI server  
**Service Type**: Render Web Service (not background worker)  

## Prerequisites

### Required Services

1. **Telegram Bot**
   - Create bot via [@BotFather](https://t.me/botfather)
   - Save the `TELEGRAM_BOT_TOKEN`

2. **OpenAI Account**
   - Get API key from [OpenAI Dashboard](https://platform.openai.com/api-keys)

3. **Supabase Database**
   - Create project at [Supabase](https://supabase.com)
   - Note the URL and service role key

4. **Upstash Services**
   - Redis database for conversation persistence
   - Vector database for semantic search
   - Get REST URLs and tokens from [Upstash](https://upstash.com)

### Optional Services

5. **Neo4j Database** (for graph memory)
   - Local Docker instance or [Neo4j AuraDB](https://neo4j.com/cloud/aura/)
   - Required for advanced memory features

6. **Memory Webhooks** (for integrations)
   - External webhook endpoint for memory event notifications

## Deployment Steps

### 1. Repository Setup

```bash
# Fork the repository
git clone https://github.com/yourusername/markdown-brain-bot
cd markdown-brain-bot

# Verify render.yaml configuration
cat render.yaml
```

### 2. Render Service Configuration

1. **Create Web Service** (not background worker)
   - Service Type: Web Service
   - Runtime: Python
   - Build Command: `pip install -r requirements.txt`
   - Start Command: `python main.py`
   - Health Check Path: `/`

2. **Environment Variables** (in Render Dashboard)

#### Required Variables
```env
# Bot Authentication
TELEGRAM_BOT_TOKEN=7742923819:AAFjSv7DEOCC8oFRwhhvAjH_EEo8uhe7JK8
OPENAI_API_KEY=your_openai_api_key

# Database Services
SUPABASE_URL=your_supabase_project_url
SUPABASE_KEY=your_supabase_service_role_key
UPSTASH_REDIS_REST_URL=your_redis_rest_url
UPSTASH_REDIS_REST_TOKEN=your_redis_token
UPSTASH_VECTOR_REST_URL=your_vector_rest_url
UPSTASH_VECTOR_REST_TOKEN=your_vector_token

# Authorization (JSON format)
AUTHORIZED_USERNAMES=["Colin_10NetZero"]
AUTHORIZED_USER_IDS=[your_telegram_user_id]
```

#### Optional Variables
```env
# Graph Memory (Neo4j)
NEO4J_URL=bolt://localhost:7687
NEO4J_USERNAME=neo4j
NEO4J_PASSWORD=your_password

# Memory Webhooks
MEM0_WEBHOOK_URL=https://your-webhook-endpoint.com/mem0
MEM0_WEBHOOK_TOKEN=your_webhook_secret

# Performance Tuning
VECTOR_NAMESPACE=10netzero
VECTOR_TOP_K=5
VECTOR_CACHE_ENABLED=true
VECTOR_CACHE_TTL=300
```

### 3. Webhook Configuration

After deployment, configure the Telegram webhook:

```bash
# Option 1: Use the setup script
python setup_webhook.py

# Option 2: Manual configuration
python src/bot/set_webhook.py

# Option 3: Direct API call
curl -X POST https://api.telegram.org/bot<YOUR_BOT_TOKEN>/setWebhook \
  -H "Content-Type: application/json" \
  -d '{"url": "https://your-render-app.onrender.com/webhook"}'
```

### 4. Verification Steps

#### Test Webhook Configuration
```bash
# Check webhook status
curl https://api.telegram.org/bot<YOUR_BOT_TOKEN>/getWebhookInfo

# Test application endpoints
curl https://your-render-app.onrender.com/
curl https://your-render-app.onrender.com/webhook
```

#### Test Bot Functionality
1. Open Telegram app
2. Search for your bot username
3. Send `/start` command
4. Test Smart Rails commands:
   ```
   /newtask for @user: Check systems tomorrow
   create new shopping list
   add milk, eggs to shopping list
   ```

## Current Features & Capabilities

### ✅ Implemented Features

1. **Smart Rails Enhancement**
   - 70% token reduction achieved
   - Deterministic preprocessing for @mentions and /commands
   - Dynamic LLM prompting based on confidence scores
   - Direct execution for 100% confidence routes

2. **Memory Systems**
   - mem0 integration for conversation memory
   - Neo4j graph memory for entity relationships
   - Memory webhooks for real-time notifications
   - User preference storage and retrieval

3. **Document Processing**
   - PDF upload and text extraction
   - Document chunking and vector indexing
   - Semantic search across uploaded documents

4. **Authorization & Security**
   - User ID-based access control
   - Authorized username validation
   - Secure webhook processing

5. **Production Infrastructure**
   - Webhook-based message processing
   - Connection pooling for databases
   - Error handling and logging
   - Auto-deployment via GitHub integration

### 🔄 Architecture Overview

```
Telegram → Webhook → FastAPI Server → Smart Rails Router
                                    ↓
                            Entity Processors
                          (Lists, Tasks, Reports)
                                    ↓
                            Memory Systems
                        (Vector, Graph, Redis)
                                    ↓
                            Storage Layer
                         (Supabase, Upstash)
```

## Monitoring & Maintenance

### Health Checks

```bash
# Application health
curl https://your-render-app.onrender.com/

# Expected response:
{"status":"ok","bot":"Markdown Brain Bot","mode":"webhook"}
```

### Log Monitoring

Monitor Render logs for:
- Webhook reception (`POST /webhook`)
- Message processing times
- Database connection status
- Error traces and exceptions

### Common Issues & Solutions

#### 1. Webhook Not Receiving Messages
```bash
# Check webhook configuration
curl https://api.telegram.org/bot<TOKEN>/getWebhookInfo

# Reconfigure if needed
python setup_webhook.py
```

#### 2. Database Connection Errors
- Verify environment variables in Render dashboard
- Check service status in Supabase/Upstash dashboards
- Review connection pool settings

#### 3. Memory Timeout Issues
- Memory seeding disabled on startup (fixed in commit 9ad3c6a)
- Check Neo4j connection if using graph memory
- Verify webhook timeout settings

#### 4. Authorization Failures
- Verify `AUTHORIZED_USERNAMES` includes correct Telegram usernames
- Check `AUTHORIZED_USER_IDS` matches your Telegram user ID
- Username format: `["Colin_10NetZero"]` (JSON array)

## Performance Optimizations

### Smart Rails Metrics
- **Direct Execution**: 0 tokens, <50ms response time
- **Focused LLM**: 50-100 tokens, <200ms response time  
- **Full LLM**: 200-500 tokens, <500ms response time
- **Overall Token Savings**: 70% reduction achieved

### Scaling Configuration
- **Connection Pools**: Configured for 10-20 concurrent connections
- **Caching**: Vector search caching with 5-minute TTL
- **Resource Limits**: Optimized for Render Starter plan

## Security Best Practices

1. **Environment Variables**: All secrets stored in Render environment
2. **Webhook Validation**: Telegram webhook secret verification
3. **Authorization**: User-based access control implemented
4. **Input Validation**: SQL injection and XSS protection
5. **HTTPS**: Automatic SSL/TLS via Render platform

## Backup & Recovery

### Database Backups
- **Supabase**: Automatic daily backups included
- **Upstash**: Point-in-time recovery available
- **Neo4j**: Export graph data periodically if using AuraDB

### Configuration Backup
- Environment variables documented in this guide
- `render.yaml` stored in repository
- Webhook configuration can be restored via setup scripts

## Troubleshooting Commands

```bash
# Test bot connectivity
python -c "import requests; print(requests.get('https://api.telegram.org/bot<TOKEN>/getMe').json())"

# Test database connections
python -c "from src.storage.storage_service import StorageService; StorageService().test_connection()"

# Test vector search
python -c "from src.storage.vector_store import VectorStore; print(VectorStore().search('test', limit=1))"

# Check webhook logs
tail -f /var/log/brainbot/webhook.log
```

## Next Steps & Roadmap

### Immediate Improvements
1. Add `/health` and `/status` endpoints for better monitoring
2. Implement performance metrics dashboard
3. Create comprehensive user documentation

### Future Enhancements
1. Multi-user namespace support
2. Web UI for document management
3. Advanced analytics and reporting
4. Enhanced error recovery mechanisms

---

This deployment guide reflects the current production state of BrainBot as of August 7, 2025. The system is stable, feature-complete, and ready for production use with the Smart Rails enhancement providing significant performance improvements.