# 📦 Unified Storage Abstraction Layer - Implementation Handoff

**Assigned Issue:** [Issue #7: Create Unified Storage Abstraction Layer](https://github.com/auldsyababua/BrainBot/issues/7)

**Repository:** auldsyababua/BrainBot  
**Branch:** Create `feature/unified-storage` from current `main` (after PR #12 is merged)

## 🎯 Current Status

### ✅ Recently Completed (Issue #6)
- **Performance Monitoring**: Comprehensive benchmarking system in place
- **Caching Layer**: Redis-based caching for vector searches
- **Resilient API Client**: Retry logic with exponential backoff
- **Documentation**: Complete testing and monitoring guides

### 📊 Current Storage Architecture

Storage operations are currently scattered across the codebase:

```python
# In various files:
redis_store.save_conversation(chat_id, messages)  # src/storage/redis_store.py
vector_store.search(query, top_k=5)              # src/storage/vector_store.py
storage_service.upload_to_s3(file_data)          # src/storage/storage_service.py
```

Each storage system has:
- Different error handling approaches
- Inconsistent async/sync patterns
- No unified interface for testing
- Separate performance tracking

## 🚨 CRITICAL INSTRUCTIONS

### Development Methodology Requirements

**1. Use Context7 for All Technical Research**
- Use `mcp__context7__resolve-library-id` and `mcp__context7__get-library-docs` for:
  - Python abstract base classes (ABC)
  - Async context managers
  - Type hints and generics
  - Factory pattern implementations

**2. Research Design Patterns**
- Use `mcp__omnisearch__tavily_search` for:
  - "Python repository pattern examples"
  - "Storage abstraction layer best practices"
  - "Async factory pattern Python"
  - "Unit of work pattern Python"

## 🎯 Issue #7: Unified Storage Abstraction Implementation

### Goal
Create a single, unified interface for all storage operations that simplifies the codebase and prepares for the async conversion (Issue #8).

### Why This Order Makes Sense

1. **Foundation for Async Conversion**: Having all storage in one place makes async conversion easier
2. **Leverages Performance Work**: Can use benchmarking decorators from Issue #6
3. **Simplifies Testing**: Mock one interface instead of three
4. **Reduces Code Duplication**: Common operations (error handling, retries) in one place

## 📋 Implementation Plan

### Phase 1: Design the Abstract Interface

Create `src/storage/base.py`:

```python
from abc import ABC, abstractmethod
from typing import List, Dict, Any, Optional
from src.core.benchmarks import async_benchmark

class StorageBackend(ABC):
    """Abstract base class for storage backends."""
    
    @abstractmethod
    async def get(self, key: str) -> Optional[Any]:
        """Get a value by key."""
        pass
    
    @abstractmethod
    async def set(self, key: str, value: Any, ttl: Optional[int] = None):
        """Set a value with optional TTL."""
        pass
    
    @abstractmethod
    async def delete(self, key: str) -> bool:
        """Delete a key."""
        pass
    
    @abstractmethod
    async def search(self, query: str, **kwargs) -> List[Dict]:
        """Search for content."""
        pass
```

### Phase 2: Create the Unified Storage Class

Create `src/storage/unified_store.py`:

```python
from typing import List, Dict, Any, Optional
from src.core.benchmarks import async_benchmark, get_performance_monitor
from src.storage.redis_store import redis_store
from src.storage.vector_store import vector_store
from src.storage.storage_service import StorageService
import logging

logger = logging.getLogger(__name__)

class UnifiedStorage:
    """
    Unified interface for all storage operations.
    
    This class provides a single point of access for:
    - Conversation storage (Redis)
    - Vector search (Upstash Vector)
    - Document storage (Supabase)
    - Media storage (S3, optional)
    """
    
    def __init__(self):
        """Initialize with existing storage backends."""
        self.redis = redis_store
        self.vector = vector_store
        self.storage_service = StorageService()
        self.monitor = get_performance_monitor()
        
    # ===== Conversation Management =====
    
    @async_benchmark("unified_get_conversation")
    async def get_conversation(self, chat_id: str) -> Optional[List[Dict]]:
        """Get conversation history with sliding window applied."""
        try:
            return await self.redis.get_conversation(chat_id)
        except Exception as e:
            logger.error(f"Failed to get conversation {chat_id}: {e}")
            return None
    
    @async_benchmark("unified_save_conversation")
    async def save_conversation(
        self, 
        chat_id: str, 
        messages: List[Dict],
        ttl_hours: int = 24
    ):
        """Save conversation with automatic expiration."""
        try:
            await self.redis.save_conversation(chat_id, messages)
            # Also update vector index with recent context
            if len(messages) > 1:  # Skip if only system message
                await self._index_conversation_context(chat_id, messages[-1])
        except Exception as e:
            logger.error(f"Failed to save conversation {chat_id}: {e}")
            raise
    
    # ===== Context Search =====
    
    @async_benchmark("unified_search_context")
    async def search_context(
        self, 
        query: str, 
        chat_id: Optional[str] = None,
        include_conversation: bool = True,
        top_k: int = 5
    ) -> Dict[str, Any]:
        """
        Unified context search combining vector search and conversation history.
        
        Returns:
            {
                "vector_results": [...],
                "conversation_context": [...],
                "combined_relevance": float
            }
        """
        results = {"vector_results": [], "conversation_context": [], "combined_relevance": 0.0}
        
        try:
            # Vector search (with caching from Issue #6)
            vector_results = await self.vector.search(query, top_k=top_k)
            results["vector_results"] = vector_results
            
            # Get recent conversation context if requested
            if include_conversation and chat_id:
                conversation = await self.get_conversation(chat_id)
                if conversation:
                    # Extract last few relevant messages
                    recent_messages = conversation[-5:]  # Last 5 messages
                    results["conversation_context"] = [
                        msg for msg in recent_messages 
                        if msg.get("role") in ["user", "assistant"]
                    ]
            
            # Calculate combined relevance score
            if vector_results:
                avg_score = sum(r.get("score", 0) for r in vector_results) / len(vector_results)
                results["combined_relevance"] = avg_score
                
        except Exception as e:
            logger.error(f"Context search failed for '{query}': {e}")
            
        return results
    
    # ===== Document Storage =====
    
    @async_benchmark("unified_store_document")
    async def store_document(
        self,
        content: str,
        metadata: Dict[str, Any],
        index_for_search: bool = True
    ) -> str:
        """
        Store document in persistent storage with optional vector indexing.
        
        Returns:
            Document ID
        """
        try:
            # Store in Supabase
            doc_id = await self.storage_service.store_document(content, metadata)
            
            # Index for vector search if requested
            if index_for_search:
                vector_metadata = {
                    **metadata,
                    "doc_id": doc_id,
                    "indexed_from": "unified_storage"
                }
                await self.vector.embed_and_store(doc_id, content, vector_metadata)
                
            return doc_id
            
        except Exception as e:
            logger.error(f"Failed to store document: {e}")
            raise
    
    # ===== Batch Operations =====
    
    @async_benchmark("unified_batch_operation")
    async def batch_store_documents(
        self,
        documents: List[Dict[str, Any]],
        index_for_search: bool = True
    ) -> List[str]:
        """
        Efficiently store multiple documents.
        
        Args:
            documents: List of dicts with 'content' and 'metadata'
            
        Returns:
            List of document IDs
        """
        doc_ids = []
        
        # Batch store in Supabase
        stored_docs = await self.storage_service.batch_store_documents(documents)
        
        # Batch index for vector search
        if index_for_search and stored_docs:
            vector_docs = [
                (
                    doc["id"],
                    doc["content"],
                    {**doc.get("metadata", {}), "doc_id": doc["id"]}
                )
                for doc in stored_docs
            ]
            await self.vector.batch_embed_and_store(vector_docs)
            
        return [doc["id"] for doc in stored_docs]
    
    # ===== Media Storage =====
    
    @async_benchmark("unified_store_media")
    async def store_media(
        self,
        file_data: bytes,
        file_name: str,
        content_type: str,
        metadata: Optional[Dict] = None
    ) -> str:
        """
        Store media file (images, documents, etc).
        
        Returns:
            Media URL
        """
        try:
            # Use S3 if available, fallback to Supabase storage
            if hasattr(self.storage_service, 'upload_to_s3'):
                return await self.storage_service.upload_to_s3(
                    file_data, file_name, content_type, metadata
                )
            else:
                return await self.storage_service.upload_to_supabase_storage(
                    file_data, file_name, content_type, metadata
                )
        except Exception as e:
            logger.error(f"Failed to store media {file_name}: {e}")
            raise
    
    # ===== Cache Management =====
    
    async def invalidate_cache(self, pattern: Optional[str] = None):
        """
        Invalidate caches across all storage systems.
        """
        # Vector cache
        await self.vector.invalidate_cache(pattern)
        
        # Add other cache invalidations as needed
        logger.info(f"Cache invalidated for pattern: {pattern or 'all'}")
    
    # ===== Health Checks =====
    
    async def health_check(self) -> Dict[str, bool]:
        """
        Check health of all storage backends.
        """
        health = {
            "redis": False,
            "vector": False,
            "supabase": False,
            "s3": False
        }
        
        try:
            # Redis health
            health["redis"] = await self.redis.redis.ping()
        except:
            pass
            
        try:
            # Vector health - try a simple operation
            await self.vector.fetch_document("health_check_doc")
            health["vector"] = True
        except:
            pass
            
        try:
            # Supabase health
            health["supabase"] = await self.storage_service.health_check()
        except:
            pass
            
        return health
    
    # ===== Private Helper Methods =====
    
    async def _index_conversation_context(
        self, 
        chat_id: str, 
        last_message: Dict
    ):
        """
        Index recent conversation for better context retrieval.
        """
        if last_message.get("role") == "assistant" and last_message.get("content"):
            # Create a searchable summary of the conversation
            doc_id = f"conversation_{chat_id}_{int(time.time())}"
            metadata = {
                "type": "conversation",
                "chat_id": chat_id,
                "timestamp": datetime.now().isoformat()
            }
            
            try:
                await self.vector.embed_and_store(
                    doc_id, 
                    last_message["content"][:1000],  # First 1000 chars
                    metadata
                )
            except Exception as e:
                logger.warning(f"Failed to index conversation context: {e}")


# Global instance
unified_storage = UnifiedStorage()
```

### Phase 3: Create Migration Helpers

Create `src/storage/migration.py`:

```python
"""
Helpers for migrating from direct storage calls to unified storage.
"""

import ast
import os
from typing import List, Tuple

class StorageMigrationHelper:
    """Helps identify and migrate storage calls."""
    
    def find_storage_calls(self, directory: str) -> List[Tuple[str, int, str]]:
        """
        Find all direct storage calls in the codebase.
        
        Returns:
            List of (file_path, line_number, code_snippet)
        """
        storage_patterns = [
            "redis_store.",
            "vector_store.",
            "storage_service.",
            "s3_client.",
            "supabase."
        ]
        
        findings = []
        
        for root, dirs, files in os.walk(directory):
            # Skip virtual environments and cache
            dirs[:] = [d for d in dirs if d not in ['venv', '__pycache__', '.git']]
            
            for file in files:
                if file.endswith('.py'):
                    file_path = os.path.join(root, file)
                    
                    with open(file_path, 'r') as f:
                        lines = f.readlines()
                        
                    for i, line in enumerate(lines, 1):
                        for pattern in storage_patterns:
                            if pattern in line and 'unified_storage' not in line:
                                findings.append((file_path, i, line.strip()))
                                
        return findings
    
    def generate_migration_report(self, findings: List[Tuple[str, int, str]]) -> str:
        """
        Generate a migration report with recommendations.
        """
        report = ["# Storage Migration Report\n"]
        report.append(f"Found {len(findings)} direct storage calls to migrate\n")
        
        # Group by file
        by_file = {}
        for file_path, line_num, code in findings:
            if file_path not in by_file:
                by_file[file_path] = []
            by_file[file_path].append((line_num, code))
        
        for file_path, calls in by_file.items():
            report.append(f"\n## {file_path}")
            report.append(f"Found {len(calls)} storage calls:")
            
            for line_num, code in calls:
                report.append(f"- Line {line_num}: `{code}`")
                
                # Add migration suggestion
                if "redis_store.save_conversation" in code:
                    report.append("  → Migrate to: `unified_storage.save_conversation()`")
                elif "vector_store.search" in code:
                    report.append("  → Migrate to: `unified_storage.search_context()`")
                elif "storage_service." in code:
                    report.append("  → Migrate to: `unified_storage.store_document()`")
                
        return "\n".join(report)
```

### Phase 4: Update Core Modules

#### 1. Update `src/core/llm.py`

Replace direct storage calls:

```python
# Before:
from src.storage.redis_store import redis_store
from src.storage.vector_store import vector_store

# After:
from src.storage.unified_store import unified_storage

# Before:
messages = await redis_store.get_conversation(chat_id)
results = await vector_store.search(query)

# After:
messages = await unified_storage.get_conversation(chat_id)
context = await unified_storage.search_context(query, chat_id)
```

#### 2. Update `src/bot/handlers.py`

Migrate all storage operations to use unified interface.

### Phase 5: Testing Strategy

Create `tests/test_unified_storage.py`:

```python
import pytest
from unittest.mock import AsyncMock, MagicMock
from src.storage.unified_store import UnifiedStorage

class TestUnifiedStorage:
    """Test unified storage operations."""
    
    @pytest.fixture
    def storage(self):
        """Create storage instance with mocked backends."""
        storage = UnifiedStorage()
        storage.redis = AsyncMock()
        storage.vector = AsyncMock()
        storage.storage_service = AsyncMock()
        return storage
    
    async def test_search_context_combines_sources(self, storage):
        """Test that search combines vector and conversation results."""
        # Mock vector search
        storage.vector.search.return_value = [
            {"id": "doc1", "score": 0.9, "content": "Test content"}
        ]
        
        # Mock conversation
        storage.redis.get_conversation.return_value = [
            {"role": "user", "content": "Previous question"},
            {"role": "assistant", "content": "Previous answer"}
        ]
        
        # Test combined search
        results = await storage.search_context("test query", "chat123")
        
        assert len(results["vector_results"]) == 1
        assert len(results["conversation_context"]) == 2
        assert results["combined_relevance"] > 0
    
    async def test_store_document_indexes_correctly(self, storage):
        """Test document storage and indexing."""
        storage.storage_service.store_document.return_value = "doc123"
        
        doc_id = await storage.store_document(
            "Test content",
            {"title": "Test"},
            index_for_search=True
        )
        
        assert doc_id == "doc123"
        storage.vector.embed_and_store.assert_called_once()
```

## 🔄 Migration Plan

### Step 1: Non-Breaking Introduction (Week 1)

1. Create unified storage alongside existing code
2. Add compatibility layer that forwards to existing implementations
3. No changes to existing code yet

### Step 2: Gradual Migration (Week 2)

1. Start with `src/core/llm.py` - highest impact
2. Update one module at a time
3. Run tests after each module
4. Keep both old and new working during transition

### Step 3: Complete Migration (Week 3)

1. Update all remaining modules
2. Remove direct storage imports
3. Update all tests
4. Remove compatibility layer

### Step 4: Optimization (Week 4)

1. Add connection pooling
2. Implement circuit breakers
3. Add retry logic where missing
4. Performance tune based on metrics

## 🎯 Success Criteria

### Functionality
- [ ] All storage operations go through unified interface
- [ ] No direct imports of storage modules in business logic
- [ ] All existing tests pass
- [ ] New unified storage tests pass

### Performance
- [ ] No performance regression (use benchmarks from Issue #6)
- [ ] Cache hit rates maintained or improved
- [ ] Response times within 5% of current

### Code Quality
- [ ] 100% type hints on unified storage
- [ ] Comprehensive error handling
- [ ] Full async/await support
- [ ] Clean separation of concerns

## ⚠️ Important Considerations

### 1. Backward Compatibility
- Keep existing storage modules during transition
- Use feature flags if needed for gradual rollout
- Document all breaking changes

### 2. Error Handling
- Unified error types for all storage backends
- Graceful degradation when backends fail
- Clear error messages for debugging

### 3. Performance
- Use benchmarking decorators from Issue #6
- Monitor cache effectiveness
- Track operation latencies

### 4. Testing
- Mock unified interface for unit tests
- Integration tests for each backend
- End-to-end tests for critical paths

## 📊 Expected Benefits

1. **Simplified Codebase**
   - Single import for all storage needs
   - Consistent error handling
   - Easier to understand and maintain

2. **Better Testing**
   - Mock one interface instead of three
   - Easier to test edge cases
   - Better test coverage

3. **Preparation for Async**
   - All storage calls in one place
   - Easier to convert to full async (Issue #8)
   - Clear async/await patterns

4. **Performance Insights**
   - Centralized monitoring
   - Better cache utilization
   - Easier optimization

## 🚀 Next Steps After Completion

1. **Issue #8**: Full async conversion will be much easier
2. **Issue #9**: Multi-tenancy can be added to unified layer
3. **Future**: Easy to add new storage backends (PostgreSQL, etc.)

---

**Note**: This issue builds directly on the performance work from Issue #6. Make sure to use the benchmarking decorators and caching strategies already implemented.

**Remember**: The goal is not just to wrap existing code, but to create a genuinely useful abstraction that simplifies the codebase and makes future changes easier.

**Good luck! 🚀**