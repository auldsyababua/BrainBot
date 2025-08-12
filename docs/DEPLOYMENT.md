# Deployment Guide

## Overview

The Markdown Brain Bot uses a multi-service architecture:
- **Main Bot Service**: FastAPI webhook server on Render
- **Cloudflare Workers**: Consumer and Webhook workers for request processing
- **Databases**: Supabase (documents), Upstash (Redis + Vector), Neo4j (graph memory)

## Architecture

```
Telegram API
     ↓
Cloudflare Webhook Worker
     ↓
Cloudflare Consumer Worker (Queue)
     ↓
Render Bot Service (/process endpoint)
     ↓
Databases (Supabase, Upstash, Neo4j)
```

## Deployment Process

### 1. Pre-Deployment Checklist

- [ ] All tests passing locally
- [ ] Environment variables configured in Render
- [ ] Cloudflare secrets configured
- [ ] Database connections verified

### 2. Environment Variables

#### Required for Render Service

```bash
# Bot Authentication
TELEGRAM_BOT_TOKEN=your_bot_token
TELEGRAM_WEBHOOK_SECRET=your_webhook_secret
CF_PROXY_SECRET=shared_secret_with_cloudflare

# OpenAI
OPENAI_API_KEY=your_openai_key

# Databases
SUPABASE_URL=your_supabase_url
SUPABASE_KEY=your_supabase_key
UPSTASH_REDIS_REST_URL=your_redis_url
UPSTASH_REDIS_REST_TOKEN=your_redis_token
UPSTASH_VECTOR_REST_URL=your_vector_url
UPSTASH_VECTOR_REST_TOKEN=your_vector_token

# Optional
NEO4J_URL=your_neo4j_url
NEO4J_USERNAME=your_neo4j_username
NEO4J_PASSWORD=your_neo4j_password
```

#### Required for Cloudflare Workers

```bash
# Consumer Worker Secrets
TELEGRAM_WEBHOOK_SECRET=your_webhook_secret
CF_PROXY_SECRET=shared_secret_with_render
PROCESS_URL=https://brainbot-v76n.onrender.com/process

# Bindings
KV Namespace: BRAINBOT_KV
Queue: brainbot-queue
Vectorize Index: VECTORIZE
```

### 3. Deployment Steps

#### Deploy to Main Branch

1. **Create Pull Request**
   ```bash
   git checkout -b feature/your-feature
   git add .
   git commit -m "feat: your feature description"
   git push origin feature/your-feature
   ```

2. **Merge to Main**
   - Wait for PR validation checks
   - Review and approve PR
   - Merge to main branch

3. **Automatic Deployment**
   - GitHub Actions will automatically:
     - Run tests
     - Deploy to Render
     - Deploy Cloudflare Workers
     - Run health checks

#### Manual Deployment

If automatic deployment fails:

1. **Deploy Render Service**
   ```bash
   # Trigger manual deploy via Render API
   curl -X POST \
     "https://api.render.com/v1/services/${RENDER_SERVICE_ID}/deploys" \
     -H "Authorization: Bearer ${RENDER_API_KEY}" \
     -H "Content-Type: application/json" \
     -d '{"clearCache": false}'
   ```

2. **Deploy Cloudflare Workers**
   ```bash
   # Deploy Consumer Worker
   cd cf/brainbot-consumer
   wrangler deploy --env production
   
   # Deploy Webhook Worker
   cd ../brainbot-webhook
   wrangler deploy --env production
   ```

### 4. Post-Deployment Verification

1. **Check Health Endpoints**
   ```bash
   # Bot service health
   curl https://brainbot-v76n.onrender.com/health
   
   # Status with metrics
   curl https://brainbot-v76n.onrender.com/status
   
   # Process endpoint (should return 401 without auth)
   curl -X POST https://brainbot-v76n.onrender.com/process
   ```

2. **Test Bot Functionality**
   - Send `/start` command to bot
   - Send a test message
   - Check `/memories` command
   - Verify document storage

3. **Monitor Logs**
   - Check Render logs for errors
   - Check Cloudflare Workers logs
   - Monitor Supabase logs

## Rollback Procedure

If deployment causes issues:

1. **Immediate Rollback**
   ```bash
   # Revert to previous commit
   git revert HEAD
   git push origin main
   ```

2. **Manual Service Rollback**
   - Go to Render Dashboard
   - Select the service
   - Click "Rollback" to previous deploy

3. **Cloudflare Rollback**
   ```bash
   # List deployments
   wrangler deployments list
   
   # Rollback to specific version
   wrangler rollback [deployment-id]
   ```

## Monitoring

### Health Checks

The service exposes several monitoring endpoints:

- `/health` - Comprehensive health check
- `/status` - Detailed status with metrics
- `/metrics` - Performance metrics (protected)

### Automated Monitoring

GitHub Actions runs health checks every 5 minutes and creates issues if failures are detected.

### Manual Monitoring

Check service health:
```bash
# Full health check
curl https://brainbot-v76n.onrender.com/health | jq .

# Performance metrics
curl https://brainbot-v76n.onrender.com/status | jq .performance

# Database connectivity
curl https://brainbot-v76n.onrender.com/health | jq .services.database
```

## Troubleshooting

### Common Issues

1. **404 on /process endpoint**
   - Ensure feature branch is merged to main
   - Verify Render has deployed latest code
   - Check CF_PROXY_SECRET is set

2. **401 Unauthorized on /process**
   - Verify CF_PROXY_SECRET matches between services
   - Check timestamp is within 5-minute window
   - Ensure HMAC signature is correct

3. **Database Connection Errors**
   - Verify all database URLs and tokens
   - Check network connectivity
   - Ensure databases are not rate-limited

4. **Slow Response Times**
   - Check performance metrics
   - Verify Redis cache is working
   - Check OpenAI API quotas
   - Monitor memory usage

### Debug Commands

```bash
# Check environment variables
env | grep -E "(TELEGRAM|OPENAI|SUPABASE|UPSTASH)"

# Test database connections
python -c "from storage.redis_store import RedisStore; r = RedisStore(); print(r.redis.ping())"

# Test vector store
python -c "from storage.vector_store import VectorStore; v = VectorStore(); print(v.index.info())"

# Check webhook registration
curl https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/getWebhookInfo
```

## Security Considerations

1. **Never commit secrets to git**
2. **Use environment variables for all sensitive data**
3. **Rotate secrets regularly**
4. **Use HMAC for request validation**
5. **Implement rate limiting**
6. **Monitor for suspicious activity**
7. **Keep dependencies updated**

## Support

For issues:
1. Check GitHub Issues
2. Review deployment logs
3. Contact team in Discord
4. Create detailed bug report with logs