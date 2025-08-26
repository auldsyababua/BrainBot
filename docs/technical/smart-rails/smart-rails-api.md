# Smart Rails API Documentation

## Command Syntax Reference

Smart Rails supports multiple command syntaxes with varying confidence levels. Commands with explicit syntax (/ and @) achieve 100% confidence and enable direct execution without LLM processing.

## Entity Type Commands

### Lists Operations

#### `/lists` or `/l`
Specifies that the message is about list operations.

**Confidence**: 100% for entity type
**Example**: `/lists show my shopping items`

#### List-Specific Commands

| Command | Operation | Confidence | Example |
|---------|-----------|------------|---------|
| `/newlist` | Create list | 100% | `/newlist grocery items` |
| `/addtolist` | Add items | 100% | `/addtolist milk, eggs, bread` |
| `/removefromlist` | Remove items | 100% | `/removefromlist milk` |
| `/showlist` | Display list | 100% | `/showlist shopping` |

### Tasks Operations

#### `/tasks`, `/t`, or `/tnr`
Specifies that the message is about task operations.

**Confidence**: 100% for entity type
**Example**: `/tasks show my assignments for this week`

#### Task-Specific Commands

| Command | Operation | Confidence | Example |
|---------|-----------|------------|---------|
| `/newtask` | Create task | 100% | `/newtask Check generator oil` |
| `/newreminder` | Create reminder | 100% | `/newreminder Call client at 3pm` |
| `/completetask` | Mark complete | 100% | `/completetask generator maintenance` |
| `/reassigntask` | Reassign task | 100% | `/reassigntask to @joel` |
| `/showtasks` | List tasks | 100% | `/showtasks for tomorrow` |
| `/showmytasks` | Show user's tasks | 100% | `/showmytasks` |

### Field Reports Operations

#### `/fr` or `/reports`
Specifies that the message is about field report operations.

**Confidence**: 100% for entity type
**Example**: `/fr new report for Eagle Lake site`

## User Assignment Syntax

### @mentions
Assigns operations to specific users with 100% confidence.

**Syntax**: `@username`
**Confidence**: 100% for assignee extraction

**Examples**:
- `@joel needs to check the generator`
- `create task for @bryan and @sarah`
- `/newtask for @joel: Check oil levels`

**Important Notes**:
- Username must exist in the system's user aliases
- Invalid @mentions are stored as `unresolved_mentions`
- Multiple @mentions create multi-user assignments

## Natural Language Patterns

Smart Rails also recognizes natural language patterns with varying confidence levels:

### High Confidence Patterns (80-95%)

#### List Operations
- `new list called [name]` → Create list
- `add [items] to [list] list` → Add items
- `remove [items] from [list]` → Remove items
- `show list [name]` → Display list

#### Task Operations
- `new task [description]` → Create task
- `mark complete [task]` → Complete task
- `assign [task] to [person]` → Reassign task
- `remind me to [action]` → Create reminder

### Medium Confidence Patterns (60-80%)

- `create [entity]` → Generic creation
- `update [entity]` → Generic update
- `show [entity]` → Generic read
- `add [content]` → Context-dependent

### Low Confidence Patterns (<60%)

- `maybe [action]` → Uncertainty modifier
- `update that thing` → Ambiguous reference
- `change something` → Vague operation

## Confidence Scoring

### Confidence Hierarchy

1. **100% Confidence** (Direct Execution)
   - Explicit /commands for entity and operation
   - Valid @mentions for user assignment
   - Hidden commands anywhere in message

2. **80-99% Confidence** (Focused LLM)
   - Clear keywords with good context
   - Entity type commands with natural language
   - Strong pattern matches

3. **<80% Confidence** (Full LLM)
   - Ambiguous language
   - Multiple possible interpretations
   - Missing required context

### Confidence Modifiers

#### Positive Modifiers
- Command at message start: +10%
- @mention present: +20%
- Time reference (for tasks): +5%
- Site name (for reports): +10%
- Comma-separated items (for lists): +5%

#### Negative Modifiers
- Uncertainty words (maybe, might): -20%
- Multiple "or" clauses: -10%
- Ambiguous words (update, change): -10%
- Conflicting entity contexts: -30%

## Execution Strategies

### Direct Execution
**When**: Confidence = 100% on entity and operation
**Behavior**: Bypasses LLM, executes function directly
**Response Time**: <50ms
**Token Usage**: 0

### Focused LLM
**When**: Confidence 80-99% or partial extraction
**Behavior**: Minimal prompt for missing fields only
**Response Time**: 200-500ms
**Token Usage**: 50-100 tokens

### Full LLM
**When**: Confidence <80% or complex scenarios
**Behavior**: Complete analysis with full context
**Response Time**: 500-1500ms
**Token Usage**: 200-500 tokens

## API Response Format

### RouteResult Object

