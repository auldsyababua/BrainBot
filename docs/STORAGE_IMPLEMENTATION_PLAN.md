# Storage Implementation Plan

## Phase 1: Document Storage (Supabase)

### 1.1 Database Schema

```sql
-- Documents table for storing markdown content
CREATE TABLE documents (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    file_path TEXT NOT NULL UNIQUE,
    title TEXT,
    content TEXT NOT NULL,
    content_hash TEXT NOT NULL, -- SHA-256 hash for deduplication
    metadata JSONB DEFAULT '{}',
    file_type TEXT DEFAULT 'markdown',
    category TEXT,
    tags TEXT[],
    
    -- Version tracking
    version INTEGER DEFAULT 1,
    previous_version_id UUID REFERENCES documents(id),
    
    -- Access control
    is_public BOOLEAN DEFAULT false,
    access_level TEXT DEFAULT 'private', -- private, team, public
    
    -- Timestamps
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    last_accessed_at TIMESTAMPTZ DEFAULT NOW()
);

-- Document chunks for vector search
CREATE TABLE document_chunks (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    document_id UUID REFERENCES documents(id) ON DELETE CASCADE,
    chunk_index INTEGER NOT NULL,
    chunk_text TEXT NOT NULL,
    chunk_hash TEXT NOT NULL,
    start_char INTEGER,
    end_char INTEGER,
    metadata JSONB DEFAULT '{}',
    
    -- Vector embedding reference
    vector_id TEXT, -- ID in Upstash Vector
    
    created_at TIMESTAMPTZ DEFAULT NOW(),
    
    UNIQUE(document_id, chunk_index)
);

-- Index for performance
CREATE INDEX idx_documents_file_path ON documents(file_path);
CREATE INDEX idx_documents_category ON documents(category);
CREATE INDEX idx_documents_tags ON documents USING GIN(tags);
CREATE INDEX idx_chunks_document_id ON document_chunks(document_id);
CREATE INDEX idx_chunks_vector_id ON document_chunks(vector_id);
```

### 1.2 Storage Service

```python
# storage_service.py
import hashlib
from typing import Optional, List, Dict
from supabase import create_client, Client
import os
from datetime import datetime

class DocumentStorage:
    def __init__(self):
        self.supabase: Client = create_client(
            os.getenv('SUPABASE_URL'),
            os.getenv('SUPABASE_ANON_KEY')
        )
    
    async def store_document(
        self, 
        file_path: str, 
        content: str, 
        metadata: Dict = None,
        category: str = None,
        tags: List[str] = None,
        is_public: bool = False
    ) -> str:
        """Store a document in Supabase."""
        # Calculate content hash
        content_hash = hashlib.sha256(content.encode()).hexdigest()
        
        # Check if document already exists
        existing = self.supabase.table('documents').select('id').eq('content_hash', content_hash).execute()
        
        if existing.data:
            return existing.data[0]['id']
        
        # Store document
        doc_data = {
            'file_path': file_path,
            'title': metadata.get('title', file_path.split('/')[-1]),
            'content': content,
            'content_hash': content_hash,
            'metadata': metadata or {},
            'category': category,
            'tags': tags or [],
            'is_public': is_public
        }
        
        result = self.supabase.table('documents').insert(doc_data).execute()
        return result.data[0]['id']
    
    async def get_document(self, file_path: str) -> Optional[Dict]:
        """Retrieve a document by file path."""
        result = self.supabase.table('documents').select('*').eq('file_path', file_path).execute()
        
        if result.data:
            # Update last accessed timestamp
            self.supabase.table('documents').update({
                'last_accessed_at': datetime.utcnow().isoformat()
            }).eq('id', result.data[0]['id']).execute()
            
            return result.data[0]
        return None
    
    async def search_documents(
        self, 
        query: str = None,
        category: str = None,
        tags: List[str] = None,
        limit: int = 10
    ) -> List[Dict]:
        """Search documents with filters."""
        query_builder = self.supabase.table('documents').select('*')
        
        if category:
            query_builder = query_builder.eq('category', category)
        
        if tags:
            query_builder = query_builder.contains('tags', tags)
        
        if query:
            query_builder = query_builder.ilike('content', f'%{query}%')
        
        result = query_builder.limit(limit).execute()
        return result.data
```

