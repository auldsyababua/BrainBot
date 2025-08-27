# Story 2.16: Complete Removal of AWS and Upstash References

## Status
Draft

## Story
**As a** developer,
**I want** all AWS S3 and Upstash references completely removed from the codebase,
**so that** the project is clean, maintainable, and has no dead code or confusing legacy references.

## Acceptance Criteria
1. [ ] Remove all Upstash Redis references from code and documentation
2. [ ] Remove all Upstash Vector references from code and documentation
3. [ ] Remove all AWS S3 references from code and documentation
4. [ ] Delete or archive legacy migration scripts
5. [ ] Remove all related environment variables from configs
6. [ ] Update all documentation to reflect Cloudflare-only infrastructure
7. [ ] Remove unused dependencies from requirements.txt
8. [ ] All tests pass without any AWS/Upstash references

## Tasks / Subtasks
- [ ] Task 1: Clean source code (AC: 1, 2, 3)
  - [ ] Remove Upstash references from src/brainbot/storage/
  - [ ] Remove AWS references from media_storage.py
  - [ ] Update storage_service.py to remove legacy code
  - [ ] Clean up migration scripts in src/brainbot/migrations/
- [ ] Task 2: Clean test files (AC: 8)
  - [ ] Delete test_s3_connection.py
  - [ ] Update test_storage_integrations.py
  - [ ] Update test_all_storage.py
  - [ ] Remove Upstash mocks from test fixtures
- [ ] Task 3: Update documentation (AC: 6)
  - [ ] Update README.md
  - [ ] Clean docs/architecture/*.md files
  - [ ] Update docs/prd/*.md files
  - [ ] Clean docs/operations/ references
  - [ ] Update setup guides
- [ ] Task 4: Clean configuration (AC: 5, 7)
  - [ ] Remove from .env.example
  - [ ] Clean render.yaml
  - [ ] Update GitHub secrets documentation
  - [ ] Remove from docker-compose files
  - [ ] Update requirements.txt
- [ ] Task 5: Archive legacy code (AC: 4)
  - [ ] Move migration scripts to archive/
  - [ ] Document why code was removed in CHANGELOG
  - [ ] Create git commit with clear message

## Dev Notes

### Files Identified for Cleanup

**Source Code Files:**
- `src/brainbot/storage/media_storage.py` - Remove boto3/S3 code
- `src/brainbot/storage/redis_store.py` - Remove Upstash Redis references
- `src/brainbot/core/memory.py` - Check for Upstash references
- `src/brainbot/migrations/migrate_to_vector.py` - Archive or update
- `src/brainbot/storage/cloudflare_cache.py` - Remove Upstash mentions
- `src/brainbot/storage/storage_service.py` - Clean legacy code

**Test Files:**
- `tests/integration/test_s3_connection.py` - Delete entirely
- `tests/integration/test_media_storage.py` - Update to R2 only
- `tests/integration/test_storage_integrations.py` - Remove AWS/Upstash tests
- `tests/system/test_all_storage.py` - Update integration tests
- `tests/integration/test_graph_memory_integration.py` - Check for references
- `tests/README.md` - Update documentation

**Documentation Files:**
- `README.md` - Already partially updated, complete cleanup
- `docs/architecture/core-components.md` - Already updated
- `docs/architecture/data-flow-and-integration.md` - Already updated
- `docs/operations/memory-configuration/*.md` - Multiple files need cleanup
- `docs/prd/flrts-brainbot-brownfield-prd.md` - Keep migration notes
- `docs/prd/epic-1-cloudflare-migration.md` - Historical record, keep
- `docs/setup/github-secrets.md` - Already updated
- `docs/technical/*.md` - Check and update

**Configuration Files:**
- `config/.coderabbit.yaml` - Remove Upstash rules
- `scripts/database/create_document_storage_tables.sql` - Check for references
- `scripts/diagnostics/*.py` - Multiple diagnostic scripts to update
- Various shell scripts in `scripts/diagnostics/`

**Other Files:**
- `web-bundles/expansion-packs/bmad-infrastructure-devops/agents/infra-devops-platform.txt`
- `testsprite_tests/README_ANTI_MESA.md`

### Migration Archive Strategy
1. Create `archive/migrations/` directory
2. Move legacy migration scripts with README explaining history
3. Keep git history for full traceability

### Commit Message Template
```
chore: Remove all AWS S3 and Upstash references

- Completed migration to Cloudflare KV (replacing Upstash Redis)
- Completed migration to Cloudflare Vectorize (replacing Upstash Vector)  
- Completed migration to Cloudflare R2 (replacing AWS S3)
- Removed all legacy code, tests, and documentation
- Archived migration scripts for historical reference

Part of Epic 2: Code Quality improvements
```

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