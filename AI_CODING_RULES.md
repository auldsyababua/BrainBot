# AI Coding Rules for Markdown Brain Bot

> **CRITICAL**: Follow these rules when making ANY code changes to prevent breaking existing functionality.

## 🚨 MANDATORY Steps Before and After Coding

### Before You Start
1. Read this document completely
2. Understand what feature you're implementing
3. Check existing code patterns in the file you're modifying

### After Every Change
```bash
# ALWAYS run this after making changes
./scripts/ai_change_check.sh
```

**If tests fail, FIX THEM before proceeding. Do not ignore test failures.**

---

## 📋 Core Requirements

### Database and Storage
- **MUST** use `redis_store` for conversation data - never store in memory
- **MUST** use `vector_store` for note storage and search - never use file storage directly
- **MUST** await all async database operations
- **NEVER** store user data in global variables or class attributes

### API Client Usage
- **MUST** use `get_resilient_client()` or the global `resilient_client` for OpenAI calls
- **NEVER** create new `OpenAI()` client instances
- **MUST** use the existing retry configuration
- **NEVER** make API calls without error handling

### Configuration
- **MUST** use values from `src/core/config.py` 
- **NEVER** hardcode configuration values (timeouts, limits, etc.)
- **MUST** respect `CONVERSATION_MAX_MESSAGES` for sliding window
- **MUST** use `SYSTEM_PROMPT` from config, not custom prompts

### Error Handling
- **MUST** handle `None` inputs gracefully
- **MUST** handle empty string inputs 
- **MUST** handle malformed inputs without crashing
- **MUST** return meaningful error messages to users
- **NEVER** let exceptions bubble up to the user interface

### Performance
- **MUST** use existing caching mechanisms
- **NEVER** make redundant API calls for the same request
- **MUST** respect rate limits and implement backoff
- **MUST** limit memory usage (no infinite data structures)

---

## 🏗️ Code Patterns to Follow

### Adding New Features
```python
# ✅ CORRECT - Follow existing patterns
from src.core.llm import process_message, conversation_manager
from src.core.api_client import get_resilient_client
from src.storage.redis_store import redis_store

# Use existing functions, don't reinvent
response = await process_message(user_input, chat_id)
```

### Database Operations
```python
# ✅ CORRECT
await redis_store.save_conversation(chat_id, messages)
await vector_store.embed_and_store(doc_id, content, metadata)

# ❌ WRONG - Don't store in memory
conversations = {}  # This data disappears on restart!
```

### API Calls
```python
# ✅ CORRECT
client = get_resilient_client()
response = await client.chat_completion(messages=messages, model=GPT_MODEL)

# ❌ WRONG - Don't create new clients
client = OpenAI(api_key=API_KEY)  # Bypasses retry logic!
```

### Error Handling
```python
# ✅ CORRECT
try:
    result = await some_operation()
    if result is None:
        return "I couldn't process that request. Please try again."
    return result
except Exception as e:
    logger.error(f"Operation failed: {e}")
    return "I encountered an error. Please try a different approach."

# ❌ WRONG - Don't let errors crash
result = await some_operation()  # What if this fails?
return result.some_property  # What if result is None?
```

---

## 🔍 Common AI Mistakes to Avoid

### 1. Forgetting to Connect New Code
```python
# ❌ WRONG - Created function but never called it
def amazing_new_feature():
    return "This is great!"

# ✅ CORRECT - Actually integrate with existing code
async def process_message(user_message, chat_id):
    # ... existing code ...
    if "amazing" in user_message:
        return amazing_new_feature()
    # ... rest of function ...
```

### 2. Creating Dead Configuration
```python
# ❌ WRONG - Config exists but isn't used
RETRY_CONFIG = RetryConfig(max_retries=5)
client = OpenAI()  # Not using the retry config!

# ✅ CORRECT - Actually use the config
client = get_resilient_client(RETRY_CONFIG)
```

### 3. Breaking User Isolation
```python
# ❌ WRONG - All users share same data
user_notes = []  # Global list shared by everyone!

# ✅ CORRECT - Use chat_id to separate users
await redis_store.save_conversation(chat_id, messages)
```

### 4. Memory Leaks
```python
# ❌ WRONG - Grows forever
all_conversations = {}  # Never cleared!

# ✅ CORRECT - Use database with TTL
await redis_store.save_conversation(chat_id, messages)  # Has TTL
```

---

## ⚙️ Testing Requirements

### Before Submitting Code
1. **Run quick check**: `./scripts/ai_change_check.sh`
2. **Run full tests**: `./scripts/test_ai_babysitter.sh` 
3. **Check linting**: `ruff check . && black .`

### When Tests Fail
1. **Read the error message completely**
2. **Understand WHY it failed** (don't just make it pass)
3. **Fix the underlying issue**
4. **Re-run tests to confirm fix**

### Common Test Failures and Fixes

**"Cache doesn't seem to be working"**
- You probably bypassed the caching layer
- Make sure you're using `vector_store.search()` not creating new instances

**"Data didn't survive restart simulation"**
- You're storing data in memory instead of database
- Use `redis_store` or `vector_store` for persistence

**"User isolation broken"**
- You're not using `chat_id` to separate user data
- Always include `chat_id` in database operations

**"Too many API calls"**
- You're making redundant API calls
- Check if data is already cached or available

---

## 📋 Quick Reference Checklist

Before submitting ANY code change:

- [ ] Used existing patterns from similar code
- [ ] All database operations use `redis_store` or `vector_store`
- [ ] All API calls use `get_resilient_client()`
- [ ] Configuration values come from `src/core/config.py`
- [ ] Error handling covers `None`, empty, and malformed inputs
- [ ] No global variables storing user data
- [ ] Ran `./scripts/ai_change_check.sh` and all tests pass
- [ ] Linting passes: `ruff check . && black .`

---

## 🆘 When You Break Something

1. **Don't panic** - the tests caught it before users saw it
2. **Read the test failure message carefully**
3. **Look at the existing code** to see how it should work
4. **Fix the specific issue** mentioned in the test
5. **Re-run tests** to confirm the fix
6. **Ask for help** if you're stuck (explain what test failed and what you tried)

## 📚 Key Files to Understand

- `src/core/llm.py` - Main message processing logic
- `src/core/config.py` - All configuration values
- `src/storage/redis_store.py` - Conversation storage
- `src/storage/vector_store.py` - Note storage and search
- `src/core/api_client.py` - OpenAI API with retry logic
- `tests/test_ai_babysitter.py` - Tests that catch AI mistakes

---

**Remember: These tests exist to help you, not make your life harder. They catch mistakes before users encounter them, saving everyone time and frustration.**
