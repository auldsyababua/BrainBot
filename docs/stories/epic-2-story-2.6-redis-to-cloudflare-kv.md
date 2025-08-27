# Epic 2 - Story 2.6: Redis to Cloudflare KV Migration

**Priority:** HIGH - Cloudflare Migration Phase
**Points:** 8
**Dependencies:** Stories 2.1-2.5 (Cleanup phase should be complete)

## Git Workflow

**Branch Name:** `feature/story-2.6-cloudflare-kv-migration`
**PR Title:** `feat(epic-2): Story 2.6 - Migrate Redis to Cloudflare KV`

### Commit Guidelines
- Make regular commits as you work (every 30-60 mins or logical checkpoint)
- Use conventional commit format:
  - `feat: Add Cloudflare KV client implementation`
  - `refactor: Replace Redis calls with KV operations`
  - `test: Add KV storage unit tests`
  - `docs: Update storage documentation for KV`

## User Story
As a platform engineer, I need to migrate from Redis/Upstash to Cloudflare KV so that all data storage is within the Cloudflare ecosystem.

## Acceptance Criteria

### Required Changes
1. Implement Cloudflare KV storage client
2. Migrate all Redis operations to KV
3. Update environment variables
4. Migrate existing data
5. Remove Redis/Upstash dependencies

### Implementation Checklist
- [ ] Create `src/brainbot/storage/kv_store.py` with KV client
- [ ] Implement all Redis operations in KV:
  - [ ] get/set operations
  - [ ] TTL/expiration support
  - [ ] List operations (may need JSON serialization)
  - [ ] Atomic operations where needed
- [ ] Update all imports from `redis_store` to `kv_store`
- [ ] Migrate conversation history storage
- [ ] Migrate session storage
- [ ] Update configuration in `config.py`
- [ ] Remove Redis dependencies from requirements.txt

### Data Migration
```python
# Migration script outline
async def migrate_redis_to_kv():
    """Migrate all Redis data to Cloudflare KV"""
    # 1. Connect to both stores
    # 2. Iterate Redis keys
    # 3. Transform data if needed
    # 4. Write to KV with appropriate TTL
    # 5. Verify migration
    # 6. Document migrated keys
```

### Environment Variable Changes
```bash
# Remove
REDIS_URL=...
UPSTASH_REDIS_REST_URL=...
UPSTASH_REDIS_REST_TOKEN=...

# Add
CLOUDFLARE_KV_NAMESPACE_ID=...
CLOUDFLARE_KV_API_TOKEN=...
CLOUDFLARE_ACCOUNT_ID=...
```

## Testing Requirements

### Unit Tests
- [ ] Test all KV operations
- [ ] Test TTL/expiration
- [ ] Test error handling
- [ ] Test connection resilience

### Integration Tests
- [ ] Test conversation storage
- [ ] Test session management
- [ ] Test concurrent access
- [ ] Test data persistence

## QA Merge Criteria

**This PR can be merged when:**
1. ✅ All Redis operations successfully migrated to KV
2. ✅ Zero Redis imports remain (`grep -r "redis_store" src/` returns nothing)
3. ✅ All tests pass with KV backend
4. ✅ Data migration script tested and documented
5. ✅ Performance benchmarks show acceptable latency
6. ✅ Environment variables updated in all configs
7. ✅ Self-hosted runner tests pass

**To QA Team:** 
- Create quality gate file: `docs/qa/story-2.6-quality-gate.md`
- Test conversation persistence across restarts
- Verify no data loss during migration
- Performance test KV operations vs Redis baseline
- Document any behavioral differences
- Verify all Redis references removed

**To Dev Team:**
- Commit after each major component (client, migration, tests)
- Test locally with real Cloudflare KV before pushing
- Document any KV limitations discovered
- Create rollback plan in case of issues
- Update all relevant documentation

## Rollback Plan
1. Keep Redis code in a feature flag initially
2. Document how to switch back if needed
3. Keep Redis data backup for 30 days

## Definition of Done
- [ ] KV client fully implemented
- [ ] All Redis operations migrated
- [ ] Data migration completed
- [ ] Tests passing with KV
- [ ] Documentation updated
- [ ] Performance acceptable
- [ ] QA quality gate file created
- [ ] PR merged to main
- [ ] Redis dependencies removed