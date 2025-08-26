# Story 2.8: Standardize HTTP Status Codes

**Priority:** LOW
**Points:** 2
**Status:** Ready for Development

## User Story
As a developer, I need HTTP status codes to use standard library constants instead of magic numbers so the code is more readable and maintainable.

## Problem
Magic numbers for HTTP status codes (200, 404, 503) make code less readable and more prone to typos.

## Implementation Pattern
```python
from http import HTTPStatus

# Before
return {"status": 200}
if response.status_code == 404:
raise Exception("Not found", 503)

# After
return {"status": HTTPStatus.OK}
if response.status_code == HTTPStatus.NOT_FOUND:
raise Exception("Service unavailable", HTTPStatus.SERVICE_UNAVAILABLE)
```

## Files to Update
- `performance_alerts.py` - Replace numeric status codes
- `cloudflare_cache.py` - Replace numeric status codes
- `health/endpoints.py` - Replace numeric status codes
- Any other files found with numeric HTTP codes

## Common Replacements
- 200 → HTTPStatus.OK
- 201 → HTTPStatus.CREATED
- 204 → HTTPStatus.NO_CONTENT
- 400 → HTTPStatus.BAD_REQUEST
- 401 → HTTPStatus.UNAUTHORIZED
- 403 → HTTPStatus.FORBIDDEN
- 404 → HTTPStatus.NOT_FOUND
- 500 → HTTPStatus.INTERNAL_SERVER_ERROR
- 503 → HTTPStatus.SERVICE_UNAVAILABLE

## Implementation Tasks
1. Import HTTPStatus from http module
2. Search for all numeric HTTP status codes
3. Replace with appropriate HTTPStatus constants
4. Verify all tests still pass
5. Update any status code comparisons

## Acceptance Criteria
- [ ] No magic number HTTP status codes remain
- [ ] All status codes use HTTPStatus constants
- [ ] Code is more readable and self-documenting
- [ ] All tests pass with new constants
- [ ] No functional changes to application behavior

## Developer Notes
- HTTPStatus enum provides both name and value
- Can still use .value if numeric value needed
- Makes code more maintainable and less error-prone
- IDEs can provide better autocomplete with enums

### Status
Approved
