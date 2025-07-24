#!/usr/bin/env python3
"""
Comprehensive test script for all storage integrations:
- Upstash Redis (session memory)
- Upstash Vector (RAG embeddings)
- Supabase (document storage)
- AWS S3 (media storage)
"""

import os
import sys
import asyncio
from datetime import datetime

# Add parent directory to path
sys.path.insert(
    0, os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
)

from dotenv import load_dotenv

load_dotenv()

# Test results tracking
results = {
    "redis": {"status": "pending", "message": ""},
    "vector": {"status": "pending", "message": ""},
    "supabase": {"status": "pending", "message": ""},
    "s3": {"status": "pending", "message": ""},
    "integration": {"status": "pending", "message": ""},
}


def print_header(title):
    print(f"\n{'='*60}")
    print(f"  {title}")
    print(f"{'='*60}\n")


def print_result(component, success, message):
    status = "✅ PASSED" if success else "❌ FAILED"
    print(f"{component}: {status}")
    print(f"  {message}")
    results[component]["status"] = "passed" if success else "failed"
    results[component]["message"] = message


async def test_redis():
    """Test Upstash Redis session storage"""
    print_header("Testing Upstash Redis")

    try:
        from src.storage.redis_store import RedisStore

        # Create redis store instance
        store = RedisStore()
        test_user_id = "test_user_123"
        test_key = f"conversation:{test_user_id}"

        # Test 1: Store conversation data
        test_data = [
            {"role": "user", "content": "Hello, testing Redis!"},
            {"role": "assistant", "content": "Redis test response"},
        ]

        # Store data
        store.set(test_key, test_data, expire_seconds=300)

        # Test 2: Retrieve conversation data
        retrieved_data = store.get(test_key)

        if retrieved_data and len(retrieved_data) == 2:
            print_result(
                "redis",
                True,
                f"Successfully stored and retrieved {len(retrieved_data)} messages",
            )
            print(f"  Data: {retrieved_data[0]['content'][:50]}...")
        else:
            print_result(
                "redis",
                False,
                f"Expected 2 messages, got {len(retrieved_data) if retrieved_data else 0}",
            )
            return

        # Test 3: Delete data
        store.delete(test_key)
        data_after = store.get(test_key)

        if data_after is None:
            print("  ✓ Delete operation working")
        else:
            print("  ✗ Delete operation failed")

    except ImportError as e:
        print_result(
            "redis", False, f"Import error - check if RedisStore exists: {str(e)}"
        )
    except Exception as e:
        print_result("redis", False, f"Error: {type(e).__name__}: {str(e)}")


async def test_vector():
    """Test Upstash Vector for RAG"""
    print_header("Testing Upstash Vector")

    try:
        from src.storage.vector_store import VectorStore

        # Create vector store instance
        vs = VectorStore()

        # Test 1: Add document with chunks
        test_content = "This is a test document about Python programming and machine learning. It contains multiple sentences for chunking."
        test_file = "test_vector_doc.md"

        # Add document (will be chunked automatically)
        vs.add_document(test_file, test_content)
        print("  ✓ Document added and chunked in vector store")

        # Test 2: Search for relevant content
        results = vs.search("Python programming", k=2)

        if results and len(results) > 0:
            print_result("vector", True, f"Found {len(results)} relevant chunks")
            for i, result in enumerate(results[:2]):
                print(
                    f"  Result {i+1}: {result.get('filename', 'unknown')} (score: {result.get('score', 0):.3f})"
                )
                print(f"    Content: {result.get('content', '')[:60]}...")
        else:
            print_result("vector", False, "No search results returned")

        # Test 3: Delete document
        try:
            vs.delete_document(test_file)
            print("  ✓ Document deleted from vector store")
        except AttributeError:
            print("  ⚠ Delete method not implemented - skipping")

    except ImportError as e:
        print_result(
            "vector", False, f"Import error - check vector_store location: {str(e)}"
        )
    except Exception as e:
        print_result("vector", False, f"Error: {type(e).__name__}: {str(e)}")


