"""
Vector store for semantic search using Upstash Vector.
Handles document embedding, storage, and retrieval for the knowledge base.
"""

import hashlib
import json
import logging
import os
import time
from datetime import datetime
from typing import Dict, List, Optional, Tuple

from dotenv import load_dotenv
from upstash_redis import Redis
from upstash_vector import Index

from core.benchmarks import async_benchmark, get_performance_monitor

logger = logging.getLogger(__name__)

# Load environment variables
load_dotenv()


class VectorStore:
    """Handles semantic search using Upstash Vector with automatic embeddings."""

    def __init__(self):
        """Initialize Vector index from environment variables."""
        self.index = Index.from_env()
        self.top_k = int(os.getenv("VECTOR_TOP_K", "5"))

        # Initialize cache
        self.redis = Redis.from_env()
        self.cache_ttl = int(os.getenv("VECTOR_CACHE_TTL", "300"))  # 5 minutes default
        self.cache_enabled = os.getenv("VECTOR_CACHE_ENABLED", "true").lower() == "true"

        # Initialize performance monitor
        self.monitor = None

    def _get_cache_key(
        self, query: str, top_k: int, filter: Optional[str] = None
    ) -> str:
        """Generate a cache key for a query."""
        # Create a stable hash of the query parameters
        key_parts = [query, str(top_k), filter or ""]
        key_string = "|".join(key_parts)
        key_hash = hashlib.md5(key_string.encode()).hexdigest()
        return f"vector_cache:{key_hash}"

    async def _ensure_monitor(self):
        """Ensure performance monitor is initialized."""
        if self.monitor is None:
            self.monitor = get_performance_monitor()

    async def invalidate_cache(self, pattern: Optional[str] = None):
        """Invalidate cache entries matching a pattern or all cache entries."""
        if not self.cache_enabled:
            return

        try:
            if pattern:
                # Invalidate specific pattern
                keys = self.redis.keys(f"vector_cache:{pattern}*")
            else:
                # Invalidate all vector cache
                keys = self.redis.keys("vector_cache:*")

            if keys:
                for key in keys:
                    self.redis.delete(key)
                # Cache invalidated successfully
        except Exception as e:
            print(f"Error invalidating cache: {e}")

    async def embed_and_store(
        self,
        document_id: str,
        content: str,
        metadata: Optional[Dict] = None,
        namespace: Optional[str] = None,
    ) -> bool:
        """
        Store a document with automatic embedding generation.

        Args:
            document_id: Unique identifier for the document
            content: Text content to embed and store
            metadata: Optional metadata to attach to the document
            namespace: Optional namespace for user isolation (defaults to None)

        Returns:
            True if stored successfully, False otherwise
        """
        try:
            logger.info(
                f"📝 Storing document {document_id} in namespace: {namespace or 'default'}"
            )
            # Prepare metadata
            if metadata is None:
                metadata = {}

            # Add timestamp and content preview
            metadata.update(
                {
                    "indexed_at": datetime.now().isoformat(),
                    "content_preview": (
                        content[:1500] + "..." if len(content) > 1500 else content
                    ),
                    "content_length": len(content),
                }
            )

            # Upsert with automatic embedding (using data field)
            # Using native namespace support from v0.8.1
            self.index.upsert(
                vectors=[(document_id, content, metadata)], namespace=namespace or ""
            )

            # Document stored successfully

            # Invalidate cache after storing new document
            await self.invalidate_cache()

            return True
        except Exception as e:
            logger.error(f"Error storing document {document_id}: {e}")
            # Ensure any open connections are properly closed
            await self.invalidate_cache()
            return False

    @async_benchmark("vector_search")
    async def search(
        self,
        query: str,
        top_k: Optional[int] = None,
        filter: Optional[str] = None,
        include_metadata: bool = True,
        namespace: Optional[str] = None,
    ) -> List[Dict]:
        """
        Search for documents using semantic similarity with caching.

        Args:
            query: Natural language query text
            top_k: Number of results to return (defaults to VECTOR_TOP_K)
            filter: Optional metadata filter
            include_metadata: Whether to include metadata in results
            namespace: Optional namespace for user isolation (defaults to None)

        Returns:
            List of matching documents with scores and metadata
        """
        start_time = time.perf_counter()
        cache_hit = False

        try:
            # Ensure monitor is initialized
            await self._ensure_monitor()

            # Use configured top_k if not specified
            if top_k is None:
                top_k = self.top_k

            # Check cache if enabled
            if self.cache_enabled:
                # Include namespace in cache key for proper isolation
                cache_key = self._get_cache_key(query, top_k, filter)
                if namespace:
                    cache_key = f"{cache_key}:ns:{namespace}"
                cached_result = self.redis.get(cache_key)

                if cached_result:
                    # Cache hit - deserialize and return
                    cache_hit = True
                    formatted_results = json.loads(cached_result)
                    duration = time.perf_counter() - start_time

                    # Track performance
                    self.monitor.track_vector_search(
                        query=query,
                        results_count=len(formatted_results),
                        duration=duration,
                        cache_hit=True,
                    )

                    # Cache hit
                    return formatted_results

            # Cache miss - perform actual search
            # Query using text data (automatic embedding)
            # Using native namespace support from v0.8.1
            logger.info(
                f"🔍 Searching in namespace: {namespace or 'default'} for query: {query[:50]}..."
            )

            results = self.index.query(
                data=query,
                top_k=top_k,
                filter=filter or "",
                include_metadata=include_metadata,
                include_vectors=False,
                namespace=namespace or "",
            )

            # Query executed successfully
            logger.info(
                f"🔍 Found {len(results)} results in namespace: {namespace or 'default'}"
            )

            # Format results
            formatted_results = []
            for i, result in enumerate(results):
                # Process each result
                # Extract content from metadata if available
                content = None
                if hasattr(result, "metadata") and result.metadata:
                    content = result.metadata.get("content_preview", "")

                formatted_result = {
                    "id": result.id,
                    "score": result.score,
                    "content": content,
                    "metadata": result.metadata if include_metadata else None,
                }
                formatted_results.append(formatted_result)

            # Cache the results if caching is enabled
            if self.cache_enabled and formatted_results:
                cache_key = self._get_cache_key(query, top_k, filter)
                if namespace:
                    cache_key = f"{cache_key}:ns:{namespace}"
                self.redis.setex(
                    cache_key, self.cache_ttl, json.dumps(formatted_results)
                )
                # Results cached successfully

            # Track performance
            duration = time.perf_counter() - start_time
            self.monitor.track_vector_search(
                query=query,
                results_count=len(formatted_results),
                duration=duration,
                cache_hit=False,
            )

            return formatted_results
        except Exception as e:
            print(f"Error searching for query '{query}': {e}")
            # Track error
            duration = time.perf_counter() - start_time
            if self.monitor:
                self.monitor.track_vector_search(
                    query=query, results_count=0, duration=duration, cache_hit=cache_hit
                )
            return []

    async def search_with_full_content(
        self, query: str, top_k: Optional[int] = None, include_full_docs: bool = True
    ) -> List[Dict]:
        """
        Search for documents and retrieve full content from Supabase.

        This method performs a vector search for relevant chunks, then
        retrieves the complete document content from Supabase database.

        Args:
            query: Natural language query text
            top_k: Number of results to return (defaults to VECTOR_TOP_K)
            include_full_docs: Whether to fetch full documents from Supabase

        Returns:
            List of matching documents with full content and metadata
        """
        try:
            # 1. Perform vector search for chunks
            results = await self.search(query, top_k=top_k, include_metadata=True)

            # 2. Group results by document ID
            docs_to_fetch = {}
            for result in results:
                if result.get("metadata"):
                    # Look for document_id first, fallback to file_path
                    document_id = result["metadata"].get("document_id")
                    file_path = result["metadata"].get("file_path")

                    # Use document_id if available, otherwise use file_path
                    doc_key = document_id if document_id else file_path

                    if doc_key:
                        if doc_key not in docs_to_fetch:
                            docs_to_fetch[doc_key] = {
                                "chunks": [],
                                "best_score": result["score"],
                                "metadata": result["metadata"],
                                "document_id": document_id,
                                "file_path": file_path,
                            }
                        docs_to_fetch[doc_key]["chunks"].append(result)
                        # Keep track of best score for this document
                        if result["score"] > docs_to_fetch[doc_key]["best_score"]:
                            docs_to_fetch[doc_key]["best_score"] = result["score"]

            # 3. Fetch full documents if requested
            enhanced_results = []

            # Import Supabase client if we need to fetch documents
            if include_full_docs and docs_to_fetch:
                from storage.storage_service import document_storage

            for doc_key, doc_info in docs_to_fetch.items():
                if include_full_docs:
                    try:
                        full_content = None
                        document_data = None

                        # Try to fetch from Supabase using document_id
                        if doc_info["document_id"] and document_storage:
                            document_data = await document_storage.get_document_by_id(
                                doc_info["document_id"]
                            )
                            if document_data:
                                full_content = document_data.get("content", "")

                        # If no document_id or fetch failed, try file_path
                        if (
                            not full_content
                            and doc_info["file_path"]
                            and document_storage
                        ):
                            document_data = await document_storage.get_document(
                                doc_info["file_path"]
                            )
                            if document_data:
                                full_content = document_data.get("content", "")

                        if full_content and document_data:
                            # Create enhanced result with full content from Supabase
                            enhanced_result = {
                                "id": document_data["id"],
                                "score": doc_info["best_score"],
                                "content": full_content,
                                "metadata": {
                                    **doc_info["metadata"],
                                    "title": document_data.get("title", ""),
                                    "category": document_data.get("category", ""),
                                    "tags": document_data.get("tags", []),
                                },
                                "chunks": doc_info["chunks"],
                                "source": "supabase",
                                "document_url": f"/documents/{document_data['id']}",  # Placeholder URL
                            }
                            enhanced_results.append(enhanced_result)
                        else:
                            # Fallback to chunks if document not found in Supabase
                            print(
                                f"Document not found in Supabase: {doc_key}, falling back to chunks"
                            )
                            # Build content from chunks
                            content_parts = []
                            for chunk in doc_info["chunks"]:
                                chunk_content = chunk.get("content")
                                if not chunk_content and chunk.get("metadata"):
                                    chunk_content = chunk["metadata"].get(
                                        "content_preview"
                                    )
                                if chunk_content:
                                    content_parts.append(chunk_content)

                            enhanced_result = {
                                "id": doc_key,
                                "score": doc_info["best_score"],
                                "content": (
                                    "\n\n".join(content_parts) if content_parts else ""
                                ),
                                "metadata": doc_info["metadata"],
                                "chunks": doc_info["chunks"],
                                "source": "chunks",
                            }
                            enhanced_results.append(enhanced_result)
                    except Exception as e:
                        print(
                            f"Error fetching document {doc_key} from Supabase: {e}, falling back to chunks"
                        )
                        # Fallback to chunks on any error
                        content_parts = []
                        for chunk in doc_info["chunks"]:
                            chunk_content = chunk.get("content")
                            if not chunk_content and chunk.get("metadata"):
                                chunk_content = chunk["metadata"].get("content_preview")
                            if chunk_content:
                                content_parts.append(chunk_content)

                        enhanced_result = {
                            "id": doc_key,
                            "score": doc_info["best_score"],
                            "content": (
                                "\n\n".join(content_parts) if content_parts else ""
                            ),
                            "metadata": doc_info["metadata"],
                            "chunks": doc_info["chunks"],
                            "source": "chunks",
                        }
                        enhanced_results.append(enhanced_result)
                else:
                    # Return chunks only
                    for chunk in doc_info["chunks"]:
                        enhanced_results.append(chunk)

            # Sort by score (highest first)
            enhanced_results.sort(key=lambda x: x["score"], reverse=True)

            return enhanced_results

        except Exception as e:
            print(f"Error in search_with_full_content for query '{query}': {e}")
            return []

    async def update_metadata(
        self, document_id: str, metadata: Dict, mode: str = "overwrite"
    ) -> bool:
        """
        Update metadata for a document.

        Args:
            document_id: Document ID to update
            metadata: New metadata to apply
            mode: "overwrite" (replace all) or "patch" (merge)

        Returns:
            True if updated successfully
        """
        try:
            # For now, use upsert to update metadata
            # This requires fetching the existing vector first
            existing = self.index.fetch([document_id])
            if not existing or len(existing) == 0:
                print(f"Document {document_id} not found for metadata update")
                return False

            # Get the existing vector and metadata
            doc = existing[0]

            # Apply metadata based on mode
            if mode == "overwrite":
                new_metadata = metadata
            else:  # patch mode
                # Merge existing metadata with new metadata
                new_metadata = (
                    doc.metadata.copy()
                    if hasattr(doc, "metadata") and doc.metadata
                    else {}
                )
                new_metadata.update(metadata)

            # Re-upsert with same vector but new metadata
            # Note: This is a workaround until native update method is available
            response = self.index.upsert(
                vectors=[(document_id, doc.vector, new_metadata)], namespace=""
            )

            if response:
                await self.invalidate_cache()
                return True

            return False
        except Exception as e:
            print(f"Error updating metadata for {document_id}: {e}")
            return False

    async def delete_document(
        self, document_id: str, namespace: Optional[str] = None
    ) -> bool:
        """
        Delete a document from the vector store.

        Args:
            document_id: Document ID to delete
            namespace: Optional namespace (defaults to empty string for MVP)

        Returns:
            True if deleted successfully, False otherwise
        """
        try:
            # Use default namespace for MVP
            self.index.delete([document_id], namespace=namespace or "")

            # Invalidate cache after deletion
            await self.invalidate_cache()

            return True
        except Exception as e:
            print(f"Error deleting document {document_id}: {e}")
            return False

    async def batch_embed_and_store(
        self, documents: List[Tuple[str, str, Optional[Dict]]]
    ) -> int:
        """
        Store multiple documents in batch for efficiency.

        Args:
            documents: List of tuples (document_id, content, metadata)

        Returns:
            Number of documents successfully stored
        """
        try:
            # Prepare vectors for batch upsert
            vectors = []
            for doc_id, content, metadata in documents:
                if metadata is None:
                    metadata = {}

                # Add standard metadata
                metadata.update(
                    {
                        "indexed_at": datetime.now().isoformat(),
                        "content_preview": (
                            content[:200] + "..." if len(content) > 200 else content
                        ),
                        "content_length": len(content),
                    }
                )

                vectors.append((doc_id, content, metadata))

            # Batch upsert with default namespace
            self.index.upsert(vectors=vectors, namespace="")

            # Invalidate cache after batch update
            await self.invalidate_cache()

            return len(vectors)
        except Exception as e:
            print(f"Error in batch storage: {e}")
            return 0

    async def fetch_document(self, document_id: str) -> Optional[Dict]:
        """
        Fetch a specific document by ID.

        Args:
            document_id: Document ID to fetch

        Returns:
            Document data or None if not found
        """
        try:
            result = self.index.fetch([document_id], namespace="")

            # Document fetched successfully

            # Find the document in the result list
            if result:
                for doc in result:
                    if doc.id == document_id:
                        return {
                            "id": document_id,
                            "content": None,  # Data content not returned by fetch
                            "metadata": doc.metadata,
                        }

            return None
        except Exception as e:
            print(f"Error fetching document {document_id}: {e}")
            return None

    async def list_documents(
        self, prefix: Optional[str] = None, limit: int = 100
    ) -> List[str]:
        """
        List document IDs in the vector store.

        Args:
            prefix: Optional prefix to filter document IDs
            limit: Maximum number of IDs to return

        Returns:
            List of document IDs
        """
        try:
            # Note: Upstash Vector doesn't have a direct list operation
            # This would need to be implemented differently, perhaps by
            # maintaining a separate index of document IDs
            return []
        except Exception as e:
            print(f"Error listing documents: {e}")
            return []

    async def reset_store(self) -> bool:
        """
        Reset (clear) all documents in the vector store.

        Returns:
            True if reset successfully, False otherwise
        """
        try:
            self.index.reset()
            return True
        except Exception as e:
            print(f"Error resetting vector store: {e}")
            return False


# Singleton instance
vector_store = VectorStore()
