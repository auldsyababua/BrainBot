#!/usr/bin/env python3
"""
Demo script for graph memory functionality in markdown-brain-bot.
Demonstrates how to use the enhanced graph memory features.
"""

import asyncio
import sys
from pathlib import Path

# Add the src directory to the path so we can import modules
src_path = Path(__file__).parent.parent / "src"
sys.path.insert(0, str(src_path))

from core.memory import bot_memory  # noqa: E402
from core.graph_memory_seeder import seed_graph_memory  # noqa: E402


class GraphMemoryDemo:
    """Demonstrates graph memory functionality."""

    def __init__(self):
        self.memory = bot_memory
        self.demo_user_id = "demo_user"

    async def run_demo(self):
        """Run the complete graph memory demonstration."""
        print("🧠 Graph Memory Demo for markdown-brain-bot")
        print("=" * 50)

        if not self.memory.has_graph:
            print(
                "⚠️  Graph memory not available. Please configure Neo4j to see graph features."
            )
            print(
                "   Set NEO4J_URL, NEO4J_USERNAME, and NEO4J_PASSWORD environment variables."
            )
            return

        print("✅ Graph memory is available!")
        print()

        # Step 1: Seed initial organizational data
        await self.demo_graph_seeding()

        # Step 2: Store some relationships
        await self.demo_relationship_storage()

        # Step 3: Demonstrate entity context retrieval
        await self.demo_entity_context()

        # Step 4: Build and display knowledge graph
        await self.demo_knowledge_graph()

        # Step 5: Demonstrate hybrid search
        await self.demo_hybrid_search()

        # Step 6: Show memory statistics
        await self.demo_memory_stats()

        print("\n🎉 Demo completed successfully!")

    async def demo_graph_seeding(self):
        """Demonstrate graph memory seeding from configuration."""
        print("1. 🌱 Seeding Graph Memory from Configuration")
        print("-" * 45)

        try:
            success = await seed_graph_memory()
            if success:
                print(
                    "   ✅ Successfully seeded organizational relationships from config"
                )
            else:
                print("   ⚠️  Graph seeding completed with warnings")
        except Exception as e:
            print(f"   ❌ Error during seeding: {e}")

        print()

    async def demo_relationship_storage(self):
        """Demonstrate storing entity relationships."""
        print("2. 🔗 Storing Entity Relationships")
        print("-" * 35)

        relationships = [
            {
                "source": "Colin",
                "relationship": "WORKS_AT",
                "target": "North Austin Facility",
                "metadata": {"role": "Field Engineer", "confidence": 1.0},
            },
            {
                "source": "Colin",
                "relationship": "SPECIALIZES_IN",
                "target": "Pump Maintenance",
                "metadata": {"years_experience": 5, "confidence": 0.9},
            },
            {
                "source": "North Austin Facility",
                "relationship": "USES",
                "target": "Advanced Pump Systems",
                "metadata": {"quantity": 12, "confidence": 1.0},
            },
        ]

        for rel in relationships:
            try:
                result = await self.memory.store_entity_relationship(
                    user_id=self.demo_user_id,
                    source_entity=rel["source"],
                    relationship=rel["relationship"],
                    target_entity=rel["target"],
                    metadata=rel["metadata"],
                )

                if result:
                    print(
                        f"   ✅ {rel['source']} -> {rel['relationship']} -> {rel['target']}"
                    )
                else:
                    print(
                        f"   ❌ Failed to store: {rel['source']} -> {rel['relationship']} -> {rel['target']}"
                    )

            except Exception as e:
                print(f"   ❌ Error storing relationship: {e}")

        print()

    async def demo_entity_context(self):
        """Demonstrate entity context retrieval."""
        print("3. 🎯 Retrieving Entity Context")
        print("-" * 32)

        entities_to_analyze = ["Colin", "North Austin Facility", "Pump Maintenance"]

        for entity in entities_to_analyze:
            try:
                context = await self.memory.get_entity_context(
                    user_id=self.demo_user_id,
                    entity=entity,
                    include_relationships=True,
                    include_mentions=True,
                )

                print(f"   📊 Context for '{entity}':")
                print(f"      - Direct mentions: {len(context['direct_mentions'])}")
                print(f"      - Relationship types: {len(context['relationships'])}")
                print(f"      - Related concepts: {len(context['related_concepts'])}")
                print(f"      - Confidence score: {context['confidence_score']:.2f}")

                if context["relationships"]:
                    print(
                        f"      - Relationships: {list(context['relationships'].keys())}"
                    )

                print()

            except Exception as e:
                print(f"   ❌ Error getting context for {entity}: {e}")

    async def demo_knowledge_graph(self):
        """Demonstrate knowledge graph building."""
        print("4. 🕸️  Building Knowledge Graph")
        print("-" * 30)

        try:
            graph = await self.memory.build_knowledge_graph(user_id=self.demo_user_id)

            print("   📈 Graph Statistics:")
            print(f"      - Total nodes: {graph['stats']['total_nodes']}")
            print(f"      - Total edges: {graph['stats']['total_edges']}")
            print(f"      - Node types: {graph['stats']['node_types']}")
            print(f"      - Relationship types: {graph['stats']['relationship_types']}")

            if graph["nodes"]:
                print("   \n   🔍 Sample Nodes:")
                for node in graph["nodes"][:5]:  # Show first 5 nodes
                    print(f"      - {node['label']} ({node['type']})")

            if graph["edges"]:
                print("   \n   🔗 Sample Relationships:")
                for edge in graph["edges"][:5]:  # Show first 5 edges
                    print(
                        f"      - {edge['source']} -> {edge['relationship']} -> {edge['target']}"
                    )

            print()

        except Exception as e:
            print(f"   ❌ Error building knowledge graph: {e}")

    async def demo_hybrid_search(self):
        """Demonstrate hybrid search with graph enhancement."""
        print("5. 🔍 Hybrid Search with Graph Enhancement")
        print("-" * 42)

        search_queries = [
            "pump maintenance procedures",
            "North Austin Facility operations",
            "Colin's expertise",
        ]

        for query in search_queries:
            try:
                results = await self.memory.hybrid_search_with_graph(
                    user_id=self.demo_user_id,
                    query=query,
                    include_related=True,
                    relationship_depth=1,
                    limit=5,
                )

                print(f"   🔎 Query: '{query}'")
                print(f"      - Results found: {len(results)}")

                for i, result in enumerate(results[:3], 1):  # Show top 3 results
                    source_type = result.get("source", "unknown")
                    score = result.get("score", 0.0)
                    print(f"      - Result {i}: {source_type} (score: {score:.2f})")

                    if (
                        "relationship_context" in result
                        and result["relationship_context"]
                    ):
                        rel_count = len(result["relationship_context"])
                        print(f"        → {rel_count} relationship contexts")

                print()

            except Exception as e:
                print(f"   ❌ Error in hybrid search for '{query}': {e}")

    async def demo_memory_stats(self):
        """Demonstrate memory statistics with graph data."""
        print("6. 📊 Memory Statistics")
        print("-" * 22)

        try:
            stats = await self.memory.get_memory_stats(user_id=self.demo_user_id)

            print("   💾 Memory Overview:")
            print(f"      - Total memories: {stats['total_memories']}")
            print(f"      - Graph enabled: {stats['has_graph']}")
            print(f"      - Graph entities: {stats['graph_entities']}")
            print(f"      - Graph relationships: {stats['graph_relationships']}")
            print(f"      - Graph density: {stats['graph_density']:.3f}")

            if stats["memory_types"]:
                print("   \n   📝 Memory Types:")
                for mem_type, count in stats["memory_types"].items():
                    print(f"      - {mem_type}: {count}")

            if stats["entity_types"]:
                print("   \n   🏷️  Entity Types:")
                for entity_type, count in stats["entity_types"].items():
                    print(f"      - {entity_type}: {count}")

            if stats["top_entities"]:
                print("   \n   ⭐ Top Connected Entities:")
                for entity_data in stats["top_entities"][:5]:
                    print(
                        f"      - {entity_data['entity']}: {entity_data['connections']} connections"
                    )

            print()

        except Exception as e:
            print(f"   ❌ Error getting memory stats: {e}")

    async def demo_connection_suggestions(self):
        """Demonstrate connection suggestions."""
        print("7. 💡 Connection Suggestions")
        print("-" * 27)

        entities_to_analyze = ["Colin", "North Austin Facility"]

        for entity in entities_to_analyze:
            try:
                suggestions = await self.memory.suggest_connections(
                    user_id=self.demo_user_id, entity=entity, limit=5
                )

                print(f"   🎯 Suggestions for '{entity}':")

                if suggestions:
                    for suggestion in suggestions:
                        confidence = suggestion["confidence"]
                        suggested_entity = suggestion["entity"]
                        reason = suggestion["reason"]
                        print(
                            f"      - {suggested_entity} (confidence: {confidence:.2f}, reason: {reason})"
                        )
                else:
                    print("      - No suggestions found")

                print()

            except Exception as e:
                print(f"   ❌ Error getting suggestions for {entity}: {e}")


async def main():
    """Main demo function."""
    demo = GraphMemoryDemo()
    await demo.run_demo()


if __name__ == "__main__":
    # Run the demo
    print("Starting Graph Memory Demo...")
    print(
        "Make sure you have Neo4j running and configured if you want to see graph features."
    )
    print()

    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        print("\n👋 Demo interrupted by user")
    except Exception as e:
        print(f"\n❌ Demo failed with error: {e}")
        import traceback

        traceback.print_exc()
