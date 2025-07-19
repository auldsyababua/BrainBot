# Webhook Setup Guide for Render

This guide explains how to switch from polling to webhooks on Render.

## Why Webhooks?

- **Instant message delivery** - No delay from polling intervals
- **Lower resource usage** - No constant API calls
- **Better scalability** - Handles high message volumes efficiently
- **Required for paid Render plans** - Makes full use of always-on service

## Setup Instructions

### 1. Update Your Render Service

In Render dashboard:
1. Change service type from "Background Worker" to "Web Service"
2. Set start command to: `python webhook_server.py`
3. Ensure all environment variables are set

### 2. Deploy the New Configuration

```bash
git add render.yaml webhook_server.py setup_webhook.py
git commit -m "Switch to webhook mode for Telegram bot"
git push origin main
```

### 3. Configure Webhook After Deploy

Once deployed, run:

```bash
python setup_webhook.py https://your-service-name.onrender.com/webhook
```

Replace `your-service-name` with your actual Render service name.

### 4. Verify Webhook

The setup script will show:
- ✅ Webhook set successfully
- Current webhook URL
- Any pending updates
- Any error messages

## Webhook Endpoints

- `/` - Health check endpoint
- `/webhook` - Telegram webhook endpoint

## Environment Variables

Render automatically provides:
- `RENDER_EXTERNAL_URL` - Your service's public URL
- `PORT` - Port to listen on (usually 10000)

## Troubleshooting

### Webhook not receiving messages
1. Check webhook info: `python setup_webhook.py`
2. Verify HTTPS certificate is valid
3. Check Render logs for errors

### Service sleeping (free tier)
Upgrade to a paid plan to keep service always active.

### Migration from polling
1. Delete any polling-specific configurations
2. Ensure no duplicate bot instances running
3. Clear pending updates with deleteWebhook first