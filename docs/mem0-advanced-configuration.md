# Advanced mem0 Configuration Guide

This guide covers all advanced configuration options for optimizing mem0 performance in the Markdown Brain Bot.

## Table of Contents

1. [Core Configuration](#core-configuration)
2. [Performance Optimization](#performance-optimization)
3. [Advanced Features](#advanced-features)
4. [Memory Management](#memory-management)
5. [Integration Points](#integration-points)

## Core Configuration

### LLM Settings

The LLM is used for intelligent memory extraction and updates:

```env
# Model selection (affects quality and cost)
MEM0_LLM_MODEL=gpt-4o-mini  # Options: gpt-4o, gpt-4o-mini, gpt-3.5-turbo
MEM0_LLM_TEMPERATURE=0.1     # Lower = more consistent (0.0-1.0)
MEM0_LLM_MAX_TOKENS=1000     # Max tokens for memory operations
```

### Embedder Configuration

For semantic search and similarity matching:

```env
MEM0_EMBEDDER_MODEL=text-embedding-3-small  # OpenAI's latest model
MEM0_EMBEDDING_DIMS=1536                     # Must match model dimensions
MEM0_EMBEDDER_BATCH_SIZE=100                # Process embeddings in batches
```

### Vector Store Optimization

```env
MEM0_VECTOR_TOP_K=10                        # Number of memories to retrieve
MEM0_COLLECTION_NAME=markdown_bot_memories  # Organize memories by collection
MEM0_DISTANCE_METRIC=cosine                 # cosine, dotproduct, or euclidean
MEM0_ENABLE_HYBRID_SEARCH=true              # Combine vector + keyword search
```

## Performance Optimization

### Caching Configuration

Reduce redundant operations with intelligent caching:

```env
# Cache similar queries to reduce API calls
MEM0_CACHE_SIMILARITY_THRESHOLD=0.8  # How similar queries must be to use cache
MEM0_CACHE_AUTO_FLUSH=50             # Flush cache after N entries
MEM0_CACHE_STRATEGY=distance         # 'distance' or 'exact' matching
MEM0_CACHE_MAX_DISTANCE=1.0          # Max distance for cache hits
```

### Chunking Settings

Optimize how large texts are split:

```env
MEM0_CHUNK_SIZE=2000       # Characters per chunk
MEM0_CHUNK_OVERLAP=100     # Overlap between chunks for context
MEM0_MIN_CHUNK_SIZE=50     # Minimum viable chunk size
```

### Batch Processing

Handle multiple memories efficiently:

```env
MEM0_BATCH_OPERATIONS=true           # Enable batch processing
MEM0_BATCH_SIZE=50                   # Memories per batch
MEM0_PARALLEL_PROCESSING=true        # Process batches in parallel
MEM0_MAX_CONCURRENT_OPERATIONS=4     # Limit concurrent operations
```

## Advanced Features

### Custom Prompts

Tailor memory extraction to your domain:

```env
# Extraction prompt for initial memory creation
MEM0_CUSTOM_FACT_EXTRACTION_PROMPT="Extract key facts about sites, partners, equipment, procedures, and operational details. Focus on: 1) Site names and aliases, 2) Partner relationships and financial terms, 3) Equipment specifications, 4) Standard operating procedures, 5) User preferences and roles."

# Update prompt for existing memories
MEM0_CUSTOM_UPDATE_MEMORY_PROMPT="Update the memory with new information, preserving critical details about sites, partners, and operations. Merge conflicting information intelligently."

# Graph extraction prompt (if using Neo4j)
MEM0_GRAPH_CUSTOM_PROMPT="Extract entities and relationships focusing on: sites, partners, equipment, procedures, users, and their interconnections. Include financial relationships, operational dependencies, and hierarchical structures."
```

### History Management

```env
# Track memory operations
MEM0_HISTORY_DB_PATH=~/.mem0/markdown_bot_history.db
MEM0_DISABLE_HISTORY=false  # Set to true for privacy
```

### Memory Features

```env
MEM0_AUTO_UPDATE_MEMORIES=true      # Update existing memories automatically
MEM0_DEDUPLICATE_MEMORIES=true      # Prevent duplicate storage
MEM0_MEMORY_DECAY_ENABLED=false     # Enable importance-based decay
MEM0_MEMORY_DECAY_RATE=0.95         # Monthly decay rate (if enabled)
```

## Memory Management

### Initial Memory Seeding

Pre-populate the system with domain knowledge:

```env
MEM0_INITIAL_MEMORIES='[
  {
    "user_id": "system",
    "content": "North Austin Facility (S001) partners with GreenEnergy Capital at 15% markup",
    "category": "partnerships"
  },
  {
    "user_id": "system",
    "content": "Site aliases: NAF = North Austin Facility, Houston-West = West Houston Mining Center",
    "category": "sites"
  }
]'
```

### User-Specific Settings

Customize memory behavior per user:

```env
# Format: MEM0_USER_{USER_ID}_{SETTING}
# Example for Telegram user 123456789:
MEM0_USER_123456789_RETENTION_DAYS=90        # Keep memories for 90 days
MEM0_USER_123456789_CATEGORIES=sites,equipment  # Focus on specific topics
MEM0_USER_123456789_AUTO_EXTRACT=true        # Auto-extract from conversations
MEM0_USER_123456789_MEMORY_LIMIT=1000        # Max memories per user
MEM0_USER_123456789_PRIORITY_TOPICS=sites,partners  # Priority extraction
```

### Webhook Integration

Get notified of memory events:

```env
MEM0_WEBHOOK_URL=https://your-app.com/memory-events
MEM0_WEBHOOK_TOKEN=your-secure-webhook-token
```

## Integration Points

### With Neo4j (Graph Memory)

```env
NEO4J_URL=bolt://localhost:7687
NEO4J_USERNAME=neo4j
NEO4J_PASSWORD=your-password
```

### With Upstash Vector

```env
UPSTASH_VECTOR_REST_URL=https://your-index.upstash.io
UPSTASH_VECTOR_REST_TOKEN=your-token
```

## Usage Examples

### 1. Batch Memory Import

```python
# Import site information in batch
memory_items = [
    {
        "content": "North Austin Facility uses solar panels for 40% power",
        "metadata": {"category": "equipment", "site": "NAF"}
    },
    {
        "content": "West Houston Mining Center has 500 GPU capacity",
        "metadata": {"category": "equipment", "site": "Houston"}
    }
]

await bot_memory.batch_add_memories(memory_items, "system")
```

### 2. Memory Optimization

```python
# Run periodic optimization
await bot_memory.optimize_memories(user_id)
```

### 3. Get Memory Insights

```python
# Analyze user's memory patterns
insights = await bot_memory.get_memory_insights(user_id)
print(f"Most discussed: {insights['most_discussed_topics']}")
```

## Performance Tips

1. **Use Batch Operations**: For bulk imports, always use `batch_add_memories`
2. **Enable Caching**: Reduces API calls for similar queries
3. **Optimize Chunk Size**: Larger chunks = fewer API calls but less granular retrieval
4. **Set Appropriate top_k**: Balance between context and performance
5. **Use Hybrid Search**: Combines vector similarity with keyword matching
6. **Regular Optimization**: Run `optimize_memories` weekly to deduplicate

## Monitoring

Track memory performance:

```python
stats = await bot_memory.get_memory_stats(user_id)
logger.info(f"Total memories: {stats['total_memories']}")
logger.info(f"Memory types: {stats['memory_types']}")
```

## Troubleshooting

### High API Costs
- Reduce `MEM0_LLM_MAX_TOKENS`
- Use `gpt-3.5-turbo` instead of GPT-4
- Increase `MEM0_CACHE_SIMILARITY_THRESHOLD`
- Enable `MEM0_BATCH_OPERATIONS`

### Slow Performance
- Enable `MEM0_PARALLEL_PROCESSING`
- Increase `MEM0_BATCH_SIZE`
- Reduce `MEM0_VECTOR_TOP_K`
- Use smaller embedding model

### Memory Not Found
- Check `MEM0_MEMORY_THRESHOLD` (lower = more memories stored)
- Verify vector dimensions match embedding model
- Ensure proper category tagging

### Duplicate Memories
- Enable `MEM0_DEDUPLICATE_MEMORIES`
- Run `optimize_memories` regularly
- Check extraction prompts for redundancy
