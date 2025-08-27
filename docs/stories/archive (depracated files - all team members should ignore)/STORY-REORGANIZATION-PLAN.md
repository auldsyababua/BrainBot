# Epic 2 Story Reorganization Plan

## Priority Order (Per Colin's Request)
1. **Cleanup & Documentation** - Remove outdated info
2. **Cloudflare Migration** - Complete stack modernization
3. **Code Quality** - Then tackle remaining improvements

## Renumbered Story Sequence

### Phase 1: Cleanup & Documentation (Stories 2.1-2.5)
- Story 2.1: Cleanup Test Artifacts & Duplicates
- Story 2.2: Update All Documentation (remove outdated stack info)
- Story 2.3: Remove AWS/Upstash References
- Story 2.4: Remove Render References
- Story 2.5: NodeJS/NVM Configuration

### Phase 2: Cloudflare Migration (Stories 2.6-2.9)
- Story 2.6: Redis to Cloudflare KV Migration
- Story 2.7: Vector to Cloudflare Vectorize Migration
- Story 2.8: S3 to Cloudflare R2 Migration
- Story 2.9: Render to Cloudflare Containers Migration

### Phase 3: Code Quality (Stories 2.10-2.15)
- Story 2.10: Remove Agent Contamination
- Story 2.11: Decompose process_message
- Story 2.12: Refactor Keyword Router
- Story 2.13: Rename Project References
- Story 2.14: Remove Manual Memory
- Story 2.15: Externalize Configuration

### Phase 4: Final Polish (Stories 2.16-2.20)
- Story 2.16: Complete TODOs
- Story 2.17: Standardize HTTP Codes
- Story 2.18: TypeScript Error Cleanup
- Story 2.19: Verify GitHub Actions
- Story 2.20: Final Epic 2 QA

## Story Template Updates

Each story will include:
1. **Branch Name**: `feature/story-2.X-brief-description`
2. **PR Title Format**: `feat(epic-2): Story 2.X - Brief Description`
3. **Commit Guidelines**: Regular commits with conventional format
4. **QA Merge Criteria**: Specific conditions for merge
5. **QA Deliverable**: Quality gate file requirement
6. **Dev Deliverable**: Updated tests and documentation

## Files to Move to Archive
- EPIC-2-STORY-ORDER.md (being replaced by this reorganization)
- epic-2-remaining-work.md (outdated)