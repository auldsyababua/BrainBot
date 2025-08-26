# CI/CD Pipeline Node.js v20 Update

**Date:** 2025-08-26  
**Updated By:** DevOps Engineer  
**Status:** ✅ COMPLETED

## Changes Applied

### 1. GitHub Actions Workflow
**File:** `.github/workflows/test.yml`
- Removed Node 18.x from test matrix
- Fixed to Node 20.x only for consistency

### 2. Package Configuration
**File:** `package.json`
- Added engines field to enforce Node v20
```json
"engines": {
  "node": ">=20.0.0 <21.0.0",
  "npm": ">=10.0.0"
}
```

### 3. NVM Configuration
**File:** `.nvmrc`
- Created with version `20.19.4`
- Enables automatic version switching for developers using nvm

### 4. Docker Configuration
**File:** `Dockerfile`
- Already using `node:20-alpine` ✅
- No changes needed

## Deployment Configuration

### Render.com Settings
Update your Render service environment:
```yaml
Environment Variables:
  NODE_VERSION: 20.19.4
  NPM_VERSION: 10.8.2
```

### Build Command
```bash
npm ci && npm run build
```

### Start Command  
```bash
npm run preview
```

## Verification Steps

1. **Local Development**
```bash
# Check Node version
node --version  # Should output v20.x.x

# For nvm users
nvm use  # Automatically switches to 20.19.4
```

2. **CI/CD Pipeline**
- GitHub Actions will now only test on Node 20
- Build artifacts tagged with Node version

3. **Docker Build**
```bash
docker build -t flrts-frontend .
docker run -p 8080:8080 flrts-frontend
```

## Rollback Plan

If issues arise:
1. Revert `.github/workflows/test.yml` to include Node 18
2. Remove engines field from `package.json`
3. Update Docker base image if needed

## Notes

- All developers should update local environments to Node 20 LTS
- CI/CD will reject builds with wrong Node version
- Performance improvements expected with Node 20's V8 engine