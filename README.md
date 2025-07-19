# 🧠 Markdown Brain Bot

A shared knowledge Telegram bot that stores all information as markdown files in a local folder structure.

## 🎯 Features

- **Natural Language Processing**: Uses OpenAI GPT-4o to understand user requests
- **Persistent Conversations**: Redis-backed conversation memory across bot restarts
- **Semantic Search**: Vector database search enhances responses with relevant context
- **Smart Todo Lists**: Checkbox formatting with completion tracking
- **Markdown Storage**: All knowledge stored as `.md` files with YAML frontmatter
- **Automatic Organization**: Maintains index.md and folder README.md files
- **Shared Brain**: Acts as a team's collective memory (no user differentiation)

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
# Start the bot in polling mode (recommended for local development)
python main.py

# Or run directly from src
python src/bot/main_polling.py

# Or use webhook mode (requires ngrok for local testing)
python src/bot/main_webhook.py
# In another terminal: ngrok http 8000
# Set webhook: python src/bot/set_webhook.py https://your-ngrok-url.ngrok.io
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
├── main.py                     # Main entry point
├── requirements.txt            # Dependencies
├── README.md                   # Project documentation
├── .env                        # Environment variables
├── .gitignore                  # Git ignore file
│
├── src/                        # Source code
│   ├── __init__.py
│   ├── bot/                    # Bot-specific code
│   │   ├── __init__.py
│   │   ├── main_polling.py
│   │   ├── main_webhook.py
│   │   └── set_webhook.py
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
pytest tests/
```

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

## 📋 TODO (v2)

- [ ] Scripted guardrails for index consistency
- [ ] Markdown linting
- [ ] GitHub backup integration
- [ ] User permissions system
- [ ] Web UI for browsing notes

## 🚀 Future Features

### Dynamic Task Management ⭐ NEXT
- **Cross-Referenced Tasks**: Tasks automatically appear in multiple views
- **Smart Entity Recognition**: Recognize users, sites, equipment in commands
- **Database Integration**: Sync with existing company database
- **Example**: "Add task for technician to service equipment at Site A"
  - Creates entry in technician's task list
  - Creates entry in site task list  
  - Links both for synchronized updates

### Advanced Analytics
- **Usage Tracking**: Monitor team knowledge patterns
- **Search Analytics**: Most accessed content
- **Knowledge Gaps**: Identify missing information
- **Team Insights**: Collaboration patterns

## 📄 License

MIT License - feel free to use this for your team!

## 🤝 Contributing

Pull requests are welcome! Please ensure:
- Code follows Python best practices
- All functions have docstrings
- Tests pass before submitting PR

---

Built with ❤️ for teams who love markdown