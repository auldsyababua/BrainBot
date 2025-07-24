# Future Improvements for BrainBot

## CAG Auto-Merge Without Questions

**Status**: Deferred from MVP
**Priority**: Medium
**Issue**: Bot currently asks "Would you like to update existing note or create new?" when finding duplicates

### Desired Behavior
- When user creates a note that matches existing content, bot should automatically merge
- No questions asked - just intelligent organization
- Preserve source IDs for audit trail
- Example:
  ```
  User: "Save note: Project deadline is Friday"
  Bot: "Merged with existing project timeline note"  # Not "Would you like to update..."
  ```

### Implementation Notes
- Current behavior is acceptable for MVP (asking is better than data loss)
- Requires careful edge case testing:
  - What if titles match but content is completely different?
  - How to handle partial matches?
  - When should it create new vs merge?
- Consider confidence thresholds for auto-merge decisions

### Test Cases to Consider
1. Exact title match, similar content → Auto-merge
2. Similar title, different content → Create new with modified title?
3. Different title, very similar content → Merge and update title?
4. User explicitly says "new" → Always create new

### Related Code
- `src/core/config.py` - SYSTEM_PROMPT has the directive but GPT-4o doesn't follow it consistently
- `tests/test_ai_babysitter.py::test_new_feature_didnt_break_old_features` - Currently accepts questions for MVP

---

## Technical Debt & Temporary Changes

### Placeholder update_metadata Method (MEDIUM PRIORITY)
- **Issue**: Currently returns False because upstash-vector v0.8.0 doesn't have update method
- **Location**: `src/storage/vector_store.py`
- **Action**: Implement properly when SDK is upgraded to newer version

### Test Namespace Constructor Parameter (LOW PRIORITY)
- **Issue**: Added optional namespace parameter to VectorStore.__init__()
- **Purpose**: For testing isolation
- **Decision**: Consider if this should stay for production flexibility

---

## Architecture & Design Questions

### Persistence Strategy
- **Question**: How do we maintain persistence across restarts?
- **Current**: Redis for conversations, Vector for knowledge
- **Consider**: Backup strategies, data export capabilities

### Time Awareness
- **Question**: How do we make the agent time aware?
- **Ideas**: 
  - Inject date/time into prompts
  - Set reminders/timers via API calls
  - Calendar integration

### Rich Responses
- **Question**: How do we enable graphs/charts/images?
- **Options**:
  - Integrate charting libraries
  - Generate and upload images
  - Use Telegram's rich media capabilities

### Dual Storage Sync
- **Question**: How to keep human-readable notes in sync with vector store?
- **Requirements**:
  - Maintain both stores simultaneously
  - Store all original submissions
  - Ensure consistency

### Tool Integration
- **Question**: Script tools vs button-based UI?
- **Consider**:
  - Telegram inline keyboards for common actions
  - Natural language for complex operations
  - Hybrid approach

### Test Coverage
- **Question**: Should we add vector-supabase sync verification to babysitter tests?
- **Benefit**: Ensure data consistency
- **Cost**: Slower test runs

---

## Personal Development Notes

### Save All Conversations
- **Claude Code**: Need local backup of all Claude Code conversations
- **Bot Conversations**: Vector store all conversations for:
  - Training data
  - History preservation
  - Analytics

---


---

## Other Future Improvements
(Add more as identified)