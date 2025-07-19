"""
Document Storage Service for Supabase
Handles storing and retrieving documents from Supabase database
"""

import hashlib
from typing import Optional, List, Dict, Any
from supabase import create_client, Client
import os
from datetime import datetime
import logging
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class DocumentStorage:
    """Handles document storage in Supabase"""

    def __init__(self):
        """Initialize Supabase client"""
        supabase_url = os.getenv("SUPABASE_URL")
        # Try service key first, fall back to anon key
        supabase_key = os.getenv("SUPABASE_SERVICE_KEY")
        key_type = "service"

        if not supabase_key:
            supabase_key = os.getenv("SUPABASE_ANON_KEY")
            key_type = "anon"

        if not supabase_url or not supabase_key:
            raise ValueError(
                "Missing Supabase credentials. Please set SUPABASE_URL and SUPABASE_ANON_KEY"
            )

        self.supabase: Client = create_client(supabase_url, supabase_key)
        self.using_anon_key = key_type == "anon"
        logger.info(f"DocumentStorage initialized with Supabase ({key_type} key)")

    async def store_document(
        self,
        file_path: str,
        content: str,
        metadata: Optional[Dict[str, Any]] = None,
        category: Optional[str] = None,
        tags: Optional[List[str]] = None,
        is_public: bool = False,
        telegram_chat_id: Optional[int] = None,
        telegram_user_id: Optional[int] = None,
        created_by: str = "manual",
    ) -> str:
        """
        Store a document in Supabase

        Args:
            file_path: Path/identifier for the document
            content: Document content
            metadata: Additional metadata
            category: Document category
            tags: List of tags
            is_public: Whether document is publicly accessible
            telegram_chat_id: Telegram chat ID if created by bot
            telegram_user_id: Telegram user ID if created by bot
            created_by: Who created the document (manual, bot, api)

        Returns:
            Document ID
        """
        try:
            # Calculate content hash for deduplication
            content_hash = hashlib.sha256(content.encode()).hexdigest()

            # Check if document already exists
            existing = (
                self.supabase.table("brain_bot_documents")
                .select("id, version")
                .eq("content_hash", content_hash)
                .execute()
            )

            if existing.data:
                logger.info(f"Document already exists with hash {content_hash[:8]}...")
                return existing.data[0]["id"]

            # Extract title from file path
            title = metadata.get("title") if metadata else None
            if not title:
                title = (
                    os.path.basename(file_path)
                    .replace(".md", "")
                    .replace("-", " ")
                    .title()
                )

            # Prepare document data
            doc_data = {
                "file_path": file_path,
                "title": title,
                "content": content,
                "content_hash": content_hash,
                "metadata": metadata or {},
                "category": category,
                "tags": tags or [],
                "is_public": is_public,
                "created_by": created_by,
                "telegram_chat_id": telegram_chat_id,
                "telegram_user_id": telegram_user_id,
            }

            # Insert document
            result = (
                self.supabase.table("brain_bot_documents").insert(doc_data).execute()
            )

            if result.data:
                doc_id = result.data[0]["id"]
                logger.info(f"Stored document {file_path} with ID {doc_id}")
                return doc_id
            else:
                raise Exception("Failed to insert document")

        except Exception as e:
            logger.error(f"Error storing document: {e}")
            raise

    async def get_document(self, file_path: str) -> Optional[Dict[str, Any]]:
        """
        Retrieve a document by file path

        Args:
            file_path: Path/identifier of the document

        Returns:
            Document data or None if not found
        """
        try:
            result = (
                self.supabase.table("brain_bot_documents")
                .select("*")
                .eq("file_path", file_path)
                .execute()
            )

            if result.data:
                # Update last accessed timestamp
                doc_id = result.data[0]["id"]
                self.supabase.table("brain_bot_documents").update(
                    {"last_accessed_at": datetime.utcnow().isoformat()}
                ).eq("id", doc_id).execute()

                return result.data[0]

            return None

        except Exception as e:
            logger.error(f"Error retrieving document: {e}")
            return None

    async def get_document_by_id(self, doc_id: str) -> Optional[Dict[str, Any]]:
        """
        Retrieve a document by ID

        Args:
            doc_id: Document ID

        Returns:
            Document data or None if not found
        """
        try:
            result = (
                self.supabase.table("brain_bot_documents")
                .select("*")
                .eq("id", doc_id)
                .execute()
            )

            if result.data:
                # Update last accessed timestamp
                self.supabase.table("brain_bot_documents").update(
                    {"last_accessed_at": datetime.utcnow().isoformat()}
                ).eq("id", doc_id).execute()

                return result.data[0]

            return None

        except Exception as e:
            logger.error(f"Error retrieving document by ID: {e}")
            return None

    async def update_document(
        self, file_path: str, content: str, metadata: Optional[Dict[str, Any]] = None
    ) -> bool:
        """
        Update an existing document, creating a new version

        Args:
            file_path: Path/identifier of the document
            content: New content
            metadata: Updated metadata

        Returns:
            True if successful, False otherwise
        """
        try:
            # Get existing document
            existing = await self.get_document(file_path)
            if not existing:
                logger.warning(f"Document {file_path} not found for update")
                return False

            # Calculate new content hash
            new_hash = hashlib.sha256(content.encode()).hexdigest()

            # Check if content actually changed
            if new_hash == existing["content_hash"]:
                logger.info("Content unchanged, skipping update")
                return True

            # Update document with new version
            update_data = {
                "content": content,
                "content_hash": new_hash,
                "version": existing["version"] + 1,
                "previous_version_id": existing["id"],
                "updated_at": datetime.utcnow().isoformat(),
            }

            if metadata:
                update_data["metadata"] = {**existing.get("metadata", {}), **metadata}

            result = (
                self.supabase.table("brain_bot_documents")
                .update(update_data)
                .eq("id", existing["id"])
                .execute()
            )

            return bool(result.data)

        except Exception as e:
            logger.error(f"Error updating document: {e}")
            return False

    async def search_documents(
        self,
        query: Optional[str] = None,
        category: Optional[str] = None,
        tags: Optional[List[str]] = None,
        telegram_chat_id: Optional[int] = None,
        is_public: Optional[bool] = None,
        limit: int = 10,
    ) -> List[Dict[str, Any]]:
        """
        Search documents with various filters

        Args:
            query: Text to search in content
            category: Filter by category
            tags: Filter by tags
            telegram_chat_id: Filter by Telegram chat
            is_public: Filter by public/private
            limit: Maximum results

        Returns:
            List of matching documents
        """
        try:
            query_builder = self.supabase.table("brain_bot_documents").select("*")

            if category:
                query_builder = query_builder.eq("category", category)

            if telegram_chat_id:
                query_builder = query_builder.eq("telegram_chat_id", telegram_chat_id)

            if is_public is not None:
                query_builder = query_builder.eq("is_public", is_public)

            if tags:
                # PostgreSQL array contains
                for tag in tags:
                    query_builder = query_builder.contains("tags", [tag])

            if query:
                # Full text search in content
                query_builder = query_builder.ilike("content", f"%{query}%")

            # Order by relevance (updated_at for now)
            query_builder = query_builder.order("updated_at", desc=True)

            result = query_builder.limit(limit).execute()

            return result.data or []

        except Exception as e:
            logger.error(f"Error searching documents: {e}")
            return []

    async def delete_document(self, file_path: str) -> bool:
        """
        Delete a document (soft delete by marking as deleted)

        Args:
            file_path: Path/identifier of the document

        Returns:
            True if successful, False otherwise
        """
        try:
            # For now, we'll do a hard delete
            # In production, you might want to implement soft delete
            result = (
                self.supabase.table("brain_bot_documents")
                .delete()
                .eq("file_path", file_path)
                .execute()
            )

            return bool(result.data)

        except Exception as e:
            logger.error(f"Error deleting document: {e}")
            return False

    async def store_document_chunk(
        self,
        document_id: str,
        chunk_index: int,
        chunk_text: str,
        vector_id: str,
        start_char: int,
        end_char: int,
        metadata: Optional[Dict[str, Any]] = None,
    ) -> Optional[str]:
        """
        Store a document chunk reference

        Args:
            document_id: Parent document ID
            chunk_index: Index of this chunk
            chunk_text: Text content of chunk
            vector_id: ID in Upstash Vector
            start_char: Starting character position
            end_char: Ending character position
            metadata: Additional metadata

        Returns:
            Chunk ID or None if failed
        """
        try:
            chunk_hash = hashlib.sha256(chunk_text.encode()).hexdigest()

            chunk_data = {
                "document_id": document_id,
                "chunk_index": chunk_index,
                "chunk_text": chunk_text,
                "chunk_hash": chunk_hash,
                "vector_id": vector_id,
                "start_char": start_char,
                "end_char": end_char,
                "metadata": metadata or {},
            }

            result = (
                self.supabase.table("brain_bot_document_chunks")
                .insert(chunk_data)
                .execute()
            )

            if result.data:
                return result.data[0]["id"]

            return None

        except Exception as e:
            logger.error(f"Error storing chunk: {e}")
            return None

    async def get_document_chunks(self, document_id: str) -> List[Dict[str, Any]]:
        """
        Get all chunks for a document

        Args:
            document_id: Document ID

        Returns:
            List of chunks
        """
        try:
            result = (
                self.supabase.table("brain_bot_document_chunks")
                .select("*")
                .eq("document_id", document_id)
                .order("chunk_index")
                .execute()
            )

            return result.data or []

        except Exception as e:
            logger.error(f"Error retrieving chunks: {e}")
            return []


# Create a singleton instance
document_storage = DocumentStorage() if os.getenv("SUPABASE_URL") else None
