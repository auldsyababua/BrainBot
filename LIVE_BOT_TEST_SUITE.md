# Live Bot Test Suite & Log Verification

## Test Instructions
Send these messages to your bot in order. After completing all tests, download the Render logs and search for the expected patterns.

---

## Test Messages to Send

### Phase 1: Basic Commands & Setup

#### 1. Start Command
**Send:** `/start`
**Expected Log Pattern:** 
```
Received update from Telegram
.*command.*start
Welcome to Markdown Brain Bot
```

#### 2. Help Command
**Send:** `/help`
**Expected Log Pattern:**
```
.*command.*help
.*Available commands:
```

#### 3. Version Command
**Send:** `/version`
**Expected Log Pattern:**
```
.*command.*version
.*Version:.*
```

### Phase 2: List Operations

#### 4. Create New List (Natural Language)
**Send:** `create new shopping list`
**Expected Log Pattern:**
```
.*entity_type.*lists
.*operation.*create
.*list_name.*shopping
```

#### 5. Create List with Slash Command
**Send:** `/newlist Grocery Items`
**Expected Log Pattern:**
```
.*Explicit command detected.*/newlist
.*confidence.*1\.0
.*list_name.*Grocery Items
```

#### 6. Add Single Item to Existing List
**Send:** `add milk to shopping list`
**Expected Log Pattern:**
```
.*entity_type.*lists
.*operation.*add_items
.*items.*milk
.*list_identifier.*shopping
```

#### 7. Add Multiple Items with Commas
**Send:** `add eggs, bread, butter, cheese to grocery items`
**Expected Log Pattern:**
```
.*Comma-separated items detected
.*items.*eggs.*bread.*butter.*cheese
.*confidence.*0\.[8-9]
```

#### 8. Interactive List Mode
**Send:** `/lists`
**Expected Log Pattern:**
```
.*operation.*interactive
.*entity_type.*lists
.*use_direct_execution.*false
```

#### 9. Remove Items from List
**Send:** `remove milk from shopping list`
**Expected Log Pattern:**
```
.*operation.*remove_items
.*items.*milk
.*list_identifier.*shopping
```

### Phase 3: Task Operations

#### 10. Create Task with User Assignment
**Send:** `@joel create new task to check generator`
**Expected Log Pattern:**
```
.*Extracted.*@joel.*from message
.*entity_type.*tasks
.*operation.*create
.*target_users.*joel
.*assignee_confidence.*1\.0
```

#### 11. Create Task with Slash Command
**Send:** `/newtask Review safety protocols`
**Expected Log Pattern:**
```
.*Explicit command detected.*/newtask
.*entity_type.*tasks
.*task_description.*Review safety protocols
```

#### 12. Reassign Existing Task
**Send:** `reassign generator task to @bryan`
**Expected Log Pattern:**
```
.*operation.*reassign
.*target_users.*bryan
.*task_identifier.*generator
```

#### 13. Complete Task
**Send:** `/completetask`
**Expected Log Pattern:**
```
.*Explicit command detected.*/completetask
.*operation.*complete
.*confidence.*1\.0
```

#### 14. Task with Multiple Users
**Send:** `assign task to @joel and @bryan to inspect all pumps`
**Expected Log Pattern:**
```
.*target_users.*joel.*bryan
.*task_description.*inspect all pumps
```

### Phase 4: Field Reports

#### 15. Create Field Report
**Send:** `new field report for Eagle Lake: temperature 72F, pressure normal`
**Expected Log Pattern:**
```
.*entity_type.*field_reports
.*operation.*create
.*site.*Eagle Lake
.*content.*temperature 72F.*pressure normal
```

#### 16. Field Report with Colon Pattern
**Send:** `Site Crockett: All systems operational, maintenance completed`
**Expected Log Pattern:**
```
.*Field report pattern matched
.*site.*Crockett
.*content.*All systems operational
```

