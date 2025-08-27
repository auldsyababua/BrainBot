# Story 2.6: Externalize Configuration

**Priority:** MEDIUM
**Points:** 5
**Status:** Ready for Development

## User Story
As a developer, I need all configuration values externalized into a central configuration module so I can easily adjust settings without hunting through the codebase.

## Problem
Hardcoded values are scattered throughout the codebase, making it difficult to tune performance, adjust limits, or understand system behavior.

## Configuration to Create

### New File: `src/flrts/config/defaults.py`
```python
# Cache Configuration
CACHE_TTL_DEFAULT = 300  # 5 minutes
ROUTER_CACHE_TTL = 1800  # 30 minutes
SYNONYM_CACHE_TTL = 3600  # 1 hour
REDIS_TTL = 86400  # 24 hours

# Size Limits
MAX_CACHE_SIZE = 1000
MAX_HEALTH_HISTORY = 100

# Memory Configuration
MAX_CONTEXT_LENGTH = 2000

# Performance Tuning
MAX_RETRY_ATTEMPTS = 3
REQUEST_TIMEOUT = 30  # seconds
BATCH_SIZE = 100

# Feature Flags
ENABLE_CACHE = True
ENABLE_METRICS = True
ENABLE_DEBUG_LOGGING = False
```

## Files to Update
- `router.py:394` - Replace hardcoded cache TTL
- `synonym_library.py:16-17` - Use cache settings from config
- `redis_store.py:23` - Use REDIS_TTL from config
- `storage_service.py:48` - Use cache TTL from config
- `health_checks.py:34` - Use MAX_HEALTH_HISTORY from config

## Implementation Tasks
1. Create `src/flrts/config/` directory
2. Create `defaults.py` with all configuration values
3. Add `__init__.py` to make it a package
4. Find all hardcoded values in codebase
5. Replace with imports from config module
6. Add environment variable override capability
7. Document all configuration options

## Acceptance Criteria
- [ ] Central configuration module created
- [ ] All identified hardcoded values moved to config
- [ ] Configuration can be overridden by environment variables
- [ ] No magic numbers remain in business logic
- [ ] Configuration is well-documented
- [ ] Tests updated to use configuration module

## Developer Notes
- Consider using pydantic for configuration validation
- Group related configuration values together
- Use clear, descriptive names for all settings
- Add comments explaining what each value controls
- Consider adding configuration validation on startup

### Status
Approved
