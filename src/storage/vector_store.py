"""
Vector store for semantic search using Upstash Vector.
Handles document embedding, storage, and retrieval for the knowledge base.
"""

import os
from typing import List, Dict, Optional, Tuple
from datetime import datetime
from upstash_vector import Index
from dotenv import load_dotenv
from pathlib import Path

# Load environment variables
load_dotenv()


class VectorStore:
    """Handles semantic search using Upstash Vector with automatic embeddings."""

    def __init__(self):
        """Initialize Vector index from environment variables."""
        self.index = Index.from_env()
        self.top_k = int(os.getenv("VECTOR_TOP_K", "5"))

    async def embed_and_store(
        self, document_id: str, content: str, metadata: Optional[Dict] = None
    ) -> bool:
        """
        Store a document with automatic embedding generation.

        Args:
            document_id: Unique identifier for the document
            content: Text content to embed and store
            metadata: Optional metadata to attach to the document

        Returns:
            True if stored successfully, False otherwise
        """
        try:
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
            response = self.index.upsert(vectors=[(document_id, content, metadata)])

            print(f"[DEBUG] Upsert response for {document_id}: {response}")
            return True
        except Exception as e:
            print(f"Error storing document {document_id}: {e}")
            return False

    async def search(
        self,
        query: str,
        top_k: Optional[int] = None,
        filter: Optional[str] = None,
        include_metadata: bool = True,
    ) -> List[Dict]:
        """
        Search for documents using semantic similarity.

        Args:
            query: Natural language query text
            top_k: Number of results to return (defaults to VECTOR_TOP_K)
            filter: Optional metadata filter
            include_metadata: Whether to include metadata in results

        Returns:
            List of matching documents with scores and metadata
        """
        try:
            # Use configured top_k if not specified
            if top_k is None:
                top_k = self.top_k

            # Query using text data (automatic embedding)
            results = self.index.query(
                data=query,
                top_k=top_k,
                filter=filter or "",
                include_metadata=include_metadata,
                include_vectors=False,
            )

            print(f"[DEBUG] Query '{query}' response: {results}")
            print(f"[DEBUG] Query response type: {type(results)}")
            print(
                f"[DEBUG] Query response length: {len(results) if hasattr(results, '__len__') else 'N/A'}"
            )

            # Format results
            formatted_results = []
            for i, result in enumerate(results):
                print(f"[DEBUG] Result {i}: {result}")
                print(f"[DEBUG] Result type: {type(result)}")
                print(f"[DEBUG] Result attributes: {dir(result)}")
                print(f"[DEBUG] Result ID: {getattr(result, 'id', 'N/A')}")
                print(f"[DEBUG] Result score: {getattr(result, 'score', 'N/A')}")
                print(f"[DEBUG] Result metadata: {getattr(result, 'metadata', 'N/A')}")
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

            return formatted_results
        except Exception as e:
            print(f"Error searching for query '{query}': {e}")
            return []

    async def search_with_full_content(
        self, query: str, top_k: Optional[int] = None, include_full_docs: bool = True
    ) -> List[Dict]:
        """
        Search for documents and retrieve full content from filesystem.

        This method performs a vector search for relevant chunks, then
        retrieves the complete document content from the filesystem.

        Args:
            query: Natural language query text
            top_k: Number of results to return (defaults to VECTOR_TOP_K)
            include_full_docs: Whether to fetch full documents from filesystem

        Returns:
            List of matching documents with full content and metadata
        """
        try:
            # 1. Perform vector search for chunks
            results = await self.search(query, top_k=top_k, include_metadata=True)

            # 2. Group results by document file path
            docs_to_fetch = {}
            for result in results:
                if result.get("metadata"):
                    file_path = result["metadata"].get("file_path")
                    if file_path:
                        if file_path not in docs_to_fetch:
                            docs_to_fetch[file_path] = {
                                "chunks": [],
                                "best_score": result["score"],
                                "metadata": result["metadata"],
                            }
                        docs_to_fetch[file_path]["chunks"].append(result)
                        # Keep track of best score for this document
                        if result["score"] > docs_to_fetch[file_path]["best_score"]:
                            docs_to_fetch[file_path]["best_score"] = result["score"]

            # 3. Fetch full documents if requested
            enhanced_results = []
            for file_path, doc_info in docs_to_fetch.items():
                if include_full_docs:
                    try:
                        # Read full document from filesystem
                        path = Path(file_path)
                        if path.exists():
                            full_content = path.read_text(encoding="utf-8")

                            # Create enhanced result with full content
                            enhanced_result = {
                                "id": file_path,
                                "score": doc_info["best_score"],
                                "content": full_content,
                                "metadata": doc_info["metadata"],
                                "chunks": doc_info["chunks"],
                                "source": "filesystem",
                            }
                            enhanced_results.append(enhanced_result)
                        else:
                            # Fallback to chunks if file not found
                            print(
                                f"File not found: {file_path}, falling back to chunks"
                            )
                            enhanced_result = {
                                "id": file_path,
                                "score": doc_info["best_score"],
                                "content": "\n\n".join(
                                    [
                                        chunk["content"]
                                        for chunk in doc_info["chunks"]
                                        if chunk.get("content")
                                    ]
                                ),
                                "metadata": doc_info["metadata"],
                                "chunks": doc_info["chunks"],
                                "source": "chunks",
                            }
                            enhanced_results.append(enhanced_result)
                    except Exception as e:
                        print(
                            f"Error reading file {file_path}: {e}, falling back to chunks"
                        )
                        # Fallback to chunks on any error
                        enhanced_result = {
                            "id": file_path,
                            "score": doc_info["best_score"],
                            "content": "\n\n".join(
                                [
                                    chunk["content"]
                                    for chunk in doc_info["chunks"]
                                    if chunk.get("content")
                                ]
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

    async def update_metadata(self, document_id: str, metadata: Dict) -> bool:
        """
        Update metadata for an existing document.

        Note: Update functionality not available in upstash-vector v0.8.0
        This method is a placeholder for future compatibility.

        TODO: When upstash-vector releases a version > v0.8.0 with the update method,
        replace this implementation with:
        ```python
        try:
            return self.index.update(document_id, metadata=metadata)
        except Exception as e:
            print(f"Error updating metadata for {document_id}: {e}")
            return False
        ```

        For now, you can work around this by using upsert:
        ```python
        self.index.upsert([(document_id, None, metadata)])
        ```

        Args:
            document_id: Document ID to update
            metadata: New metadata to merge with existing

        Returns:
            False (not implemented in current SDK version)
        """
        print("[DEBUG] Update metadata not supported in upstash-vector v0.8.0")
        print(
            "[DEBUG] The update method exists in the main branch but not in the current release"
        )
        print("[DEBUG] See: https://github.com/upstash/vector-py#update-a-vector")
        return False

    async def delete_document(self, document_id: str) -> bool:
        """
        Delete a document from the vector store.

        Args:
            document_id: Document ID to delete

        Returns:
            True if deleted successfully, False otherwise
        """
        try:
            self.index.delete([document_id])
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

            # Batch upsert
            self.index.upsert(vectors=vectors)

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
            result = self.index.fetch([document_id])

            print(f"[DEBUG] Fetch result for {document_id}: {result}")
            print(f"[DEBUG] Fetch result type: {type(result)}")

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
