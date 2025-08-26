# GitHub Secrets Configuration Guide

## Required GitHub Secrets

This document lists all the GitHub secrets that need to be configured in the BrainBot repository settings for CI/CD to work properly.

### Core Application Secrets

**TELEGRAM_BOT_TOKEN** → Required  
Bot token from @BotFather on Telegram

**TELEGRAM_WEBHOOK_SECRET** → Required  
Secret key for webhook authentication (generate a secure random string)

**CF_PROXY_SECRET** → Required  
Cloudflare proxy authentication secret (currently matches Render, migrating to Containers - see [Story 2.17](../stories/2.17.story.md))

### API Keys

**OPENAI_API_KEY** → Required  
OpenAI API key for LLM functionality

**RENDER_API_KEY** → Deprecated (migrating to Cloudflare Containers - see [Story 2.17](../stories/2.17.story.md))  
Render.com API key for deployment automation (being replaced)

**RENDER_SERVICE_ID** → Deprecated (migrating to Cloudflare Containers - see [Story 2.17](../stories/2.17.story.md))  
Render service identifier for the BrainBot service (being replaced)

### Database & Storage

**SUPABASE_URL** → Required  
Supabase project URL

**SUPABASE_ANON_KEY** → Required  
Supabase anonymous/public key

**SUPABASE_SERVICE_KEY** → Required  
Supabase service role key (admin access)

**UPSTASH_REDIS_REST_URL** → Deprecated (migrating to Cloudflare KV - see [Story 2.13](../stories/2.13.story.md))  
Upstash Redis REST API endpoint (being replaced)

**UPSTASH_REDIS_REST_TOKEN** → Deprecated (migrating to Cloudflare KV - see [Story 2.13](../stories/2.13.story.md))  
Upstash Redis authentication token (being replaced)

**UPSTASH_VECTOR_REST_URL** → Deprecated (migrating to Cloudflare Vectorize - see [Story 2.14](../stories/2.14.story.md))  
Upstash Vector database REST endpoint (being replaced)

**UPSTASH_VECTOR_REST_TOKEN** → Deprecated (migrating to Cloudflare Vectorize - see [Story 2.14](../stories/2.14.story.md))  
Upstash Vector database token (being replaced)

### CI/CD & Security

**GH_APP_ID** → Optional (Required for guardrails)  
GitHub App ID for advanced automation

**GH_APP_PRIVATE_KEY** → Optional (Required for guardrails)  
GitHub App private key (base64 encoded)

**SEMGREP_APP_TOKEN** → Optional  
Semgrep Cloud token for enhanced security scanning

**LINEAR_API_KEY** → Optional  
Linear API key for issue tracking integration

## How to Add Secrets

1. Go to the BrainBot repository on GitHub
2. Navigate to Settings → Secrets and variables → Actions
3. Click "New repository secret"
4. Add each secret with the exact name shown above
5. Paste the corresponding value

## Verification

After adding secrets, verify they're working:

1. Check the Actions tab for any workflow runs
2. Look for green checkmarks on recent commits
3. Review deployment logs in Render dashboard (migrating to Cloudflare - see [Story 2.17](../stories/2.17.story.md))

## Security Notes

- Never commit secrets to the repository
- Use environment variables in code
- Rotate secrets regularly
- Use GitHub's secret scanning to detect leaks
- Enable Dependabot security updates

## Current Status

As of migration (2025-01-24):
- ✅ Repository migrated to BrainBot
- ✅ Workflows exist in .github/workflows/
- ⚠️ Secrets need to be verified/added in GitHub
- ✅ Render has CF_PROXY_SECRET configured (migrating to Cloudflare - see [Story 2.17](../stories/2.17.story.md))
- ✅ Semgrep workflow added for security scanning

## Troubleshooting

If workflows fail due to missing secrets:
1. Check the Actions tab for error messages
2. Verify secret names match exactly (case-sensitive)
3. Ensure no trailing spaces in secret values
4. Check that base64 encoded values are properly formatted