# Story 2.13: Complete Upstash Redis to Cloudflare KV Migration

## Status
Draft

## Story
**As a** developer,
**I want** all Redis caching functionality migrated to Cloudflare KV,
**so that** we have a unified Cloudflare infrastructure and eliminate Upstash dependencies.

## Acceptance Criteria
1. [ ] Replace all Upstash Redis client code with Cloudflare KV client
2. [ ] Migrate session management to Cloudflare KV
3. [ ] Update cache TTL configurations for KV compatibility
4. [ ] Ensure all cached data patterns work with KV's eventual consistency model
5. [ ] Update environment variables from UPSTASH_REDIS_* to CLOUDFLARE_KV_*
6. [ ] Remove redis-py and upstash-redis from requirements.txt
7. [ ] All existing tests pass with KV implementation
8. [ ] Performance meets or exceeds current Redis metrics

## Tasks / Subtasks
- [ ] Task 1: Update redis_store.py to use Cloudflare KV API (AC: 1, 2)
  - [ ] Replace Redis client with Cloudflare KV client
  - [ ] Implement KV-compatible session storage methods
  - [ ] Handle KV's 1MB value limit (split large data if needed)
- [ ] Task 2: Refactor caching patterns for KV compatibility (AC: 3, 4)
  - [ ] Convert Redis TTL patterns to KV expiration
  - [ ] Handle eventual consistency in cache reads
  - [ ] Implement cache warming strategies where needed
- [ ] Task 3: Update configuration and dependencies (AC: 5, 6)
  - [ ] Update .env.example with KV variables
  - [ ] Update render.yaml environment variables
  - [ ] Remove Redis dependencies from requirements.txt
- [ ] Task 4: Testing and validation (AC: 7, 8)
  - [ ] Update unit tests for KV implementation
  - [ ] Run integration tests with test KV namespace
  - [ ] Perform load testing to verify performance

## Dev Notes

### Testing Standards
**From Architecture** [Source: architecture/coding-standards.md]
- Test files location: `tests/unit/` and `tests/integration/`
- Testing framework: pytest
- Mock external services in unit tests
- Use real test instances for integration tests

### Relevant Source Tree
[Source: architecture/source-tree.md]
- `src/brainbot/storage/redis_store.py` - Primary file to modify
- `src/brainbot/storage/cloudflare_cache.py` - Reference implementation
- `src/brainbot/storage/storage_service.py` - Update cache integration
- `tests/unit/test_redis_store.py` - Update tests
- `tests/integration/test_storage_integrations.py` - Integration tests

### Technical Context
[Source: architecture/tech-stack.md#Data & Storage]
- Current: Upstash Redis for caching
- Target: Cloudflare KV for key-value store caching
- Database remains Supabase PostgreSQL

### Cloudflare KV Specifications
- Maximum value size: 25 MB (but 1 MB recommended)
- Maximum key size: 512 bytes
- Eventual consistency model (typically <60 seconds)
- TTL support via expiration timestamps
- REST API and Worker bindings available

### Migration Considerations
- KV uses eventual consistency vs Redis' strong consistency
- No support for complex data types (lists, sets, sorted sets)
- All values are strings (JSON serialization required)
- Consider using Durable Objects for strong consistency if needed

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