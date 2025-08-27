# Epic 2 - Story 2.1: Cleanup Test Artifacts & Duplicates

**Priority:** HIGH - Cleanup Phase
**Points:** 3
**Dependencies:** None (can start immediately)

## Git Workflow

**Branch Name:** `feature/story-2.1-cleanup-test-artifacts`
**PR Title:** `feat(epic-2): Story 2.1 - Cleanup test artifacts and duplicate files`

### Commit Guidelines
- Make regular commits as you work (every 30-60 mins or logical checkpoint)
- Use conventional commit format:
  - `fix: Remove duplicate test files`
  - `chore: Clean up temporary test artifacts`
  - `docs: Update test documentation`

## User Story
As a developer, I need the codebase cleaned of test artifacts and duplicate files so that the repository is organized and maintainable.

## Acceptance Criteria

### Required Changes
1. Remove all duplicate " 2.md" files throughout the codebase unless those are the most up-to-date. If they are, then delete the older version. If there is only one version and it has the " 2.md" at the end, then remove the " 2". Make sure any mentions of this file are updates.
2. Clean up test artifacts and temporary files
3. Organize test fixtures properly
4. Remove or archive old test reports
5. Update .gitignore to prevent future artifacts

### File Cleanup Targets
- [ ] Remove all `*" 2.md"` duplicate files
- [ ] Clean `/tests/fixtures/` of unused fixtures  
- [ ] Archive old test reports to `/tests/archive/`
- [ ] Remove `__pycache__` directories
- [ ] Clean up `.pytest_cache` directories
- [ ] Remove temporary test databases
- [ ] Clean coverage reports (keep latest only)

### Documentation Updates
- [ ] Update tests/README.md with current structure
- [ ] Document test organization standards
- [ ] Add cleanup script to `/scripts/maintenance/`

## Technical Implementation

```bash
# Find and remove duplicates
find . -name "*' 2.*'" -type f

# Clean Python artifacts  
find . -type d -name "__pycache__" -exec rm -rf {} +
find . -type d -name ".pytest_cache" -exec rm -rf {} +

# Archive old coverage reports
mkdir -p tests/archive/coverage
mv tests/coverage/coverage-*.json tests/archive/coverage/
```

## QA Merge Criteria

**This PR can be merged when:**
1. ✅ No duplicate files remain (verified by: `find . -name "*' 2.*'" | wc -l` returns 0)
2. ✅ All tests still pass (`pytest tests/`)
3. ✅ .gitignore updated with artifact patterns
4. ✅ Cleanup script created and tested
5. ✅ PR approved by at least one reviewer
6. ✅ Self-hosted runner tests pass

**To QA Team:** 
- Create quality gate file: `docs/qa/story-2.1-quality-gate.md`
- Document: files removed, patterns added to .gitignore, test results
- Verify no functionality broken by cleanup
- Run full test suite and document results

**To Dev Team:**
- Make regular commits (don't wait until end)
- Test after each major deletion
- Document any questionable files in PR description
- Update relevant documentation as you go

## Definition of Done
- [ ] All duplicate files removed
- [ ] Test artifacts cleaned
- [ ] .gitignore updated
- [ ] Cleanup script created
- [ ] Tests passing
- [ ] Documentation updated
- [ ] QA quality gate file created
- [ ] PR merged to main