#!/usr/bin/env python3
"""
Test 10NetZero Vector Store Queries
Demonstrates working semantic search on 10NetZero knowledge base
"""

import os
import sys
import asyncio

# Add src to Python path
sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)), "src"))

from storage.vector_store import vector_store


async def main():
    print("🔍 Testing 10NetZero Vector Store Queries")
    print("=" * 50)

    test_queries = [
        "How many sites does 10NetZero have?",
        "What are the aliases for Eagle Lake?",
        "Who are the partners at each site?",
        "Tell me about Mathis site",
        "What is FLRTS?",
        "Todoist webhook implementation",
        "10NetZero founders",
        "Bitcoin mining operations",
    ]

    for query in test_queries:
        print(f"\n🔍 Query: '{query}'")
        results = await vector_store.search(query, top_k=2)

        if results:
            for i, result in enumerate(results, 1):
                score = result.get("score", 0)
                metadata = result.get("metadata", {})
                title = metadata.get("title", "Unknown")
                file_path = metadata.get("file_path", "Unknown")
                preview = (
                    result.get("content", "")[:150] + "..."
                    if result.get("content")
                    else "No preview"
                )

                print(f"\n   {i}. [{score:.4f}] {title}")
                print(f"      📁 {file_path}")
                print(f"      📝 {preview}")
        else:
            print("   ❌ No results found")

    print("\n✅ Test complete!")


if __name__ == "__main__":
    asyncio.run(main())
