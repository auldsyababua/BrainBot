# 🧠 Markdown Brain Bot

A shared knowledge Telegram bot that stores all information as markdown files in a local folder structure.

## 🎯 Features

- **Natural Language Processing**: Uses OpenAI GPT-4o to understand user requests
- **Markdown Storage**: All knowledge stored as `.md` files with YAML frontmatter
- **Automatic Organization**: Maintains index.md and folder README.md files
- **No Database**: Pure filesystem-based storage
- **Shared Brain**: Acts as a team's collective memory (no user differentiation)

## 🚀 Quick Start

### 1. Prerequisites

- Python 3.9+
- Telegram Bot Token (from [@BotFather](https://t.me/botfather))
- OpenAI API Key

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
# Start the FastAPI server
uvicorn main:app --reload

# In another terminal, expose via ngrok (for Telegram webhook)
ngrok http 8000

# Set your Telegram webhook
curl -X POST "https://api.telegram.org/bot<YOUR_BOT_TOKEN>/setWebhook" \
     -H "Content-Type: application/json" \
     -d '{"url": "https://your-ngrok-url.ngrok.io/webhook"}'
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

## 📂 File Structure

```
markdown-brain-bot/
├── main.py             # FastAPI + Telegram webhook
├── llm.py              # GPT-4o integration
├── tools.py            # File operations
├── config.py           # Configuration
├── notes/              # All markdown files stored here
│   ├── index.md        # Global index
│   ├── shopping-list.md
│   └── recipes/
│       ├── README.md   # Folder index
│       └── cookies.md
└── requirements.txt
```

## 🔧 Configuration

Environment variables in `.env`:

```env
TELEGRAM_BOT_TOKEN=your_bot_token_here
OPENAI_API_KEY=your_openai_api_key_here
```

## 🚢 Deployment

### Option 1: Render.com

1. Create a new Web Service
2. Connect your GitHub repository
3. Set environment variables
4. Deploy

### Option 2: Fly.io

```bash
# Install flyctl
curl -L https://fly.io/install.sh | sh

# Deploy
fly launch
fly secrets set TELEGRAM_BOT_TOKEN="your_token"
fly secrets set OPENAI_API_KEY="your_key"
fly deploy
```

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

## 📄 License

MIT License - feel free to use this for your team!

## 🤝 Contributing

Pull requests are welcome! Please ensure:
- Code follows Python best practices
- All functions have docstrings
- Tests pass before submitting PR

---

Built with ❤️ for teams who love markdown