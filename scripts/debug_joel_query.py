#!/usr/bin/env python3
"""
Debug script for the Joel Fulford query issue.
"""

import asyncio
import sys
import os

# Add project root to path
project_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, project_root)

from src.storage.vector_store import vector_store
from src.core.llm import process_message


async def test_vector_search():
    """Test vector search independently."""
    print("\n1. Testing vector search for 'joel fulford'")
    print("=" * 60)

    results = await vector_store.search("joel fulford", top_k=5, include_metadata=True)

    print(f"\nFound {len(results)} results:")
    for i, result in enumerate(results):
        print(f"\nResult {i+1}:")
        print(f"  ID: {result['id']}")
        print(f"  Score: {result['score']:.4f}")
        if result.get("content"):
            print(f"  Content preview: {result['content'][:200]}...")
        if result.get("metadata", {}).get("content_preview"):
            preview = result["metadata"]["content_preview"]
            # Look for Joel Fulford in the preview
            if "joel" in preview.lower():
                print(
                    f"  ⭐ FOUND JOEL: {preview[preview.lower().find('joel')-50:preview.lower().find('joel')+150]}"
                )


async def test_full_flow():
    """Test the full processing flow."""
    print("\n\n2. Testing full LLM flow")
    print("=" * 60)

    # Test with the exact query that failed
    response = await process_message(
        "can you tell me what you know about joel fulford", "debug_test"
    )

    print("\nLLM Response:")
    print(response)


async def test_context_building():
    """Test how context is built in process_message."""
    print("\n\n3. Testing context building")
    print("=" * 60)

    # Manually search and build context like process_message does
    search_results = await vector_store.search(
        "joel fulford", top_k=5, include_metadata=True
    )

    context_parts = []
    for result in search_results:
        if result.get("metadata"):
            file_path = result["metadata"].get("file_path", "Unknown")
            content = result.get("content", "")
            if not content and result["metadata"].get("content_preview"):
                content = result["metadata"]["content_preview"]

            if content:
                context_parts.append(f"\n---\nFrom {file_path}:\n{content}\n---\n")

    print("\nContext parts built:")
    for i, part in enumerate(context_parts):
        print(f"\nContext {i+1}: {part[:300]}...")

    # Build the enhanced message
    user_message = "can you tell me what you know about joel fulford"
    enhanced_message = f"{user_message}\n\n[System: Found relevant context from knowledge base]\n{''.join(context_parts)}"

    print("\n\nEnhanced message preview:")
    print(enhanced_message[:500] + "...")


async def main():
    print("🔍 Debugging Joel Fulford Query Issue")
    print("=" * 60)

    await test_vector_search()
    await test_context_building()
    await test_full_flow()


if __name__ == "__main__":
    asyncio.run(main())
