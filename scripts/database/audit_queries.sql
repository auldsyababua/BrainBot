-- Audit Trail Queries for Brain Bot Storage

-- 1. See all documents created by a specific Telegram user
SELECT 
    file_path,
    title,
    created_at,
    updated_at,
    version,
    telegram_chat_id,
    telegram_user_id
FROM brain_bot_documents
WHERE telegram_user_id = 123456789  -- Replace with actual user ID
ORDER BY created_at DESC;

-- 2. Track all changes to a specific document
WITH document_history AS (
    SELECT 
        d1.id,
        d1.file_path,
        d1.version,
        d1.created_at as changed_at,
        d1.telegram_user_id as changed_by,
        d1.previous_version_id,
        'current' as status
    FROM brain_bot_documents d1
    WHERE d1.file_path = '10NetZero/Eagle Lake/maintenance-log.md'
    
    UNION ALL
    
    SELECT 
        d2.id,
        d2.file_path,
        d2.version,
        d2.created_at as changed_at,
        d2.telegram_user_id as changed_by,
        d2.previous_version_id,
        'historical' as status
    FROM brain_bot_documents d2
    WHERE EXISTS (
        SELECT 1 FROM brain_bot_documents d3 
        WHERE d3.previous_version_id = d2.id
    )
)
SELECT * FROM document_history
ORDER BY version DESC;

-- 3. See all activity from a specific chat in the last 7 days
SELECT 
    'document' as type,
    file_path as item,
    created_at as timestamp,
    telegram_user_id as user_id,
    'created' as action
FROM brain_bot_documents
WHERE telegram_chat_id = -1001234567890  -- Replace with chat ID
    AND created_at > NOW() - INTERVAL '7 days'

UNION ALL

SELECT 
    'media' as type,
    file_name as item,
    created_at as timestamp,
    telegram_user_id as user_id,
    'uploaded' as action
FROM brain_bot_media_files
WHERE telegram_chat_id = -1001234567890
    AND created_at > NOW() - INTERVAL '7 days'

ORDER BY timestamp DESC;

-- 4. Find most active users
SELECT 
    telegram_user_id,
    COUNT(DISTINCT file_path) as documents_created,
    MAX(created_at) as last_activity
FROM brain_bot_documents
WHERE telegram_user_id IS NOT NULL
GROUP BY telegram_user_id
ORDER BY documents_created DESC;

-- 5. See what files were accessed recently
SELECT 
    file_path,
    title,
    last_accessed_at,
    created_at,
    telegram_user_id as created_by
FROM brain_bot_documents
WHERE last_accessed_at > NOW() - INTERVAL '24 hours'
ORDER BY last_accessed_at DESC;

-- 6. Media upload activity by user
SELECT 
    telegram_user_id,
    COUNT(*) as files_uploaded,
    SUM(file_size) as total_bytes,
    pg_size_pretty(SUM(file_size)::bigint) as total_size_human,
    MAX(created_at) as last_upload
FROM brain_bot_media_files
WHERE telegram_user_id IS NOT NULL
GROUP BY telegram_user_id
ORDER BY files_uploaded DESC;