## Phase 2: Media Storage (S3)

### 2.1 S3 Configuration

```python
# media_storage.py
import boto3
import hashlib
from typing import Optional, Dict, BinaryIO
import mimetypes
import os

class MediaStorage:
    def __init__(self):
        self.s3_client = boto3.client(
            's3',
            aws_access_key_id='AKIA5WC32374N5FFMOVI',
            aws_secret_access_key=os.getenv('AWS_SECRET_ACCESS_KEY'),
            region_name='us-east-1'
        )
        self.bucket_name = 't2t2-images'
        
        # Organized folder structure
        self.folders = {
            'images': 'brain-bot/images/',
            'videos': 'brain-bot/videos/',
            'audio': 'brain-bot/audio/',
            'documents': 'brain-bot/documents/',
            'temp': 'brain-bot/temp/'
        }
    
    async def upload_media(
        self, 
        file_content: BinaryIO,
        file_name: str,
        file_type: str = None,
        metadata: Dict = None
    ) -> Dict:
        """Upload media file to S3."""
        # Determine file type
        if not file_type:
            file_type, _ = mimetypes.guess_type(file_name)
        
        # Calculate file hash
        file_hash = hashlib.sha256(file_content.read()).hexdigest()
        file_content.seek(0)  # Reset file pointer
        
        # Determine folder based on file type
        folder = self._get_folder_for_type(file_type)
        
        # Create S3 key
        file_extension = os.path.splitext(file_name)[1]
        s3_key = f"{folder}{file_hash}{file_extension}"
        
        # Check if file already exists
        try:
            self.s3_client.head_object(Bucket=self.bucket_name, Key=s3_key)
            # File exists, return existing URL
            return {
                's3_key': s3_key,
                's3_url': f"https://{self.bucket_name}.s3.amazonaws.com/{s3_key}",
                'file_hash': file_hash,
                'already_exists': True
            }
        except:
            pass
        
        # Upload file
        extra_args = {
            'ContentType': file_type,
            'Metadata': metadata or {}
        }
        
        self.s3_client.upload_fileobj(
            file_content,
            self.bucket_name,
            s3_key,
            ExtraArgs=extra_args
        )
        
        return {
            's3_key': s3_key,
            's3_url': f"https://{self.bucket_name}.s3.amazonaws.com/{s3_key}",
            'file_hash': file_hash,
            'file_type': file_type,
            'already_exists': False
        }
    
    def _get_folder_for_type(self, file_type: str) -> str:
        """Determine S3 folder based on file type."""
        if file_type and file_type.startswith('image/'):
            return self.folders['images']
        elif file_type and file_type.startswith('video/'):
            return self.folders['videos']
        elif file_type and file_type.startswith('audio/'):
            return self.folders['audio']
        else:
            return self.folders['documents']
```

## Phase 3: Integration with Vector Store

### 3.1 Updated Vector Store Integration

```python
# vector_store_enhanced.py
from vector_store import vector_store
from storage_service import DocumentStorage
from media_storage import MediaStorage

class EnhancedVectorStore:
    def __init__(self):
        self.vector_store = vector_store
        self.doc_storage = DocumentStorage()
        self.media_storage = MediaStorage()
    
    async def search_with_full_content(
        self, 
        query: str, 
        top_k: Optional[int] = None,
        include_full_docs: bool = True
    ) -> List[Dict]:
        """Search vector store and retrieve full content from storage."""
        # 1. Perform vector search
        results = await self.vector_store.search(query, top_k=top_k)
        
        # 2. Enhance results with full content
        enhanced_results = []
        for result in results:
            metadata = result.get('metadata', {})
            
            # Check storage type
            storage_type = metadata.get('storage_type', 'filesystem')
            
            if storage_type == 'supabase':
                # Fetch from Supabase
                doc = await self.doc_storage.get_document(metadata['file_path'])
                if doc:
                    result['full_content'] = doc['content']
                    result['document_metadata'] = doc['metadata']
            
            elif storage_type == 's3':
                # For media files, include S3 URL
                result['media_url'] = metadata.get('s3_url')
                result['media_type'] = metadata.get('file_type')
            
            elif storage_type == 'filesystem':
                # Legacy: try to read from filesystem
                file_path = metadata.get('file_path')
                if file_path and os.path.exists(file_path):
                    with open(file_path, 'r') as f:
                        result['full_content'] = f.read()
            
            enhanced_results.append(result)
        
        return enhanced_results
```

