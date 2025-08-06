# Graph Memory Setup Guide

## Quick Setup

1. **Start Neo4j:**
   ```bash
   docker-compose -f docker-compose.neo4j.yml up -d
   ```

2. **Install Neo4j Python packages:**
   ```bash
   pip install -r requirements.neo4j.txt
   ```

3. **Load environment variables:**
   ```bash
   source .env.local
   ```

4. **Test graph memory:**
   ```bash
   python test_graph_memory.py
   ```

## Manual Installation (if pip times out)

1. **Download packages manually:**
   ```bash
   # For neo4j driver
   pip download neo4j
   pip install neo4j-*.whl
   
   # For langchain-neo4j
   pip download langchain-neo4j
   pip install langchain_neo4j-*.whl
   ```

2. **Alternative: Use conda**
   ```bash
   conda install -c conda-forge neo4j-python-driver
   pip install langchain-neo4j
   ```

## Verification

- Neo4j Web UI: http://localhost:7474
- Username: neo4j
- Password: markdown-bot-password

## Environment Variables

Ensure these are set in your `.env` or `.env.local`:

```bash
NEO4J_URL=bolt://localhost:7687
NEO4J_USERNAME=neo4j
NEO4J_PASSWORD=markdown-bot-password
```

## Troubleshooting

- **Docker not running:** Start Docker Desktop
- **Neo4j connection failed:** Check if container is healthy with `docker ps`
- **Import errors:** Install dependencies manually as shown above
- **Permission errors:** Make sure Docker has proper permissions