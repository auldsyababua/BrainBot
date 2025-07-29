# Setting Up mem0 with Graph Memory (Self-Hosted)

## Prerequisites

1. **Choose a Graph Database**:
   - Neo4j (recommended for production)
   - Memgraph (lighter weight alternative)

## Neo4j Setup

### Option 1: Docker
```bash
docker run -d \
  --name neo4j \
  -p 7474:7474 -p 7687:7687 \
  -e NEO4J_AUTH=neo4j/yourpassword \
  -e NEO4J_PLUGINS='["graph-data-science"]' \
  neo4j:5-community
```

### Option 2: Homebrew (macOS)
```bash
brew install neo4j
neo4j start
```

## Configure mem0 with Graph Memory

### 1. Update your memory.py:

```python
import os
from mem0 import Memory

class BotMemory:
    def __init__(self):
        config = {
            "llm": {
                "provider": "openai",
                "config": {
                    "model": "gpt-4o-mini",
                    "api_key": os.getenv("OPENAI_API_KEY")
                }
            },
            "vector_store": {
                "provider": "upstash",
                "config": {
                    "url": os.getenv("UPSTASH_VECTOR_REST_URL"),
                    "token": os.getenv("UPSTASH_VECTOR_REST_TOKEN")
                }
            },
            "graph_store": {
                "provider": "neo4j",
                "config": {
                    "url": os.getenv("NEO4J_URL", "bolt://localhost:7687"),
                    "username": os.getenv("NEO4J_USERNAME", "neo4j"),
                    "password": os.getenv("NEO4J_PASSWORD")
                }
            },
            "version": "v1.1"
        }
        
        self.memory = Memory.from_config(config)
```

### 2. Environment Variables:

```bash
# .env
OPENAI_API_KEY=sk-...
UPSTASH_VECTOR_REST_URL=https://...
UPSTASH_VECTOR_REST_TOKEN=...
NEO4J_URL=bolt://localhost:7687
NEO4J_USERNAME=neo4j
NEO4J_PASSWORD=yourpassword
```

### 3. Using Graph Memory:

```python
# Add memories - they'll be stored in both vector and graph
memory.add(
    messages=[{"role": "user", "content": "I work with pumps at Eagle Lake"}],
    user_id="colin"
)

# Graph will automatically:
# - Create nodes for: User (colin), Location (Eagle Lake), Equipment (pumps)
# - Create relationships: colin -> WORKS_AT -> Eagle Lake
#                        colin -> WORKS_WITH -> pumps

# Query the graph
if hasattr(memory, 'graph') and memory.graph:
    entities = memory.graph.search(
        query="What locations does the user work at?",
        filters={"user_id": "colin"}
    )
```

## Visualizing Your Graph

### Option 1: Neo4j Browser
1. Open http://localhost:7474
2. Login with your credentials
3. Run queries:
   ```cypher
   // See all nodes
   MATCH (n) RETURN n LIMIT 100
   
   // See user's connections
   MATCH (u:User {id: 'colin'})-[r]-(n)
   RETURN u, r, n
   ```

### Option 2: Build Simple Visualization

```python
# export_graph.py
import json
import networkx as nx
import matplotlib.pyplot as plt
from py2neo import Graph

# Connect to Neo4j
graph = Graph("bolt://localhost:7687", auth=("neo4j", "password"))

# Query all relationships
query = """
MATCH (n)-[r]-(m)
RETURN n.id as source, type(r) as relationship, m.id as target
LIMIT 100
"""

results = graph.run(query).data()

# Create NetworkX graph
G = nx.DiGraph()
for record in results:
    G.add_edge(
        record['source'], 
        record['target'], 
        relationship=record['relationship']
    )

# Visualize
plt.figure(figsize=(12, 8))
pos = nx.spring_layout(G)
nx.draw(G, pos, with_labels=True, node_color='lightblue', 
        node_size=1500, font_size=10, arrows=True)

# Draw edge labels
edge_labels = nx.get_edge_attributes(G, 'relationship')
nx.draw_networkx_edge_labels(G, pos, edge_labels)

plt.title("Memory Graph Visualization")
plt.savefig("memory_graph.png")
plt.show()
```

### Option 3: Streamlit Dashboard

```python
# dashboard.py
import streamlit as st
import pandas as pd
from mem0 import Memory
import plotly.graph_objects as go

st.title("🧠 Mem0 Memory Dashboard")

# Initialize memory
memory = Memory.from_config(your_config)

# User selection
user_id = st.text_input("User ID", "colin")

if st.button("Load Memories"):
    # Get all memories
    memories = memory.get_all(user_id=user_id)
    
    # Display in table
    st.subheader("📝 Stored Memories")
    if memories:
        df = pd.DataFrame(memories['results'])
        st.dataframe(df[['memory', 'created_at']])
    
    # If graph is enabled
    if hasattr(memory, 'graph') and memory.graph:
        st.subheader("🕸️ Knowledge Graph")
        entities = memory.graph.get_all({"user_id": user_id})
        
        # Create interactive graph with Plotly
        # ... (graph visualization code)
```

## Cost Comparison

### Self-Hosted
- Neo4j Community: **FREE**
- Your own compute: ~$20-100/month
- Total: **$20-100/month**

### Mem0 Platform
- Starter: $99/month
- Pro: $299/month (includes graph)
- Enterprise: Custom pricing

## Recommendation

For your use case:
1. **Start with self-hosted** + Neo4j Community
2. You get ALL the core features including Graph Memory
3. Build a simple dashboard if needed
4. Consider managed platform only if you need:
   - The beautiful UI
   - Managed infrastructure
   - Enterprise features
   - Support

The "magic sauce" (LLM-based extraction, graph relationships) is all in the open-source version!