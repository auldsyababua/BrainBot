# Live Bot Test Suite & Log Verification

## Test Instructions
Send these messages to your bot in order. After completing all tests, download the Render logs and search for the expected patterns.

---

## Test Messages to Send

### 1. Basic Command Test
**Send:** `/start`
**Expected Log Pattern:** 
```
Received update from Telegram
.*command.*start
```

### 2. Version Command
**Send:** `/version`
**Expected Log Pattern:**
```
.*command.*version
.*Version:.*
```

### 3. Simple List Addition
**Send:** `add milk to shopping list`
**Expected Log Pattern:**
```
.*Routing message.*add milk to shopping list
.*entity_type.*lists
.*operation.*add_items
.*confidence.*0\.[7-9]
```

### 4. Multi-Item List Addition
**Send:** `add eggs, bread, butter to grocery list`
**Expected Log Pattern:**
```
.*Comma-separated items detected.*boost.*
.*entity_type.*lists
.*items.*eggs.*bread.*butter
```

### 5. Task Creation with User
**Send:** `create task for @joel to check generator tomorrow`
**Expected Log Pattern:**
```
.*entity_type.*tasks
.*operation.*create
.*target_users.*joel
.*assignee_confidence.*1\.0
```

### 6. Field Report Creation
**Send:** `new field report for Eagle Lake: temperature 72F, all systems normal`
**Expected Log Pattern:**
```
.*entity_type.*field_reports
.*operation.*create
.*site.*Eagle Lake
.*confidence.*0\.[8-9]
```

### 7. Task Completion
**Send:** `mark generator maintenance task complete`
**Expected Log Pattern:**
```
.*entity_type.*tasks
.*operation.*complete
.*keyword.*complete
```

### 8. Explicit Command Syntax
**Send:** `/newlist Weekend Projects`
**Expected Log Pattern:**
```
.*Explicit command detected.*/newlist
.*entity_type.*lists
.*operation.*create
.*confidence.*1\.0
```

### 9. Interactive Mode
**Send:** `/lists`
**Expected Log Pattern:**
```
.*entity_type.*lists
.*operation.*interactive
.*use_direct_execution.*false
```

### 10. Multi-User Task
**Send:** `assign task to @joel and @bryan to review safety protocols`
**Expected Log Pattern:**
```
.*target_users.*joel.*bryan
.*Multiple user mentions detected
```

### 11. Site Report Pattern
**Send:** `Site Crockett: Generator oil changed, filters replaced`
**Expected Log Pattern:**
```
.*Field report pattern matched
.*site.*Crockett
.*content.*oil changed.*filters replaced
```

### 12. Remove Items from List
**Send:** `remove eggs from shopping list`
**Expected Log Pattern:**
```
.*entity_type.*lists
.*operation.*remove_items
.*items.*eggs
```

### 13. Help Command
**Send:** `/help`
**Expected Log Pattern:**
```
.*command.*help
.*Available commands:
```

### 14. Invalid/Ambiguous Message
**Send:** `update the thing`
**Expected Log Pattern:**
```
.*Low confidence routing
.*confidence.*0\.[0-6]
.*Could not determine a clear action
```

### 15. Reset Command
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

## Success Criteria

### ✅ Routing Accuracy
- [ ] Lists operations route to `entity_type: lists`
- [ ] Task operations route to `entity_type: tasks`
- [ ] Field reports route to `entity_type: field_reports`
- [ ] Commands execute without routing

### ✅ Confidence Levels
- [ ] Explicit commands (`/newlist`) have confidence = 1.0
- [ ] Clear natural language has confidence > 0.7
- [ ] Ambiguous messages have confidence < 0.7
- [ ] User mentions with @ have assignee_confidence = 1.0

### ✅ Data Extraction
- [ ] Multi-item lists extract all items
- [ ] User mentions are resolved correctly
- [ ] Site names are extracted from field reports
- [ ] Time mentions ("tomorrow") are detected

### ✅ Error Handling
- [ ] Invalid commands don't crash the bot
- [ ] Low confidence messages get helpful responses
- [ ] All messages receive some response

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