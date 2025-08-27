# Vector Store Enhancement: Document Chunking & Full Retrieval Plan

## Current State Analysis

### Limitations
1. **Partial Content Access**: Bot only sees 1500-character previews from metadata
2. **No Chunking**: Entire documents stored as single vectors (poor for long docs)
3. **Limited Context**: Bot misses information beyond the preview window
4. **Inefficient Search**: Large documents don't match well with specific queries

### Requirements
1. **Maintain Human-Readable Files**: Keep markdown as source of truth
2. **Full Document Access**: Bot should access complete content when needed
3. **Smart Chunking**: Break documents into semantic chunks with overlap
4. **Backwards Compatible**: Don't break existing functionality

## Proposed Architecture

### 1. Hybrid Storage System
```
┌─────────────────────┐     ┌─────────────────────┐
│   Markdown Files    │     │   Vector Database   │
│  (Source of Truth)  │     │  (Search & Chunks)  │
└──────────┬──────────┘     └──────────┬──────────┘
           │                           │
           │      ┌─────────────┐      │
           └─────►│  Migration   │◄─────┘
                  │   Process    │
                  └─────────────┘
```

### 2. Chunking Strategy
Based on LangChain best practices:
- **Chunk Size**: 1000 characters (optimal for semantic coherence)
- **Overlap**: 200 characters (maintains context between chunks)
- **Metadata**: Each chunk stores:
  - `file_path`: Original document location
  - `chunk_index`: Position in document (0, 1, 2...)
  - `total_chunks`: Total chunks from this document
  - `start_char`: Starting character position
  - `end_char`: Ending character position

### 3. Search & Retrieval Flow
```
1. User Query
   ↓
2. Vector Search → Returns relevant chunks
   ↓
3. Group chunks by file_path
   ↓
4. For each unique file:
   - Read full document from filesystem
   - Or retrieve all chunks if full read fails
   ↓
5. Provide complete context to LLM
```

## Implementation Plan

### Phase 1: Update Vector Store
```python
# vector_store.py modifications
class VectorStore:
    async def search_with_full_content(
        self,
        query: str,
        top_k: int = 5,
        include_full_docs: bool = True
    ) -> List[Dict]:
        # 1. Vector search for chunks
        results = await self.search(query, top_k=top_k)
        
        # 2. Group by document
        docs_to_fetch = {}
        for result in results:
            file_path = result['metadata'].get('file_path')
            if file_path:
                if file_path not in docs_to_fetch:
                    docs_to_fetch[file_path] = []
                docs_to_fetch[file_path].append(result)
        
        # 3. Fetch full documents
        if include_full_docs:
            for file_path in docs_to_fetch:
                try:
                    content = read_file(file_path)
                    # Enhance results with full content
                except:
                    # Fallback to chunks
                    pass
        
        return enhanced_results
```

### Phase 2: Implement Chunking
```python
# chunking.py - New file
from typing import List, Dict, Tuple

class DocumentChunker:
    def __init__(
        self,
        chunk_size: int = 1000,
        chunk_overlap: int = 200,
        separator: str = "\n\n"
    ):
        self.chunk_size = chunk_size
        self.chunk_overlap = chunk_overlap
        self.separator = separator
    
    def chunk_document(
        self,
        content: str,
        metadata: Dict
    ) -> List[Tuple[str, Dict]]:
        """
        Split document into overlapping chunks.
        Returns list of (chunk_text, chunk_metadata) tuples.
        """
        chunks = []
        
        # Smart splitting logic
        # 1. Try to split on paragraphs first
        # 2. Fall back to sentences
        # 3. Last resort: character boundary
        
        return chunks
```

### Phase 3: Update Migration Script
```python
# migrate_to_vector.py modifications
async def migrate_file_chunked(file_path: str) -> int:
    """Migrate a single file using chunking."""
    # Read full content
    content = read_file(file_path)
    
    # Extract metadata
    metadata, markdown_content = extract_frontmatter(content)
    
    # Create chunks
    chunker = DocumentChunker()
    chunks = chunker.chunk_document(markdown_content, {
        'file_path': file_path,
        'title': metadata.get('title', ''),
        'type': metadata.get('type', 'note')
    })
    
    # Store chunks
    for i, (chunk_text, chunk_meta) in enumerate(chunks):
        chunk_id = f"{file_path}#chunk_{i}"
        await vector_store.embed_and_store(
            chunk_id,
            chunk_text,
            chunk_meta
        )
    
    return len(chunks)
```

### Phase 4: Update LLM Integration
```python
# llm.py modifications
async def search_knowledge_base(query: str) -> List[Dict]:
    """Enhanced search with full document retrieval."""
    try:
        # Get search results with full content
        results = await vector_store.search_with_full_content(
            query,
            top_k=5,
            include_full_docs=True
        )
        return results
    except Exception as e:
        # Fallback behavior
        pass
```

## Testing Strategy

### 1. Unit Tests
- Test chunking with various document sizes
- Test overlap preservation
- Test metadata propagation

### 2. Integration Tests
- Test full pipeline: chunk → store → search → retrieve
- Test fallback behavior when file read fails
- Test performance with large documents

### 3. Migration Testing
- Test on 10NetZero documents
- Verify all content is accessible
- Compare search quality before/after

## Rollback Plan
1. Keep original migration script as `migrate_to_vector_legacy.py`
2. Tag current git state before changes
3. Vector store namespace separation for testing

## Performance Considerations
- **Chunking**: More vectors but better search precision
- **Full Document Reads**: Filesystem I/O on each search
- **Caching**: Consider Redis cache for frequently accessed docs

## Security Considerations
- Maintain file permission checks
- No sensitive data in vector metadata
- Audit trail for document access

## Future Enhancements
1. **Smart Chunking**: Use sentence boundaries, markdown headers
2. **Hierarchical Retrieval**: Chunk → Section → Document
3. **Caching Layer**: Redis for hot documents
4. **Chunk Reranking**: Score and reorder chunks post-retrieval

## Success Metrics
1. **Search Quality**: More relevant results
2. **Answer Completeness**: Bot has full context
3. **Performance**: <500ms search latency
4. **Storage Efficiency**: ~5-10 chunks per document average

## Next Steps
1. Review and approve plan
2. Create feature branch
3. Implement Phase 1 (Vector Store updates)
4. Test with sample documents
5. Proceed with remaining phases

---

**Handoff Notes for Next Session:**
- Start with Phase 1 implementation in `vector_store.py`
- Use RecursiveCharacterTextSplitter pattern from LangChain
- Test chunking on actual 10NetZero documents
- Consider using async file I/O for performance
EOF < /dev/null