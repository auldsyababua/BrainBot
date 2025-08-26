# Epic 2: Code Cleanup & Migration - Story Development Order

## Overview
This document defines the logical order for implementing Epic 2 stories to ensure smooth development flow with minimal blocking dependencies.

---

## Phase 1: Critical Blockers & Environment Setup
**Must be completed first to unblock all other development**

### 🔴 IMMEDIATE PRIORITY
1. **2.19** - Configure Node.js Version Management with NVM
   - Creates .nvmrc files for consistent Node v20.19.4
   - Prevents toolchain compatibility issues
   - **Blocks**: All frontend development

2. **2.20** - Verify and Fix GitHub Actions Node.js Configuration  
   - Ensures CI/CD uses Node v20.x
   - **Blocks**: All PR merges and deployments

3. **2.21** - TypeScript Error Cleanup
   - Fix all 38 TypeScript errors in frontend
   - Enable strict type checking
   - **Blocks**: Frontend quality and CI/CD

4. **2.10** - Fix GitHub Test Failures
   - Fixes Python test imports and MyPy issues
   - Ensures all backend tests pass
   - **Blocks**: All PR merges

---

## Phase 2: Core Refactoring
**Foundation work that other stories depend on**

### ✅ COMPLETED
- **2.0** - Remove Agent Contamination ✓
- **2.1** - Decompose Process Message ✓
- **2.2** - Refactor Keyword Router ✓
- **2.3** - Rename Project (flrts → flrts-bmad) ✓
- **2.4** - Test File Cleanup ✓
- **2.5** - Remove Manual Memory ✓

### 🟡 IN PROGRESS
5. **2.6** - Externalize Configuration
   - Move hardcoded values to config files
   - **Enables**: Clean migrations to Cloudflare

6. **2.7** - Complete TODOs
   - Address all TODO comments in codebase
   - **Enables**: Clean codebase for migrations

7. **2.8** - Standardize HTTP Response Codes
   - Consistent error handling across APIs
   - **Enables**: Better debugging during migrations

---

## Phase 3: Cloudflare Migration - Data Layer
**Migrate data services first (no code changes needed)**

8. **2.13** - Redis to Cloudflare KV Migration
   - Replace Upstash Redis with Cloudflare KV
   - **Dependencies**: Config externalization (2.6)
   - **Enables**: Unified Cloudflare data layer

9. **2.14** - Vector to Cloudflare Vectorize Migration
   - Replace Upstash Vector with Cloudflare Vectorize
   - **Dependencies**: Config externalization (2.6)
   - **Enables**: Semantic search on Cloudflare

10. **2.15** - S3 to Cloudflare R2 Migration (Already Done: 2.9)
    - Migrate media storage to Cloudflare R2
    - **Note**: May be duplicate of 2.9

---

## Phase 4: Cloudflare Migration - Infrastructure
**Move hosting after data layer is stable**

11. **2.11** - Cloudflare Containers Migration (Backend)
    - Move FastAPI from Render to Cloudflare
    - **Dependencies**: All data migrations (2.13, 2.14, 2.15)
    - **Enables**: Unified Cloudflare infrastructure

12. **2.17** - Render to Cloudflare Containers Migration
    - Complete backend migration
    - **Note**: May be duplicate of 2.11

---

## Phase 5: Cleanup & Polish
**Remove legacy code after migrations complete**

13. **2.16** - Remove AWS & Upstash References
    - Clean up all AWS S3 and Upstash code
    - **Dependencies**: All data migrations complete
    - **Result**: Clean, maintainable codebase

14. **2.18** - Remove Render References
    - Clean up all Render.com configurations
    - **Dependencies**: Infrastructure migration complete
    - **Result**: Cloudflare-only deployment

15. **2.12** - Cleanup Test Artifacts
    - Remove redundant test files
    - Organize test structure
    - **Dependencies**: All tests passing (2.10)
    - **Result**: Clean test suite

---

## Recommended Sprint Planning

### Sprint 1 (Week 1) - Critical Blockers
- 2.19 - NVM Configuration (1 point)
- 2.20 - GitHub Actions Fix (2 points)
- 2.21 - TypeScript Error Cleanup (3 points)
- 2.10 - Fix Backend Tests (8 points)
**Total: 14 points**

### Sprint 2 (Week 2)
- 2.6 - Externalize Config (5 points)
- 2.7 - Complete TODOs (3 points)
- 2.8 - HTTP Codes (3 points)
- 2.12 - Test Cleanup (2 points)
**Total: 13 points**

### Sprint 3 (Week 3)
- 2.13 - Redis → KV (5 points)
- 2.14 - Vector → Vectorize (5 points)
- 2.15 - S3 → R2 (3 points if needed)
**Total: 13 points**

### Sprint 4 (Week 4)
- 2.11/2.17 - Cloudflare Containers (8 points)
- 2.16 - Remove AWS/Upstash (3 points)
- 2.18 - Remove Render (2 points)
**Total: 13 points**

---

## Notes

1. **Duplicate Stories**: 2.15 and 2.9 appear to cover S3→R2 migration. 2.11 and 2.17 appear to cover Render→Cloudflare. These should be consolidated.

2. **TypeScript Cleanup**: Now properly numbered as Story 2.21, separated from backend test fixes in 2.10.

3. **Priority Override**: If production is broken, Stories 2.19, 2.20, 2.21, and 2.10 should be done immediately as they block all other work.

4. **Parallel Work**: Once Phase 1 is complete, Phase 3 data migrations can happen in parallel with Phase 2 refactoring.

---

**Last Updated**: January 26, 2025  
**Updated By**: BMad Orchestrator