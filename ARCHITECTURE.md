# 🏗️ Architecture & File Organization

> **🔄 CRITICAL UPDATE: We've moved from POLLING to WEBHOOKS for production!**

## 🚫 What Changed?

### Old Architecture (Background Worker + Polling)
- Render ran a background worker
- Bot constantly polled Telegram servers for updates
- Used `main.py` as entry point
- Inefficient and resource-intensive

### New Architecture (Web Service + Webhooks)
- Render runs a web service with FastAPI
- Telegram sends updates directly to our webhook endpoint
- Uses `webhook_server.py` as entry point
- Efficient and scalable

## 📁 File Organization

### 🏭 PRODUCTION FILES (Used on Render)

```
webhook_server.py          # ⭐ Main production entry point - FastAPI server
setup_webhook.py          # Configures Telegram to use webhook URL
src/bot/main_webhook.py   # Webhook request handler
src/bot/set_webhook.py    # Alternative webhook configuration
requirements.txt          # Production dependencies
render.yaml               # Render deployment configuration
pyproject.toml            # Package configuration
```

### 🧪 LOCAL DEVELOPMENT FILES

```
run_bot.py                # Main local entry point - uses polling
src/bot/main_polling.py   # Polling implementation
test_bot_local.py         # DELETE THIS - duplicate of run_bot.py
test_storage_integrations.py  # Storage tests
```

### ⚠️ CONFUSING/LEGACY FILES

```
main.py                   # MISLEADING NAME - production file that uses polling
                         # Should be renamed or removed
test_bot_local.py        # DUPLICATE - same as run_bot.py, should be deleted
```

### 📋 Test Files (Local Only)

```
tests/                    # All unit and integration tests
scripts/test_*.py        # Various test scripts
scripts/diagnostics/     # Diagnostic tools
scratch/                 # Temporary test files
```

### 🔧 Utility Scripts

```
scripts/deployment/      # Production deployment scripts
scripts/database/        # Database management
scripts/reset_vector_10net.py  # Vector store management
```

## 🚀 How to Run

### Local Development (Polling)
```bash
# Use this for local testing - no webhook needed
python run_bot.py
```

### Production (Webhooks)
```bash
# Render automatically runs this:
python webhook_server.py

# After deployment, set up webhook:
python setup_webhook.py
```

## 📝 Key Differences

| Aspect | Local (Polling) | Production (Webhook) |
|--------|----------------|---------------------|
| Entry Point | `run_bot.py` | `webhook_server.py` |
| Update Method | Bot polls Telegram | Telegram pushes to bot |
| Server Type | Simple script | FastAPI web server |
| Efficiency | Lower | Higher |
| Setup | Just run | Need webhook URL |

## 🚮 Common Mistakes to Avoid

1. **DON'T** use `main.py` - it's confusingly named
2. **DON'T** use polling in production - use webhooks
3. **DON'T** commit the `/notes/` folder - it's test data
4. **DON'T** use `test_bot_local.py` - use `run_bot.py`

## 🔍 Where Things Are

- **Bot Logic**: `src/bot/`
- **Storage**: `src/storage/`
- **Core Utils**: `src/core/`
- **Tests**: `tests/` and `scripts/test_*.py`
- **Docs**: `docs/` and this file

## 🎯 Next Steps

1. Delete `test_bot_local.py`
2. Rename `main.py` to `legacy_polling_entry.py`
3. Move all test scripts to `tests/` or `scratch/`
4. Remove `/notes/` from repo
5. Update documentation to reflect webhook architecture