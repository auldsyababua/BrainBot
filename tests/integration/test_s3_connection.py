#!/usr/bin/env python3
"""Test S3 connection and credentials"""
import boto3
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()


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


if __name__ == "__main__":
    test_s3_connection()
