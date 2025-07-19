# Vector Store Update Method TODO

## Current Status (July 19, 2025)

The `update_metadata()` method in `src/storage/vector_store.py` is currently non-functional because:

1. We're using upstash-vector v0.8.0 (released Feb 27, 2025)
2. The `update()` method exists in the main branch on GitHub but hasn't been released to PyPI yet
3. The method is documented in the official README: https://github.com/upstash/vector-py#update-a-vector

## Action Required

When upstash-vector releases a version > v0.8.0:

1. **Update the package**:
   ```bash
   pip install --upgrade upstash-vector
   ```

2. **Replace the update_metadata implementation** in `src/storage/vector_store.py`:
   ```python
   async def update_metadata(self, document_id: str, metadata: Dict) -> bool:
       """Update metadata for an existing document."""
       try:
           return self.index.update(document_id, metadata=metadata)
       except Exception as e:
           print(f"Error updating metadata for {document_id}: {e}")
           return False
   ```

3. **Update the test** in `test_storage_integrations.py` to expect success instead of failure

## Current Workaround

If you need to update metadata before the new release, use upsert with None vector:
```python
self.index.upsert([(document_id, None, metadata)])
```

Note: This workaround may have different behavior than the dedicated update method.