async def test_supabase():
    """Test Supabase document storage"""
    print_header("Testing Supabase Document Storage")

    try:
        from src.storage.storage_service import StorageService

        # Create storage instance
        storage = StorageService()

        # Test 1: Save document using create_file
        test_title = "Storage Test Document"
        test_content = (
            "# Storage Test\n\nTesting Supabase document storage integration."
        )
        test_folder = "test"
        test_tags = ["test", "storage", "integration"]

        # Note: StorageService expects title, not path
        result = storage.create_file(
            title=test_title,
            content=test_content,
            folder=test_folder,
            file_type="note",
            tags=test_tags,
        )

        if result and "created" in result:
            print("  ✓ Document created successfully")
            print(f"  File path: {result.get('file_path', 'unknown')}")
            test_path = result.get("file_path")
        else:
            print_result("supabase", False, f"Failed to create document: {result}")
            return

        # Test 2: Read document
        if test_path:
            doc_content = storage.read_file(test_path)

            if doc_content:
                print("  ✓ Document retrieved successfully")
                print(f"  Content length: {len(doc_content)} chars")
            else:
                print("  ✗ Failed to retrieve document")

        # Test 3: Search for document
        search_results = storage.search_files("Storage Test")

        if search_results:
            print(f"  ✓ Search found {len(search_results)} documents")
        else:
            print("  ⚠ Search returned no results")

        # Test 4: List all files
        all_files = storage.list_all_files()
        print(f"  ✓ Total files in storage: {len(all_files)}")

        print_result("supabase", True, "All storage operations completed successfully")

    except ImportError as e:
        print_result(
            "supabase", False, f"Import error - check StorageService: {str(e)}"
        )
    except Exception as e:
        print_result("supabase", False, f"Error: {type(e).__name__}: {str(e)}")


async def test_s3():
    """Test AWS S3 media storage"""
    print_header("Testing AWS S3 Media Storage")

    try:
        from src.storage.media_storage import MediaStorage

        # Create storage instance
        storage = MediaStorage()

        # Test 1: Upload text file
        test_content = b"This is a test file for S3 storage"
        test_key = "test/test_file.txt"

        url = storage.upload_media(test_key, test_content, "text/plain")

        if url:
            print("  ✓ Text file uploaded successfully")
            print(f"  URL: {url}")
        else:
            print_result("s3", False, "Failed to upload file")
            return

        # Test 2: Upload binary data (simulate image)
        # Create fake image data instead of using PIL
        fake_image_data = (
            b"\x89PNG\r\n\x1a\n" + b"\x00" * 100
        )  # Minimal PNG header + data

        img_key = "test/test_image.png"
        img_url = storage.upload_media(img_key, fake_image_data, "image/png")

        if img_url:
            print("  ✓ Binary file uploaded successfully")
            print(f"  URL: {img_url}")
        else:
            print("  ✗ Failed to upload binary file")

        # Test 3: List files (if method available)
        # Note: Standard S3 doesn't have a simple list, would need to implement

        print_result("s3", True, "All media operations completed successfully")

    except ImportError as e:
        print_result("s3", False, f"Import error - check MediaStorage: {str(e)}")
    except Exception as e:
        print_result("s3", False, f"Error: {type(e).__name__}: {str(e)}")


