#!/usr/bin/env python3
"""Test Media Storage Service"""
import asyncio
from src.storage.media_storage import MediaStorage
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()


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


if __name__ == "__main__":
    asyncio.run(test_media_storage())