## Phase 4: Management Tools

### 4.1 Document Upload Tool

```python
#!/usr/bin/env python3
# upload_to_storage.py
import asyncio
import sys
from pathlib import Path
from storage_service import DocumentStorage
from media_storage import MediaStorage
from vector_store import vector_store
from chunking import chunk_markdown_document

async def upload_document(file_path: str, category: str = None, tags: List[str] = None):
    """Upload a document to Supabase and index in vector store."""
    doc_storage = DocumentStorage()
    
    # Read file
    with open(file_path, 'r') as f:
        content = f.read()
    
    # Extract metadata
    metadata = {
        'title': Path(file_path).stem,
        'source': 'manual_upload',
        'original_path': file_path
    }
    
    # Store in Supabase
    doc_id = await doc_storage.store_document(
        file_path=file_path,
        content=content,
        metadata=metadata,
        category=category,
        tags=tags
    )
    
    # Chunk and index
    chunks = chunk_markdown_document(content, file_path, metadata)
    
    for i, (chunk_text, chunk_metadata) in enumerate(chunks):
        chunk_metadata['storage_type'] = 'supabase'
        chunk_metadata['document_id'] = doc_id
        
        chunk_id = f"{doc_id}_chunk_{i}"
        await vector_store.embed_and_store(chunk_id, chunk_text, chunk_metadata)
    
    print(f"✅ Uploaded {file_path} with {len(chunks)} chunks")

async def upload_media(file_path: str):
    """Upload media file to S3 and index metadata."""
    media_storage = MediaStorage()
    
    with open(file_path, 'rb') as f:
        result = await media_storage.upload_media(
            file_content=f,
            file_name=Path(file_path).name
        )
    
    # Index in vector store
    metadata = {
        'storage_type': 's3',
        's3_key': result['s3_key'],
        's3_url': result['s3_url'],
        'file_type': result['file_type'],
        'file_name': Path(file_path).name
    }
    
    # Create searchable description
    description = f"Media file: {Path(file_path).name} ({result['file_type']})"
    
    await vector_store.embed_and_store(
        result['s3_key'],
        description,
        metadata
    )
    
    print(f"✅ Uploaded media to {result['s3_url']}")

if __name__ == "__main__":
    # Usage: python upload_to_storage.py <file> [--category=X] [--tags=a,b,c]
    asyncio.run(main())
```

## Phase 5: Migration Strategy

### 5.1 Migrate Existing Notes

```bash
# 1. Reorganize local folders
mkdir -p notes/public notes/private
mv notes/10NetZero notes/public/
mv notes/personal notes/private/

# 2. Update .gitignore
echo "notes/private/" >> .gitignore

# 3. Run migration script
python migrate_to_storage.py --folder notes/public --category company --public
python migrate_to_storage.py --folder notes/private --category personal
```

### 5.2 Update Bot Configuration

```python
# config.py
STORAGE_CONFIG = {
    'documents': {
        'provider': 'supabase',
        'public_categories': ['company', 'documentation'],
        'private_categories': ['personal', 'notes']
    },
    'media': {
        'provider': 's3',
        'bucket': 't2t2-images',
        'max_file_size': 100 * 1024 * 1024  # 100MB
    }
}
```

## Benefits of This Approach

1. **Persistence**: Both S3 and Supabase persist through deploys
2. **Scalability**: S3 handles large media files, Supabase handles documents
3. **Security**: Fine-grained access control with RLS in Supabase
4. **Search**: Vector embeddings point to content in both storages
5. **Management**: API access for adding/updating content
6. **Cost-effective**: S3 is cheap for media, Supabase free tier is generous
7. **Flexibility**: Can mix storage providers based on content type

## Next Steps

1. Set up Supabase project and create tables
2. Test S3 credentials and bucket access
3. Implement storage services
4. Create migration scripts
5. Update vector store integration
6. Deploy and test