# GitHub Secrets Configuration Template

This document lists all the secrets that need to be configured in GitHub repository settings for the CI/CD pipeline to work properly.

## Required Secrets for Telegram Mini App Deployment

### Core Application Secrets

**TELEGRAM_BOT_USERNAME**
- Description: Your Telegram bot's username (without @)
- Example: `markdown_brain_bot`
- Required: Yes

**TELEGRAM_WEB_APP_URL**
- Description: The URL where your Telegram Mini App is hosted
- Example: `https://your-app.vercel.app`
- Required: Yes

**API_URL**
- Description: Backend API endpoint URL
- Example: `https://api.your-domain.com`
- Required: Yes

### Vercel Deployment Secrets

**VERCEL_TOKEN**
- Description: Vercel authentication token
- How to get: https://vercel.com/account/tokens
- Required: For Vercel deployment

**VERCEL_ORG_ID**
- Description: Your Vercel organization ID
- How to get: Run `vercel whoami` in project directory
- Required: For Vercel deployment

**VERCEL_PROJECT_ID**
- Description: Your Vercel project ID
- How to get: Run `vercel project ls` and find your project
- Required: For Vercel deployment

### Netlify Deployment Secrets

**NETLIFY_AUTH_TOKEN**
- Description: Netlify personal access token
- How to get: https://app.netlify.com/user/applications#personal-access-tokens
- Required: For Netlify deployment

**NETLIFY_SITE_ID**
- Description: Your Netlify site ID
- How to get: Site settings > General > Site details
- Required: For Netlify deployment

**NETLIFY_SITE_NAME**
- Description: Your Netlify site name
- Example: `telegram-mini-app`
- Required: For Netlify deployment

### Render Deployment Secrets

**RENDER_API_KEY**
- Description: Render API key for deployments
- How to get: https://dashboard.render.com/account/api-keys
- Required: For Render deployment

**RENDER_SERVICE_ID**
- Description: Your Render service ID
- How to get: From service dashboard URL
- Required: For Render deployment

**RENDER_SERVICE_NAME**
- Description: Your Render service name
- Example: `telegram-mini-app`
- Required: For Render deployment

### Optional Security & Monitoring Secrets

**SNYK_TOKEN**
- Description: Snyk authentication token for security scanning
- How to get: https://app.snyk.io/account
- Required: No (but recommended)

**SENTRY_AUTH_TOKEN**
- Description: Sentry authentication token for error tracking
- How to get: https://sentry.io/settings/account/api/auth-tokens/
- Required: No

**SENTRY_ORG**
- Description: Sentry organization slug
- Example: `your-org`
- Required: No

**SENTRY_PROJECT**
- Description: Sentry project slug
- Example: `telegram-mini-app`
- Required: No

## How to Add Secrets to GitHub

1. Go to your repository on GitHub
2. Click on "Settings" tab
3. Click on "Secrets and variables" → "Actions" in the left sidebar
4. Click "New repository secret"
5. Add the secret name and value
6. Click "Add secret"

## Environment-Specific Secrets

For different deployment environments, you might want to use GitHub Environments:

1. Go to Settings → Environments
2. Create environments: `production-vercel`, `production-netlify`, `production-render`
3. Add environment-specific secrets and protection rules

## Security Best Practices

1. **Never commit secrets to the repository**
2. **Rotate secrets regularly** (every 90 days recommended)
3. **Use least privilege principle** - only grant minimum required permissions
4. **Enable secret scanning** in repository settings
5. **Use environment protection rules** for production deployments
6. **Audit secret usage** regularly through GitHub audit logs

## Verifying Secrets

To verify your secrets are configured correctly:

1. Run a manual workflow dispatch from Actions tab
2. Check the workflow logs (secrets will be masked)
3. Verify deployments are successful

## Troubleshooting

If deployments fail due to missing secrets:

1. Check workflow logs for "secret not found" errors
2. Verify secret names match exactly (case-sensitive)
3. Ensure secrets are added to the correct environment
4. Check if secrets have expired (tokens may need renewal)