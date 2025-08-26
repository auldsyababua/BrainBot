# 🚨 TEAM UPDATE: Node.js Environment Change

**Date:** 2025-08-26  
**Priority:** HIGH - Action Required

## Summary

We've resolved the frontend build tool blocking issue by standardizing on Node.js v20 LTS. All team members need to update their local environments.

## What Changed

- **From:** Node v24.4.1 (bleeding edge)
- **To:** Node v20.19.4 (LTS)
- **Reason:** v24 incompatibility with TypeScript/Vite toolchain

## Action Required - All Developers

### 1. Update Your Local Environment

#### Option A: Using Homebrew (Mac)
```bash
brew unlink node
brew install node@20
brew link --overwrite node@20
```

#### Option B: Using NVM (Recommended)
```bash
nvm install 20.19.4
nvm use 20.19.4
nvm alias default 20.19.4
```

#### Option C: Direct Download
Download Node v20.19.4 from [nodejs.org](https://nodejs.org/en/download/)

### 2. Verify Your Setup
```bash
node --version  # Should show v20.19.4
npm --version   # Should show 10.x.x
```

### 3. Clean Reinstall in Your Branch
```bash
cd telegram-mini-app
rm -rf node_modules package-lock.json
npm install
```

## What This Fixes

✅ TypeScript compilation (`npm run typecheck`)  
✅ ESLint (`npm run lint`)  
✅ Vite builds (`npm run build`)  
✅ Test suite (`npm run test:run`)

## New Standards

1. **Always use Node v20 LTS** for FLRTS project
2. **`.nvmrc` file** now in telegram-mini-app directory
3. **CI/CD** enforces Node v20 only
4. **Docker** uses node:20-alpine

## TypeScript Cleanup

There are 38 TypeScript errors that don't block builds but need cleanup. Story FLRTS-2024-001 has been created for this technical debt.

## Questions?

- **Technical Issues:** Contact Winston (Architect)
- **Story Questions:** Contact Bob (Scrum Master)
- **Deployment:** Contact DevOps

## Quick Reference

```bash
# In telegram-mini-app directory
nvm use              # Auto-switches to correct version
npm run typecheck    # Check TypeScript
npm run lint         # Lint code
npm run build        # Build app
npm run test:run     # Run tests
```

## Timeline

- **Immediate:** Update local environments
- **This Week:** All active branches should be rebased
- **Next Sprint:** TypeScript cleanup story

---

**Remember:** Stay on LTS versions for production stability!