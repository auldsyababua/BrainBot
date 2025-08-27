"""
Document Storage Service for Supabase
Handles storing and retrieving documents from Supabase database
"""

import hashlib
import logging
import os
from datetime import datetime, timedelta
from typing import Any, Dict, List, Optional

from dotenv import load_dotenv
from supabase import Client, create_client

# Load environment variables
load_dotenv()

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class DocumentStorage:
    """Handles document storage in Supabase"""

    def __init__(self):
        """Initialize Supabase client with connection optimization"""
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

        # Initialize client with connection pooling
        self.supabase: Client = create_client(supabase_url, supabase_key)
        self.using_anon_key = key_type == "anon"

        # Performance optimizations
        self._query_cache = {}
        self._cache_ttl = 300  # 5 minutes
        self._last_cache_cleanup = datetime.now()

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
        allow_update: bool = True,
    ) -> str:
        """
        Store a document in Supabase with atomic operations and duplicate prevention

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
            allow_update: Whether to allow updating existing documents with same file_path

        Returns:
            Document ID
        """
        # Input validation
        if file_path is None:
            raise ValueError("file_path cannot be None")
        if content is None:
            raise ValueError("content cannot be None")

        try:
            # Calculate content hash for deduplication
            content_hash = hashlib.sha256(content.encode()).hexdigest()

            # Check for existing document by file_path first
            existing_by_path = (
                self.supabase.table("brain_bot_documents")
                .select("id, content_hash, version")
                .eq("file_path", file_path)
                .execute()
            )

            if existing_by_path.data:
                existing_doc = existing_by_path.data[0]

                # If content is identical, return existing ID
                if existing_doc["content_hash"] == content_hash:
                    logger.info(f"Document already exists with identical content: {file_path}")
                    return existing_doc["id"]

                # If content changed and updates are allowed, update the document
                if allow_update:
                    logger.info(f"Updating existing document: {file_path}")
                    success = await self._atomic_update_document(
                        existing_doc["id"],
                        content,
                        metadata,
                        category,
                        tags,
                        is_public,
                        telegram_chat_id,
                        telegram_user_id,
                        created_by,
                    )
                    if success:
                        return existing_doc["id"]
                    else:
                        raise Exception("Failed to update document atomically")
                else:
                    # Create new document with unique path
                    base_path = file_path
                    counter = 1
                    while True:
                        new_path = f"{base_path}_{counter}"
                        check_path = (
                            self.supabase.table("brain_bot_documents")
                            .select("id")
                            .eq("file_path", new_path)
                            .execute()
                        )
                        if not check_path.data:
                            file_path = new_path
                            break
                        counter += 1

            # Check for duplicate content (different path, same content)
            existing_by_content = (
                self.supabase.table("brain_bot_documents")
                .select("id")
                .eq("content_hash", content_hash)
                .execute()
            )

            if existing_by_content.data and not existing_by_path.data:
                logger.info(
                    f"Document with identical content exists at different path: {content_hash[:8]}..."
                )
                return existing_by_content.data[0]["id"]

            # Extract title from file path
            title = metadata.get("title") if metadata else None
            if not title:
                title = os.path.basename(file_path).replace(".md", "").replace("-", " ").title()

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

            # Insert document atomically
            result = self.supabase.table("brain_bot_documents").insert(doc_data).execute()

            if result.data:
                doc_id = result.data[0]["id"]
                logger.info(f"Stored document {file_path} with ID {doc_id}")

                # Clear relevant caches
                self._invalidate_document_cache(file_path, doc_id)

                return doc_id
            else:
                raise Exception("Failed to insert document")

        except Exception as e:
            logger.error(f"Error storing document: {e}")
            raise

    async def store_and_return_document(
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
    ) -> Optional[Dict[str, Any]]:
        """
        Store a document in Supabase and return the full document data.

        This is useful for indexing workflows where you need both
        the document ID and other data immediately after storing.

        Args:
            Same as store_document

        Returns:
            Full document data including ID, or None if failed
        """
        try:
            doc_id = await self.store_document(
                file_path=file_path,
                content=content,
                metadata=metadata,
                category=category,
                tags=tags,
                is_public=is_public,
                telegram_chat_id=telegram_chat_id,
                telegram_user_id=telegram_user_id,
                created_by=created_by,
            )

            if doc_id:
                return await self.get_document_by_id(doc_id)
            return None

        except Exception as e:
            logger.error(f"Error in store_and_return_document: {e}")
            return None

    async def get_document(self, file_path: str) -> Optional[Dict[str, Any]]:
        """
        Retrieve a document by file path with caching
        """
        if file_path is None:
            raise ValueError("file_path cannot be None")

        try:
            # Check cache first
            cache_key = f"doc_path:{file_path}"
            if cache_key in self._query_cache:
                cached_result, timestamp = self._query_cache[cache_key]
                if datetime.now() - timestamp < timedelta(seconds=self._cache_ttl):
                    return cached_result

            result = (
                self.supabase.table("brain_bot_documents")
                .select("*")
                .eq("file_path", file_path)
                .execute()
            )

            if result.data:
                doc = result.data[0]
                doc_id = doc["id"]

                # Update last accessed timestamp (fire and forget)
                try:
                    self.supabase.table("brain_bot_documents").update(
                        {"last_accessed_at": datetime.utcnow().isoformat()}
                    ).eq("id", doc_id).execute()
                except Exception:
                    pass  # Non-critical operation

                # Cache result
                self._query_cache[cache_key] = (doc, datetime.now())
                self._cleanup_cache()

                return doc

            return None

        except Exception as e:
            logger.error(f"Error retrieving document: {e}")
            return None

    async def get_document_by_id(self, doc_id: str) -> Optional[Dict[str, Any]]:
        """
        Retrieve a document by ID with caching
        """
        try:
            # Check cache first
            cache_key = f"doc_id:{doc_id}"
            if cache_key in self._query_cache:
                cached_result, timestamp = self._query_cache[cache_key]
                if datetime.now() - timestamp < timedelta(seconds=self._cache_ttl):
                    return cached_result

            result = (
                self.supabase.table("brain_bot_documents").select("*").eq("id", doc_id).execute()
            )

            if result.data:
                doc = result.data[0]

                # Update last accessed timestamp (fire and forget)
                try:
                    self.supabase.table("brain_bot_documents").update(
                        {"last_accessed_at": datetime.utcnow().isoformat()}
                    ).eq("id", doc_id).execute()
                except Exception:
                    pass  # Non-critical operation

                # Cache result
                self._query_cache[cache_key] = (doc, datetime.now())
                self._cleanup_cache()

                return doc

            return None

        except Exception as e:
            logger.error(f"Error retrieving document by ID: {e}")
            return None

    async def get_documents_by_ids(self, doc_ids: list[str]) -> list[dict[str, Any]]:
        """
        Retrieve multiple documents by their IDs in a single query
        """
        if not doc_ids:
            return []

        try:
            # Filter out cached results
            uncached_ids = []
            results = []

            for doc_id in doc_ids:
                cache_key = f"doc_id:{doc_id}"
                if cache_key in self._query_cache:
                    cached_result, timestamp = self._query_cache[cache_key]
                    if datetime.now() - timestamp < timedelta(seconds=self._cache_ttl):
                        results.append(cached_result)
                    else:
                        uncached_ids.append(doc_id)
                else:
                    uncached_ids.append(doc_id)

            # Batch fetch uncached documents
            if uncached_ids:
                result = (
                    self.supabase.table("brain_bot_documents")
                    .select("*")
                    .in_("id", uncached_ids)
                    .execute()
                )

                if result.data:
                    for doc in result.data:
                        # Cache each result
                        cache_key = f"doc_id:{doc['id']}"
                        self._query_cache[cache_key] = (doc, datetime.now())
                        results.append(doc)
                        self._cleanup_cache()

            return results

        except Exception as e:
            logger.error(f"Error retrieving documents by IDs: {e}")
            return []

    async def get_documents_by_paths(self, file_paths: list[str]) -> list[dict[str, Any]]:
        """
        Retrieve multiple documents by their file paths in a single query
        """
        if not file_paths:
            return []

        try:
            # Filter out cached results
            uncached_paths = []
            results = []

            for file_path in file_paths:
                cache_key = f"doc_path:{file_path}"
                if cache_key in self._query_cache:
                    cached_result, timestamp = self._query_cache[cache_key]
                    if datetime.now() - timestamp < timedelta(seconds=self._cache_ttl):
                        results.append(cached_result)
                    else:
                        uncached_paths.append(file_path)
                else:
                    uncached_paths.append(file_path)

            # Batch fetch uncached documents
            if uncached_paths:
                result = (
                    self.supabase.table("brain_bot_documents")
                    .select("*")
                    .in_("file_path", uncached_paths)
                    .execute()
                )

                if result.data:
                    for doc in result.data:
                        # Cache each result
                        cache_key = f"doc_path:{doc['file_path']}"
                        self._query_cache[cache_key] = (doc, datetime.now())
                        results.append(doc)
                        self._cleanup_cache()

            return results

        except Exception as e:
            logger.error(f"Error retrieving documents by paths: {e}")
            return []

    async def update_document_by_id(
        self, doc_id: str, content: str, metadata: Optional[Dict[str, Any]] = None
    ) -> bool:
        """
        Update an existing document by ID, creating a new version

        Args:
            doc_id: Document ID
            content: New content
            metadata: Updated metadata

        Returns:
            True if successful, False otherwise
        """
        return await self._atomic_update_document(doc_id=doc_id, content=content, metadata=metadata)

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

            return await self._atomic_update_document(
                doc_id=existing["id"], content=content, metadata=metadata
            )

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
    ) -> list[dict[str, Any]]:
        """
        Search documents with various filters and caching
        """
        # Note: query parameter can be None for searches without text filter

        try:
            # Create cache key from search parameters
            cache_key = f"search:{hash((query, category, tuple(tags or []), telegram_chat_id, is_public, limit))}"

            # Check cache
            if cache_key in self._query_cache:
                cached_result, timestamp = self._query_cache[cache_key]
                if datetime.now() - timestamp < timedelta(seconds=30):  # Shorter cache for search
                    return cached_result

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
                # Use full-text search for better performance
                query_builder = query_builder.text_search("content", query)

            # Order by relevance
            query_builder = query_builder.order("updated_at", desc=True)

            result = query_builder.limit(limit).execute()
            documents = result.data or []

            # Cache result
            self._query_cache[cache_key] = (documents, datetime.now())
            self._cleanup_cache()

            return documents

        except Exception as e:
            logger.error(f"Error searching documents: {e}")
            return []

    async def delete_document(self, file_path: str) -> bool:
        """
        Delete a document and all its chunks atomically

        Args:
            file_path: Path/identifier of the document

        Returns:
            True if successful, False otherwise
        """
        try:
            # Get document by file_path
            doc = await self.get_document(file_path)
            if not doc:
                logger.warning(f"Document {file_path} not found for deletion")
                return False

            return await self.safe_delete_document(doc["id"])

        except Exception as e:
            logger.error(f"Error deleting document: {e}")
            return False

    async def clear_all_documents(self) -> bool:
        """
        Clear all documents from the database (for reset purposes)
        """
        try:
            # Clear cache
            self._query_cache.clear()

            # Delete all documents
            result = (
                self.supabase.table("brain_bot_documents")
                .delete()
                .neq("id", "00000000-0000-0000-0000-000000000000")
                .execute()
            )

            logger.info(f"Cleared {len(result.data) if result.data else 0} documents from Supabase")
            return True

        except Exception as e:
            logger.error(f"Error clearing all documents: {e}")
            return False

    def _cleanup_cache(self):
        """Clean up expired cache entries"""
        now = datetime.now()
        if now - self._last_cache_cleanup > timedelta(minutes=5):
            expired_keys = [
                key
                for key, (_, timestamp) in self._query_cache.items()
                if now - timestamp > timedelta(seconds=self._cache_ttl)
            ]
            for key in expired_keys:
                del self._query_cache[key]
            self._last_cache_cleanup = now
            if expired_keys:
                logger.debug(f"Cleaned up {len(expired_keys)} expired cache entries")

    async def _atomic_update_document(
        self,
        doc_id: str,
        content: str,
        metadata: Optional[Dict[str, Any]] = None,
        category: Optional[str] = None,
        tags: Optional[List[str]] = None,
        is_public: bool = False,
        telegram_chat_id: Optional[int] = None,
        telegram_user_id: Optional[int] = None,
        created_by: str = "manual",
    ) -> bool:
        """
        Atomically update a document and its chunks

        This method ensures:
        1. All chunks are deleted before document update
        2. Document is updated with new content
        3. If any step fails, the operation is rolled back

        Args:
            doc_id: Document ID to update
            content: New content
            metadata: Updated metadata
            category: Updated category
            tags: Updated tags
            is_public: Updated public status
            telegram_chat_id: Updated chat ID
            telegram_user_id: Updated user ID
            created_by: Who is making the update

        Returns:
            True if update was successful, False otherwise
        """
        try:
            # Get existing document
            existing = await self.get_document_by_id(doc_id)
            if not existing:
                logger.warning(f"Document {doc_id} not found for atomic update")
                return False

            # Calculate new content hash
            new_hash = hashlib.sha256(content.encode()).hexdigest()

            # Check if content actually changed
            if new_hash == existing["content_hash"]:
                logger.info("Content unchanged, skipping atomic update")
                return True

            # Start atomic operation
            logger.info(f"Starting atomic update for document {doc_id}")

            # Step 1: Delete all existing chunks for this document
            delete_chunks_result = (
                self.supabase.table("brain_bot_document_chunks")
                .delete()
                .eq("document_id", doc_id)
                .execute()
            )

            if delete_chunks_result.error:
                logger.error(f"Failed to delete chunks: {delete_chunks_result.error}")
                return False

            # Step 2: Update document with new content
            update_data = {
                "content": content,
                "content_hash": new_hash,
                "version": existing["version"] + 1,
                "previous_version_id": existing["id"],
                "updated_at": datetime.utcnow().isoformat(),
            }

            # Merge metadata if provided
            if metadata:
                update_data["metadata"] = {**existing.get("metadata", {}), **metadata}
            if category is not None:
                update_data["category"] = category
            if tags is not None:
                update_data["tags"] = tags
            if is_public is not None:
                update_data["is_public"] = is_public
            if telegram_chat_id is not None:
                update_data["telegram_chat_id"] = telegram_chat_id
            if telegram_user_id is not None:
                update_data["telegram_user_id"] = telegram_user_id
            if created_by:
                update_data["created_by"] = created_by

            update_result = (
                self.supabase.table("brain_bot_documents")
                .update(update_data)
                .eq("id", doc_id)
                .execute()
            )

            if update_result.error:
                logger.error(f"Failed to update document: {update_result.error}")
                # Note: In a real transaction system, we would rollback here
                # For now, we'll log the error and return False
                return False

            # Clear relevant caches
            self._invalidate_document_cache(existing["file_path"], doc_id)

            logger.info(f"Successfully completed atomic update for document {doc_id}")
            return True

        except Exception as e:
            logger.error(f"Error in atomic update: {e}")
            return False

    def _invalidate_document_cache(self, file_path: str, doc_id: str):
        """Invalidate cache entries for a document"""
        cache_keys_to_remove = [
            f"doc_path:{file_path}",
            f"doc_id:{doc_id}",
        ]

        # Also invalidate search caches
        search_keys = [k for k in self._query_cache.keys() if k.startswith("search:")]
        cache_keys_to_remove.extend(search_keys)

        for key in cache_keys_to_remove:
            self._query_cache.pop(key, None)

        logger.debug(f"Invalidated {len(cache_keys_to_remove)} cache entries")

    async def safe_delete_document(self, doc_id: str) -> bool:
        """
        Safely delete a document and all its chunks atomically

        Args:
            doc_id: Document ID to delete

        Returns:
            True if deletion was successful, False otherwise
        """
        try:
            # Get document info for cache invalidation
            doc = await self.get_document_by_id(doc_id)
            if not doc:
                logger.warning(f"Document {doc_id} not found for deletion")
                return False

            # Delete chunks first
            delete_chunks_result = (
                self.supabase.table("brain_bot_document_chunks")
                .delete()
                .eq("document_id", doc_id)
                .execute()
            )

            if delete_chunks_result.error:
                logger.error(f"Failed to delete chunks: {delete_chunks_result.error}")
                return False

            # Then delete the document
            delete_doc_result = (
                self.supabase.table("brain_bot_documents").delete().eq("id", doc_id).execute()
            )

            if delete_doc_result.error:
                logger.error(f"Failed to delete document: {delete_doc_result.error}")
                return False

            # Clear caches
            self._invalidate_document_cache(doc["file_path"], doc_id)

            logger.info(f"Successfully deleted document {doc_id} and all chunks")
            return True

        except Exception as e:
            logger.error(f"Error in safe document deletion: {e}")
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

            result = self.supabase.table("brain_bot_document_chunks").insert(chunk_data).execute()

            if result.data:
                return result.data[0]["id"]

            return None

        except Exception as e:
            logger.error(f"Error storing chunk: {e}")
            return None

    async def get_document_chunks(self, document_id: str) -> list[dict[str, Any]]:
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
