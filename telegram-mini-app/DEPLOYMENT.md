# Telegram Mini App Deployment Guide

## Table of Contents
- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Local Development](#local-development)
- [CI/CD Pipeline](#cicd-pipeline)
- [Deployment Platforms](#deployment-platforms)
- [Environment Variables](#environment-variables)
- [Monitoring](#monitoring)
- [Troubleshooting](#troubleshooting)

## Overview

This Telegram Mini App can be deployed to multiple platforms with automated CI/CD pipelines configured through GitHub Actions. The application supports deployment to:

- **Vercel** (Recommended for production)
- **Netlify** (Alternative with good CDN)
- **Render** (Static site hosting)
- **Docker** (Self-hosted option)

## Prerequisites

### Required Tools
- Node.js 20+ and npm 10+
- Git
- GitHub account with repository access
- Account on chosen deployment platform(s)

### Required Secrets
Configure these in GitHub Settings → Secrets and variables → Actions:

```
# Core Application
TELEGRAM_BOT_USERNAME
TELEGRAM_WEB_APP_URL
API_URL

# Platform-specific (choose one)
VERCEL_TOKEN, VERCEL_ORG_ID, VERCEL_PROJECT_ID
NETLIFY_AUTH_TOKEN, NETLIFY_SITE_ID
RENDER_API_KEY, RENDER_SERVICE_ID
```

## Local Development

### Setup
```bash
# Clone repository
git clone <repository-url>
cd flrts/telegram-mini-app

# Install dependencies
npm install

# Copy environment variables
cp .env.example .env.local

# Edit .env.local with your values
nano .env.local
```

### Development Commands
```bash
# Start development server
npm run dev

# Run tests
npm run test

# Type checking
npm run typecheck

# Linting
npm run lint
npm run lint:fix

# Build for production
npm run build

# Preview production build
npm run preview

# Run all checks before commit
npm run preflight
```

### Docker Development
```bash
# Build and run with Docker Compose
docker-compose up --build

# Access at http://localhost:8080
```

## CI/CD Pipeline

The GitHub Actions workflow (`.github/workflows/deploy-mini-app.yml`) runs automatically on:
- **Pull Requests**: Runs tests and linting
- **Push to main**: Deploys to production
- **Manual dispatch**: Deploy to specific platform

### Pipeline Stages

1. **Lint & Type Check** → Ensures code quality
2. **Run Tests** → Executes test suite
3. **Build Application** → Creates production build
4. **Deploy** → Deploys to selected platform
5. **Lighthouse Audit** → Performance analysis
6. **Security Scan** → Vulnerability checking

### Manual Deployment
```bash
# Trigger deployment from GitHub UI
# Actions → Deploy Telegram Mini App → Run workflow
# Select branch and deployment target
```

## Deployment Platforms

### Vercel Deployment

**Initial Setup:**
```bash
# Install Vercel CLI
npm i -g vercel

# Login to Vercel
vercel login

# Link project (first time only)
vercel link

# Get project and org IDs
vercel project ls
```

**Manual Deploy:**
```bash
npm run deploy:vercel
```

**Configuration:** `vercel.json`
- Auto-deploy on push to main
- Preview deployments for PRs
- Custom domains support
- Edge functions ready

---

### Netlify Deployment

**Initial Setup:**
```bash
# Install Netlify CLI
npm i -g netlify-cli

# Login to Netlify
netlify login

# Initialize site (first time only)
netlify init
```

**Manual Deploy:**
```bash
npm run deploy:netlify
```

**Configuration:** `netlify.toml`
- Branch deploys
- Deploy previews
- Built-in forms and functions
- Split testing support

---

### Render Deployment

**Initial Setup:**
1. Create account at https://render.com
2. Connect GitHub repository
3. Select "Static Site" service type
4. Configure using `render.yaml`

**Configuration:** `render.yaml`
- Auto-deploy from GitHub
- Pull request previews
- Custom domains
- SSL certificates included

---

### Docker Deployment

**Build and Run:**
```bash
# Build image
docker build -t telegram-mini-app .

# Run container
docker run -p 8080:8080 telegram-mini-app

# Or use docker-compose
docker-compose up -d
```

**Deploy to Cloud:**
```bash
# Tag for registry
docker tag telegram-mini-app:latest registry.example.com/telegram-mini-app:latest

# Push to registry
docker push registry.example.com/telegram-mini-app:latest
```

## Environment Variables

### Required Variables
```env
# Telegram Configuration
VITE_TELEGRAM_BOT_USERNAME=your_bot_username
VITE_TELEGRAM_WEB_APP_URL=https://your-app-url.com
VITE_TELEGRAM_BOT_TOKEN=bot_token_here

# API Configuration
VITE_API_URL=https://api.your-domain.com
```

### Optional Variables
```env
# Supabase (if using)
VITE_SUPABASE_URL=https://project.supabase.co
VITE_SUPABASE_ANON_KEY=anon_key_here

# Analytics
VITE_GA_TRACKING_ID=UA-XXXXXXXXX-X
VITE_SENTRY_DSN=https://dsn@sentry.io/project

# Feature Flags
VITE_ENABLE_ANALYTICS=true
VITE_ENABLE_DEBUG=false
```

### Platform-Specific Configuration

**Vercel:**
- Set in Dashboard → Settings → Environment Variables
- Or use `vercel env add`

**Netlify:**
- Set in Site Settings → Environment Variables
- Or use `netlify env:set KEY value`

**Render:**
- Set in Dashboard → Environment
- Or define in `render.yaml`

## Monitoring

### Performance Monitoring

**Lighthouse CI Results:**
- Automatically runs on deployments
- Results posted to PR comments
- Thresholds: Performance > 90, Accessibility > 90

**Real User Monitoring:**
```javascript
// Add to src/main.tsx for web vitals
import { reportWebVitals } from './reportWebVitals';
reportWebVitals(console.log);
```

### Error Tracking

**Sentry Integration:**
```javascript
// Configure in src/sentry.ts
import * as Sentry from "@sentry/react";

Sentry.init({
  dsn: import.meta.env.VITE_SENTRY_DSN,
  environment: import.meta.env.MODE,
  tracesSampleRate: 0.1,
});
```

### Health Checks

**Endpoints:**
- `/health` - Basic health check
- `/api/health` - API health status
- `/metrics` - Prometheus metrics (if configured)

## Troubleshooting

### Common Issues

**Build Failures:**
```bash
# Clear cache and rebuild
npm run clean
rm -rf node_modules package-lock.json
npm install
npm run build
```

**Environment Variable Issues:**
```bash
# Verify environment variables
npm run build -- --mode development
# Check for VITE_ prefix on client-side vars
```

**Deployment Failures:**

1. **Vercel:**
   - Check build logs: `vercel logs`
   - Verify project settings: `vercel project ls`
   - Reset project: `vercel remove && vercel`

2. **Netlify:**
   - Check deploy logs: `netlify deploy --debug`
   - Clear cache: `netlify build --clear-cache`
   - Check functions: `netlify functions:list`

3. **Render:**
   - Check service logs in dashboard
   - Verify build command in `render.yaml`
   - Check environment variables

**CORS Issues:**
```javascript
// Add to vite.config.ts
server: {
  cors: {
    origin: ['https://telegram.org', 'https://web.telegram.org'],
    credentials: true
  }
}
```

### Performance Optimization

**Build Size:**
```bash
# Analyze bundle size
npm run build:analyze

# Check for large dependencies
npx vite-bundle-visualizer
```

**Caching Strategy:**
- Static assets: 1 year cache
- HTML files: no-cache
- API responses: 5 minute cache

**CDN Configuration:**
- Vercel: Automatic edge network
- Netlify: Automatic CDN
- Render: CloudFlare integration available

### Security Checklist

- [ ] Environment variables secured
- [ ] HTTPS enforced
- [ ] CSP headers configured
- [ ] CORS properly restricted
- [ ] Rate limiting enabled
- [ ] Security headers added
- [ ] Dependencies updated
- [ ] Vulnerability scanning enabled

## Rollback Procedures

### Vercel
```bash
# List deployments
vercel ls

# Rollback to previous
vercel rollback <deployment-url>
```

### Netlify
```bash
# Rollback via UI or
netlify deploy --prod --dir=dist
```

### Render
- Use dashboard to rollback
- Or trigger previous commit deploy

### Docker
```bash
# Rollback to previous image
docker pull registry/app:previous-tag
docker stop telegram-mini-app
docker run -d -p 8080:8080 registry/app:previous-tag
```

## Support

For issues or questions:
1. Check [TESTING.md](./TESTING.md) for test procedures
2. Review GitHub Actions logs
3. Check platform-specific documentation
4. Open an issue with deployment logs