# Story 2.18: Complete Removal of Render References

## Status
Draft

## Story
**As a** developer,
**I want** all Render.com references completely removed from the codebase,
**so that** the project reflects our Cloudflare-first architecture with no legacy deployment configurations.

## Acceptance Criteria
1. [ ] Delete render.yaml deployment configuration
2. [ ] Remove all Render environment variables from documentation
3. [ ] Delete any Render-specific deployment scripts
4. [ ] Update all deployment documentation to Cloudflare-only
5. [ ] Remove Render references from README.md
6. [ ] Update GitHub Actions to remove Render deployment steps
7. [ ] Clean up diagnostic scripts that check Render services
8. [ ] Archive legacy deployment guides for historical reference

## Tasks / Subtasks
- [ ] Task 1: Remove configuration files (AC: 1)
  - [ ] Delete render.yaml from project root
  - [ ] Remove Render configs from any docker-compose files
  - [ ] Check for other Render-specific config files
- [ ] Task 2: Clean documentation (AC: 2, 4, 5)
  - [ ] Update README.md deployment section
  - [ ] Remove Render references from docs/architecture/
  - [ ] Update docs/setup/ guides
  - [ ] Clean deployment guides and references
- [ ] Task 3: Update CI/CD (AC: 6)
  - [ ] Remove Render deployment from GitHub Actions
  - [ ] Remove RENDER_API_KEY and RENDER_SERVICE_ID secrets
  - [ ] Update workflow to only deploy to Cloudflare
  - [ ] Test updated CI/CD pipeline
- [ ] Task 4: Clean diagnostic scripts (AC: 7)
  - [ ] Update scripts/diagnostics/check_render_*.sh
  - [ ] Remove Render monitoring scripts
  - [ ] Update health check scripts
  - [ ] Clean deployment verification scripts
- [ ] Task 5: Archive legacy guides (AC: 8)
  - [ ] Move old Render guides to archive/deployment/
  - [ ] Create README explaining historical context
  - [ ] Document what was removed and why

## Dev Notes

### Files Identified for Removal/Update

**Configuration Files:**
- `render.yaml` - Delete entirely
- `config/render.yaml` - Check if exists, remove
- Any references in docker-compose files

**Documentation Files:**
- `README.md` - Update deployment section (already partially done)
- `docs/architecture/*.md` - Remove Render references
- `docs/setup/*.md` - Update deployment guides
- Any standalone deployment guides

**Scripts and Automation:**
- `scripts/diagnostics/check_render_config.sh` - Remove or archive
- `scripts/diagnostics/check_render_logs.sh` - Remove or archive
- `scripts/deployment/deploy-render.sh` - Archive
- `scripts/deployment/render_env_setup.md` - Archive
- Any other Render-specific deployment scripts

**GitHub Workflows:**
- `.github/workflows/*.yml` - Remove Render deployment steps
- Update environment variables section
- Remove Render-specific secrets from documentation

**Environment Documentation:**
- Remove RENDER_* variables from .env.example
- Update GitHub secrets documentation
- Clean up environment setup guides

### Archive Strategy
1. Create `archive/deployment/render/` directory
2. Move (don't delete) historical deployment guides
3. Add README.md explaining what was archived and when
4. Keep git history for full traceability

### Commit Message Template
```
chore: Remove all Render.com references and configs

- Deleted render.yaml (migrated to Cloudflare Containers)
- Updated documentation to reflect Cloudflare-first deployment
- Removed Render deployment from CI/CD pipeline
- Archived legacy Render deployment guides
- Cleaned diagnostic scripts of Render dependencies

Part of Epic 2: Infrastructure consolidation on Cloudflare
```

### Verification Checklist
After completion, verify:
- [ ] No `render.yaml` file exists
- [ ] No Render references in README.md
- [ ] GitHub Actions workflows only deploy to Cloudflare
- [ ] No broken links in documentation
- [ ] All deployment guides point to Cloudflare
- [ ] Diagnostic scripts work without Render

## Change Log
| Date | Version | Description | Author |
|------|---------|-------------|--------|
| 2025-01-26 | 1.0 | Initial story creation | Scrum Master |

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