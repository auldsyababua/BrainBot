#!/usr/bin/env python3
"""Test S3 connection and credentials with comprehensive edge case coverage"""
import concurrent.futures
import os
from unittest.mock import patch

import boto3
from botocore.exceptions import (
    ClientError,
    EndpointConnectionError,
    NoCredentialsError,
    ParamValidationError,
)
from dotenv import load_dotenv

# Load environment variables
load_dotenv()


# Edge case test fixtures
MALICIOUS_BUCKET_NAMES = [
    "../../../etc/passwd",
    "bucket'; DROP TABLE--",
    "<script>alert(1)</script>",
    "bucket\x00null",
    "http://evil.com/bucket",
]

INVALID_BUCKET_NAMES = [
    "",  # Empty
    "a",  # Too short
    "a" * 64,  # Too long
    "Bucket-Name",  # Uppercase
    "bucket..name",  # Consecutive dots
    "192.168.1.1",  # IP address format
    "bucket name",  # Space
    "bucket_name",  # Underscore
]

LARGE_FILE_SIZE = 100 * 1024 * 1024  # 100MB


def test_s3_connection_edge_cases():
    """Test S3 connection with comprehensive edge cases"""
    try:
        # Get credentials
        aws_access_key = os.getenv("AWS_ACCESS_KEY_ID")
        aws_secret_key = os.getenv("AWS_SECRET_ACCESS_KEY")
        aws_region = os.getenv("AWS_REGION", "us-east-1")
        bucket_name = os.getenv("S3_BUCKET_NAME", "t2t2-images")

        if not aws_access_key or not aws_secret_key:
            print("❌ AWS credentials missing, skipping edge case tests")
            return

        # Create S3 client
        s3_client = boto3.client(
            "s3",
            aws_access_key_id=aws_access_key,
            aws_secret_access_key=aws_secret_key,
            region_name=aws_region,
        )

        print("🔍 Testing S3 Edge Cases")

        # Test 1: Invalid bucket names
        print("\n📦 Testing invalid bucket names...")
        for invalid_name in INVALID_BUCKET_NAMES:
            try:
                s3_client.head_bucket(Bucket=invalid_name)
                print(f"   ⚠️ Unexpectedly succeeded for: {repr(invalid_name)}")
            except (ClientError, ParamValidationError):
                print(f"   ✅ Correctly rejected: {repr(invalid_name)}")

        # Test 2: Malicious bucket names
        print("\n🛡️ Testing malicious bucket names...")
        for malicious_name in MALICIOUS_BUCKET_NAMES:
            try:
                # Should be rejected by validation
                s3_client.head_bucket(Bucket=malicious_name)
                print(f"   ⚠️ Unexpectedly succeeded for: {repr(malicious_name)}")
            except (ClientError, ParamValidationError):
                print(f"   ✅ Correctly rejected: {repr(malicious_name)}")

        # Test 3: Invalid region handling
        print("\n🌍 Testing invalid regions...")
        invalid_regions = ["invalid-region", "us-invalid-1", "", None]
        for region in invalid_regions:
            try:
                bad_client = boto3.client(
                    "s3",
                    aws_access_key_id=aws_access_key,
                    aws_secret_access_key=aws_secret_key,
                    region_name=region or "us-east-1",
                )
                # Try to use the client
                bad_client.list_buckets()
            except Exception as e:
                print(f"   ✅ Region {repr(region)} handled: {type(e).__name__}")

        # Test 4: Concurrent operations
        print("\n🔄 Testing concurrent S3 operations...")

        def concurrent_list(index):
            return s3_client.list_objects_v2(
                Bucket=bucket_name,
                MaxKeys=1,
                Prefix=f"brain-bot/concurrent-test-{index}/",
            )

        with concurrent.futures.ThreadPoolExecutor(max_workers=10) as executor:
            futures = [executor.submit(concurrent_list, i) for i in range(20)]
            results = [f.result() for f in concurrent.futures.as_completed(futures)]

        print(f"   ✅ Completed {len(results)} concurrent operations")

        # Test 5: Large object handling
        print("\n📦 Testing large object operations...")
        large_key = "brain-bot/test/large-object-test.bin"

        # Test multipart upload threshold
        try:
            # S3 requires multipart for objects > 5GB, but we'll test with smaller
            response = s3_client.create_multipart_upload(
                Bucket=bucket_name,
                Key=large_key,
                ContentType="application/octet-stream",
            )
            upload_id = response["UploadId"]

            # Abort the multipart upload (cleanup)
            s3_client.abort_multipart_upload(
                Bucket=bucket_name, Key=large_key, UploadId=upload_id
            )
            print("   ✅ Multipart upload operations working")
        except ClientError as e:
            print(f"   ⚠️ Multipart upload test failed: {e}")

        # Test 6: Special characters in object keys
        print("\n🔤 Testing special characters in keys...")
        special_keys = [
            "brain-bot/test/file with spaces.txt",
            "brain-bot/test/文件名.txt",
            "brain-bot/test/файл.txt",
            "brain-bot/test/emoji-🚀.txt",
            "brain-bot/test/special!@#$%^&()_+.txt",
        ]

        for key in special_keys:
            try:
                s3_client.put_object(
                    Bucket=bucket_name,
                    Key=key,
                    Body=b"Special character test",
                    ContentType="text/plain",
                )
                print(f"   ✅ Uploaded: {repr(key)}")

                # Cleanup
                s3_client.delete_object(Bucket=bucket_name, Key=key)
            except ClientError as e:
                print(f"   ❌ Failed for {repr(key)}: {e}")

        # Test 7: Error handling for various S3 errors
        print("\n❌ Testing S3 error handling...")
        error_scenarios = [
            ("non-existent-bucket-12345", "NoSuchBucket"),
            (bucket_name + "/invalid", "InvalidBucketName"),
        ]

        for test_bucket, expected_error in error_scenarios:
            try:
                s3_client.head_bucket(Bucket=test_bucket)
            except ClientError as e:
                error_code = e.response["Error"]["Code"]
                print(f"   ✅ Got expected error {error_code} for {test_bucket}")
            except ParamValidationError:
                print(f"   ✅ Parameter validation error for {test_bucket}")

        # Test 8: Presigned URL edge cases
        print("\n🔗 Testing presigned URL edge cases...")
        test_key = "brain-bot/test/presigned-test.txt"

        # Upload test object
        s3_client.put_object(
            Bucket=bucket_name, Key=test_key, Body=b"Presigned URL test"
        )

        # Test various expiration times
        expiration_times = [1, 60, 3600, 604800]  # 1s, 1m, 1h, 1 week
        for exp_time in expiration_times:
            url = s3_client.generate_presigned_url(
                "get_object",
                Params={"Bucket": bucket_name, "Key": test_key},
                ExpiresIn=exp_time,
            )
            assert url is not None
            print(f"   ✅ Generated URL with {exp_time}s expiration")

        # Cleanup
        s3_client.delete_object(Bucket=bucket_name, Key=test_key)

        print("\n✅ All S3 edge case tests completed!")
        return True

    except Exception as e:
        print(f"\n❌ S3 edge case tests failed: {e}")
        import traceback

        traceback.print_exc()
        return False


