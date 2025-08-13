# @debugging - Debugging and Troubleshooting Guide
**Trigger:** Manual (use @debugging to activate)  
**Description:** Systematic debugging approach for FLRTS issues

## Debugging Strategy

### Initial Investigation
- [ ] Reproduce the issue consistently
- [ ] Check recent changes that might have caused it
- [ ] Review error logs in Supabase
- [ ] Check webhook/polling mode differences
- [ ] Verify environment configuration

### Smart Rails Debugging
- [ ] Check confidence scores for the message
- [ ] Verify preprocessing is working correctly
- [ ] Review router.py decision path
- [ ] Check if correct processor was selected
- [ ] Verify token usage and savings
- [ ] Test with similar messages for patterns

## Common Issues & Solutions

### Bot Not Responding
1. Check webhook configuration: `python scripts/diagnostics/check_webhook.py`
2. Verify bot token is valid
3. Check authorization (AUTHORIZED_USER_IDS)
4. Review Render deployment status
5. Check for rate limiting

### Wrong Command Processing
1. Review confidence scoring for the command
2. Check synonym library mappings
3. Verify processor pattern matching
4. Test preprocessing extraction
5. Review dynamic prompt generation

### Storage Issues

#### Vector Store
- Check namespace configuration
- Verify embeddings are created
- Test search with known content
- Review vector dimension matching

#### Redis
- Check connection string
- Verify TTL settings
- Test get/set operations
- Monitor memory usage

#### Supabase
- Check RLS policies
- Verify table permissions
- Review audit logs
- Test direct queries

## Logging & Monitoring

```python
# Add debug logging
import logging
logger = logging.getLogger(__name__)
logger.debug(f"Processing message: {message[:50]}")
logger.info(f"Confidence score: {confidence}")
logger.error(f"Failed to process: {error}", exc_info=True)
```

## Performance Debugging

```python
# Add timing logs
import time
start = time.time()
# ... operation ...
logger.info(f"⏱️ Operation took: {time.time() - start:.3f}s")
```

## Diagnostic Commands

```bash
# Check vector store
python scripts/diagnostics/diagnose_vector.py

# List vector contents
python scripts/diagnostics/list_vector_contents.py

# Check namespace API
python scripts/diagnostics/check_namespace_api.py

# Monitor deployment
python scripts/diagnostics/monitor_deployment.sh

# View task report
./scripts/diagnostics/task-report.sh

# Remote diagnostic
python scripts/diagnostics/remote_diagnostic.py
```

## Memory & Resource Issues
- [ ] Check Redis memory usage
- [ ] Monitor Python process memory
- [ ] Review connection pool usage
- [ ] Check for memory leaks in long-running processes
- [ ] Verify garbage collection is working

## Testing Isolated Components

```python
# Test specific processor
python tests/unit/test_processors.py::TestTaskProcessor

# Test Smart Rails routing
python tests/unit/test_smart_rails_proper.py

# Test storage integration
python tests/integration/test_storage_integrations.py
```

## Error Analysis Checklist
- [ ] Full stack trace captured
- [ ] User context identified
- [ ] Input that caused error saved
- [ ] State at time of error documented
- [ ] Similar past issues reviewed
- [ ] Fix tested with original input
- [ ] Regression test added