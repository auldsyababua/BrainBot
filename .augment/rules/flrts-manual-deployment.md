# @deployment - Deployment Checklist and Guidelines
**Trigger:** Manual (use @deployment to activate)  
**Description:** Complete deployment checklist and procedures for FLRTS

## Pre-Deployment Checklist

### Code Readiness
- [ ] All tests passing: `pytest tests/`
- [ ] Code formatted: `black src/ --check`
- [ ] No linting errors
- [ ] Version updated in `src/core/version.py`
- [ ] CHANGELOG.md updated
- [ ] README.md reflects new features

### Environment Configuration
- [ ] Verify all environment variables in `.env`
- [ ] Check TELEGRAM_BOT_TOKEN is production token
- [ ] Verify OPENAI_API_KEY has sufficient credits
- [ ] Confirm database connection strings
- [ ] Check AUTHORIZED_USER_IDS list
- [ ] Verify webhook URL matches deployment

### Database Preparation
- [ ] Run database migrations
- [ ] Backup existing data
- [ ] Verify Supabase tables and RLS policies
- [ ] Check Redis connection and TTL settings
- [ ] Verify Vector store namespace configuration
- [ ] Test Neo4j graph connections (if used)

### Smart Rails Verification
- [ ] Test command routing (/commands)
- [ ] Verify @mention extraction
- [ ] Check confidence scoring thresholds
- [ ] Test token reduction metrics
- [ ] Verify prompt caching

### Webhook Configuration
- [ ] Set webhook URL: `python setup_webhook.py`
- [ ] Verify webhook is receiving messages
- [ ] Test webhook error handling
- [ ] Confirm SSL certificate is valid
- [ ] Check webhook timeout settings

### Render.com Specific
- [ ] Update render.yaml if needed
- [ ] Set environment variables in Render dashboard
- [ ] Configure health check endpoint
- [ ] Set appropriate instance type
- [ ] Configure auto-deploy from correct branch

## Deployment Steps

1. Create git tag: `git tag -a v1.x.x -m "Release version 1.x.x"`
2. Push to repository: `git push origin main --tags`
3. Trigger Render deployment (auto or manual)
4. Monitor deployment logs
5. Verify webhook configuration post-deploy

## Post-Deployment Verification

- [ ] Send test message to bot
- [ ] Verify bot responds correctly
- [ ] Check Smart Rails routing works
- [ ] Test critical commands
- [ ] Monitor error logs for 15 minutes
- [ ] Check performance metrics
- [ ] Verify audit logging to Supabase

## Monitoring Setup

- [ ] Check Supabase logs dashboard
- [ ] Monitor Render metrics
- [ ] Set up alerts for errors
- [ ] Verify backup automation
- [ ] Test rollback procedure

## Rollback Plan

1. Keep previous version tagged
2. Document breaking changes
3. Have rollback script ready
4. Know how to revert webhook
5. Keep database migration rollback scripts

## Critical Commands

```bash
# View logs
./scripts/deployment/botlogs.sh

# Restart bot
./scripts/deployment/bot-restart.sh

# Check webhook
python scripts/diagnostics/check_webhook.py

# Remote diagnostic
python scripts/diagnostics/remote_diagnostic.py
```