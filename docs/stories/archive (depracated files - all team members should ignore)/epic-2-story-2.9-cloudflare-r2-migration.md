# Story 2.9: Cloudflare R2 Migration

**Priority:** COMPLETED ✅
**Points:** 8
**Status:** DONE

## User Story
As a system architect, I needed all media storage migrated from AWS S3 to Cloudflare R2 to maintain our Cloudflare-first architecture and reduce vendor dependencies.

## Problem (RESOLVED)
`media_storage.py` was using boto3 and AWS S3, violating our Cloudflare-first architecture principle. This has been fully migrated to Cloudflare R2.

## Current State
- Media storage using boto3 and AWS S3
- AWS credentials required in environment
- Inconsistent with rest of Cloudflare infrastructure

## Target State
- All media storage on Cloudflare R2
- No AWS dependencies
- Consistent Cloudflare-first architecture

## Implementation Tasks

### Phase 1: R2 Setup
1. Create Cloudflare R2 bucket
2. Configure R2 access credentials
3. Set up CORS policies if needed
4. Configure lifecycle rules

### Phase 2: Code Migration
1. Replace boto3 with Cloudflare R2 API client
2. Update `media_storage.py` methods:
   - `upload_file()` → R2 upload
   - `download_file()` → R2 download
   - `delete_file()` → R2 delete
   - `list_files()` → R2 list objects
3. Update environment variables:
   - Remove AWS_ACCESS_KEY_ID
   - Remove AWS_SECRET_ACCESS_KEY
   - Add CLOUDFLARE_R2_ACCESS_KEY
   - Add CLOUDFLARE_R2_SECRET_KEY
   - Add CLOUDFLARE_R2_BUCKET

### Phase 3: Data Migration
1. List all objects in S3 bucket
2. Download and upload to R2
3. Verify data integrity
4. Update any stored URLs/references

### Phase 4: Cleanup
1. Remove boto3 from requirements.txt
2. Remove AWS configuration code
3. Update deployment documentation
4. Decommission S3 bucket after verification

## Files to Update
- `src/brainbot/storage/media_storage.py` - Complete rewrite
- `requirements.txt` - Remove boto3, add R2 client
- `.env.example` - Update environment variables
- Deployment configurations
- Documentation

## Acceptance Criteria
- [ ] No AWS/boto3 dependencies remain
- [ ] All media operations use Cloudflare R2
- [ ] Existing files successfully migrated
- [ ] Upload functionality works correctly
- [ ] Download functionality works correctly
- [ ] Delete functionality works correctly
- [ ] List functionality works correctly
- [ ] Performance meets or exceeds S3
- [ ] Cost reduced or comparable

## Rollback Plan
1. Keep S3 bucket intact for 30 days
2. Maintain mapping of migrated files
3. Feature flag for storage backend
4. Quick switch back if issues arise

## Developer Notes
- R2 is S3-compatible but check for API differences
- Consider using Workers for signed URL generation
- R2 has no egress fees (cost advantage)
- Test with various file sizes and types
- Ensure proper error handling for R2-specific errors

### Status
Approved
