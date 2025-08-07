# Smart Rails Commands User Guide

## Overview

Smart Rails is a high-performance command processing system that provides lightning-fast response times for common bot operations. It uses keyword-based pattern matching to identify commands with **100% confidence** and executes them directly without LLM processing, resulting in:

- **0 tokens consumed** for direct commands
- **<50ms response time** (vs 2-5 seconds for LLM calls)
- **Consistent, predictable behavior**
- **Natural language flexibility**

## How Smart Rails Works

Smart Rails uses a two-stage processing system:

1. **Keyword Detection**: Analyzes your message for known command patterns
2. **Confidence Scoring**: Determines whether to execute directly (100% confidence) or use LLM processing

### Confidence Levels

- **100% Confidence**: Direct execution, 0 tokens, ~40ms response time
- **70-99% Confidence**: Enhanced LLM prompts with function restrictions
- **<70% Confidence**: Standard LLM processing with full flexibility

## Direct Execution Commands (100% Confidence)

These commands are executed immediately without LLM processing:

### Task Commands

#### Create New Task
```
/newtask Task description here
newtask: Fix the login bug
create task: Update documentation
new task for @username: Review code changes
```

**Expected Output:**
```
✅ Task created: "Fix the login bug"
📝 ID: task_abc123
👤 Assigned to: @username (if specified)
```

#### Complete Task
```
/completetask task_abc123
complete task task_abc123
finished task: task_abc123
mark done: task_abc123
```

**Expected Output:**
```
✅ Task completed: "Fix the login bug"
🎉 Status changed from 'in_progress' to 'completed'
```

#### Reassign Task
```
/reassigntask task_abc123 @newuser
reassign task_abc123 to @newuser
transfer task task_abc123 @newuser
give task_abc123 to @newuser
```

**Expected Output:**
```
🔄 Task reassigned: "Fix the login bug"
👤 From: @olduser → @newuser
```

#### Show Tasks
```
/showtasks
show my tasks
list tasks
what tasks do I have?
tasks for @username
```

**Expected Output:**
```
📋 Your Tasks (3 active):

🔵 task_abc123: Fix the login bug
   👤 Assigned: @you | 📅 Due: Tomorrow

🟡 task_def456: Update documentation  
   👤 Assigned: @you | 📅 Due: Friday

✅ task_ghi789: Review code changes (COMPLETED)
   👤 Assigned: @you | ✅ Completed: 2 hours ago
```

### List Commands

#### Create New List
```
/newlist Shopping List
create list: Project Requirements
new list: Meeting Notes
make list called "Team Goals"
```

**Expected Output:**
```
📝 List created: "Shopping List"
🆔 ID: list_abc123
📊 Items: 0
```

#### Add Items to List
```
/addtolist list_abc123 Buy milk, eggs, bread
add to Shopping List: apples, bananas
put on list_abc123: coffee, sugar
Shopping List needs: butter, cheese
```

**Expected Output:**
```
📝 Added to "Shopping List":
✅ Buy milk
✅ eggs  
✅ bread
📊 Total items: 5
```

#### Remove Items from List
```
/removefromlist list_abc123 milk
remove from Shopping List: eggs
take off list_abc123: bread
Shopping List doesn't need: coffee
```

**Expected Output:**
```
📝 Removed from "Shopping List":
❌ milk
❌ eggs
📊 Remaining items: 3
```

#### Show List
```
/showlist list_abc123
show Shopping List
list items for list_abc123
what's on Shopping List?
```

**Expected Output:**
```
📝 Shopping List (list_abc123)

1. 🔘 bread
2. 🔘 coffee  
3. 🔘 sugar
4. 🔘 butter
5. 🔘 cheese

📊 Total: 5 items
👤 Owner: @username
📅 Created: 2 hours ago
```

### User Assignment with @mentions

All task commands support user assignments:

```
newtask: Review PR @alice
create task for @bob: Update tests
assign task_abc123 to @charlie
reassign task_def456 from @alice to @bob
```

**Assignment Features:**
- Automatic user recognition from @mentions
- Support for multiple assignees: `@alice @bob @charlie`
- Flexible syntax: "for @user", "to @user", "assign @user"
- User validation and notifications

## Natural Language Processing Examples

Smart Rails handles natural language variations while maintaining high confidence:

### Task Examples
```
✅ "I need to create a task for fixing the API bug"
✅ "Make a new task: update the README file" 
✅ "Can you add a task to review John's code?"
✅ "Task for @sarah: prepare the quarterly report"
✅ "I'm done with task_abc123"
✅ "Mark task_def456 as completed"
✅ "Show me what tasks I have"
✅ "List all tasks assigned to @mike"
```

### List Examples
```
✅ "Create a shopping list"
✅ "I need a new list for meeting notes"
✅ "Add milk and eggs to the grocery list"
✅ "Put 'call client' on my todo list"
✅ "Remove 'old item' from project_list"
✅ "Show me the contents of my shopping list"
```

## Performance Benefits

### Token Usage Comparison
| Command Type | Tokens | Response Time | Cost |
|-------------|---------|---------------|------|
| Smart Rails Direct | 0 | ~40ms | $0.000 |
| Enhanced LLM | 150-300 | ~1.5s | ~$0.001 |
| Standard LLM | 400-800 | ~3s | ~$0.002 |

