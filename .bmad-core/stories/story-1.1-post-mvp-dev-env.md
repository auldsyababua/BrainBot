# Story 1.1: Establish Post-MVP Dev Env

## Status: Ready for Review

## Story
As a founder, I want a separate preview environment with its own database and services, so that I can safely test new features after the MVP is launched without affecting the production application.

## Acceptance Criteria
1. A `develop` branch is created in the Git repository to serve as the integration branch for new features.
2. A process is documented for provisioning separate Supabase and Cloudflare instances for the preview environment.
3. The GitHub Actions workflow is updated to deploy the `develop` branch to the preview environment.

## Tasks / Subtasks
- [x] Git Setup (AC: #1)
  - Created `develop` branch
- [x] Documentation (AC: #2)
  - Created comprehensive environment setup guide at `docs/ENVIRONMENT_SETUP.md`
- [x] CI/CD Pipeline (AC: #3)
  - Created `.github/workflows/preview-deploy.yml` for develop branch
  - Created `.github/workflows/production-deploy.yml` for main branch

## Dev Agent Record

### Agent Model Used
Claude Opus 4.1

### Debug Log References
- Successfully created develop branch
- Documentation created with detailed setup instructions
- GitHub Actions workflows configured for both environments

### Completion Notes
- Develop branch established as integration branch
- Comprehensive documentation for environment provisioning
- Separate CI/CD pipelines for preview and production
- Health checks and integration tests included
- Rollback considerations documented

### File List
- Created: `docs/prd/flrts-brainbot-brownfield-prd.md`
- Created: `docs/architecture/flrts-brainbot-architecture.md`
- Created: `docs/ENVIRONMENT_SETUP.md`
- Created: `.github/workflows/preview-deploy.yml`
- Created: `.github/workflows/production-deploy.yml`
- Created: `.bmad-core/stories/story-1.1-post-mvp-dev-env.md`

### Change Log
| Date | Developer | Changes |
|------|-----------|---------|
| 2025-08-18 | James | Initial implementation of Story 1.1 |
| 2025-08-18 | James | Added BMAD documentation (PRD and Architecture) |
| 2025-08-18 | James | Created develop branch and CI/CD pipelines |

## Testing
- Branch creation verified
- Documentation completeness checked
- GitHub Actions syntax validated
- Environment variable requirements documented

## Dev Notes
The preview environment setup requires the following secrets to be configured in GitHub:
- `DEV_SUPABASE_URL`
- `DEV_SUPABASE_ANON_KEY`
- `RENDER_PREVIEW_DEPLOY_HOOK`
- `PREVIEW_URL`
- `DEV_TELEGRAM_BOT_TOKEN`

For production:
- `SUPABASE_URL`
- `SUPABASE_ANON_KEY`
- `RENDER_PRODUCTION_DEPLOY_HOOK`
- `PRODUCTION_URL`