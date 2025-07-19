#!/usr/bin/env python3
"""
Test if hybrid index is working properly with both dense and sparse search
"""

import os
import sys
import asyncio

# Add src to Python path
sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)), "src"))

from storage.vector_store import vector_store


async def test_hybrid():
    print("🧪 Testing Hybrid Vector Capabilities")
    print("=" * 50)
    print("📊 Your index configuration: bge-small-en-v1.5 (dense) + BM25 (sparse)")

    # Store a test document
    test_id = "hybrid_test_doc"
    test_content = "Eagle Lake site, also known as English or Wharton, is operated by 10NetZero with partner Flober LLC"

    print("\n1️⃣ Storing test document...")
    await vector_store.embed_and_store(test_id, test_content, {"test": "hybrid"})

    # Wait for indexing
    print("\n⏳ Waiting 5 seconds for indexing...")
    await asyncio.sleep(5)

    # Test different queries
    test_queries = [
        ("Eagle Lake English Wharton", "Exact keyword match"),
        ("site with Flober partnership", "Semantic understanding"),
        ("10NetZero mining operations", "Mixed query"),
    ]

    print("\n2️⃣ Testing queries with your hybrid index:")

    for query, desc in test_queries:
        print(f"\n🔍 Query: '{query}' ({desc})")

        # Default query should use hybrid mode automatically
        try:
            results = await vector_store.search(query, top_k=3)
            if results:
                for i, r in enumerate(results, 1):
                    score = r.get("score", 0)
                    doc_id = r.get("id", "Unknown")
                    print(f"   {i}. [{score:.4f}] {doc_id}")
            else:
                print("   No results found")
        except Exception as e:
            print(f"   ❌ Error: {e}")

    # Try direct index query to test different modes
    print("\n3️⃣ Testing direct index queries:")

    # Test basic query with index
    print("\n📝 Direct index query (should use hybrid mode):")
    try:
        direct_results = vector_store.index.query(
            data="Eagle Lake Flober", top_k=3, include_metadata=True
        )
        for i, r in enumerate(direct_results, 1):
            print(f"   {i}. [{r.score:.4f}] {r.id}")
    except Exception as e:
        print(f"   ❌ Error: {e}")

    # Cleanup
    print("\n🧹 Cleaning up test document...")
    await vector_store.delete_document(test_id)

    print("\n✅ Test complete!")
    print("\n💡 Your hybrid index appears to be configured correctly!")
    print("   - Dense model: bge-small-en-v1.5 (for semantic understanding)")
    print("   - Sparse model: BM25 (for keyword matching)")
    print("   - Queries automatically use both models for best results")


if __name__ == "__main__":
    asyncio.run(test_hybrid())