### Real-World Performance
```
Command: "newtask: Fix login bug"
⚡ Smart Rails: 42ms, 0 tokens
🐌 Standard LLM: 2.3s, 456 tokens

Command: "show my tasks"  
⚡ Smart Rails: 38ms, 0 tokens
🐌 Standard LLM: 1.8s, 234 tokens

Command: "add milk to shopping list"
⚡ Smart Rails: 45ms, 0 tokens  
🐌 Standard LLM: 2.1s, 312 tokens
```

## Confidence Scoring System

### High Confidence Indicators (90-100%)
- Direct command syntax: `/newtask`, `/showtasks`
- Clear action words: "create", "show", "add", "complete"
- Specific entity types: "task", "list"
- User mentions: "@username"

### Medium Confidence Indicators (70-89%)
- Ambiguous action words: "make", "get", "do"
- Unclear entity references: "this", "that", "it"
- Complex sentence structures
- Multiple potential interpretations

### Low Confidence Indicators (<70%)
- Conversational language: "maybe", "could you", "I think"
- Missing key information: no clear action or entity
- Off-topic content: general questions, chitchat
- Complex multi-step requests

## Troubleshooting Common Issues

### Command Not Recognized
**Problem**: Message processed by LLM instead of Smart Rails
**Solutions**:
- Use clearer action words: "create", "show", "add", "complete"
- Include entity type: "task", "list"
- Try direct command syntax: `/newtask`, `/showtasks`
- Check spelling and formatting

**Example Fix**:
```
❌ "Maybe make something for the bug?"
✅ "Create task: Fix the login bug"

❌ "Show me stuff"  
✅ "Show my tasks"
```

### User Assignment Issues
**Problem**: @mentions not recognized
**Solutions**:
- Ensure username starts with @
- Use exact usernames from Telegram
- Place @mention after the task description
- Check user exists in the system

**Example Fix**:
```
❌ "Task for john: Review code"
✅ "Task for @john: Review code"

❌ "@user123 create task review"
✅ "Create task for @user123: Review code"
```

### List Operation Errors
**Problem**: List not found or items not added
**Solutions**:
- Use exact list names or IDs
- Ensure list exists before adding items
- Check list permissions
- Verify item formatting

**Example Fix**:
```
❌ "Add stuff to some list"
✅ "Add milk, eggs to Shopping List"

❌ "Remove from list_abc"
✅ "Remove milk from list_abc123"
```

## Best Practices for Optimal Performance

### 1. Use Direct Command Syntax
```
✅ /newtask Fix API bug
✅ /showtasks  
✅ /addtolist grocery_list milk
```

### 2. Be Specific and Clear
```
✅ "Create task: Update documentation"
✅ "Show tasks assigned to @alice"
✅ "Add coffee to shopping list"
```

### 3. Follow Consistent Patterns
```
✅ "Complete task task_abc123"
✅ "Reassign task_def456 to @bob"
✅ "Remove item from list_ghi789"
```

### 4. Include Entity Types
```
✅ "Create new task for bug fix"
✅ "Show my task list"
✅ "Add items to shopping list"
```

### 5. Use @mentions Correctly
```
✅ "Task for @username: Description here"
✅ "Assign @alice to task_abc123"
✅ "Show tasks for @bob"
```

## Advanced Features

### Batch Operations
```
Add multiple items: "Add milk, eggs, bread, coffee to grocery list"
Multiple assignments: "Assign @alice @bob @charlie to task_abc123"
Bulk completion: "Complete task_abc123 task_def456 task_ghi789"
```

### Smart Parsing
Smart Rails understands context and variations:
```
"I need milk and eggs on my shopping list" → Add items
"Take coffee off the grocery list" → Remove item  
"What's on my todo list?" → Show list
"I'm finished with that login task" → Complete task
```

### Error Recovery
If Smart Rails misinterprets your command:
```
1. Try more direct syntax: "/newtask Description"
2. Include entity type: "Create TASK: Description"  
3. Use specific action words: "create", "show", "add", "complete"
4. Break complex requests into simple steps
```

## Command Reference Quick Guide

| Action | Keywords | Example |
|--------|----------|---------|
| **Create Task** | `create`, `new`, `make`, `add` | `newtask: Fix bug` |
| **Complete Task** | `complete`, `finish`, `done`, `mark complete` | `complete task_123` |
| **Reassign Task** | `reassign`, `transfer`, `move`, `give to` | `reassign task_123 @user` |
| **Show Tasks** | `show`, `list`, `display`, `what tasks` | `show my tasks` |
| **Create List** | `create list`, `new list`, `make list` | `new list: Shopping` |
| **Add to List** | `add to`, `put on`, `include in`, `needs` | `add milk to grocery list` |
| **Remove from List** | `remove from`, `take off`, `delete from` | `remove milk from list_123` |
| **Show List** | `show list`, `what's on`, `list items` | `show grocery list` |

## Getting Help

- **Command not working?** Try the direct syntax: `/newtask`, `/showtasks`
- **Need to see all commands?** Type `/help` for full command list
- **Performance issues?** Check the troubleshooting section above
- **Feature requests?** Contact the development team

---

*Last updated: January 2025*
*Smart Rails Version: 2.1*