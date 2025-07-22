# 🧠 BrainBot - CAG (Creation Augmented Generation)

An intelligent Telegram bot that acts as your personal filing assistant. Send it any information and it automatically organizes everything without asking questions - like having a hyper-competent assistant who just handles knowledge management.

> **Architecture**: Webhook-based (production) | Polling (local development)  
> **Philosophy**: Append-only, source-preserving, auto-organizing

## 🎯 Core Features

- **Auto-Organization**: Intelligently files information without user intervention
- **Source Preservation**: Every input preserved with audit trail
- **Smart Merging**: Automatically combines similar content while keeping sources
- **Natural Search**: Ask questions in plain language, get relevant answers
- **No Questions Asked**: The bot decides how to organize, not you
- **Cross-Device Sync**: Dump notes from any device, access from anywhere

## 🚀 How It Works

1. **Send any text** to the bot via Telegram
2. **Bot analyzes** content and existing knowledge structure  
3. **Auto-files** by either merging with similar content or creating new
4. **Preserves sources** - every derivative references its origins
5. **Brief confirmation** - "Added to project notes" or "Merged with existing FAQ"

Think of it as "Git for thoughts" - all versions preserved, intelligently organized.

## 🚀 Quick Start

### 1. Prerequisites

- Python 3.9+
- Telegram Bot Token (from [@BotFather](https://t.me/botfather))
- OpenAI API Key
- Upstash Redis database (for conversation persistence)
- Upstash Vector database (for semantic search)

### 2. Installation

```bash
# Clone the repository
git clone <your-repo-url>
cd markdown-brain-bot

# Install dependencies
pip install -r requirements.txt

# Copy .env template and add your keys
cp .env.example .env
# Edit .env with your TELEGRAM_BOT_TOKEN and OPENAI_API_KEY
```

### 3. Running Locally

```bash
# FOR LOCAL DEVELOPMENT - Use polling mode (no webhook needed)
python run_bot.py

# Alternative: run polling directly
python src/bot/main_polling.py
```

### 4. Production Deployment (Webhook Mode)

```bash
# Production uses webhooks - DO NOT use polling in production!
# Render automatically runs: python webhook_server.py
# This starts a FastAPI server that receives webhook events

# To set up webhook after deployment:
python setup_webhook.py  # or python src/bot/set_webhook.py
```

## 📝 Usage Examples

### Creating Content
- "Create a shopping list with milk, eggs, and bread"
- "Make a note about the team meeting tomorrow"
- "Create a recipe for chocolate chip cookies"

### Adding to Existing Content
- "Add butter to the shopping list"
- "Add a note about the deadline to the team meeting"

### Reading Content
- "What's on the shopping list?"
- "Show me the team meeting notes"
- "What's in the cookie recipe?"

### Searching
- "Find all notes about meetings"
- "Search for recipes"
- "What notes do we have?"

## 📂 Project Structure

```
markdown-brain-bot/
├── 🏭 PRODUCTION FILES
├── webhook_server.py           # ⭐ PRODUCTION: FastAPI webhook server
├── setup_webhook.py            # ⭐ PRODUCTION: Configure webhook URL
├── requirements.txt            # ⭐ PRODUCTION: Dependencies
├── render.yaml                 # ⭐ PRODUCTION: Render deployment config
├── README.md                   # Project documentation
├── .env                        # Environment variables
├── .gitignore                  # Git ignore file
│
├── 🧪 LOCAL TESTING FILES
├── run_bot.py                  # 🧪 LOCAL: Run bot with polling
├── test_bot_local.py          # 🧪 LOCAL: Duplicate of run_bot.py (DELETE THIS)
├── main.py                     # ⚠️ CONFUSING: Production file that uses polling
│
├── src/                        # Source code
│   ├── __init__.py
│   ├── bot/                    # Bot-specific code
│   │   ├── __init__.py
│   │   ├── main_polling.py    # 🧪 LOCAL: Polling implementation
│   │   ├── main_webhook.py    # ⭐ PRODUCTION: Webhook implementation
│   │   └── set_webhook.py     # ⭐ PRODUCTION: Alternative webhook setter
│   ├── storage/                # Storage services
│   │   ├── __init__.py
│   │   ├── storage_service.py
│   │   ├── media_storage.py
│   │   ├── redis_store.py
│   │   └── vector_store.py
│   ├── core/                   # Core functionality
│   │   ├── __init__.py
│   │   ├── config.py
│   │   ├── tools.py
│   │   ├── llm.py
│   │   ├── chunking.py
│   │   └── version.py
│   └── migrations/             # Data migration scripts
│       ├── __init__.py
│       ├── migrate_to_vector.py
│       └── add_to_vector.py
│
├── scripts/                    # Utility scripts
│   ├── diagnostics/           # Diagnostic tools
│   │   ├── diagnose_vector.py
│   │   ├── remote_diagnostic.py
│   │   └── list_vector_contents.py
│   ├── deployment/            # Deployment scripts
│   │   ├── bot-restart.sh
│   │   ├── botlogs.sh
│   │   └── start.py
│   └── database/              # Database scripts
│       ├── create_document_storage_tables.sql
│       └── audit_queries.sql
│
├── tests/                     # All tests
│   ├── integration/           # Integration tests
│   │   ├── test_document_storage.py
│   │   ├── test_media_storage.py
│   │   └── test_s3_connection.py
│   ├── unit/                  # Unit tests
│   │   ├── test_context_awareness.py
│   │   └── test_search_resilience.py
│   └── scratch/               # Temporary test files
│       ├── test_chunked_migration.py
│       ├── test_chunking.py
│       └── test_full_content_search.py
│
├── docs/                      # Documentation
│   ├── DEPLOYMENT_GUIDE.md
│   ├── STORAGE_IMPLEMENTATION_PLAN.md
│   ├── STORAGE_OPTIONS.md
│   └── VECTOR_ENHANCEMENT_PLAN.md
│
├── notes/                     # Knowledge base (unchanged)
│   └── ...
│
└── logs/                      # Log files (unchanged)
    └── ...
```

## 🔧 Configuration

Environment variables in `.env`:

```env
# Required
TELEGRAM_BOT_TOKEN=your_bot_token_here
OPENAI_API_KEY=your_openai_api_key_here
UPSTASH_REDIS_REST_URL=your_upstash_redis_url_here
UPSTASH_REDIS_REST_TOKEN=your_upstash_redis_token_here
UPSTASH_VECTOR_REST_URL=your_upstash_vector_url_here
UPSTASH_VECTOR_REST_TOKEN=your_upstash_vector_token_here

# Optional
VECTOR_NAMESPACE=10netzero
VECTOR_TOP_K=5

# Performance Configuration (NEW)
VECTOR_CACHE_ENABLED=true          # Enable vector search caching
VECTOR_CACHE_TTL=300              # Cache TTL in seconds (5 minutes)
CONVERSATION_MAX_MESSAGES=20       # Max messages in conversation window
CONVERSATION_TTL_HOURS=24         # Hours before conversation expires
```

## 🚢 Deployment

### Render.com (Recommended)

1. **Set up Upstash services**:
   - Create [Upstash Redis](https://upstash.com) database
   - Create [Upstash Vector](https://upstash.com/docs/vector) database
   - Note the REST URLs and tokens

2. **Deploy to Render**:
   - Fork this repository to your GitHub account
   - Connect your forked repository to Render
   - Use the included `render.yaml` configuration
   - Set environment variables in Render dashboard:
     - `TELEGRAM_BOT_TOKEN` (from @BotFather)
     - `OPENAI_API_KEY` (from OpenAI)
     - `UPSTASH_REDIS_REST_URL` & `UPSTASH_REDIS_REST_TOKEN`
     - `UPSTASH_VECTOR_REST_URL` & `UPSTASH_VECTOR_REST_TOKEN`

3. **Initialize knowledge base** (optional):
   - Run the migration script to populate vector database
   - Upload markdown files via Telegram

## 🛠️ Development

### Running Tests

```bash
# Run all tests
python tests/test_all_storage.py

# Run performance tests specifically
python tests/test_performance.py

# Run integration tests
python tests/integration/test_storage_integrations.py
```

### Performance Monitoring

```bash
# Check real-time metrics (when bot is running)
curl http://localhost:8000/metrics

# View performance in local development
python scripts/local_dev.py
# Watch console for timing logs: ⏱️ vector_search: 0.234s

# Run performance test suite
python tests/test_performance.py
```

See [Testing Guide](tests/README.md) and [Monitoring Guide](docs/MONITORING_GUIDE.md) for detailed information.

### File Format

All files use YAML frontmatter:

```markdown
---
title: Shopping List
type: list
created: 2025-01-18
updated: 2025-01-18 14:30:00
tags: [shopping, groceries]
---

# Shopping List

- Milk
- Eggs
- Bread
```

## 🔮 Roadmap

**Current (MVP)**:
- ✅ Basic auto-organization
- 🔄 Source tracking for audit trails
- 🔄 Supabase + Vector sync

**Next Phase**:
- [ ] Auth via Telegram + Supabase (audit trail for all interactions)
- [ ] FLRTS structure (Field reports, Lists, Reminders, Tasks, Sub-tasks)
- [ ] Chunking pipeline for all uploaded documents
- [ ] Web UI for viewing vectors/documents
- [ ] Private namespace support for multi-user isolation
- [ ] Time awareness (date injection, reminders, timers)

**Advanced Features**:
- [ ] Agent selection in Telegram bot
- [ ] Rich outputs (charts, graphs, images)
- [ ] Web search and external tools integration
- [ ] Full training mode (beyond just vector returns)
- [ ] Conversation vectorization for better memory
- [ ] Smart CAG/RAG prompt switching
- [ ] Tool calls tied to UI buttons (new task, reminder)
- [ ] Redis configuration optimization

**Infrastructure**:
- [ ] Persist all conversations to vector store
- [ ] Sync between human-readable notes and vector store
- [ ] Store all original submissions with audit trail
- [ ] Add vector-supabase sync verification to test suite

## 📄 License

MIT License - feel free to use this for your team!

## 🤝 Contributing

Pull requests are welcome! Please ensure:
- Code follows Python best practices
- All functions have docstrings
- Tests pass before submitting PR

---

Built with ❤️ for teams who love markdown