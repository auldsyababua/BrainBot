# Story 2.17: Complete Infrastructure Migration to Cloudflare Containers

## Status
Draft

## Story
**As a** developer,
**I want** the entire FastAPI backend migrated from Render to Cloudflare Containers,
**so that** we have a fully unified Cloudflare infrastructure with zero refactoring needed.

## Acceptance Criteria
1. [ ] Create separate branch `feature/cloudflare-migration` for safety
2. [ ] Backend (FastAPI) deploys successfully to Cloudflare Containers
3. [ ] Frontend (telegram-mini-app) deploys to Cloudflare Pages
4. [ ] All webhook endpoints working correctly
5. [ ] Telegram bot fully functional
6. [ ] All environment variables migrated to Cloudflare
7. [ ] Update GitHub Actions to deploy to Cloudflare
8. [ ] Zero downtime during migration
9. [ ] Test rollback procedure documented and verified

## Tasks / Subtasks
- [ ] Task 1: Setup Cloudflare Container Configuration (AC: 1, 2)
  - [ ] Create feature/cloudflare-migration branch
  - [ ] Create/update Dockerfile for FastAPI application
  - [ ] Configure wrangler.toml for container deployment
  - [ ] Set up environment variables in Cloudflare dashboard
  - [ ] Test local Docker build
- [ ] Task 2: Frontend Migration to Cloudflare Pages (AC: 3)
  - [ ] Configure Pages build settings
  - [ ] Set up environment variables for frontend
  - [ ] Update API endpoints to point to Containers
  - [ ] Test build and deployment pipeline
- [ ] Task 3: Webhook and Integration Testing (AC: 4, 5)
  - [ ] Deploy to Cloudflare Containers
  - [ ] Update Telegram webhook URL
  - [ ] Test all API endpoints
  - [ ] Verify bot message handling
  - [ ] Test Mini App integration
- [ ] Task 4: CI/CD Pipeline Updates (AC: 7)
  - [ ] Update GitHub Actions workflow
  - [ ] Configure Cloudflare API tokens
  - [ ] Set up automatic deployment on merge
  - [ ] Test full deployment pipeline
- [ ] Task 5: Migration and Rollback Testing (AC: 8, 9)
  - [ ] Document rollback procedure
  - [ ] Keep Render running in parallel during migration
  - [ ] Test DNS switching between services
  - [ ] Monitor for 24-48 hours after migration
  - [ ] Document post-migration checklist

## Dev Notes

### Implementation Details from Handoff
**Cloudflare Container Configuration:**
```dockerfile
# Dockerfile (minimal changes to existing)
FROM python:3.11-slim
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

**wrangler.toml:**
```toml
name = "flrts-backend"
main = "src/index.js"  # Small Worker to route to container

[[containers]]
name = "fastapi"
image = "./Dockerfile"
```

### Key Advantages of Containers over Workers
- **Zero Code Changes**: Run existing FastAPI Python code as-is
- **Full Python Support**: All Python libraries work without modification
- **Database Connections**: Can maintain persistent connections
- **Long-running Tasks**: No 30-second CPU limit
- **File System Access**: Full file system available if needed
- **Gradual Migration**: Can migrate at our own pace

### Environment Variables to Configure
```env
# Cloudflare Services (already configured in previous stories)
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

### Risk Mitigation Strategy
- **CRITICAL**: Use separate branch `feature/cloudflare-migration`
- Keep Render deployment running until Cloudflare is verified
- Use DNS/routing to switch traffic between services
- Document rollback procedure before starting
- Test thoroughly before merging to develop

### Success Metrics
- Response time: <100ms p50, <300ms p95
- Availability: 99.9% uptime
- Deploy time: <2 minutes
- Cold start: Not applicable (containers stay warm)

### Dependencies
- Stories 2.13, 2.14, 2.15 must be completed first
- Cloudflare account with Containers beta access
- Wrangler CLI configured locally
- Docker installed for local builds

## Change Log
| Date | Version | Description | Author |
|------|---------|-------------|--------|
| 2025-01-26 | 1.0 | Initial story creation from architect handoff | Scrum Master |

## Dev Agent Record

### Agent Model Used
(To be filled by Dev Agent)

### Debug Log References
(To be filled by Dev Agent)

### Completion Notes List
(To be filled by Dev Agent)

### File List
(To be filled by Dev Agent)

## QA Results
(To be filled by QA Agent)