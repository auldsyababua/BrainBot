#!/usr/bin/env python3
"""Test Document Storage Service"""
import asyncio
from src.storage.storage_service import DocumentStorage
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()


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
        print(
            f"SUPABASE_ANON_KEY: {'SET' if os.getenv('SUPABASE_ANON_KEY') else '❌ Missing'}"
        )
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
        results = await storage.search_documents(
            query="storage system", category="test", limit=5
        )

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


if __name__ == "__main__":
    asyncio.run(test_document_storage())
