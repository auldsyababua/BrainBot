# Story 2.19: Configure Node.js Version Management with NVM

## Status
Ready for Development

## Story
**As a** developer,
**I want** an .nvmrc file configured with the correct Node.js version,
**so that** all developers automatically use the same Node.js version and avoid toolchain compatibility issues.

## Acceptance Criteria
1. [ ] Create `.nvmrc` file in project root with version `20.19.4`
2. [ ] Create `.nvmrc` file in telegram-mini-app directory with version `20.19.4`
3. [ ] Update development setup documentation with nvm instructions
4. [ ] Add nvm usage instructions to README
5. [ ] Verify `nvm use` command works in both directories
6. [ ] CI/CD pipeline respects .nvmrc version

## Tasks / Subtasks
- [ ] Task 1: Create .nvmrc files (AC: 1, 2)
  - [ ] Create .nvmrc in project root with `20.19.4`
  - [ ] Create .nvmrc in telegram-mini-app with `20.19.4`
- [ ] Task 2: Update documentation (AC: 3, 4)
  - [ ] Add nvm setup instructions to docs/DEVELOPMENT_SETUP.md
  - [ ] Update README.md with Node version requirements
  - [ ] Include nvm installation link for new developers
- [ ] Task 3: Verify configuration (AC: 5, 6)
  - [ ] Test `nvm use` in both directories
  - [ ] Verify GitHub Actions respects .nvmrc
  - [ ] Ensure local builds work with nvm-selected version

## Dev Notes

### Priority
**HIGH** - This is a prerequisite for consistent development environment

### Testing Standards
- Manual verification: `nvm use` should select 20.19.4
- CI verification: GitHub Actions should use Node 20.19.4

### Technical Context
- Node v24.4.1 caused TypeScript/Vite toolchain failures
- Node v20.19.4 LTS is the stable, tested version
- This implements recommendation from FRONTEND_NODE_FIX_RESOLUTION.md

### Implementation Notes
```bash
# .nvmrc content (single line)
20.19.4
```

### Developer Setup Instructions
```bash
# Install nvm (if not installed)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Use project Node version
nvm use

# Install Node version if not present
nvm install
```

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
- [ ] /.nvmrc
- [ ] /telegram-mini-app/.nvmrc
- [ ] /docs/DEVELOPMENT_SETUP.md (updated)
- [ ] /README.md (updated)

## QA Results
(To be filled by QA Agent)