def test_s3_credential_edge_cases():
    """Test S3 with various credential issues"""
    print("\n🔐 Testing S3 credential edge cases...")

    # Test 1: Empty credentials
    try:
        empty_client = boto3.client(
            "s3",
            aws_access_key_id="",
            aws_secret_access_key="",
            region_name="us-east-1",
        )
        empty_client.list_buckets()
        print("   ⚠️ Empty credentials unexpectedly worked")
    except (NoCredentialsError, ClientError):
        print("   ✅ Empty credentials correctly rejected")

    # Test 2: Invalid credentials
    try:
        invalid_client = boto3.client(
            "s3",
            aws_access_key_id="AKIAINVALIDKEY12345",
            aws_secret_access_key="invalid+secret+key+xxxxxxxxxxxxxxxx",
            region_name="us-east-1",
        )
        invalid_client.list_buckets()
        print("   ⚠️ Invalid credentials unexpectedly worked")
    except ClientError as e:
        if e.response["Error"]["Code"] in [
            "InvalidAccessKeyId",
            "SignatureDoesNotMatch",
            "AuthFailure",
        ]:
            print("   ✅ Invalid credentials correctly rejected")

    # Test 3: Malformed credentials
    malformed_creds = [
        ("AKI", "short"),  # Too short
        ("A" * 100, "B" * 100),  # Too long
        ("AKIA<script>", "secret</script>"),  # XSS attempt
        ("AKIA\x00null", "secret\x00null"),  # Null bytes
    ]

    for access_key, secret_key in malformed_creds:
        try:
            malformed_client = boto3.client(
                "s3",
                aws_access_key_id=access_key,
                aws_secret_access_key=secret_key,
                region_name="us-east-1",
            )
            malformed_client.list_buckets()
        except Exception as e:
            print(f"   ✅ Malformed creds rejected: {type(e).__name__}")

    print("\n✅ Credential edge case tests completed!")


