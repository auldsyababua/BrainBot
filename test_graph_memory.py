#!/usr/bin/env python3
"""
Simple test for graph memory functionality.
"""

import os
import asyncio
from dotenv import load_dotenv

# Load environment variables
load_dotenv(".env.local")
load_dotenv()  # Load main .env if it exists


async def test_graph_memory():
    """Test graph memory functionality."""
    try:
        from src.core.memory import BotMemory

        print("🧠 Testing BotMemory initialization...")
        memory = BotMemory()

        if memory.has_graph:
            print("✅ Graph memory is enabled!")

            # Test basic graph operations
            user_id = "test_user"

            # Store a relationship
            print("\n💾 Testing relationship storage...")
            result = await memory.store_entity_relationship(
                user_id=user_id,
                source_entity="Colin",
                relationship="WORKS_AT",
                target_entity="Eagle Lake Facility",
                metadata={"confidence": 0.9},
            )

            if result:
                print("✅ Relationship stored successfully")
            else:
                print("❌ Failed to store relationship")

            # Test memory stats
            print("\n📈 Testing memory stats...")
            stats = await memory.get_memory_stats(user_id)
            print(f"Graph entities: {stats.get('graph_entities', 0)}")
            print(f"Graph relationships: {stats.get('graph_relationships', 0)}")
            print(f"Has graph: {stats.get('has_graph', False)}")

        else:
            print("❌ Graph memory is not enabled")
            print("Check your environment variables:")
            print(f"  NEO4J_URL: {os.getenv('NEO4J_URL')}")
            print(f"  NEO4J_USERNAME: {os.getenv('NEO4J_USERNAME')}")
            print(
                f"  NEO4J_PASSWORD: {'***' if os.getenv('NEO4J_PASSWORD') else 'Not set'}"
            )

    except ImportError as e:
        print(f"❌ Import error: {e}")
        print("Make sure to install Neo4j dependencies:")
        print("  pip install -r requirements.neo4j.txt")
    except Exception as e:
        print(f"❌ Test failed: {e}")


if __name__ == "__main__":
    asyncio.run(test_graph_memory())
