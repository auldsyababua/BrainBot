# Story 2.20: Verify and Fix GitHub Actions Node.js Configuration

## Status
Ready for Development

## Story
**As a** DevOps engineer,
**I want** GitHub Actions workflows verified and fixed to use Node.js v20.x,
**so that** CI/CD pipelines match our local development environment and tests pass consistently.

## Acceptance Criteria
1. [ ] All GitHub Actions workflows use Node.js v20.x
2. [ ] Node version is pinned to v20.19.4 or v20.x range
3. [ ] Frontend build steps use correct Node version
4. [ ] All Node-dependent tests pass in CI
5. [ ] Cache configuration updated for Node v20
6. [ ] No Node v18.x or v24.x references remain

## Tasks / Subtasks
- [ ] Task 1: Audit all workflow files (AC: 1, 6)
  - [ ] Check .github/workflows/test.yml
  - [ ] Check .github/workflows/ci.yml
  - [ ] Check .github/workflows/comprehensive_tests.yml
  - [ ] Check any other workflow files
- [ ] Task 2: Update Node version configurations (AC: 2, 3)
  - [ ] Set node-version to '20.x' in all workflows
  - [ ] Update actions/setup-node to latest version
  - [ ] Ensure package.json engines field is respected
- [ ] Task 3: Fix cache configurations (AC: 5)
  - [ ] Update npm cache keys for Node v20
  - [ ] Clear old caches from Node v18/v24
  - [ ] Verify cache restoration works
- [ ] Task 4: Verify all workflows pass (AC: 4)
  - [ ] Push changes and monitor workflow runs
  - [ ] Fix any Node v20-specific issues
  - [ ] Ensure all tests complete successfully

## Dev Notes

### Priority
**HIGH** - CI/CD must work for team productivity

### Current State
Per CICD_NODE20_UPDATE.md:
- Node 18.x was removed from test matrix
- Should be fixed to Node 20.x only
- Needs verification that changes were applied

### Files to Check/Update
```yaml
# .github/workflows/test.yml
strategy:
  matrix:
    node-version: [20.x]  # Should be this only

# All workflows should have:
- uses: actions/setup-node@v4
  with:
    node-version: '20.x'
    cache: 'npm'
```

### Verification Commands
```bash
# Check all workflow files for Node versions
grep -r "node-version" .github/workflows/

# Verify no old Node versions
grep -r "18\|24" .github/workflows/
```

### Cache Consideration
- Node v20 npm cache location may differ
- Cache keys should include Node version
- Example: `${{ runner.os }}-node-v20-${{ hashFiles('**/package-lock.json') }}`

## Change Log
| Date | Version | Description | Author |
|------|---------|-------------|--------|
| 2025-01-26 | 1.0 | Initial story creation | BMad Orchestrator |

## Dev Agent Record

### Agent Model Used
(To be filled by Dev Agent)

### Debug Log References
(To be filled by Dev Agent)

### Completion Notes List
(To be filled by Dev Agent)

### File List
(To be filled by Dev Agent)
- [ ] /.github/workflows/test.yml
- [ ] /.github/workflows/ci.yml
- [ ] /.github/workflows/comprehensive_tests.yml
- [ ] /.github/workflows/*.yml (any others)

## QA Results
(To be filled by QA Agent)