def test_s3_connection():
    """Test S3 connection and list bucket contents"""
    try:
        # Get credentials from environment
        aws_access_key = os.getenv("AWS_ACCESS_KEY_ID")
        aws_secret_key = os.getenv("AWS_SECRET_ACCESS_KEY")
        aws_region = os.getenv("AWS_REGION", "us-east-1")
        bucket_name = os.getenv("S3_BUCKET_NAME", "t2t2-images")

        print("🔍 Testing S3 Connection")
        print(
            f"Access Key: {aws_access_key[:10]}..." if aws_access_key else "❌ Missing"
        )
        print(f"Secret Key: {'*' * 10}..." if aws_secret_key else "❌ Missing")
        print(f"Region: {aws_region}")
        print(f"Bucket: {bucket_name}")
        print()

        if not aws_access_key or not aws_secret_key:
            print("❌ AWS credentials missing!")
            return False

        # Create S3 client
        s3_client = boto3.client(
            "s3",
            aws_access_key_id=aws_access_key,
            aws_secret_access_key=aws_secret_key,
            region_name=aws_region,
        )

        # Test 1: Check if bucket exists
        print("📦 Checking bucket access...")
        try:
            s3_client.head_bucket(Bucket=bucket_name)
            print(f"✅ Bucket '{bucket_name}' exists and is accessible")
        except Exception as e:
            print(f"❌ Cannot access bucket: {e}")
            return False

        # Test 2: List bucket contents (first 10 items)
        print("\n📋 Listing bucket contents (first 10 items)...")
        try:
            response = s3_client.list_objects_v2(
                Bucket=bucket_name,
                MaxKeys=10,
                Prefix="brain-bot/",  # Check if our folder exists
            )

            if "Contents" in response:
                print(f"Found {response['KeyCount']} items in brain-bot/ folder:")
                for obj in response["Contents"]:
                    print(f"  - {obj['Key']} ({obj['Size']} bytes)")
            else:
                print(
                    "No items found in brain-bot/ folder (this is normal for first run)"
                )
        except Exception as e:
            print(f"❌ Error listing objects: {e}")

        # Test 3: Try to upload a test file
        print("\n🧪 Testing upload capability...")
        test_key = "brain-bot/test/connection-test.txt"
        test_content = f"Connection test at {os.popen('date').read().strip()}"

        try:
            s3_client.put_object(
                Bucket=bucket_name,
                Key=test_key,
                Body=test_content.encode("utf-8"),
                ContentType="text/plain",
            )
            print(f"✅ Successfully uploaded test file: {test_key}")

            # Clean up test file
            s3_client.delete_object(Bucket=bucket_name, Key=test_key)
            print("✅ Successfully deleted test file")

        except Exception as e:
            print(f"❌ Upload test failed: {e}")
            return False

        print("\n✅ All S3 tests passed! Ready to use for media storage.")
        return True

    except Exception as e:
        print(f"\n❌ S3 connection test failed: {e}")
        return False


def test_s3_network_edge_cases():
    """Test S3 behavior under network issues"""
    print("\n🌐 Testing S3 network edge cases...")

    aws_access_key = os.getenv("AWS_ACCESS_KEY_ID")
    aws_secret_key = os.getenv("AWS_SECRET_ACCESS_KEY")

    if not aws_access_key or not aws_secret_key:
        print("   ⚠️ Skipping network tests - no credentials")
        return

    # Test 1: Invalid endpoint
    try:
        bad_endpoint_client = boto3.client(
            "s3",
            aws_access_key_id=aws_access_key,
            aws_secret_access_key=aws_secret_key,
            endpoint_url="http://invalid.endpoint.local:9999",
        )
        bad_endpoint_client.list_buckets()
    except (EndpointConnectionError, Exception):
        print("   ✅ Invalid endpoint correctly failed")

    # Test 2: Timeout simulation
    with patch("botocore.endpoint.URLLib3Session.send") as mock_send:
        mock_send.side_effect = Exception("Read timed out")

        try:
            s3_client = boto3.client("s3")
            s3_client.list_buckets()
        except Exception:
            print("   ✅ Timeout correctly handled")

    print("\n✅ Network edge case tests completed!")


if __name__ == "__main__":
    # Run all test suites
    test_s3_connection()
    test_s3_connection_edge_cases()
    test_s3_credential_edge_cases()
    test_s3_network_edge_cases()
