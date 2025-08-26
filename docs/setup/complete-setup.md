# Complete Cloudflare Setup Guide

## Step 1: Set Your Bot Token

First, you need to export your Telegram bot token as an environment variable:

```bash
export TELEGRAM_BOT_TOKEN='your_actual_bot_token_here'
```

To get your bot token:
1. Open Telegram and message @BotFather
2. Send `/mybots`
3. Select your bot
4. Click "API Token"

## Step 2: Set Telegram Webhook to Cloudflare

Run the setup script:

```bash
./scripts/setup_telegram_webhook.sh
```

This will:
- Point your Telegram bot to the Cloudflare Worker
- Verify the webhook is working
- Show you the current status

## Step 3: Configure Mini App in BotFather

1. Open Telegram and message @BotFather
2. Send `/mybots`
3. Select your bot (likely "BrainBot" or similar)
4. Choose "Bot Settings"
5. Select "Menu Button"
6. Click "Configure Menu Button"
7. When asked for the URL, enter:
   ```
   https://brainbot-mini-app.pages.dev
   ```
8. When asked for the button text, enter:
   ```
   Open BrainBot
   ```

## Step 4: Test Everything

### Test Bot Messages:
1. Open your bot in Telegram
2. Send `/start`
3. You should get a welcome message

### Test Mini App:
1. Look for the menu button (usually bottom-left in the chat)
2. Click "Open BrainBot"
3. The Mini App should load

## Step 5: Monitor Your Infrastructure

### Watch Cloudflare Worker Logs:
```bash
# Terminal 1: Watch webhook worker
cd cf/brainbot-webhook
npx wrangler tail

# Terminal 2: Watch consumer worker
cd cf/brainbot-consumer
npx wrangler tail
```

### Check Render Backend:
```bash
# Check if /process endpoint is working
curl -X POST https://brainbot-v76n.onrender.com/process
# Should return 401 (authentication required)
```

## Architecture Overview

Your complete setup:

```
Message Flow:
1. User sends message in Telegram
2. Telegram sends to: brainbot-webhook.colin-c4d.workers.dev
3. Webhook Worker queues message
4. Consumer Worker picks up from queue
5. Consumer sends to: brainbot-v76n.onrender.com/process
6. Python backend processes and responds

Mini App Flow:
1. User clicks menu button in Telegram
2. Telegram opens: brainbot-mini-app.pages.dev
3. Mini App connects to: brainbot-v76n.onrender.com API
```

## Troubleshooting

### If webhook doesn't work:
```bash
# Check webhook status
curl "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/getWebhookInfo"

# Check for errors in Worker logs
npx wrangler tail brainbot-webhook
```

### If Mini App doesn't load:
- Ensure you're opening it through Telegram (not browser)
- Check deployment status: https://dash.cloudflare.com

### If messages aren't processing:
- Check Render is running: https://dashboard.render.com
- Verify CF_PROXY_SECRET is set in Render environment
- Check Consumer Worker logs for errors

## Success Indicators

✅ Webhook set to: `https://brainbot-webhook.colin-c4d.workers.dev`
✅ Mini App accessible at: `https://brainbot-mini-app.pages.dev`
✅ Bot responds to commands
✅ Mini App loads in Telegram
✅ No errors in Worker logs

## Next Steps

Once everything is working:
1. Monitor performance and costs in Cloudflare dashboard
2. Consider implementing user authentication (Supabase)
3. Add more features to the Mini App
4. Optimize Worker performance