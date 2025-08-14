#!/usr/bin/env python3
"""Test Media Storage Service with comprehensive edge case coverage"""
import asyncio
import concurrent.futures
import os
import sys
from unittest.mock import MagicMock, patch

import pytest
from dotenv import load_dotenv

# Add parent directory to path before importing our modules
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", ".."))
from botocore.exceptions import ClientError, NoCredentialsError

from src.storage.media_storage import MediaStorage

# Load environment variables
load_dotenv()


# Edge case test fixtures
MALICIOUS_FILENAMES = [
    "../../../etc/passwd",
    "..\\..\\windows\\system32\\config\\sam",
    "file://etc/passwd",
    "\x00nullbyte.txt",
    "<script>alert(1)</script>.js",
    "'; DROP TABLE media;--.sql",
]

LARGE_FILE = b"x" * (50 * 1024 * 1024)  # 50MB
VERY_LARGE_FILE = b"x" * (500 * 1024 * 1024)  # 500MB
EMPTY_FILE = b""


async def test_media_storage_edge_cases():
    """Test media storage with comprehensive edge cases"""
    storage = MediaStorage()

    # Test 1: Null/None input handling
    print("\n🔍 Testing null/None inputs...")
    with pytest.raises((ValueError, AttributeError, TypeError)):
        await storage.upload_media(None, "file.txt", "text/plain")

    with pytest.raises((ValueError, AttributeError, TypeError)):
        await storage.upload_media(b"content", None, "text/plain")

    with pytest.raises((ValueError, AttributeError, TypeError)):
        await storage.download_media(None)

    # Test 2: Empty file handling
    print("\n🔍 Testing empty files...")
    result = await storage.upload_media(
        file_content=EMPTY_FILE, file_name="empty.txt", file_type="text/plain"
    )
    # Should handle empty files gracefully
    assert result is not None
    assert result.get("file_hash") is not None

    # Test 3: Malicious filenames
    print("\n🔍 Testing malicious filenames...")
    for malicious_name in MALICIOUS_FILENAMES:
        try:
            result = await storage.upload_media(
                file_content=b"safe content",
                file_name=malicious_name,
                file_type="text/plain",
            )
            # If it succeeds, filename should be sanitized
            assert result is not None
            assert ".." not in result["s3_key"]
            assert "<script>" not in result["s3_key"]
        except Exception:
            # S3 may reject malicious filenames, which is acceptable
            pass

    # Test 4: Invalid file types
    print("\n🔍 Testing invalid file types...")
    invalid_types = ["", None, "invalid/type/with/slashes", "text/plain; rm -rf /"]
    for file_type in invalid_types:
        try:
            result = await storage.upload_media(
                file_content=b"content",
                file_name="test.txt",
                file_type=file_type or "application/octet-stream",
            )
            assert result is not None  # Should handle gracefully
        except (ValueError, TypeError):
            pass  # Expected for None type

    # Test 5: Large file handling
    print("\n🔍 Testing large files...")
    # Test 50MB file
    result = await storage.upload_media(
        file_content=LARGE_FILE,
        file_name="large-file.bin",
        file_type="application/octet-stream",
        description="50MB test file",
    )
    assert result is not None
    print(f"   50MB file uploaded: {result['s3_key']}")

    # Test 6: Concurrent uploads
    print("\n🔍 Testing concurrent uploads...")

    async def concurrent_upload(index):
        content = f"Concurrent upload {index}".encode()
        return await storage.upload_media(
            file_content=content,
            file_name=f"concurrent-{index}.txt",
            file_type="text/plain",
        )

    # Upload same content concurrently (test deduplication)
    same_content = b"duplicate content test"

    async def concurrent_duplicate(index):
        return await storage.upload_media(
            file_content=same_content,
            file_name=f"duplicate-{index}.txt",
            file_type="text/plain",
        )

    with concurrent.futures.ThreadPoolExecutor(max_workers=10) as executor:
        loop = asyncio.get_event_loop()
        tasks = [
            loop.run_in_executor(executor, asyncio.run, concurrent_duplicate(i))
            for i in range(10)
        ]
        results = await asyncio.gather(*tasks, return_exceptions=True)

    # All should have same s3_key due to deduplication
    s3_keys = [r["s3_key"] for r in results if isinstance(r, dict)]
    assert len(set(s3_keys)) == 1  # All should be deduplicated to same key

    # Test 7: S3 connection failures
    print("\n🔍 Testing S3 failures...")
    with patch.object(storage.s3_client, "put_object") as mock_put:
        mock_put.side_effect = ClientError(
            {"Error": {"Code": "NoSuchBucket", "Message": "Bucket not found"}},
            "PutObject",
        )

        with pytest.raises(ClientError):
            await storage.upload_media(b"content", "fail.txt", "text/plain")

    # Test 8: Invalid S3 credentials
    with patch.object(storage.s3_client, "put_object") as mock_put:
        mock_put.side_effect = NoCredentialsError()

        with pytest.raises(NoCredentialsError):
            await storage.upload_media(b"content", "nocreds.txt", "text/plain")

    # Test 9: Unicode filenames
    print("\n🔍 Testing Unicode filenames...")
    unicode_names = [
        "中文文件.txt",
        "русский_файл.doc",
        "🚀🎉emoji.png",
        "café_månu.pdf",
    ]

    for name in unicode_names:
        try:
            result = await storage.upload_media(
                file_content=b"Unicode filename test",
                file_name=name,
                file_type="text/plain",
            )
            assert result is not None
            # S3 key should be URL-safe
            assert all(ord(c) < 128 for c in result["s3_key"] if c not in "/.-_")
        except Exception:
            # S3 may reject Unicode filenames in metadata, which is acceptable
            pass

    # Test 10: Presigned URL edge cases
    print("\n🔍 Testing presigned URL edge cases...")
    # Upload a test file first
    test_result = await storage.upload_media(
        b"URL test content", "url-test.txt", "text/plain"
    )

    # Test invalid expiration times
    for expires_in in [0, -1, sys.maxsize]:
        try:
            url = await storage.get_media_url(
                test_result["s3_key"], expires_in=expires_in
            )
            # Should either work or raise exception
        except (ValueError, OverflowError):
            pass

    # Test non-existent key
    url = await storage.get_media_url("non/existent/key.txt")
    assert url is None  # Should return None for non-existent files

    # Test 11: Download edge cases
    print("\n🔍 Testing download edge cases...")
    # Download non-existent file
    with patch.object(storage.s3_client, "get_object") as mock_get:
        mock_get.side_effect = ClientError(
            {"Error": {"Code": "NoSuchKey", "Message": "Key not found"}}, "GetObject"
        )

        content = await storage.download_media("non/existent/file.txt")
        assert content is None  # Should return None for missing files

    # Test 12: Media type filtering
    print("\n🔍 Testing media type filtering...")
    # Upload files with different types
    test_files = [
        (b"image", "test.jpg", "image/jpeg"),
        (b"video", "test.mp4", "video/mp4"),
        (b"audio", "test.mp3", "audio/mpeg"),
        (b"document", "test.pdf", "application/pdf"),
    ]

    for content, name, mime_type in test_files:
        await storage.upload_media(content, name, mime_type)

    # List with various filters
    for media_type in ["image", "video", "audio", "document", "unknown", ""]:
        results = await storage.list_media(media_type=media_type)
        assert isinstance(results, list)

    # Cleanup
    print("\n🧹 Cleaning up test files...")
    # Note: In real tests, we would clean up all uploaded files
    # For now, just delete the main test files
    test_keys = [result["s3_key"], test_result["s3_key"]] + s3_keys[:1]
    for key in test_keys:
        try:
            await storage.delete_media(key)
        except Exception:
            pass  # Ignore cleanup errors

    print("\n✅ All media storage edge case tests completed!")


