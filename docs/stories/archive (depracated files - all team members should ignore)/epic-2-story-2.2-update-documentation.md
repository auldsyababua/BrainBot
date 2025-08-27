# Epic 2 - Story 2.2: Update All Documentation

**Priority:** HIGH - Cleanup Phase
**Points:** 5
**Dependencies:** Story 2.1 (Cleanup Test Artifacts)

## Git Workflow

**Branch Name:** `feature/story-2.2-update-documentation`
**PR Title:** `docs(epic-2): Story 2.2 - Update all documentation to reflect current stack`

### Commit Guidelines
- Make regular commits as you work (every 30-60 mins or logical checkpoint)
- Use conventional commit format:
  - `docs: Remove AWS references from README`
  - `docs: Update deployment guide for Cloudflare`
  - `docs: Fix outdated stack references`
  - `docs: Update environment variable documentation`

## User Story
As a developer, I need all documentation updated to reflect the current technology stack so that new team members and maintainers have accurate information.

## Acceptance Criteria

### Required Changes

1. **README.md Updates**
   - [ ] Remove all AWS/Upstash references
   - [ ] Remove all Render.com references
   - [ ] Update tech stack section to show Cloudflare services
   - [ ] Update deployment section to reflect current process
   - [ ] Update environment variables list

2. **Deployment Documentation**
   - [ ] Update `docs/DEPLOYMENT_CHECKLIST.md`
   - [ ] Remove AWS-specific deployment steps
   - [ ] Remove Render.com deployment references
   - [ ] Add Cloudflare deployment process
   - [ ] Update GitHub Actions workflow documentation

3. **Architecture Documentation**
   - [ ] Update `docs/PRD.md` with current architecture
   - [ ] Update `docs/ARCHITECTURE.md` to reflect Cloudflare services
   - [ ] Remove references to Redis/Upstash
   - [ ] Remove references to S3
   - [ ] Remove references to Qdrant (if migrating to Vectorize)

4. **Development Documentation**
   - [ ] Update `CLAUDE.md` to remove outdated stack references
   - [ ] Update any setup guides in `/docs`
   - [ ] Update environment variable templates (`.env.example`)
   - [ ] Update any API documentation

5. **Configuration Files**
   - [ ] Update `package.json` descriptions if they mention old stack
   - [ ] Update any Docker files to remove old service references
   - [ ] Update GitHub workflow files documentation comments

## Technical Approach

### Phase 1: Audit Current Documentation
1. Search for all references to outdated services:
   ```bash
   grep -r "AWS\|Upstash\|Redis\|Render\|S3\|Qdrant" docs/ *.md
   ```

2. Create list of files needing updates

### Phase 2: Update Core Documentation
1. Start with README.md as the primary entry point
2. Update deployment documentation next
3. Update architecture documentation
4. Update development guides

### Phase 3: Validate Documentation
1. Ensure all links work
2. Verify all code examples are current
3. Check that environment variables match actual usage

## Search Patterns to Find Outdated References

```bash
# Find AWS references
grep -rn "AWS\|aws\|Amazon" --include="*.md" .

# Find Upstash/Redis references
grep -rn "Upstash\|upstash\|Redis\|redis\|UPSTASH_" --include="*.md" .

# Find Render references
grep -rn "Render\|render.com\|RENDER_" --include="*.md" .

# Find S3 references
grep -rn "S3\|s3\|bucket" --include="*.md" .

# Find Qdrant references
grep -rn "Qdrant\|qdrant\|QDRANT_" --include="*.md" .
```

## Documentation Standards

### Each Updated File Should:
1. Use consistent terminology for Cloudflare services
2. Include accurate code examples
3. Have working links
4. Reference correct environment variables
5. Match the actual implementation

### Cloudflare Service Names to Use:
- **Cloudflare KV** (not "Workers KV")
- **Cloudflare R2** (not "R2 Storage")
- **Cloudflare Vectorize** (when implemented)
- **Cloudflare Workers** (for containers/functions)

## QA Merge Criteria

**This PR can be merged when:**
1. ✅ All AWS/Upstash references removed from documentation
2. ✅ All Render.com references removed
3. ✅ All documentation reflects Cloudflare stack
4. ✅ Environment variable documentation is current
5. ✅ No broken links in documentation
6. ✅ Self-hosted runner tests pass
7. ✅ PR approved by reviewer

**To QA Team:** 
- Create quality gate file: `docs/qa/story-2.2-quality-gate.md`
- Verify all documentation matches actual implementation
- Test all code examples in documentation
- Ensure setup guides work for new developers

**To Dev Team:**
- Make regular commits throughout work
- Update documentation as you find outdated references
- Test documentation changes by following the guides