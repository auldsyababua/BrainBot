# Future Features for Markdown Brain Bot

## Multi-Namespace Knowledge Base System

### Concept
Allow users to switch between personal and shared knowledge bases using namespaces.

### Implementation Design

#### 1. Namespace Structure
```
Namespaces:
- "" (empty) = Shared team knowledge
- "colin_personal" = Colin's private notes
- "bryan_personal" = Bryan's private notes  
- "joel_personal" = Joel's private notes
- "10netzero" = Company-wide knowledge
```

#### 2. User Interface Options

**Option A: Inline Keyboard Buttons**
```python
keyboard = [
    [
        InlineKeyboardButton("📚 Shared", callback_data="db:shared"),
        InlineKeyboardButton("🔒 Personal", callback_data="db:personal")
    ],
    [
        InlineKeyboardButton("🏢 Company", callback_data="db:10netzero"),
        InlineKeyboardButton("🔄 Switch", callback_data="db:switch")
    ]
]
```

**Option B: Commands**
- `/shared` - Switch to shared knowledge base
- `/personal` - Switch to personal knowledge base
- `/switchdb` - Show menu of available databases
- `/status` - Show current database context

#### 3. Context Indicators
Show users which DB they're using:
```
🔍 Searching in: [Shared Knowledge Base]
✅ Note saved to: [Personal Knowledge Base]
```

#### 4. Search Behavior
```python
# Default: Search current namespace only
results = vector_db.query(text, namespace=current_namespace)

# Advanced: Search across multiple
/searchall "Eagle Lake generator"
- Searches: personal + shared + company
- Shows results grouped by source
```

#### 5. Permission Model
- **Personal**: Full CRUD for owner only
- **Shared**: Full CRUD for all team members
- **Company**: Read for all, write requires role

#### 6. Smart Routing
```python
# Automatically detect where content should go
if "10NetZero" in message or "Eagle Lake" in message:
    suggest_namespace = "10netzero"
elif "personal" in message or "private" in message:
    suggest_namespace = f"{user}_personal"
else:
    suggest_namespace = "shared"
```

#### 7. Configuration
```env
# Future configuration
ENABLE_PERSONAL_DB=true
ENABLE_COMPANY_DB=true
DEFAULT_NAMESPACE=shared
ALLOW_CROSS_SEARCH=true
```

### Benefits
1. **Privacy**: Personal notes stay private
2. **Organization**: Clear separation of concerns
3. **Flexibility**: Easy to switch contexts
4. **Scalability**: Add new namespaces easily
5. **Collaboration**: Shared knowledge remains accessible

### Migration Path
1. Start with empty namespace (current plan)
2. Later add personal namespaces
3. Migrate existing content as needed
4. Users can copy between namespaces

---

## Other Future Features

### QStash Reminders
- Scheduled reminders for tasks
- Recurring maintenance alerts
- Follow-up notifications

### Workflow Integration
- Multi-step document processing
- Automated report generation
- Batch operations on knowledge base

### Enhanced Search
- Temporal search ("notes from last week")
- Semantic clustering visualization
- Related document suggestions

### Access Control
- Role-based permissions
- Audit logs for compliance
- Guest access tokens
