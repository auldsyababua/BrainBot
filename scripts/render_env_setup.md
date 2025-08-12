# Render Environment Variable Configuration

## Quick Setup for CF_PROXY_SECRET

### Step 1: Access Render Dashboard
1. Go to https://dashboard.render.com
2. Log in with your credentials
3. Select the **brainbot-v76n** service

### Step 2: Navigate to Environment Variables
1. Click on **Environment** in the left sidebar
2. Select **Environment Variables** tab

### Step 3: Add CF_PROXY_SECRET
Click **Add Environment Variable** and enter:

| Field | Value |
|-------|-------|
| **Key** | `CF_PROXY_SECRET` |
| **Value** | `8f84125f867d95cd22c5906640f2f6a8badc37ad5136669d04d134ea7df58ab4` |

### Step 4: Save and Deploy
1. Click **Save Changes**
2. Render will automatically redeploy the service
3. Wait 2-3 minutes for deployment to complete

## Verification

After deployment, verify the environment variable is set:

```bash
# Check if /process endpoint accepts authenticated requests
curl -X POST https://brainbot-v76n.onrender.com/process \
  -H "Content-Type: application/json" \
  -H "X-Request-Timestamp: $(date +%s)" \
  -H "X-BrainBot-Signature: test" \
  -d '{"test": true}'
```

Expected response: HTTP 401 (Unauthorized) - this confirms the endpoint exists and is checking authentication.

## Important Notes

- **Security**: The CF_PROXY_SECRET is a shared secret between Cloudflare Workers and your Python backend
- **HMAC Validation**: This secret is used to generate HMAC signatures for secure communication
- **Already Configured**: The Cloudflare Consumer Worker already has this secret configured
- **No Restart Required**: Render will automatically restart the service after adding the environment variable

## Troubleshooting

If the endpoint returns 404 after deployment:
1. Check deployment logs in Render dashboard
2. Verify the feat/cf-migration-phase1 branch was merged successfully
3. Confirm the deployment completed without errors

If HMAC validation fails:
1. Ensure the secret matches exactly (no extra spaces)
2. Check that both Cloudflare and Render have the same secret
3. Verify timestamp is within 5-minute window