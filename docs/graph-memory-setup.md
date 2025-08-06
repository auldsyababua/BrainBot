# Graph Memory Setup and Usage Guide

This guide explains how to set up and use the enhanced graph memory functionality in the markdown-brain-bot project.

## Overview

The graph memory system adds relationship mapping and knowledge graph capabilities to the existing mem0 integration, enabling:

- **Relationship Mapping**: Store and query relationships between entities (locations, equipment, people, organizations)
- **Enhanced Context Understanding**: Retrieve context through graph connections
- **Hybrid Search**: Combine vector similarity with graph traversal for better results
- **Knowledge Graph Visualization**: Build structured representations of stored knowledge
- **Connection Suggestions**: AI-powered suggestions for potential relationships

## Prerequisites

### 1. Neo4j Database

The graph memory functionality requires a Neo4j database. You have several options:

#### Option A: Docker (Recommended for development)
```bash
docker run -d \
  --name neo4j-graph-memory \
  -p 7474:7474 -p 7687:7687 \
  -e NEO4J_AUTH=neo4j/your-secure-password \
  -e NEO4J_PLUGINS='["graph-data-science"]' \
  neo4j:5-community
```

#### Option B: Homebrew (macOS)
```bash
brew install neo4j
neo4j start
```

#### Option C: Neo4j Desktop
Download and install from [neo4j.com/download](https://neo4j.com/download/)

### 2. Python Dependencies

Install the required packages:
```bash
pip install -r requirements.txt
```

This includes:
- `mem0ai>=0.0.15` - Core memory functionality
- `langchain-neo4j>=0.0.5` - Neo4j integration for mem0
- `neo4j>=5.0.0` - Neo4j Python driver

## Configuration

### Environment Variables

Add the following to your `.env` file:

```bash
# Required for graph memory functionality
NEO4J_URL=bolt://localhost:7687
NEO4J_USERNAME=neo4j
NEO4J_PASSWORD=your-secure-password

# Required for mem0 functionality
OPENAI_API_KEY=your-openai-api-key
UPSTASH_VECTOR_REST_URL=your-upstash-vector-url
UPSTASH_VECTOR_REST_TOKEN=your-upstash-vector-token

# Optional: Advanced mem0 configuration
MEM0_LLM_MODEL=gpt-4o-mini
MEM0_MEMORY_THRESHOLD=0.7
MEM0_COLLECTION_NAME=markdown_bot_memories
MEM0_ENABLE_HYBRID_SEARCH=true

# Optional: Graph-specific settings
MEM0_GRAPH_CUSTOM_PROMPT="Extract entities and relationships from this text..."
```

### Verify Configuration

Test your setup:
```bash
python scripts/demo_graph_memory.py
```

If configured correctly, you should see:
```
🧠 Graph Memory Demo for markdown-brain-bot
==================================================
✅ Graph memory is available!
```

## Usage

### 1. Basic Relationship Storage

```python
from src.core.memory import bot_memory

# Store a relationship between entities
result = await bot_memory.store_entity_relationship(
    user_id="user123",
    source_entity="North Austin Facility",
    relationship="LOCATED_IN",
    target_entity="Austin",
    metadata={"confidence": 1.0, "verified": True}
)
```

### 2. Entity Context Retrieval

```python
# Get comprehensive context about an entity
context = await bot_memory.get_entity_context(
    user_id="user123",
    entity="North Austin Facility",
    include_relationships=True,
    include_mentions=True
)

print(f"Direct mentions: {len(context['direct_mentions'])}")
print(f"Relationships: {list(context['relationships'].keys())}")
print(f"Related concepts: {context['related_concepts']}")
```

### 3. Knowledge Graph Building

```python
# Build a knowledge graph for visualization
graph = await bot_memory.build_knowledge_graph(
    user_id="user123",
    entity_types=["location", "organization"]  # Optional filter
)

print(f"Nodes: {len(graph['nodes'])}")
print(f"Edges: {len(graph['edges'])}")
print(f"Node types: {graph['stats']['node_types']}")
```

### 4. Hybrid Search

```python
# Search combining vector similarity and graph relationships
results = await bot_memory.hybrid_search_with_graph(
    user_id="user123",
    query="pump maintenance procedures",
    include_related=True,
    relationship_depth=2,
    limit=10
)

for result in results:
    print(f"Source: {result['source']} (Score: {result['score']:.2f})")
    if 'relationship_context' in result:
        print(f"  Related entities: {len(result['relationship_context'])}")
```

### 5. Connection Suggestions

```python
# Get AI-powered suggestions for potential connections
suggestions = await bot_memory.suggest_connections(
    user_id="user123",
    entity="North Austin Facility",
    limit=5
)

for suggestion in suggestions:
    print(f"Suggest: {suggestion['entity']} ")
    print(f"  Confidence: {suggestion['confidence']:.2f}")
    print(f"  Reason: {suggestion['reason']}")
```

### 6. Memory Statistics

```python
# Get comprehensive memory statistics
stats = await bot_memory.get_memory_stats(user_id="user123")

print(f"Total memories: {stats['total_memories']}")
print(f"Graph entities: {stats['graph_entities']}")
print(f"Graph relationships: {stats['graph_relationships']}")
print(f"Graph density: {stats['graph_density']:.3f}")
print(f"Top entities: {stats['top_entities']}")
```

## Initial Data Seeding

The system can automatically seed organizational relationships from configuration:

```python
from src.core.graph_memory_seeder import seed_graph_memory

# Seed initial organizational data
success = await seed_graph_memory()
if success:
    print("✅ Graph memory seeded successfully")
```

This reads from `config/mem0-config.json` and creates relationships for:
- Company structure
- Site locations and statuses
- Partnership relationships
- Equipment and tool inventories
- Legacy system mappings

## Integration with Existing Systems

### Bot Handlers

Add graph memory to your bot handlers:

```python
from src.core.memory import bot_memory

async def handle_message(update, context):
    user_id = str(update.effective_user.id)
    message_text = update.message.text
    
    # Get context using hybrid search
    relevant_context = await bot_memory.hybrid_search_with_graph(
        user_id=user_id,
        query=message_text,
        include_related=True,
        limit=5
    )
    
    # Use context in your response generation...
    
    # Store the conversation for future context
    await bot_memory.remember_from_conversation(
        messages=[
            {"role": "user", "content": message_text},
            {"role": "assistant", "content": response_text}
        ],
        user_id=user_id
    )
```

### Document Processing

Enhance document processing with relationship extraction:

```python
from src.core.memory import bot_memory

async def process_document(content: str, user_id: str):
    # Extract entities and create relationships
    entities = await bot_memory.extract_entities_from_text(content, user_id)
    
    # Store explicit relationships
    for location in entities.get('locations', []):
        for equipment in entities.get('equipment', []):
            await bot_memory.store_entity_relationship(
                user_id=user_id,
                source_entity=location,
                relationship="HAS_EQUIPMENT",
                target_entity=equipment,
                metadata={"source": "document_processing"}
            )
```

## Visualization

### Neo4j Browser

1. Open http://localhost:7474
2. Login with your credentials
3. Run Cypher queries:

```cypher
// See all nodes and relationships
MATCH (n)-[r]-(m)
RETURN n, r, m
LIMIT 100

// Find a specific user's network
MATCH (n)-[r]-(m)
WHERE n.user_id = 'user123' OR m.user_id = 'user123'
RETURN n, r, m
```

### Python Visualization

```python
import networkx as nx
import matplotlib.pyplot as plt

# Build graph for visualization
graph_data = await bot_memory.build_knowledge_graph(user_id="user123")

# Create NetworkX graph
G = nx.Graph()
for node in graph_data['nodes']:
    G.add_node(node['id'], **node)

for edge in graph_data['edges']:
    G.add_edge(edge['source'], edge['target'], **edge)

# Visualize
plt.figure(figsize=(12, 8))
pos = nx.spring_layout(G)
nx.draw(G, pos, with_labels=True, node_color='lightblue', 
        node_size=1500, font_size=8)
plt.title("Knowledge Graph")
plt.show()
```

## Testing

Run the test suite to verify functionality:

```bash
# Unit tests
python -m pytest tests/unit/test_graph_memory.py -v

# Integration tests
python -m pytest tests/integration/test_graph_memory_integration.py -v

# Demo script
python scripts/demo_graph_memory.py
```

## Performance Considerations

### Optimization Settings

```bash
# Batch processing for better performance
MEM0_BATCH_OPERATIONS=true
MEM0_BATCH_SIZE=50
MEM0_PARALLEL_PROCESSING=true
MEM0_MAX_CONCURRENT_OPERATIONS=4

# Memory management
MEM0_DEDUPLICATE_MEMORIES=true
MEM0_AUTO_UPDATE_MEMORIES=true

# Caching
MEM0_CACHE_STRATEGY=distance
MEM0_CACHE_SIMILARITY_THRESHOLD=0.8
```

### Monitoring

- Use Neo4j Browser to monitor graph size and query performance
- Track memory statistics with `get_memory_stats()`
- Set up webhooks for memory events:

```bash
MEM0_WEBHOOK_URL=https://your-webhook-endpoint.com/mem0
MEM0_WEBHOOK_TOKEN=your-webhook-secret
```

## Troubleshooting

### Common Issues

1. **Neo4j Connection Failed**
   ```
   Error: Failed to initialize BotMemory: Could not connect to Neo4j
   ```
   - Verify Neo4j is running: `docker ps` or `neo4j status`
   - Check connection settings in `.env`
   - Ensure ports 7474 and 7687 are accessible

2. **Missing Dependencies**
   ```
   Error: langchain_neo4j is not installed
   ```
   - Install missing packages: `pip install langchain-neo4j neo4j`
   - Update requirements: `pip install -r requirements.txt`

3. **Graph Memory Not Available**
   ```
   Warning: Graph memory not available
   ```
   - Set `NEO4J_URL`, `NEO4J_USERNAME`, and `NEO4J_PASSWORD` in `.env`
   - Verify Neo4j is running and accessible
   - Check the demo script output for specific errors

4. **Performance Issues**
   - Enable batch processing in configuration
   - Increase `MEM0_BATCH_SIZE` and `MEM0_MAX_CONCURRENT_OPERATIONS`
   - Use entity type filters in graph queries
   - Consider Neo4j query optimization

### Debug Mode

Enable debug logging:

```python
import logging
logging.getLogger('src.core.memory').setLevel(logging.DEBUG)
```

## Migration

If upgrading from a version without graph memory:

1. Install new dependencies
2. Set up Neo4j database
3. Add configuration variables
4. Run seeding script to populate initial relationships
5. Existing vector memories will continue to work normally

## Security Considerations

- Use strong passwords for Neo4j
- Restrict Neo4j network access to your application
- Consider encryption for sensitive relationship data
- Use user-specific isolation (user_id) for all operations
- Regularly backup your Neo4j database

## Next Steps

- Explore advanced Cypher queries in Neo4j Browser
- Build custom visualization dashboards
- Implement domain-specific relationship types
- Set up automated memory cleanup and archival
- Consider Neo4j clustering for production scaling

For more information, see the [mem0 documentation](https://docs.mem0.ai/) and [Neo4j documentation](https://neo4j.com/docs/).
