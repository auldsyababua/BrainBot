---
type: "agent_requested"
description: "Example description"
---
# FLRTS Auto Rules
**Trigger:** Auto (automatically included based on context)  
**Description:** Context-aware rules that automatically apply based on what you're working on

## Rails Development
**Applies to:** `src/rails/**`, `**/confidence_scoring.py`, `**/router.py`, `**/processors/*.py`

Smart Rails development requirements:
- Follow three-phase routing: preprocess → confidence → execution
- New processors must extend BaseProcessor class
- Implement confidence_score() method returning 0-100
- Cache dynamic prompts for reuse
- Document token savings in docstrings
- Add unit tests in tests/unit/test_processors.py
- Test confidence thresholds: 100% (direct), 80-99% (focused), <80% (full)

## Telegram Mini App
**Applies to:** `telegram-mini-app/**`, `**/*.tsx`, `**/*.ts`, `**/components/**`

Telegram Mini App requirements:
- Use TypeScript strict mode (no any types)
- Components must handle offline state gracefully
- Follow existing Tailwind CSS patterns
- Test with vitest, not jest
- Implement Telegram WebApp security checks
- Use brainbotApi service for backend calls
- Handle loading and error states in all components
- Mobile-first responsive design

## Bot Handlers
**Applies to:** `src/bot/**`, `**/handlers.py`, `**/webhook_bot.py`

Bot handler requirements:
- Return confirmation messages under 100 characters
- Handle both webhook and polling modes
- Implement rate limiting for user commands
- Use async/await for ALL I/O operations
- Add comprehensive error messages for debugging
- Process commands with Smart Rails routing
- Maintain conversation context in Redis

## Storage Operations
**Applies to:** `src/storage/**`, `**/vector_store.py`, `**/redis_store.py`, `**/media_storage.py`

Storage operation requirements:
- Vector operations must respect VECTOR_TOP_K setting
- Batch operations when processing > 10 documents
- Implement retry logic with exponential backoff
- Cache vector search results (TTL: 300s)
- Use asyncio for concurrent API calls
- Handle connection failures gracefully
- Log all storage operations for debugging

## Testing Requirements
**Applies to:** `tests/**`, `**/test_*.py`, `**/*.test.ts`, `**/*.test.tsx`

Testing requirements:
- Use pytest fixtures for setup/teardown
- Mock ALL external API calls
- Test both success and failure paths
- Include edge cases and boundary conditions
- Performance benchmarks for operations > 100ms
- Document test purpose in docstrings
- Keep tests independent and isolated
- Use descriptive test names that explain what's being tested

## Database Operations
**Applies to:** `scripts/database/**`, `**/*.sql`, `**/migrations/**`

Database operation requirements:
- Always use transactions for multi-step operations
- Create indexes for frequently queried columns
- Document complex queries with comments
- Use Supabase RLS policies for security
- Plan migrations with rollback strategies
- Test migrations on development first
- Never drop tables without backup

## FLRTS Structure
**Applies to:** `10nz_kb/**`, `**/sites/**`, `**/field-reports/**`, `**/lists/**`

FLRTS filing structure:
- Field reports: `10nz_kb/sites/{site_name}/field-reports/`
- Lists: `10nz_kb/sites/{site_name}/lists/`
- Use YAML frontmatter for metadata
- Maintain consistent naming conventions
- Tasks and reminders stored in Supabase
- All files must have proper frontmatter