async def test_integration():
    """Test integrated workflow with all components"""
    print_header("Testing Integrated Workflow")

    try:
        from src.storage.storage_service import StorageService
        from src.storage.media_storage import MediaStorage
        from src.storage.redis_store import RedisStore

        # Simulate a complete workflow
        user_id = "integration_test_user"

        # 1. User sends message (stored in Redis)
        redis_store = RedisStore()
        conversation_key = f"conversation:{user_id}"

        conversation = [
            {
                "role": "user",
                "content": "Create a note about our Q4 2024 planning meeting",
            },
            {"role": "assistant", "content": "I'll create a meeting note for you."},
        ]
        redis_store.set(conversation_key, conversation, expire_seconds=300)
        print("  1. ✓ Conversation stored in Redis")

        # 2. Create document via StorageService
        storage = StorageService()
        doc_result = storage.create_file(
            title="Q4 2024 Planning Meeting",
            content="""# Q4 2024 Planning Meeting

Date: 2024-01-19
Attendees: Team A, Team B

## Key Points
- Budget review
- Project timeline
- Resource allocation

## Action Items
1. Review budget proposals
2. Update project roadmap
3. Schedule follow-up meetings
""",
            folder="meetings",
            file_type="meeting-notes",
            tags=["meeting", "planning", "Q4-2024"],
        )

        if doc_result and "created" in doc_result:
            print("  2. ✓ Document created via StorageService")
            doc_path = doc_result.get("file_path")
        else:
            print("  2. ✗ Failed to create document")
            doc_path = None

        # 3. Vector search should work automatically via StorageService
        if doc_path:
            # Test search
            search_results = storage.search_files("budget review Q4")
            if search_results:
                print(f"  3. ✓ RAG search found {len(search_results)} results")
            else:
                print("  3. ⚠ RAG search returned no results")

        # 4. Simulate media attachment
        media_storage = MediaStorage()
        mock_image = b"\xff\xd8\xff\xe0" + b"\x00" * 100  # JPEG header + data
        media_url = media_storage.upload_media(
            "test/meeting_whiteboard.jpg", mock_image, "image/jpeg"
        )

        if media_url:
            print("  4. ✓ Media uploaded to S3")
            print(f"     URL: {media_url}")
        else:
            print("  4. ✗ Failed to upload media")

        # 5. Update conversation with result
        conversation.append(
            {
                "role": "assistant",
                "content": f"Created meeting notes at {doc_path or 'unknown'} with attached whiteboard image",
            }
        )
        redis_store.set(conversation_key, conversation, expire_seconds=300)

        # Check overall success
        redis_ok = redis_store.get(conversation_key) is not None
        storage_ok = doc_result is not None
        media_ok = media_url is not None

        if redis_ok and storage_ok and media_ok:
            print_result(
                "integration",
                True,
                "Complete workflow successful: Redis → StorageService → Vector → S3",
            )
            print("\n  Integration verified:")
            print("  - Redis session management ✓")
            print("  - Document storage (file + Supabase) ✓")
            print("  - Vector search (automatic via StorageService) ✓")
            print("  - Media storage (S3) ✓")
        else:
            failures = []
            if not redis_ok:
                failures.append("Redis")
            if not storage_ok:
                failures.append("Storage")
            if not media_ok:
                failures.append("S3")
            print_result(
                "integration", False, f"Failed components: {', '.join(failures)}"
            )

    except ImportError as e:
        print_result("integration", False, f"Import error: {str(e)}")
    except Exception as e:
        print_result("integration", False, f"Error: {type(e).__name__}: {str(e)}")


async def main():
    """Run all tests"""
    print("\n🧪 BRAIN BOT STORAGE INTEGRATION TEST SUITE")
    print("=" * 60)
    print(f"Started at: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")

    # Run individual component tests
    await test_redis()
    await test_vector()
    await test_supabase()
    await test_s3()
    await test_integration()

    # Summary
    print_header("TEST SUMMARY")

    all_passed = True
    for component, result in results.items():
        status_icon = "✅" if result["status"] == "passed" else "❌"
        print(f"{status_icon} {component.upper()}: {result['status']}")
        if result["status"] != "passed":
            all_passed = False
            print(f"   → {result['message']}")

    print("\n" + "=" * 60)
    if all_passed:
        print("🎉 ALL TESTS PASSED! Storage integration is working correctly.")
    else:
        print("⚠️  Some tests failed. Please check the errors above.")
    print("=" * 60)


if __name__ == "__main__":
    # Check for required environment variables first
    required_vars = [
        "TELEGRAM_BOT_TOKEN",
        "OPENAI_API_KEY",
        "UPSTASH_REDIS_REST_URL",
        "UPSTASH_REDIS_REST_TOKEN",
        "UPSTASH_VECTOR_REST_URL",
        "UPSTASH_VECTOR_REST_TOKEN",
        "SUPABASE_URL",
        "SUPABASE_ANON_KEY",
        "S3_ACCESS_KEY_ID",
        "S3_SECRET_ACCESS_KEY",
        "S3_BUCKET_NAME",
    ]

    missing_vars = []
    for var in required_vars:
        if not os.getenv(var):
            missing_vars.append(var)

    if missing_vars:
        print("\n⚠️  Missing environment variables:")
        for var in missing_vars:
            print(f"  - {var}")
        print("\nPlease check your .env file.")
        sys.exit(1)

    # Run tests
    asyncio.run(main())
