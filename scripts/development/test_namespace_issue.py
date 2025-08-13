#!/usr/bin/env python3
"""Test script to demonstrate the namespace issue with vector search."""

import asyncio
import sys
import os

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "..", "src"))

from storage.vector_store import vector_store
import logging

# Configure logging
logging.basicConfig(
    level=logging.INFO, format="%(asctime)s - %(name)s - %(levelname)s - %(message)s"
)


async def test_namespace_issue():
    """Test storing and searching with different namespaces."""
    print("\n=== Testing Vector Store Namespace Issue ===")

    # Test 1: Store without namespace, search without namespace
    print("\n1. Store WITHOUT namespace, search WITHOUT namespace:")
    doc_id = "test_doc_1"
    content = "This is a test document about machine learning and AI."
    metadata = {"title": "ML Guide", "category": "tech"}

    success = await vector_store.embed_and_store(doc_id, content, metadata)
    print(f"   Stored: {success}")

    results = await vector_store.search("machine learning", top_k=3)
    print(f"   Found: {len(results)} results")

    # Test 2: Store with namespace, search with same namespace
    print("\n2. Store WITH namespace='user123', search WITH namespace='user123':")
    doc_id = "test_doc_2"
    content = "This is another test document about Python programming."
    metadata = {"title": "Python Guide", "category": "programming"}

    success = await vector_store.embed_and_store(
        doc_id, content, metadata, namespace="user123"
    )
    print(f"   Stored: {success}")

    results = await vector_store.search(
        "Python programming", top_k=3, namespace="user123"
    )
    print(f"   Found: {len(results)} results")

    # Test 3: Search with wrong namespace
    print("\n3. Search WITH namespace='user456' (wrong namespace):")
    results = await vector_store.search(
        "Python programming", top_k=3, namespace="user456"
    )
    print(f"   Found: {len(results)} results (should be 0!)")

    # Test 4: Store with namespace, search without namespace
    print("\n4. Store WITH namespace='user789', search WITHOUT namespace:")
    doc_id = "test_doc_3"
    content = "This is a test document about web development."
    metadata = {"title": "Web Dev Guide", "category": "programming"}

    success = await vector_store.embed_and_store(
        doc_id, content, metadata, namespace="user789"
    )
    print(f"   Stored: {success}")

    results = await vector_store.search("web development", top_k=3)
    print(f"   Found: {len(results)} results (won't find the namespaced document!)")

    # Cleanup
    print("\nCleaning up test documents...")
    await vector_store.delete_document("test_doc_1")
    await vector_store.delete_document("test_doc_2", namespace="user123")
    await vector_store.delete_document("test_doc_3", namespace="user789")

    print("\n=== Test Complete ===")
    print("\nKey Findings:")
    print(
        "- Documents stored WITH a namespace can only be found when searching WITH the SAME namespace"
    )
    print(
        "- Documents stored WITHOUT a namespace can only be found when searching WITHOUT a namespace"
    )
    print(
        "- This is why the bot returns empty results - it's searching in the wrong namespace!"
    )


if __name__ == "__main__":
    asyncio.run(test_namespace_issue())
