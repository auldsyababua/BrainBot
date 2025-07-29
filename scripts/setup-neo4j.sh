#!/bin/bash

# Setup Neo4j for mem0 graph memory

echo "🚀 Setting up Neo4j for mem0 graph memory..."

# Set password (you can change this)
NEO4J_PASSWORD="mem0bot123"

# Check if Neo4j container already exists
if docker ps -a | grep -q neo4j-mem0; then
    echo "⚠️  Neo4j container already exists. Removing old container..."
    docker stop neo4j-mem0 2>/dev/null
    docker rm neo4j-mem0 2>/dev/null
fi

# Run Neo4j container
echo "📦 Starting Neo4j container..."
docker run -d \
  --name neo4j-mem0 \
  -p 7474:7474 -p 7687:7687 \
  -e NEO4J_AUTH=neo4j/$NEO4J_PASSWORD \
  -e NEO4J_PLUGINS='["graph-data-science"]' \
  -v neo4j-mem0-data:/data \
  neo4j:5-community

echo "⏳ Waiting for Neo4j to start..."
sleep 10

# Check if Neo4j is running
if docker ps | grep -q neo4j-mem0; then
    echo "✅ Neo4j is running!"
    echo ""
    echo "📊 Neo4j Details:"
    echo "   Browser URL: http://localhost:7474"
    echo "   Bolt URL: bolt://localhost:7687"
    echo "   Username: neo4j"
    echo "   Password: $NEO4J_PASSWORD"
    echo ""
    echo "📝 Add these to your .env file:"
    echo "   NEO4J_URL=bolt://localhost:7687"
    echo "   NEO4J_USERNAME=neo4j"
    echo "   NEO4J_PASSWORD=$NEO4J_PASSWORD"
    echo ""
    echo "🎯 Next steps:"
    echo "   1. Add the above variables to your .env file"
    echo "   2. Restart your bot to enable graph memory"
    echo "   3. Use /graph command to explore connections"
    echo "   4. Visit http://localhost:7474 to see the Neo4j browser"
else
    echo "❌ Failed to start Neo4j. Check Docker logs:"
    echo "   docker logs neo4j-mem0"
fi

echo ""
echo "💡 Useful commands:"
echo "   Stop Neo4j:    docker stop neo4j-mem0"
echo "   Start Neo4j:   docker start neo4j-mem0"
echo "   View logs:     docker logs neo4j-mem0"
echo "   Remove:        docker rm -f neo4j-mem0"