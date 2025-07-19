# Markdown Brain Bot - Project Handoff Document

## Project Overview

Building a Telegram-based markdown knowledge management bot for 10NetZero that will:
1. Accept natural language input via Telegram
2. Store knowledge as markdown files (initially) → vector database (in progress)
3. Connect to existing 10NetZero Supabase SSOT database
4. Serve as a "shared brain" for the team

## Current Status

### ✅ Completed
1. **Basic Bot Structure** - Working Telegram bot using polling mode
2. **File-based Knowledge Storage** - Creates/reads/searches markdown files
3. **Context-Aware System Prompt** - Understands 10NetZero organizational structure
4. **Conversation Memory** - In-memory history with 1-hour expiry
5. **Environment Configuration** - All settings in .env file
6. **Test Suite** - Comprehensive tests for search and context awareness
7. **Bot Management Scripts** - `botlogs` and `botrestart` aliases

### 🚧 In Progress
1. **Upstash Integration**
   - Redis configuration added to .env (for persistent conversation memory)
   - Vector DB configuration added to .env (for semantic search)
   - Need to implement actual integration code
   
   **Redis Integration Needed For:**
   - Persistent conversation memory (survives bot restarts)
   - User session management
   - Rate limiting
   - Temporary data caching
   
   **Vector Integration Needed For:**
   - Semantic search (replaces unreliable file search)
   - Document embeddings storage
   - Hybrid search (keyword + semantic)
   - Fast retrieval of relevant context

2. **Supabase SSOT Connection**
   - Found existing FLRTS database with complete schema
   - Project ID: `thnwlykidzhrsagyjncc`
   - Has sites, partners, vendors, financial tables already set up
   - Need to sync with QuickBooks exports and Airtable data

### 📋 Todo List Status
```
[pending] Deploy to Render once everything works
[pending] Document prompt optimization changes
[pending] Test enhanced context awareness
[pending] Implement vector search functionality
[pending] Migrate existing markdown files to vector DB
[pending] Update bot to use vector search by default
[in_progress] Connect to existing 10NZ Supabase SSOT database
[pending] Import QuickBooks data into Supabase
[pending] Sync Airtable site/partner data
```

## Key Technical Details

### Architecture
```
Current: Telegram → Bot → File System (markdown)
Target:  Telegram → Bot → Vector DB + Supabase SSOT
```

### Important Files
- `main_polling.py` - Main bot implementation
- `llm.py` - OpenAI integration with conversation memory
- `tools.py` - File operations
- `config.py` - Configuration management
- `.env` - Contains all API keys and settings

### Critical Context

#### 10NetZero Sites & Relationships
From Airtable screenshots:
- **Eagle Lake** (10% markup)
  - Partner: Flober LLC
  - Aliases: English, Wharton, English 1, ENG
- **Mathis** (20% markup)
  - Partner: WasteWatt Ventures LLC
  - Aliases: Buetnagel
- **Crockett** (10% markup)
  - Partner: Operation Orange LLC
  - Aliases: 1511 Co Road

#### Current Issue
The bot works but doesn't leverage its full potential:
1. Still using file-based search (often fails to find things)
2. Not connected to Supabase SSOT with financial/operational data
3. Vector search would make it much more reliable

## Next Steps

### 1. Implement Redis + Vector Search

#### Redis Implementation (redis_store.py)
```python
# For persistent conversation memory
from upstash_redis import Redis

redis = Redis(
    url=UPSTASH_REDIS_REST_URL,
    token=UPSTASH_REDIS_REST_TOKEN
)

# Replace in-memory conversation_history with:
async def get_conversation(chat_id: str):
    return await redis.get(f"conv:{chat_id}")

async def save_conversation(chat_id: str, messages: list):
    await redis.setex(
        f"conv:{chat_id}", 
        3600,  # 1 hour TTL
        json.dumps(messages)
    )
```

#### Vector Implementation (vector_store.py)
```python
# The user has configured Upstash Vector with:
# - Model: BAAI/bge-small-en-v1.5
# - Dimensions: 384
# - Type: Hybrid (BM25 + dense)
# - Metric: Cosine

from upstash_vector import Index
from sentence_transformers import SentenceTransformer

# Initialize
vector_index = Index(
    url=UPSTASH_VECTOR_REST_URL,
    token=UPSTASH_VECTOR_REST_TOKEN
)
model = SentenceTransformer('BAAI/bge-small-en-v1.5')

# Core operations needed:
1. embed_and_store() - Convert text to vectors and store
2. search() - Always called FIRST before any response
3. migrate_existing() - One-time migration of markdown files
```