```python
@dataclass
class RouteResult:
    entity_type: Optional[str]      # 'lists', 'tasks', 'field_reports'
    operation: Optional[str]         # 'create', 'read', 'update', etc.
    function_name: Optional[str]     # Function to execute
    confidence: float               # Overall confidence (0.0-1.0)
    extracted_data: Dict[str, Any]  # Extracted parameters
    use_direct_execution: bool      # Skip LLM if True
    target_users: List[str]         # Assigned users
    entity_confidence: float        # Entity detection confidence
    operation_confidence: float     # Operation detection confidence
    assignee_confidence: float      # User extraction confidence
```

### Extracted Data Fields

#### Common Fields
- `cleaned_message`: Message with syntax removed
- `command_source`: Original command used
- `extraction_type`: How data was extracted
- `preprocessing_extractions`: Debug information

#### Entity-Specific Fields

**Lists**:
- `list_name`: Name of the list
- `items`: Array of items
- `list_type`: Type of list (optional)

**Tasks**:
- `task_title`: Task description
- `assignee`: Person assigned
- `due_date`: When due
- `priority`: Task priority
- `time_references`: Temporal context

**Field Reports**:
- `site`: Site name
- `report_content`: Report text
- `followups`: Action items
- `site_references`: All mentioned sites

## Usage Examples

### High Confidence (Direct Execution)

```python
# 100% confidence - direct execution
message = "/newtask for @joel: Check generator at 3pm"

# Result:
RouteResult(
    entity_type='tasks',
    operation='create',
    function_name='create_task',
    confidence=1.0,
    extracted_data={
        'assignee': 'joel',
        'time_references': ['at 3pm'],
        'cleaned_message': 'for : Check generator at 3pm'
    },
    use_direct_execution=True,
    entity_confidence=1.0,
    operation_confidence=1.0,
    assignee_confidence=1.0
)
```

### Medium Confidence (Focused LLM)

```python
# 85% confidence - focused LLM
message = "add milk and eggs to shopping list"

# Result:
RouteResult(
    entity_type='lists',
    operation='add_items',
    function_name='update_list',
    confidence=0.85,
    extracted_data={
        'items': ['milk', 'eggs'],
        'suggested_name': 'shopping'
    },
    use_direct_execution=False,
    entity_confidence=0.85,
    operation_confidence=0.85
)
```

### Low Confidence (Full LLM)

```python
# 45% confidence - full LLM analysis
message = "maybe update that thing we discussed"

# Result:
RouteResult(
    entity_type=None,
    operation=None,
    function_name=None,
    confidence=0.45,
    extracted_data={},
    use_direct_execution=False
)
```

## Performance Guidelines

### Optimizing for Direct Execution

1. **Use explicit commands**: Start with `/command`
2. **Include @mentions**: Explicitly tag users
3. **Be specific**: Use full command words
4. **Avoid ambiguity**: Don't use "maybe" or "might"

### Command Combinations

Combine commands for maximum efficiency:

```
/newtask for @joel and @bryan: Check Eagle Lake generator tomorrow at 3pm
```

This achieves:
- Entity: 100% (tasks)
- Operation: 100% (create)
- Assignees: 100% (joel, bryan)
- Site: Extracted (Eagle Lake)
- Time: Extracted (tomorrow at 3pm)
- Execution: Direct (0 tokens)

## Error Handling

### Invalid Commands
Commands that don't match patterns return low confidence and trigger full LLM analysis.

### Unresolved Mentions
@mentions for unknown users are stored in `unresolved_mentions` for LLM interpretation.

### Malformed Syntax
Messages starting with `/` but not matching command patterns are treated as natural language.

## Best Practices

### For Users

1. **Use commands for speed**: `/newtask` is faster than "create a new task"
2. **Tag users explicitly**: `@joel` is clearer than "for Joel"
3. **Include context early**: Put important info at message start
4. **Be specific**: Name lists, describe tasks clearly

### For Developers

1. **Load aliases early**: Call `ensure_aliases_loaded()` before routing
2. **Check confidence scores**: Use appropriate thresholds for your use case
3. **Monitor cache performance**: Track hit rates and adjust limits
4. **Test edge cases**: Verify handling of invalid mentions and commands

## Migration from Traditional Routing

### Before (Traditional)
```python
# Every message goes through LLM
message = "create task for joel"
# ~300 tokens, 800ms
```

### After (Smart Rails)
```python
# Direct execution for explicit syntax
message = "/newtask for @joel: Check generator"
# 0 tokens, 50ms
```

### Gradual Migration

1. Start with high-value commands (`/newtask`, `/completetask`)
2. Add @mention support for user extraction
3. Enable natural language patterns with confidence scoring
4. Optimize thresholds based on usage patterns

## Extending the System

### Adding New Commands

1. Add to `hidden_commands` dictionary in router.py
2. Define entity type and operation
3. Set confidence to 1.0 for deterministic matching

### Adding New Patterns

1. Add keywords to operation configuration
2. Update `keyword_specificity` scores
3. Adjust confidence weights if needed

### Custom Confidence Factors

1. Extend `ConfidenceFactors` class
2. Add new factor calculation
3. Update weight distribution

## Conclusion

Smart Rails API provides flexible command syntax with performance optimization through confidence-based routing. By using explicit syntax (/ commands and @mentions), users can achieve instant execution without LLM processing, while natural language remains fully supported with intelligent routing decisions.