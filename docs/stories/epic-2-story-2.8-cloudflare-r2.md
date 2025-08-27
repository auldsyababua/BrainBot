# Story 2.15: Complete AWS S3 to Cloudflare R2 Migration

## Status
Draft

## Story
**As a** developer,
**I want** all media storage functionality migrated from AWS S3 to Cloudflare R2,
**so that** we have object storage on Cloudflare with S3-compatible API and no AWS dependencies.

## Acceptance Criteria
1. [ ] Replace boto3 S3 client with Cloudflare R2 client
2. [ ] Migrate all existing media files from S3 to R2
3. [ ] Update file upload/download logic for R2
4. [ ] Implement R2 public access for media serving
5. [ ] Update environment variables from AWS_* to CLOUDFLARE_R2_*
6. [ ] Remove boto3 from requirements.txt
7. [ ] All media storage tests pass with R2
8. [ ] File operations performance meets or exceeds S3 metrics

## Tasks / Subtasks
- [ ] Task 1: Implement Cloudflare R2 client (AC: 1, 3)
  - [ ] Update media_storage.py to use R2 S3-compatible API
  - [ ] Configure R2 client with proper credentials
  - [ ] Implement upload, download, delete methods
  - [ ] Handle R2-specific features (public URLs, caching)
- [ ] Task 2: Migrate existing media (AC: 2)
  - [ ] Inventory all S3 objects
  - [ ] Create R2 bucket with proper configuration
  - [ ] Batch transfer files from S3 to R2
  - [ ] Verify file integrity after migration
- [ ] Task 3: Configure public access (AC: 4)
  - [ ] Set up R2 public bucket access
  - [ ] Configure CORS for browser uploads
  - [ ] Implement signed URLs for private content
- [ ] Task 4: Update configuration (AC: 5, 6)
  - [ ] Update .env.example with R2 variables
  - [ ] Update render.yaml environment variables
  - [ ] Remove AWS SDK dependencies
- [ ] Task 5: Testing and validation (AC: 7, 8)
  - [ ] Update unit tests for R2 implementation
  - [ ] Test file upload/download/delete operations
  - [ ] Verify public URL generation
  - [ ] Performance testing for large files

## Dev Notes

### Testing Standards
**From Architecture** [Source: architecture/coding-standards.md]
- Test files location: `tests/unit/` and `tests/integration/`
- Testing framework: pytest
- Mock external services in unit tests
- Use real test instances for integration tests

### Relevant Source Tree
[Source: architecture/source-tree.md]
- `src/flrts/storage/media_storage.py` - Primary file to modify
- `tests/integration/test_media_storage.py` - Update tests
- `tests/integration/test_s3_connection.py` - Remove or update
- `tests/system/test_all_storage.py` - Update integration

### Technical Context
[Source: architecture/tech-stack.md#Data & Storage]
- Current: AWS S3 (via boto3) for media storage
- Target: Cloudflare R2 for object storage
- R2 provides S3-compatible API

### Cloudflare R2 Specifications
- S3-compatible API (can use boto3 with endpoint override)
- Zero egress fees
- Automatic replication across regions
- Public bucket support with custom domains
- Signed URL support for temporary access
- Maximum object size: 5TB
- Worker bindings for direct access

### Migration Considerations
- R2 uses S3-compatible API, minimal code changes needed
- Update endpoint URL in boto3 client configuration
- Consider using R2's public bucket feature for media
- Leverage R2's automatic caching at edge
- No need to change bucket naming conventions

### Implementation Notes
- Can continue using boto3 with endpoint_url override
- Or use official Cloudflare SDK for additional features
- Public URLs format: `https://pub-{hash}.r2.dev/{key}`
- Consider R2's automatic image optimization features

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