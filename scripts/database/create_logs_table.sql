-- Create bot_logs table for real-time log access
-- Run this in Supabase SQL editor

-- Drop existing table if needed (careful!)
-- DROP TABLE IF EXISTS bot_logs;

-- Create the logs table
CREATE TABLE IF NOT EXISTS bot_logs (
    id BIGSERIAL PRIMARY KEY,
    timestamp TIMESTAMPTZ DEFAULT NOW() NOT NULL,
    level VARCHAR(10) NOT NULL,
    component VARCHAR(100),
    message TEXT NOT NULL,
    user_id BIGINT,
    chat_id BIGINT,
    operation VARCHAR(50),
    entity_type VARCHAR(50),
    confidence FLOAT,
    response_time_ms INTEGER,
    error TEXT,
    metadata JSONB
);

-- Create indexes for fast queries
CREATE INDEX IF NOT EXISTS idx_logs_timestamp ON bot_logs(timestamp DESC);
CREATE INDEX IF NOT EXISTS idx_logs_level ON bot_logs(level) WHERE level IN ('ERROR', 'CRITICAL');
CREATE INDEX IF NOT EXISTS idx_logs_user ON bot_logs(user_id) WHERE user_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_logs_operation ON bot_logs(operation) WHERE operation IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_logs_slow_ops ON bot_logs(response_time_ms) WHERE response_time_ms > 1000;

-- Create a view for recent errors
CREATE OR REPLACE VIEW recent_errors AS
SELECT 
    id,
    timestamp,
    component,
    message,
    user_id,
    error,
    metadata
FROM bot_logs
WHERE level IN ('ERROR', 'CRITICAL')
  AND timestamp > NOW() - INTERVAL '1 hour'
ORDER BY timestamp DESC;

-- Create a view for slow operations
CREATE OR REPLACE VIEW slow_operations AS
SELECT 
    id,
    timestamp,
    operation,
    entity_type,
    response_time_ms,
    message,
    user_id
FROM bot_logs
WHERE response_time_ms > 1000
  AND timestamp > NOW() - INTERVAL '1 hour'
ORDER BY response_time_ms DESC;

-- Create a view for routing analytics
CREATE OR REPLACE VIEW routing_analytics AS
SELECT 
    entity_type,
    operation,
    COUNT(*) as count,
    AVG(confidence) as avg_confidence,
    AVG(response_time_ms) as avg_response_time,
    MIN(timestamp) as first_seen,
    MAX(timestamp) as last_seen
FROM bot_logs
WHERE entity_type IS NOT NULL
  AND timestamp > NOW() - INTERVAL '24 hours'
GROPP BY entity_type, operation
ORDER BY count DESC;

-- Function to clean old logs (optional)
CREATE OR REPLACE FUNCTION clean_old_logs(days_to_keep INTEGER DEFAULT 7)
RETURNS INTEGER AS $$
DECLARE
    deleted_count INTEGER;
BEGIN
    DELETE FROM bot_logs 
    WHERE timestamp < NOW() - INTERVAL '1 day' * days_to_keep;
    
    GET DIAGNOSTICS deleted_count = ROW_COUNT;
    RETURN deleted_count;
END;
$$ LANGUAGE plpgsql;

-- Grant permissions (adjust as needed)
GRANT ALL ON bot_logs TO authenticated;
GRANT ALL ON bot_logs_id_seq TO authenticated;

-- Sample queries for monitoring:
/*
-- Recent errors
SELECT * FROM recent_errors LIMIT 20;

-- Slow operations
SELECT * FROM slow_operations LIMIT 20;

-- Routing performance by entity type
SELECT * FROM routing_analytics;

-- User activity
SELECT 
    user_id,
    COUNT(*) as actions,
    COUNT(DISTINCT operation) as unique_operations,
    AVG(response_time_ms) as avg_response_time
FROM bot_logs
WHERE timestamp > NOW() - INTERVAL '1 hour'
  AND user_id IS NOT NULL
GROUP BY user_id
ORDER BY actions DESC;

-- Clean logs older than 30 days
SELECT clean_old_logs(30);
*/