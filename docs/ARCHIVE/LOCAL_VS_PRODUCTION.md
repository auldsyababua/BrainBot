# 🚀 Local vs Production File Guide

## 🏠 LOCAL DEVELOPMENT

### Entry Point
```bash
python run_bot.py  # ✅ USE THIS FOR LOCAL TESTING
```

### Files Used
- `run_bot.py` - Main local runner
- `src/bot/main_polling.py` - Polling implementation
- `.env` - Local environment variables
- `test_storage_integrations.py` - Storage tests
- `scripts/test_*.py` - Various test scripts
- `tests/` - All test files

### Architecture
- Uses **POLLING** - Bot asks Telegram for updates
- No webhook URL needed
- Runs as simple Python script
- Perfect for local testing

---

## 🏭 PRODUCTION (RENDER)

### Entry Point
```bash
python webhook_server.py  # ✅ RENDER RUNS THIS AUTOMATICALLY
```

### Files Used
- `webhook_server.py` - FastAPI webhook server
- `src/bot/main_webhook.py` - Webhook handler
- `setup_webhook.py` - Configure webhook URL
- `requirements.txt` - Production dependencies
- `render.yaml` - Render configuration
- Environment variables set in Render dashboard

### Architecture
- Uses **WEBHOOKS** - Telegram pushes updates to bot
- Requires public URL (provided by Render)
- Runs as FastAPI web service
- More efficient and scalable

---

## ⚠️ FILES TO AVOID/DELETE

### Confusing Files
- `main.py` - 🚫 Legacy polling entry point (misleading name)
- `test_bot_local.py` - 🚫 Duplicate of run_bot.py (DELETE THIS)

### Problematic Directories
- `/notes/` - 🚫 Contains test data, shouldn't be in repo
  - Production should use Supabase, not local files
  - Local testing should use `NOTES_FOLDER` env var

---

## 📊 Quick Reference

| Question | Answer |
|----------|--------|
| How to run locally? | `python run_bot.py` |
| How to run in production? | Render runs `python webhook_server.py` automatically |
| Which uses polling? | Local development only |
| Which uses webhooks? | Production only |
| Where are env vars? | Local: `.env` file / Production: Render dashboard |
| Can I use polling in production? | NO! Use webhooks only |
| Can I use webhooks locally? | Yes, but requires ngrok - easier to use polling |

---

## 🔧 Migration from Polling to Webhooks

### What Changed?
1. **Old**: Render ran background worker with polling
2. **New**: Render runs web service with webhooks

### Why Change?
- Webhooks are more efficient (no constant polling)
- Better for production scale
- Lower latency
- Less resource usage

### Key Files That Changed
- Added: `webhook_server.py` (new entry point)
- Added: `src/bot/main_webhook.py` (webhook handler)
- Added: FastAPI and uvicorn to requirements
- Updated: `render.yaml` (from background worker to web service)

---

## 🎯 Action Items

1. ✅ Delete `test_bot_local.py`
2. ✅ Rename `main.py` to `legacy_polling_entry.py`
3. ✅ Remove `/notes/` from repository
4. ✅ Update any deployment scripts to use webhooks
5. ✅ Ensure all team members know about the change