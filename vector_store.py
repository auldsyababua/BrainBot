"""
Vector store for semantic search using Upstash Vector.
Handles document embedding, storage, and retrieval for the knowledge base.
"""

import os
from typing import List, Dict, Optional, Tuple
from datetime import datetime
from upstash_vector import Index
from dotenv import load_dotenv

# Load environment variables
load_dotenv()


class VectorStore:
    """Handles semantic search using Upstash Vector with automatic embeddings."""

    def __init__(self):
        """Initialize Vector index from environment variables."""
        self.index = Index.from_env()
        self.namespace = os.getenv("VECTOR_NAMESPACE", "")  # Default namespace
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
                        content[:200] + "..." if len(content) > 200 else content
                    ),
                    "content_length": len(content),
                }
            )

            # Upsert with automatic embedding (using data field)
            # Note: Upstash Python SDK doesn't support namespace in upsert directly
            # Need to use namespace() method first if namespace is set
            if self.namespace:
                self.index.namespace(self.namespace).upsert(
                    vectors=[(document_id, content, metadata)]
                )
            else:
                self.index.upsert(vectors=[(document_id, content, metadata)])

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
            # Note: include_data is not a parameter in the SDK
            if self.namespace:
                results = self.index.namespace(self.namespace).query(
                    data=query,
                    top_k=top_k,
                    filter=filter or "",
                    include_metadata=include_metadata,
                    include_vectors=False,
                )
            else:
                results = self.index.query(
                    data=query,
                    top_k=top_k,
                    filter=filter or "",
                    include_metadata=include_metadata,
                    include_vectors=False,
                )

            # Format results
            formatted_results = []
            for result in results:
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

    async def update_metadata(self, document_id: str, metadata: Dict) -> bool:
        """
        Update metadata for an existing document.

        Args:
            document_id: Document ID to update
            metadata: New metadata to merge with existing

        Returns:
            True if updated successfully, False otherwise
        """
        try:
            # Fetch existing document
            if self.namespace:
                result = self.index.namespace(self.namespace).fetch([document_id])
            else:
                result = self.index.fetch([document_id])

            if not result or document_id not in result:
                print(f"Document {document_id} not found")
                return False

            # Merge metadata
            existing_metadata = result[document_id].metadata or {}
            existing_metadata.update(metadata)
            existing_metadata["last_updated"] = datetime.now().isoformat()

            # Update the document
            if self.namespace:
                self.index.namespace(self.namespace).update(
                    id=document_id, metadata=existing_metadata
                )
            else:
                self.index.update(id=document_id, metadata=existing_metadata)

            return True
        except Exception as e:
            print(f"Error updating metadata for {document_id}: {e}")
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
            if self.namespace:
                self.index.namespace(self.namespace).delete([document_id])
            else:
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
            if self.namespace:
                self.index.namespace(self.namespace).upsert(vectors=vectors)
            else:
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
            if self.namespace:
                result = self.index.namespace(self.namespace).fetch([document_id])
            else:
                result = self.index.fetch([document_id])

            if result and document_id in result:
                doc = result[document_id]
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

    async def reset_namespace(self, namespace: Optional[str] = None) -> bool:
        """
        Reset (clear) all documents in a namespace.

        Args:
            namespace: Namespace to reset (uses default if not specified)

        Returns:
            True if reset successfully, False otherwise
        """
        try:
            target_namespace = namespace or self.namespace
            if target_namespace:
                self.index.namespace(target_namespace).reset()
            else:
                self.index.reset()
            return True
        except Exception as e:
            print(f"Error resetting namespace {target_namespace}: {e}")
            return False


# Singleton instance
vector_store = VectorStore()
