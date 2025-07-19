# Storage Options for Production

## Current Problem
- Files in `notes/` are gitignored (for good reason - privacy)
- Render deployments only include files from git
- Vector DB points to files that don't exist on Render

## Solution Options

### 1. **Render Persistent Disk** ($7/month for 10GB)
```yaml
# render.yaml
services:
  - type: web
    name: markdown-brain-bot
    env: python
    disk:
      name: notes-storage
      mountPath: /opt/render/project/notes
      sizeGB: 10
```

Pros:
- Simple, stays within Render
- Survives redeploys
- Can SSH to manage files

Cons:
- Need to manually upload files
- No automatic sync with local

### 2. **Supabase Storage** (Free tier: 1GB)
```python
# Modified vector_store.py
async def search_with_full_content(self, query, ...):
    # ... find chunks ...
    
    # Instead of reading from filesystem:
    if include_full_docs:
        content = await supabase.storage
            .from_('notes')
            .download(file_path)
```

Pros:
- Free tier available
- API access
- Can upload from anywhere

Cons:
- Need to modify code
- Another service to manage

### 3. **AWS S3** (Pay as you go)
```python
import boto3

s3 = boto3.client('s3')

# Upload
s3.upload_file('notes/10NetZero/about.md', 
               'my-brain-bucket', 
               '10NetZero/about.md')

# Download when needed
content = s3.get_object(Bucket='my-brain-bucket', 
                       Key=file_path)['Body'].read()
```

Pros:
- Industry standard
- Cheap for small files
- Many tools available

Cons:
- AWS complexity
- Need AWS account

### 4. **GitHub Private Repo** (Free)
Create a separate private repo just for notes:

```bash
# Create private repo: 'my-brain-notes'
# Clone it inside your project
git clone https://github.com/yourusername/my-brain-notes.git notes_data

# Update vector store to use notes_data/ instead of notes/
```

Pros:
- Free
- Version controlled
- Easy to sync

Cons:
- Not ideal for large files
- Need to manage two repos

### 5. **Database Storage** (PostgreSQL)
```sql
CREATE TABLE documents (
    id VARCHAR PRIMARY KEY,
    file_path VARCHAR,
    content TEXT,
    metadata JSONB,
    created_at TIMESTAMP
);
```

Then modify the code:
```python
# Instead of filesystem
content = await db.query(
    "SELECT content FROM documents WHERE file_path = $1",
    file_path
)
```

Pros:
- Already have a database (Redis)
- Can add PostgreSQL to Render
- ACID compliance

Cons:
- Not great for large documents
- Need to migrate existing files

## Recommended Approach

### For Immediate Fix:
1. **Remove sensitive folders from git**, keep company docs
2. Reorganize:
   ```
   notes/
   ├── public/      # In git (company docs)
   │   └── 10NetZero/
   └── private/     # In .gitignore (personal)
       └── personal/
   ```

3. Update `.gitignore`:
   ```
   notes/private/
   ```

### For Long Term:
1. Use **Render Persistent Disk** for simplicity
2. Or **Supabase Storage** if you want API access
3. Create upload/sync scripts

### Implementation Steps:

1. **Reorganize folders locally**
2. **Update .gitignore**
3. **Commit and push** (public docs will deploy)
4. **Run migration** on Render
5. **Test** the bot

This way, company docs are in git (and deployed), while personal notes stay private.
