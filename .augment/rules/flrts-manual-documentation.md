# @documentation - Documentation Standards and Checklist
**Trigger:** Manual (use @documentation to activate)  
**Description:** Documentation standards and requirements for FLRTS

## Documentation Requirements

### Code Documentation

#### Python Docstrings (Google Style)
```python
def process_message(message: str, user_id: int) -> Dict[str, Any]:
    """Process a message using Smart Rails routing.
    
    Args:
        message: The message text to process.
        user_id: Telegram user ID for authorization.
    
    Returns:
        Dict containing:
            - success: Boolean indicating if processing succeeded
            - response: The response text
            - tokens_saved: Number of tokens saved
            - confidence: Confidence score (0-100)
    
    Raises:
        AuthorizationError: If user is not authorized.
        ProcessingError: If message processing fails.
    
    Example:
        >>> result = process_message("Create a task for @john", 12345)
        >>> print(result['tokens_saved'])
        150
    """
```

#### TypeScript Documentation
```typescript
/**
 * Processes a task creation request with Smart Rails optimization.
 * @param message - The user's message text
 * @param userId - Telegram user ID for authorization
 * @returns Promise resolving to processed task object
 * @throws {AuthorizationError} When user lacks permission
 * @example
 * const task = await processTask("New task for @john", 12345);
 */
```

### README Sections
- [ ] Project title and description
- [ ] Key features (bullet points)
- [ ] Quick start guide
- [ ] Installation instructions
- [ ] Configuration (environment variables)
- [ ] Usage examples
- [ ] Project structure
- [ ] API documentation
- [ ] Testing instructions
- [ ] Deployment guide
- [ ] Contributing guidelines
- [ ] License information

## API Documentation

### Endpoint Documentation Template
```markdown
### POST /api/process

Process a message using Smart Rails routing.

**Request:**
```json
{
  "message": "Create task for @john: Check generator",
  "user_id": 12345,
  "chat_id": -67890
}
```

**Response:**
```json
{
  "success": true,
  "response": "Task created and assigned to @john",
  "tokens_saved": 150,
  "confidence": 95
}
```

**Error Responses:**
- `401`: Unauthorized user
- `400`: Invalid message format
- `500`: Processing error
```

### Smart Rails Documentation
- [ ] Explain three-phase routing
- [ ] Document confidence thresholds
- [ ] Provide command syntax examples
- [ ] Show token savings metrics
- [ ] Include performance benchmarks

## Feature Documentation Template

```markdown
## Feature: [Name]

### Overview
Brief description of what the feature does.

### How It Works
1. Step-by-step explanation
2. Technical details
3. Integration points

### Configuration
- Required environment variables
- Optional settings
- Default values

### Usage Examples
```python
# Example code
```

### Performance Impact
- Token usage
- Response time
- Resource consumption

### Troubleshooting
- Common issues
- Debug steps
- FAQ
```

## Changelog Format

```markdown
## [1.2.0] - 2024-01-15

### Added
- Smart Rails routing system
- Graph memory with Neo4j

### Changed
- Improved confidence scoring algorithm
- Updated to Python 3.9+

### Fixed
- Webhook timeout issues
- Memory leak in vector store

### Breaking Changes
- Changed API response format
- Updated environment variable names
```

## Migration Guide Template

```markdown
## Migrating from v1.x to v2.x

### Breaking Changes
1. Environment variable changes:
   - OLD_VAR → NEW_VAR

2. API changes:
   - Endpoint moved from /old to /new

### Migration Steps
1. Update environment variables
2. Run migration script: `python migrate.py`
3. Update webhook configuration
4. Test with sample messages

### Rollback Plan
If issues occur:
1. Revert to previous version
2. Restore database backup
3. Reset webhook
```

## Documentation Checklist
- [ ] All functions have docstrings
- [ ] Complex logic has inline comments
- [ ] README is up to date
- [ ] API changes documented
- [ ] Breaking changes highlighted
- [ ] Examples provided
- [ ] Performance metrics included
- [ ] Troubleshooting section added
- [ ] Changelog updated
- [ ] Migration guide written (if needed)