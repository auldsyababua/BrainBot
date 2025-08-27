# Story 2.14: Complete Upstash Vector to Cloudflare Vectorize Migration

## Status
Draft

## Story
**As a** developer,
**I want** all vector search functionality migrated to Cloudflare Vectorize,
**so that** we have semantic search on the Cloudflare platform without Upstash dependencies.

## Acceptance Criteria
1. [ ] Replace all Upstash Vector client code with Cloudflare Vectorize API
2. [ ] Migrate existing vector embeddings to Vectorize index
3. [ ] Implement namespace isolation for multi-tenant support
4. [ ] Update embedding generation to use Vectorize-compatible format
5. [ ] Update environment variables from UPSTASH_VECTOR_* to CLOUDFLARE_VECTORIZE_*
6. [ ] Remove upstash-vector from requirements.txt
7. [ ] All vector search tests pass with Vectorize
8. [ ] Search accuracy and performance meet or exceed current metrics

## Tasks / Subtasks
- [ ] Task 1: Implement Cloudflare Vectorize client (AC: 1)
  - [ ] Create vectorize_store.py with Vectorize API client
  - [ ] Implement insert, update, delete, and query methods
  - [ ] Handle Vectorize index management
- [ ] Task 2: Migrate vector data (AC: 2, 3)
  - [ ] Export existing vectors from Upstash
  - [ ] Transform to Vectorize format if needed
  - [ ] Import vectors to Cloudflare Vectorize
  - [ ] Verify data integrity after migration
- [ ] Task 3: Update embedding pipeline (AC: 4)
  - [ ] Ensure embedding dimensions match Vectorize config
  - [ ] Update vector metadata format
  - [ ] Implement batch upload for efficiency
- [ ] Task 4: Update configuration (AC: 5, 6)
  - [ ] Update .env.example with Vectorize variables
  - [ ] Update render.yaml environment variables
  - [ ] Remove Upstash Vector dependencies
- [ ] Task 5: Testing and validation (AC: 7, 8)
  - [ ] Update unit tests for Vectorize
  - [ ] Run semantic search accuracy tests
  - [ ] Perform load testing for query performance

## Dev Notes

### Testing Standards
**From Architecture** [Source: architecture/coding-standards.md]
- Test files location: `tests/unit/` and `tests/integration/`
- Testing framework: pytest
- Mock external services in unit tests
- Use real test instances for integration tests

### Relevant Source Tree
[Source: architecture/source-tree.md]
- `src/flrts/storage/cloudflare_vector_store.py` - Existing CF vector implementation
- `src/flrts/migrations/migrate_to_vector.py` - Migration script to update
- `tests/test_cloudflare_vector_store.py` - Update tests
- `tests/integration/test_storage_integrations.py` - Integration tests

### Technical Context
[Source: architecture/tech-stack.md#Data & Storage]
- Current: Upstash Vector for semantic search
- Target: Cloudflare Vectorize for efficient semantic search
- Embedding model: sentence-transformers (unchanged)

### Cloudflare Vectorize Specifications
- Dimension support: up to 1536 dimensions
- Index types: HNSW (Hierarchical Navigable Small World)
- Metadata filtering support
- Namespace isolation for multi-tenancy
- REST API and Worker bindings
- Automatic scaling and replication

### Migration Considerations
- Vectorize uses different index structure than Upstash
- May need to adjust similarity thresholds
- Batch operations have different limits
- Consider re-indexing for optimal performance
- Metadata format may differ

### Previous Context
- cloudflare_vector_store.py already exists with partial implementation
- Need to complete migration from hybrid approach

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