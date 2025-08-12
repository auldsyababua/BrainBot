# Cloudflare Workers for BrainBot

This directory contains the Cloudflare Workers implementation for BrainBot's edge infrastructure.

## Workers

### brainbot-webhook
- **Purpose**: Receives Telegram webhook updates and queues them for processing
- **URL**: https://brainbot-webhook.colin-c4d.workers.dev
- **Features**:
  - Validates Telegram webhook secret token
  - Enqueues messages to Cloudflare Queue
  - Minimal latency response to Telegram

### brainbot-consumer
- **Purpose**: Processes queued messages and proxies to Python backend
- **URL**: https://brainbot-consumer.colin-c4d.workers.dev  
- **Features**:
  - Consumes messages from queue
  - Generates HMAC signatures for authentication
  - Proxies to Python /process endpoint
  - Handles retries on failure

## Deployment

### Prerequisites
- Cloudflare account with Workers enabled
- Wrangler CLI installed (`npm install -g wrangler`)
- Logged in to Cloudflare (`wrangler login`)

### Deploy Workers
```bash
# Deploy webhook worker
cd brainbot-webhook
npm install
npx wrangler deploy

# Deploy consumer worker
cd ../brainbot-consumer
npm install
npx wrangler deploy
```

### Configure Secrets
```bash
# Set Telegram webhook secret
cd brainbot-webhook
echo "YOUR_SECRET" | npx wrangler secret put TELEGRAM_WEBHOOK_SECRET

# Set proxy secret (shared with Python backend)
cd ../brainbot-consumer
echo "YOUR_SECRET" | npx wrangler secret put CF_PROXY_SECRET
```

## Architecture

```
Telegram → Webhook Worker → Queue → Consumer Worker → Python Backend
```

## Resources Used
- **KV Namespace**: `BRAINBOT_KV` - Metadata storage
- **R2 Bucket**: `brainbot-media` - Media file storage
- **Vectorize Index**: `brainbot-docs` - Document embeddings
- **Queue**: `brainbot-updates` - Message queue

## Monitoring
```bash
# View webhook logs
npx wrangler tail brainbot-webhook

# View consumer logs  
npx wrangler tail brainbot-consumer

# Check queue status
npx wrangler queues list
```

## Migration Status
- Phase 1: ✅ Complete (Workers deployed, awaiting backend deployment)
- Phase 2: ⬜ Planned (Move simple operations to edge)
- Phase 3: ⬜ Future (Full edge migration with Durable Objects)