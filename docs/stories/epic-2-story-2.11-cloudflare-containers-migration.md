# Story 2.11: Backend Cloudflare Containers Migration

**Priority:** HIGH
**Points:** 13
**Status:** In Progress
**Branch:** feature/cloudflare-migration

## User Story
As a system architect, I need the FastAPI backend migrated from legacy hosting to Cloudflare Containers so we have a fully Cloudflare-native architecture with zero refactoring needed for our existing Python codebase.

## Problem
The FastAPI backend needs to be migrated to complete our Cloudflare-first strategy. This will:
- Unify all infrastructure under Cloudflare
- Reduce latency between services
- Simplify deployment and management
- Reduce operational costs
- Enable better integration with Cloudflare's edge services

## Current Architecture
- FastAPI application (Python)
- PostgreSQL database connections (Supabase)
- Webhook handling for Telegram
- RESTful API endpoints
- Memory management with mem0

## Target Architecture
- **Cloudflare Containers** running the existing FastAPI application unchanged
- **Cloudflare KV** for caching
- **Cloudflare R2** for media storage
- **Cloudflare Vectorize** for vector search
- **Cloudflare Pages** for Telegram Mini App
- **Supabase PostgreSQL** remains as primary database

## Implementation Phases

### Phase 1: Preparation (2 points) ✅ COMPLETED
1. ✅ Remove all Upstash Redis dependencies
2. ✅ Remove all Upstash Vector dependencies
3. ✅ Remove all AWS S3/boto3 dependencies
4. ✅ Update documentation to reflect Cloudflare services
5. ✅ Configure environment variables for Cloudflare

### Phase 2: Container Setup (3 points) - IN PROGRESS
1. Create Dockerfile for FastAPI application (existing)
2. Configure Cloudflare Container deployment
3. Set up environment variables in Cloudflare
4. Configure database connections to Supabase
5. Set up health check endpoints

### Phase 3: Service Integration (4 points)
1. Connect to Cloudflare KV for caching
2. Connect to Cloudflare R2 for media storage
3. Connect to Cloudflare Vectorize for vector operations
4. Configure Telegram webhook to point to Container URL
5. Test all API endpoints

### Phase 4: Migration & Testing (3 points)
1. Deploy to Cloudflare Containers
2. Run smoke tests on all endpoints
3. Perform load testing
4. Update DNS/routing as needed
5. Monitor for 24-48 hours

### Phase 5: Cleanup (1 point)
1. Decommission old hosting infrastructure
2. Update all documentation
3. Remove legacy configuration files
4. Archive old deployment scripts

## Key Advantages of Containers over Workers

1. **Zero Code Changes**: Run existing FastAPI Python code as-is
2. **Full Python Support**: All Python libraries work without modification
3. **Database Connections**: Can maintain persistent connections
4. **Long-running Tasks**: No 30-second CPU limit
5. **File System Access**: Full file system available if needed
6. **Gradual Migration**: Can migrate at our own pace

## Container Configuration

```dockerfile
# Existing Dockerfile can be used unchanged
FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

## Environment Variables to Configure

```env
# Cloudflare Services
CLOUDFLARE_KV_NAMESPACE_ID=xxx
CLOUDFLARE_R2_BUCKET=brainbot-media
CLOUDFLARE_R2_ACCESS_KEY=xxx
CLOUDFLARE_R2_SECRET_KEY=xxx
CLOUDFLARE_VECTORIZE_INDEX=brainbot-docs
CLOUDFLARE_ACCOUNT_ID=xxx

# Existing Services (unchanged)
SUPABASE_URL=xxx
SUPABASE_KEY=xxx
TELEGRAM_BOT_TOKEN=xxx
OPENAI_API_KEY=xxx
NEO4J_URI=xxx
NEO4J_USERNAME=xxx
NEO4J_PASSWORD=xxx
```

## Files to Update

### Must Update
- `src/flrts/storage/redis_store.py` → Use Cloudflare KV
- `src/flrts/storage/vector_store.py` → Use Cloudflare Vectorize  
- `src/flrts/storage/media_storage.py` → Use Cloudflare R2
- `.env.example` → Remove AWS/Upstash, add Cloudflare vars
- `requirements.txt` → Remove boto3, redis-py, upstash-vector

### Already Compatible
- `main.py` - No changes needed
- `src/flrts/processors/` - No changes needed
- `src/flrts/rails/` - No changes needed
- Database connections - Continue using Supabase

## Acceptance Criteria
- [ ] FastAPI application runs on Cloudflare Containers
- [ ] All API endpoints functional
- [ ] Cloudflare KV integration working
- [ ] Cloudflare R2 media storage working
- [ ] Cloudflare Vectorize search working
- [ ] Performance meets or exceeds current metrics
- [ ] Zero downtime during migration
- [ ] All tests passing
- [ ] Documentation updated

## Success Metrics
- Response time: <100ms p50, <300ms p95
- Availability: 99.9% uptime
- Cost: Reduced by 40%+ vs multiple providers
- Deploy time: <2 minutes
- Cold start: Not applicable (containers stay warm)

## Migration Commands

```bash
# Deploy to Cloudflare Containers
wrangler deploy --compatibility-date=2024-01-01

# Check deployment status
wrangler tail

# Update Telegram webhook
curl -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/setWebhook" \
  -H "Content-Type: application/json" \
  -d '{"url": "https://flrts.{account}.containers.cloudflare.com/webhook"}'
```

## Rollback Plan
1. Keep existing infrastructure running in parallel
2. Use DNS/routing to switch traffic
3. If issues arise, switch back immediately
4. No data migration required (using same Supabase)

## Developer Notes
- Cloudflare Containers support full Python runtime
- No code refactoring needed - lift and shift approach
- Can use existing CI/CD pipelines with minor updates
- Monitoring available through Cloudflare dashboard
- Automatic SSL/TLS termination included
- DDoS protection included by default

### Status
Approved - High Priority