### 2. Connect to Supabase SSOT

#### CRITICAL: Database Population Needed
The Supabase database has the schema but needs real data:

**Step 1: Update Sites Table with Real 10NetZero Sites**
```sql
-- Current has sample data (North Austin, West Houston, Phoenix)
-- Need to replace with:
- Eagle Lake (aliases: English, Wharton, English 1, ENG)
- Mathis (aliases: Buetnagel)  
- Crockett (aliases: 1511 Co Road)
```

**Step 2: Import QuickBooks Data**
Located at: `/Users/colinaulds/Downloads/`
- `10NetZero, Inc. Jul 18, 2025-2.zip` contains:
  - Balance_sheet.xlsx
  - Profit_and_loss.xlsx
  - General_ledger.xlsx
  - Journal.xlsx
  - Trial_balance.xlsx
  - Vendors.xlsx
  - Customers.xlsx
  - Employees.xlsx

- `10NetZero, Inc. Jul 18, 2025.zip` (appears to be duplicate)

**Step 3: Sync Airtable Site-Partner Relationships**
From screenshots at `/Users/colinaulds/Desktop/tables/`:
- Eagle Lake → Flober LLC (10% markup)
- Mathis → WasteWatt Ventures LLC (20% markup)
- Crockett → Operation Orange LLC (10% markup)

**Import Script Needed:**
```python
# 1. Parse Excel files from QuickBooks
# 2. Map to Supabase schema:
#    - vendors → vendors table
#    - customers → partners table (where applicable)
#    - transactions → vendor_invoices table
# 3. Create site_partner_assignments with correct markup %
# 4. Let triggers calculate partner_billings automatically
```

### 3. Integration Architecture
```python
# Bot should query BOTH systems:
async def process_query(user_message):
    # 1. Always search vectors first
    context = await upstash_vector.search(user_message)
    
    # 2. Check if query needs Supabase data
    if needs_financial_data(user_message):
        supabase_data = await query_supabase(user_message)
        context.extend(supabase_data)
    
    # 3. Generate response with full context
    return llm.generate(prompt, context)
```

## User's Vision

Colin wants:
1. A true "company brain" that all tools can access
2. Supabase as the SSOT for structured data
3. Vector DB for knowledge/document search
4. Bot that seamlessly queries both
5. Future: Personal namespaces for each user + shared knowledge

## Environment Variables Needed

The following are configured in .env and ready to use:
```env
# Telegram
TELEGRAM_BOT_TOKEN=✓ (configured)

# OpenAI
OPENAI_API_KEY=✓ (configured)

# Upstash
UPSTASH_REDIS_REST_URL=✓ (configured)
UPSTASH_REDIS_REST_TOKEN=✓ (configured)
UPSTASH_VECTOR_REST_URL=✓ (configured)
UPSTASH_VECTOR_REST_TOKEN=✓ (configured)

# Supabase (need to add)
SUPABASE_URL=https://thnwlykidzhrsagyjncc.supabase.co
SUPABASE_ANON_KEY=(need from Supabase dashboard)
SUPABASE_SERVICE_KEY=(for admin operations)
```

## Commands to Run

```bash
# To test the bot
botlogs  # Full logging
botrestart  # Quick restart

# To run tests
python tests/test_search_resilience.py
python tests/test_context_awareness.py

# Current branch
git branch  # Currently on 'prompt-optimization'
```

## Key Insights

1. **Vector search solves the main pain point** - No more "I can't find that"
2. **Supabase SSOT enables financial queries** - "What's our revenue at Eagle Lake?"
3. **Hybrid search (dense + sparse) is perfect** - Handles both semantic and exact matches
4. **The schema is already built** - Just need to populate with real data

## Questions for Colin

1. Should we update the sample sites in Supabase to the real ones (Eagle Lake, Mathis, Crockett)?
2. Do you want to import ALL QuickBooks data or just specific tables?
3. Should the bot have write access to Supabase financial data or read-only?
4. Priority: Vector search first or Supabase integration first?

---

**Note to next Claude**: The user (Colin) is very technical and prefers direct, efficient communication. The bot is part of a larger vision for a unified company knowledge system. Focus on making it work reliably first, then expand features.