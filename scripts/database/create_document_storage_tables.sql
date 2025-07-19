-- Document Storage Tables for Markdown Brain Bot
-- This creates tables in the existing 10NetZero Supabase database

-- Enable UUID generation if not already enabled
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Documents table for storing markdown content
CREATE TABLE IF NOT EXISTS brain_bot_documents (
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
    previous_version_id UUID REFERENCES brain_bot_documents(id),
    
    -- Access control
    is_public BOOLEAN DEFAULT false,
    access_level TEXT DEFAULT 'private', -- private, team, public
    
    -- Bot tracking
    created_by TEXT DEFAULT 'manual', -- manual, bot, api
    telegram_chat_id BIGINT, -- Track which chat created this
    telegram_user_id BIGINT, -- Track which user created this
    
    -- Timestamps
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    last_accessed_at TIMESTAMPTZ DEFAULT NOW()
);

-- Document chunks for vector search
CREATE TABLE IF NOT EXISTS brain_bot_document_chunks (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    document_id UUID REFERENCES brain_bot_documents(id) ON DELETE CASCADE,
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

-- Media files reference (stored in S3)
CREATE TABLE IF NOT EXISTS brain_bot_media_files (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    file_name TEXT NOT NULL,
    file_type TEXT NOT NULL,
    mime_type TEXT,
    file_size BIGINT,
    
    -- S3 Storage Info
    s3_key TEXT NOT NULL UNIQUE,
    s3_bucket TEXT NOT NULL DEFAULT 't2t2-images',
    s3_url TEXT,
    file_hash TEXT NOT NULL, -- SHA-256 for deduplication
    
    -- Metadata
    metadata JSONB DEFAULT '{}',
    description TEXT,
    tags TEXT[],
    
    -- Bot tracking
    uploaded_by TEXT DEFAULT 'manual',
    telegram_chat_id BIGINT,
    telegram_user_id BIGINT,
    
    -- Timestamps
    created_at TIMESTAMPTZ DEFAULT NOW(),
    last_accessed_at TIMESTAMPTZ DEFAULT NOW()
);

-- Index for performance
CREATE INDEX idx_brain_bot_documents_file_path ON brain_bot_documents(file_path);
CREATE INDEX idx_brain_bot_documents_category ON brain_bot_documents(category);
CREATE INDEX idx_brain_bot_documents_tags ON brain_bot_documents USING GIN(tags);
CREATE INDEX idx_brain_bot_documents_telegram_chat ON brain_bot_documents(telegram_chat_id);
CREATE INDEX idx_brain_bot_chunks_document_id ON brain_bot_document_chunks(document_id);
CREATE INDEX idx_brain_bot_chunks_vector_id ON brain_bot_document_chunks(vector_id);
CREATE INDEX idx_brain_bot_media_s3_key ON brain_bot_media_files(s3_key);
CREATE INDEX idx_brain_bot_media_tags ON brain_bot_media_files USING GIN(tags);

-- Enable Row Level Security
ALTER TABLE brain_bot_documents ENABLE ROW LEVEL SECURITY;
ALTER TABLE brain_bot_document_chunks ENABLE ROW LEVEL SECURITY;
ALTER TABLE brain_bot_media_files ENABLE ROW LEVEL SECURITY;

-- Create policies (adjust based on your auth setup)
-- For now, we'll create permissive policies that can be tightened later

-- Documents policies
CREATE POLICY "Service role has full access to documents" ON brain_bot_documents
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Anon can read public documents" ON brain_bot_documents
    FOR SELECT USING (is_public = true);

-- Chunks policies  
CREATE POLICY "Service role has full access to chunks" ON brain_bot_document_chunks
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Anon can read chunks of public documents" ON brain_bot_document_chunks
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM brain_bot_documents 
            WHERE brain_bot_documents.id = brain_bot_document_chunks.document_id 
            AND brain_bot_documents.is_public = true
        )
    );

-- Media policies
CREATE POLICY "Service role has full access to media" ON brain_bot_media_files
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Anon can read media metadata" ON brain_bot_media_files
    FOR SELECT USING (true);

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers for updated_at
CREATE TRIGGER update_brain_bot_documents_updated_at BEFORE UPDATE ON brain_bot_documents
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Function to track document access
CREATE OR REPLACE FUNCTION update_last_accessed_at()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE brain_bot_documents 
    SET last_accessed_at = NOW() 
    WHERE id = NEW.document_id;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Optional: Track when chunks are accessed (might be too much overhead)
-- CREATE TRIGGER track_chunk_access AFTER SELECT ON brain_bot_document_chunks
--     FOR EACH ROW EXECUTE FUNCTION update_last_accessed_at();

-- Grant permissions to service role
GRANT ALL ON brain_bot_documents TO service_role;
GRANT ALL ON brain_bot_document_chunks TO service_role;
GRANT ALL ON brain_bot_media_files TO service_role;

-- Grant read permissions to anon role
GRANT SELECT ON brain_bot_documents TO anon;
GRANT SELECT ON brain_bot_document_chunks TO anon;
GRANT SELECT ON brain_bot_media_files TO anon;