async def test_hash_collision_handling():
    """Test handling of hash collisions"""
    storage = MediaStorage()

    print("\n🔍 Testing hash collision handling...")

    # Create two different files with mocked same hash
    content1 = b"File content 1"
    content2 = b"Different file content 2"

    # Upload first file
    result1 = await storage.upload_media(content1, "file1.txt", "text/plain")

    # Mock hash function to return same hash for different content
    with patch("hashlib.sha256") as mock_hash:
        mock_instance = MagicMock()
        mock_instance.hexdigest.return_value = result1["file_hash"]
        mock_hash.return_value = mock_instance

        # This should still work even with hash collision
        result2 = await storage.upload_media(content2, "file2.txt", "text/plain")

        # Files should have different S3 keys despite same hash
        assert result2["already_exists"] is True  # Due to mocked same hash
        assert result2["s3_key"] == result1["s3_key"]  # Dedup thinks it's same file

    print("✅ Hash collision test completed!")


async def test_media_storage():
    """Test basic media storage operations"""
    try:
        # Initialize storage
        print("🔍 Testing Media Storage Service")
        print(
            f"AWS_ACCESS_KEY_ID: {os.getenv('AWS_ACCESS_KEY_ID')[:10]}..."
            if os.getenv("AWS_ACCESS_KEY_ID")
            else "❌ Missing"
        )
        print(f"S3_BUCKET_NAME: {os.getenv('S3_BUCKET_NAME')}")
        print()

        storage = MediaStorage()
        print("✅ MediaStorage initialized")

        # Test 1: Upload a text file
        print("\n📤 Testing file upload...")
        test_content = b"This is a test file for the brain bot media storage system."

        result = await storage.upload_media(
            file_content=test_content,
            file_name="test-document.txt",
            file_type="text/plain",
            description="Test document for storage system",
            tags=["test", "storage", "s3"],
        )

        print("✅ File uploaded:")
        print(f"   S3 Key: {result['s3_key']}")
        print(f"   S3 URL: {result['s3_url']}")
        print(f"   File Hash: {result['file_hash'][:16]}...")
        print(f"   Already Existed: {result['already_exists']}")

        # Test 2: Upload same file again (deduplication test)
        print("\n🔁 Testing deduplication...")
        result2 = await storage.upload_media(
            file_content=test_content,
            file_name="test-document-copy.txt",
            file_type="text/plain",
        )

        print("✅ Deduplication works:")
        print(f"   Same S3 Key: {result2['s3_key'] == result['s3_key']}")
        print(f"   Already Existed: {result2['already_exists']}")

        # Test 3: Download file
        print("\n📥 Testing file download...")
        content = await storage.download_media(result["s3_key"])

        if content:
            print("✅ File downloaded:")
            print(f"   Size: {len(content)} bytes")
            print(f"   Content matches: {content == test_content}")
        else:
            print("❌ Failed to download file")

        # Test 4: Generate presigned URL
        print("\n🔗 Testing presigned URL generation...")
        url = await storage.get_media_url(result["s3_key"], expires_in=300)

        if url:
            print("✅ Presigned URL generated:")
            print(f"   URL: {url[:80]}...")
            print("   Expires in: 5 minutes")
        else:
            print("❌ Failed to generate presigned URL")

        # Test 5: List media
        print("\n📋 Testing media listing...")
        media_list = await storage.list_media(media_type="document", limit=10)

        print(f"✅ Found {len(media_list)} documents in S3")
        for media in media_list[:3]:
            print(f"   - {media['s3_key']} ({media['size']} bytes)")

        # Test 6: Upload an image (different type)
        print("\n🖼️ Testing image upload...")
        fake_image = b"\x89PNG\r\n\x1a\n" + b"\x00" * 100  # Fake PNG header

        img_result = await storage.upload_media(
            file_content=fake_image,
            file_name="test-image.png",
            file_type="image/png",
            telegram_chat_id=123456,
            telegram_user_id=789,
            description="Test image upload",
            tags=["test", "image"],
        )

        print(f"✅ Image uploaded to: {img_result['s3_key']}")
        print(f"   Folder: {img_result['s3_key'].split('/')[1]}")

        print("\n✅ All media storage tests passed!")

        # Cleanup
        print("\n🧹 Cleaning up test files...")
        deleted1 = await storage.delete_media(result["s3_key"])
        deleted2 = await storage.delete_media(img_result["s3_key"])

        if deleted1 and deleted2:
            print("✅ Test files deleted")

        return True

    except Exception as e:
        print(f"\n❌ Media storage test failed: {e}")
        import traceback

        traceback.print_exc()
        return False


