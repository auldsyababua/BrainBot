# Cloudflare Migration Phase 1 - Deployment Checklist

## Pre-Deployment Verification

### 1. Code Review
- [ ] Review all changes in `feat/cf-migration-phase1` branch
- [ ] Verify no sensitive data is hardcoded
- [ ] Check that all tests pass locally
- [ ] Ensure CI/CD workflows are configured correctly

### 2. Infrastructure Readiness
- [ ] Cloudflare Workers deployed and accessible:
  - `brainbot-webhook` at https://brainbot-webhook.colin-c4d.workers.dev
  - `brainbot-consumer` at https://brainbot-consumer.colin-c4d.workers.dev
- [ ] Cloudflare Queue `brainbot-updates` created
- [ ] KV namespace `BRAINBOT_KV` provisioned
- [ ] R2 bucket `BRAINBOT_MEDIA` created
- [ ] Vectorize index configured

### 3. Secrets Configuration
- [ ] Cloudflare Workers have required secrets:
  - `TELEGRAM_WEBHOOK_SECRET` (webhook worker)
  - `CF_PROXY_SECRET` (consumer worker)
- [ ] GitHub Actions secrets configured:
  - `CLOUDFLARE_API_TOKEN`
  - `RENDER_API_KEY`
  - `RENDER_SERVICE_ID`

---

## Deployment Steps

### Step 1: Merge to Main Branch
```bash
./scripts/deploy_phase1.sh
```

**Actions performed:**
- Fetches latest changes
- Merges `feat/cf-migration-phase1` to `main`
- Pushes to origin/main
- Triggers automatic Render deployment

**Expected duration:** 1-2 minutes

### Step 2: Configure Render Environment Variable

**Navigate to:** https://dashboard.render.com

1. Select service: `markdown-brain-bot` (or `brainbot-v76n`)
2. Go to: Environment → Environment Variables
3. Add new variable:
   - **Key:** `CF_PROXY_SECRET`
   - **Value:** `8f84125f867d95cd22c5906640f2f6a8badc37ad5136669d04d134ea7df58ab4`
4. Click "Save Changes"

**Expected duration:** 2-3 minutes for redeploy

### Step 3: Verify Deployment
```bash
./scripts/verify_migration.sh
```

**Checks performed:**
- `/process` endpoint exists (expects 401)
- Cloudflare Workers are responsive
- Telegram webhook configuration
- Git merge status

---

## Post-Deployment Verification

### 1. Endpoint Health Checks

#### Python Backend
```bash
# Should return 401 (endpoint exists, auth required)
curl -X POST https://brainbot-v76n.onrender.com/process \
  -H "Content-Type: application/json" \
  -d '{"test": true}'
```

#### Main Health Check
```bash
# Should return 200 OK
curl https://brainbot-v76n.onrender.com/health
```

### 2. Monitor Deployment Logs

**Render Dashboard:**
- Check service logs for startup errors
- Verify environment variables loaded
- Confirm `/process` endpoint registered

**GitHub Actions:**
- Monitor deployment workflow: https://github.com/colinaulds/flrts/actions
- Check health monitoring alerts

### 3. Test Bot Functionality
1. Send test message to bot
2. Verify response received
3. Check latency and performance

---

## Rollback Procedure

If issues occur after deployment:

### Immediate Rollback
```bash
./scripts/rollback_phase1.sh
```

**Actions:**
- Reverts main branch to pre-Phase 1 state
- Force pushes to trigger redeployment
- Bot returns to direct webhook mode

### Manual Rollback Steps
1. **Identify last safe commit:**
   ```bash
   git log --oneline main | grep -v "cf-migration\|Cloudflare\|/process" | head -1
   ```

2. **Reset main branch:**
   ```bash
   git checkout main
   git reset --hard <SAFE_COMMIT_HASH>
   git push origin main --force-with-lease
   ```

3. **Wait for Render redeploy** (2-3 minutes)

---

## Monitoring & Alerts

### Automated Monitoring
- GitHub Actions runs health checks every 5 minutes
- Creates issues automatically on failures
- Monitors `/process` endpoint availability

### Manual Monitoring Commands

**Check Worker Logs:**
```bash
npx wrangler tail brainbot-webhook
npx wrangler tail brainbot-consumer
```

**View Queue Status:**
```bash
npx wrangler queues list
```

**Test HMAC Validation:**
```bash
python scripts/test_process_endpoint.py
```

---

## Troubleshooting Guide

### Issue: /process returns 404
**Cause:** Python backend not deployed with new endpoint
**Fix:** 
1. Verify merge completed successfully
2. Check Render deployment logs
3. Ensure `src/bot/webhook_bot.py` includes `/process` route

### Issue: HMAC validation fails
**Cause:** Secret mismatch between Cloudflare and Render
**Fix:**
1. Verify `CF_PROXY_SECRET` matches exactly in both environments
2. Check for trailing spaces or newlines
3. Ensure timestamps are synchronized (5-minute window)

### Issue: Messages not processing
**Cause:** Queue not consuming or worker errors
**Fix:**
1. Check queue backlog: `npx wrangler queues list`
2. View consumer logs: `npx wrangler tail brainbot-consumer`
3. Verify consumer has correct PROCESS_URL configured

### Issue: High latency
**Cause:** Cold starts or network issues
**Fix:**
1. Check worker performance metrics
2. Verify Render service is not sleeping
3. Consider upgrading Render plan for always-on service

---

## Success Criteria

Phase 1 deployment is successful when:

- [ ] `/process` endpoint returns 401 for unauthorized requests
- [ ] Cloudflare Workers show active traffic in dashboard
- [ ] Bot responds to messages within 2 seconds
- [ ] No error alerts in monitoring system
- [ ] Health checks pass consistently for 30 minutes

---

## Next Steps After Success

1. **Update Telegram Webhook** (Phase 1.5):
   - Point webhook to Cloudflare Worker instead of Render
   - Run webhook update script

2. **Performance Baseline**:
   - Document response times
   - Monitor queue processing rates
   - Track error rates

3. **Prepare Phase 2**:
   - Plan edge logic implementation
   - Design caching strategy
   - Prepare storage migration scripts

---

## Contact & Escalation

**Primary Contact:** Colin Aulds
**Backup:** Check Render and Cloudflare dashboards

**Service URLs:**
- Render Dashboard: https://dashboard.render.com
- Cloudflare Dashboard: https://dash.cloudflare.com
- GitHub Actions: https://github.com/colinaulds/flrts/actions

**Emergency Contacts:**
- Render Support (if service issues)
- Cloudflare Support (if worker issues)

---

_Last Updated: August 2025_
_Phase: Cloudflare Migration Phase 1 - Proxy Mode_