"""
Media Storage Service for AWS S3
Handles storing and retrieving media files from S3
"""

import hashlib
import io
import logging
import mimetypes
import os
from datetime import datetime
from typing import BinaryIO, Dict, Optional, Union

import boto3
from dotenv import load_dotenv

from src.storage.storage_service import document_storage

# Load environment variables
load_dotenv()

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class MediaStorage:
    """Handles media file storage in AWS S3"""

    def __init__(self):
        """Initialize S3 client"""
        aws_access_key = os.getenv("AWS_ACCESS_KEY_ID")
        aws_secret_key = os.getenv("AWS_SECRET_ACCESS_KEY")
        aws_region = os.getenv("AWS_REGION", "us-east-1")
        bucket_name = os.getenv("S3_BUCKET_NAME", "t2t2-images")

        if not aws_access_key or not aws_secret_key:
            raise ValueError(
                "Missing AWS credentials. Please set AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY"
            )

        self.s3_client = boto3.client(
            "s3",
            aws_access_key_id=aws_access_key,
            aws_secret_access_key=aws_secret_key,
            region_name=aws_region,
        )
        self.bucket_name = bucket_name

        # Organized folder structure
        self.folders = {
            "image": "brain-bot/images/",
            "video": "brain-bot/videos/",
            "audio": "brain-bot/audio/",
            "document": "brain-bot/documents/",
            "other": "brain-bot/other/",
            "temp": "brain-bot/temp/",
        }

        logger.info(f"MediaStorage initialized with bucket: {self.bucket_name}")

    def _get_folder_for_type(self, file_type: str) -> str:
        """Determine S3 folder based on file type"""
        if not file_type:
            return self.folders["other"]

        file_type_lower = file_type.lower()

        if file_type_lower.startswith("image/"):
            return self.folders["image"]
        elif file_type_lower.startswith("video/"):
            return self.folders["video"]
        elif file_type_lower.startswith("audio/"):
            return self.folders["audio"]
        elif file_type_lower in ["application/pdf", "application/msword", "text/plain"]:
            return self.folders["document"]
        else:
            return self.folders["other"]

    async def upload_media(
        self,
        file_content: Union[BinaryIO, bytes],
        file_name: str,
        file_type: Optional[str] = None,
        metadata: Optional[Dict] = None,
        telegram_chat_id: Optional[int] = None,
        telegram_user_id: Optional[int] = None,
        description: Optional[str] = None,
        tags: Optional[list] = None,
    ) -> Dict:
        """
        Upload media file to S3

        Args:
            file_content: File content as binary stream or bytes
            file_name: Original file name
            file_type: MIME type (will be guessed if not provided)
            metadata: Additional metadata
            telegram_chat_id: Telegram chat ID if uploaded by bot
            telegram_user_id: Telegram user ID if uploaded by bot
            description: Human-readable description
            tags: List of tags

        Returns:
            Dict with upload details
        """
        if file_content is None:
            raise ValueError("file_content cannot be None")
        if file_name is None:
            raise ValueError("file_name cannot be None")

        try:
            # Handle bytes vs file-like object
            if isinstance(file_content, bytes):
                file_stream = io.BytesIO(file_content)
            else:
                file_stream = file_content

            # Determine file type if not provided
            if not file_type:
                file_type, _ = mimetypes.guess_type(file_name)
                if not file_type:
                    file_type = "application/octet-stream"

            # Read content and calculate hash
            file_stream.seek(0)
            content_bytes = file_stream.read()
            file_hash = hashlib.sha256(content_bytes).hexdigest()
            file_size = len(content_bytes)
            file_stream.seek(0)  # Reset for upload

            # Determine folder and create S3 key
            folder = self._get_folder_for_type(file_type)
            file_extension = os.path.splitext(file_name)[1] or ""
            s3_key = f"{folder}{file_hash}{file_extension}"

            # Check if file already exists
            try:
                self.s3_client.head_object(Bucket=self.bucket_name, Key=s3_key)
                logger.info(f"File already exists with hash {file_hash[:8]}...")

                # Get existing URL
                s3_url = f"https://{self.bucket_name}.s3.amazonaws.com/{s3_key}"

                return {
                    "s3_key": s3_key,
                    "s3_url": s3_url,
                    "s3_bucket": self.bucket_name,
                    "file_hash": file_hash,
                    "file_type": file_type,
                    "file_size": file_size,
                    "already_exists": True,
                }
            except self.s3_client.exceptions.ClientError as e:
                if e.response["Error"]["Code"] != "404":
                    raise

            # Prepare S3 metadata
            s3_metadata = {
                "file_name": file_name,
                "file_hash": file_hash,
                "uploaded_at": datetime.utcnow().isoformat(),
                "uploaded_by": "brain_bot",
            }

            if telegram_chat_id:
                s3_metadata["telegram_chat_id"] = str(telegram_chat_id)
            if telegram_user_id:
                s3_metadata["telegram_user_id"] = str(telegram_user_id)

            # Upload to S3
            extra_args = {"ContentType": file_type, "Metadata": s3_metadata}

            self.s3_client.upload_fileobj(
                file_stream, self.bucket_name, s3_key, ExtraArgs=extra_args
            )

            s3_url = f"https://{self.bucket_name}.s3.amazonaws.com/{s3_key}"
            logger.info(f"Uploaded {file_name} to S3: {s3_key}")

            # Store metadata in Supabase if available
            if document_storage:
                try:
                    media_metadata = {
                        "s3_key": s3_key,
                        "s3_bucket": self.bucket_name,
                        "s3_url": s3_url,
                        "file_name": file_name,
                        "file_type": file_type,
                        "mime_type": file_type,
                        "file_size": file_size,
                        "file_hash": file_hash,
                        "metadata": metadata or {},
                        "description": description,
                        "tags": tags or [],
                        "telegram_chat_id": telegram_chat_id,
                        "telegram_user_id": telegram_user_id,
                        "uploaded_by": "brain_bot",
                    }

                    # Store in brain_bot_media_files table
                    result = (
                        document_storage.supabase.table("brain_bot_media_files")
                        .insert(media_metadata)
                        .execute()
                    )

                    if result.data:
                        logger.info("Stored media metadata in Supabase")
                except Exception as e:
                    logger.warning(f"Failed to store media metadata in Supabase: {e}")

            return {
                "s3_key": s3_key,
                "s3_url": s3_url,
                "s3_bucket": self.bucket_name,
                "file_hash": file_hash,
                "file_type": file_type,
                "file_size": file_size,
                "file_name": file_name,
                "already_exists": False,
            }

        except Exception as e:
            logger.error(f"Error uploading media: {e}")
            raise

    async def download_media(self, s3_key: str) -> Optional[bytes]:
        """
        Download media file from S3

        Args:
            s3_key: S3 object key

        Returns:
            File content as bytes or None if not found
        """
        if s3_key is None:
            raise ValueError("s3_key cannot be None")

        try:
            response = self.s3_client.get_object(Bucket=self.bucket_name, Key=s3_key)

            content = response["Body"].read()

            # Update access timestamp in Supabase if available
            if document_storage:
                try:
                    document_storage.supabase.table("brain_bot_media_files").update(
                        {"last_accessed_at": datetime.utcnow().isoformat()}
                    ).eq("s3_key", s3_key).execute()
                except Exception:
                    pass

            return content

        except self.s3_client.exceptions.NoSuchKey:
            logger.warning(f"S3 object not found: {s3_key}")
            return None
        except Exception as e:
            logger.error(f"Error downloading media: {e}")
            return None

    async def get_media_url(self, s3_key: str, expires_in: int = 3600) -> Optional[str]:
        """
        Generate a presigned URL for media access

        Args:
            s3_key: S3 object key
            expires_in: URL expiration time in seconds (default 1 hour)

        Returns:
            Presigned URL or None if object doesn't exist
        """
        try:
            # Check if object exists
            self.s3_client.head_object(Bucket=self.bucket_name, Key=s3_key)

            # Generate presigned URL
            url = self.s3_client.generate_presigned_url(
                "get_object",
                Params={"Bucket": self.bucket_name, "Key": s3_key},
                ExpiresIn=expires_in,
            )

            return url

        except self.s3_client.exceptions.NoSuchKey:
            logger.warning(f"S3 object not found: {s3_key}")
            return None
        except Exception as e:
            logger.error(f"Error generating presigned URL: {e}")
            return None

    async def delete_media(self, s3_key: str) -> bool:
        """
        Delete media file from S3

        Args:
            s3_key: S3 object key

        Returns:
            True if deleted, False otherwise
        """
        try:
            self.s3_client.delete_object(Bucket=self.bucket_name, Key=s3_key)

            # Delete from Supabase if available
            if document_storage:
                try:
                    document_storage.supabase.table(
                        "brain_bot_media_files"
                    ).delete().eq("s3_key", s3_key).execute()
                except Exception:
                    pass

            logger.info(f"Deleted media: {s3_key}")
            return True

        except Exception as e:
            logger.error(f"Error deleting media: {e}")
            return False

    async def list_media(
        self,
        prefix: Optional[str] = None,
        media_type: Optional[str] = None,
        limit: int = 100,
    ) -> list:
        """
        List media files in S3

        Args:
            prefix: S3 prefix to filter by
            media_type: Type of media (image, video, audio, document)
            limit: Maximum number of results

        Returns:
            List of media objects
        """
        try:
            # Determine prefix
            if media_type and media_type in self.folders:
                prefix = self.folders[media_type]
            elif not prefix:
                prefix = "brain-bot/"

            # List objects
            paginator = self.s3_client.get_paginator("list_objects_v2")
            pages = paginator.paginate(
                Bucket=self.bucket_name,
                Prefix=prefix,
                PaginationConfig={"MaxItems": limit},
            )

            media_list = []
            for page in pages:
                if "Contents" in page:
                    for obj in page["Contents"]:
                        media_list.append(
                            {
                                "s3_key": obj["Key"],
                                "size": obj["Size"],
                                "last_modified": obj["LastModified"].isoformat(),
                                "etag": obj["ETag"].strip('"'),
                            }
                        )

            return media_list

        except Exception as e:
            logger.error(f"Error listing media: {e}")
            return []


# Create a singleton instance
media_storage = MediaStorage() if os.getenv("AWS_ACCESS_KEY_ID") else None