#### 17. Field Report Slash Command
**Send:** `/fr Mathis site inspection complete`
**Expected Log Pattern:**
```
.*Explicit command detected.*/fr
.*entity_type.*field_reports
.*confidence.*1\.0
```

### Phase 5: Context Commands

#### 18. Task Context Command
**Send:** `/tnr check oil levels`
**Expected Log Pattern:**
```
.*Context command.*/tnr
.*entity_type.*tasks
.*Boosted confidence.*context
```

#### 19. Add to List with Context
**Send:** `/addtolist grocery items: apples, oranges`
**Expected Log Pattern:**
```
.*Explicit command detected.*/addtolist
.*items.*apples.*oranges
```

### Phase 6: Edge Cases & Cleanup

#### 20. Ambiguous Message
**Send:** `update the list`
**Expected Log Pattern:**
```
.*Low confidence
.*confidence.*0\.[0-6]
.*Could not determine
```

#### 21. Continue Command
**Send:** `/continue`
**Expected Log Pattern:**
```
.*command.*continue
.*Continuing from previous
```

#### 22. Report Command
**Send:** `/report`
**Expected Log Pattern:**
```
.*command.*report
.*Usage report
```

#### 23. Reset Command
**Send:** `/reset`
**Expected Log Pattern:**
```
.*command.*reset
.*Conversation history cleared
```

---

## Log Analysis Script

After downloading logs, use this grep command to extract test results:

```bash
# Save logs to render_logs.txt, then run:
grep -E "(Routing message|entity_type|operation|confidence|command|target_users|Explicit command|Field report pattern)" render_logs.txt > test_results.txt
```

## Test Coverage Summary

### ✅ Commands Tested (11 total)
- [ ] `/start` - Basic bot initialization
- [ ] `/help` - Command listing
- [ ] `/version` - Version info
- [ ] `/reset` - Clear conversation
- [ ] `/continue` - Resume conversation
- [ ] `/report` - Usage statistics
- [ ] `/lists` - Interactive list mode
- [ ] `/newlist` - Create list
- [ ] `/newtask` - Create task
- [ ] `/completetask` - Complete task
- [ ] `/fr` - Field report
- [ ] `/tnr` - Task context
- [ ] `/addtolist` - Add to list

### ✅ @ Mention Patterns (4 types)
- [ ] `@user` at start of message
- [ ] Task assignment to `@user`
- [ ] Multiple users `@user1 and @user2`
- [ ] Reassignment to `@user`

### ✅ Entity Operations
**Lists (5 operations):**
- [ ] Create new list (natural language)
- [ ] Create with `/newlist`
- [ ] Add single item to existing list
- [ ] Add multiple items (comma-separated)
- [ ] Remove items from list

**Tasks (5 operations):**
- [ ] Create with user assignment
- [ ] Create with `/newtask`
- [ ] Reassign to different user
- [ ] Complete task
- [ ] Multi-user assignment

**Field Reports (3 operations):**
- [ ] Create with "new field report for [site]"
- [ ] Create with "Site [name]:" pattern
- [ ] Create with `/fr` command

### ✅ Reference Patterns
- [ ] Reference existing list by name ("shopping list")
- [ ] Reference existing task by description ("generator task")
- [ ] Reference sites by name ("Eagle Lake", "Crockett", "Mathis")

---

## Common Issues to Check

1. **Webhook Not Receiving Updates**
   - Look for: `Received update from Telegram`
   - If missing: Check webhook URL in Render

2. **Database Connection Issues**
   - Look for: `Database connection failed` or `Supabase error`
   - If found: Check environment variables

3. **Routing Failures**
   - Look for: `Exception` or `Error in routing`
   - If found: Check for missing imports or syntax errors

4. **Memory/Performance Issues**
   - Look for: Response times > 1000ms
   - If found: Check for database query optimization

---

## Expected Log Summary

After all 15 tests, you should see:
- 15 "Received update" entries
- 4 command executions (start, version, help, reset)
- 11 routing operations
- At least 8 high confidence (>0.7) routes
- 1 low confidence (<0.7) route
- 0 unhandled exceptions