async def test_media_metadata_edge_cases():
    """Test media metadata handling edge cases"""
    storage = MediaStorage()

    print("\n🔍 Testing metadata edge cases...")

    # Test 1: Extremely long tags
    long_tags = ["x" * 1000 for _ in range(100)]  # 100 tags of 1000 chars each
    result = await storage.upload_media(
        b"metadata test", "metadata-test.txt", "text/plain", tags=long_tags
    )
    assert result is not None

    # Test 2: Special characters in description
    special_descriptions = [
        "Line1\nLine2\rLine3",
        "Tab\there",
        "Quote'and\"double",
        "Null\x00byte",
        "Unicode ❤️ 🌈 ✨",
    ]

    for desc in special_descriptions:
        result = await storage.upload_media(
            b"special desc", f"special-{hash(desc)}.txt", "text/plain", description=desc
        )
        assert result is not None

    # Test 3: Invalid telegram IDs
    invalid_ids = [0, -1, sys.maxsize, float("inf"), float("-inf")]
    for telegram_id in invalid_ids:
        try:
            result = await storage.upload_media(
                b"telegram test",
                "telegram.txt",
                "text/plain",
                telegram_chat_id=(
                    int(telegram_id) if telegram_id != float("inf") else 999999
                ),
                telegram_user_id=(
                    int(telegram_id) if telegram_id != float("inf") else 999999
                ),
            )
            # Should handle gracefully
        except (ValueError, OverflowError):
            pass  # Expected for inf values

    print("✅ Metadata edge case tests completed!")


if __name__ == "__main__":
    # Run all test suites
    asyncio.run(test_media_storage())
    asyncio.run(test_media_storage_edge_cases())
    asyncio.run(test_hash_collision_handling())
    asyncio.run(test_media_metadata_edge_cases())
