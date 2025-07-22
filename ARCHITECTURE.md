# 🏗️ BrainBot Architecture

## Core Components

### CAG Engine
- **LLM Decision Making**: GPT-4o decides organization structure
- **Source Preservation**: Every input stored with unique ID
- **Derivative Creation**: LLM can merge/synthesize while preserving sources
- **Audit Trail**: All derivatives reference their source IDs

### Storage Layer
- **Filesystem**: Markdown files with YAML frontmatter (being migrated)
- **Supabase**: Document storage with metadata
- **Upstash Vector**: Semantic search capabilities
- **Redis**: Conversation memory and caching

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

## 🔑 Key Design Principles

1. **Append-Only**: Never delete user data, only create derivatives
2. **No Questions**: Bot decides organization, doesn't ask users
3. **Source Tracking**: Every piece of content traceable to origin
4. **Permissive**: Start flexible, add structure later

## 🔍 Where Things Are

- **Bot Logic**: `src/bot/`
- **Storage**: `src/storage/`
- **Core Utils**: `src/core/`
- **Tests**: `tests/` and `scripts/test_*.py`
- **Docs**: `docs/` and this file

## 🗺️ Data Flow

```
User Input (Telegram) 
    ↓
CAG Engine (Decides: merge or create)
    ↓
Storage Layer (Preserves source + creates derivative)
    ↓
Vector Index (Makes searchable)
    ↓
User Query → RAG Search → Intelligent Response
```

## 🔧 Configuration

```bash
# Key environment variables
TELEGRAM_BOT_TOKEN=your_bot_token
OPENAI_API_KEY=your_key
UPSTASH_REDIS_REST_URL=your_url
UPSTASH_REDIS_REST_TOKEN=your_token
UPSTASH_VECTOR_REST_URL=your_url
UPSTASH_VECTOR_REST_TOKEN=your_token

# Performance settings
VECTOR_CACHE_ENABLED=true
VECTOR_CACHE_TTL=300
CONVERSATION_MAX_MESSAGES=20
```

## 🧪 Testing

```bash
# Quick smoke test
./scripts/ai_change_check.sh

# Full test suite
pytest tests/test_ai_babysitter.py -v

# Check metrics
curl http://localhost:8000/metrics | jq .
```