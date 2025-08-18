"""
Integration tests for Cloudflare Vectorize implementation.
"""

import pytest
from unittest.mock import Mock, patch, AsyncMock

from src.storage.cloudflare_vector_store import CloudflareVectorStore


@pytest.fixture
def mock_env(monkeypatch):
    """Set up test environment variables."""
    monkeypatch.setenv("CLOUDFLARE_ACCOUNT_ID", "test-account-123")
    monkeypatch.setenv("CLOUDFLARE_API_TOKEN", "test-token-xyz")
    monkeypatch.setenv("CLOUDFLARE_VECTORIZE_INDEX", "test-index")
    monkeypatch.setenv("OPENAI_API_KEY", "test-openai-key")
    monkeypatch.setenv("VECTOR_TOP_K", "5")


@pytest.fixture
def mock_openai():
    """Mock OpenAI client for embeddings."""
    with patch("src.storage.cloudflare_vector_store.openai") as mock:
        mock_client = Mock()
        mock_response = Mock()
        mock_response.data = [Mock(embedding=[0.1] * 1536)]
        mock_client.embeddings.create.return_value = mock_response
        mock.OpenAI.return_value = mock_client
        yield mock


@pytest.fixture
async def vector_store(mock_env, mock_openai):
    """Create a CloudflareVectorStore instance for testing."""
    store = CloudflareVectorStore()
    return store


class TestCloudflareVectorStore:
    """Test suite for Cloudflare Vectorize operations."""

    @pytest.mark.asyncio
    async def test_embed_and_store(self, vector_store):
        """Test storing a document with embeddings."""
        with patch("httpx.AsyncClient") as mock_client:
            mock_response = Mock()
            mock_response.raise_for_status = Mock()
            mock_instance = mock_client.return_value.__aenter__.return_value
            mock_instance.post = AsyncMock(return_value=mock_response)

            result = await vector_store.embed_and_store(
                document_id="test-doc-1",
                content="This is a test document",
                metadata={"category": "test"},
                namespace="test-namespace",
            )

            assert result is True
            mock_instance.post.assert_called_once()
            call_args = mock_instance.post.call_args
            assert "upsert" in call_args[0][0]
            assert "vectors" in call_args[1]["json"]

    @pytest.mark.asyncio
    async def test_search(self, vector_store):
        """Test searching for documents."""
        with patch("httpx.AsyncClient") as mock_client:
            mock_response = Mock()
            mock_response.raise_for_status = Mock()
            mock_response.json.return_value = {
                "result": {
                    "matches": [
                        {
                            "id": "doc-1",
                            "score": 0.95,
                            "metadata": {"content_preview": "Test content"},
                        },
                        {
                            "id": "doc-2",
                            "score": 0.85,
                            "metadata": {"content_preview": "Another test"},
                        },
                    ]
                }
            }
            mock_instance = mock_client.return_value.__aenter__.return_value
            mock_instance.post = AsyncMock(return_value=mock_response)

            results = await vector_store.search(
                query="test query", top_k=2, namespace="test-namespace"
            )

            assert len(results) == 2
            assert results[0]["id"] == "doc-1"
            assert results[0]["score"] == 0.95
            assert results[1]["id"] == "doc-2"

    @pytest.mark.asyncio
    async def test_delete_document(self, vector_store):
        """Test deleting a document."""
        with patch("httpx.AsyncClient") as mock_client:
            mock_response = Mock()
            mock_response.raise_for_status = Mock()
            mock_instance = mock_client.return_value.__aenter__.return_value
            mock_instance.post = AsyncMock(return_value=mock_response)

            result = await vector_store.delete_document("test-doc-1")

            assert result is True
            mock_instance.post.assert_called_once()
            call_args = mock_instance.post.call_args
            assert "delete" in call_args[0][0]

    @pytest.mark.asyncio
    async def test_batch_embed_and_store(self, vector_store):
        """Test batch storing documents."""
        with patch("httpx.AsyncClient") as mock_client:
            mock_response = Mock()
            mock_response.raise_for_status = Mock()
            mock_instance = mock_client.return_value.__aenter__.return_value
            mock_instance.post = AsyncMock(return_value=mock_response)

            documents = [
                ("doc-1", "First document", {"type": "A"}),
                ("doc-2", "Second document", {"type": "B"}),
                ("doc-3", "Third document", None),
            ]

            count = await vector_store.batch_embed_and_store(documents)

            assert count == 3
            mock_instance.post.assert_called_once()
            call_args = mock_instance.post.call_args
            vectors = call_args[1]["json"]["vectors"]
            assert len(vectors) == 3

    @pytest.mark.asyncio
    async def test_fetch_document(self, vector_store):
        """Test fetching a specific document."""
        with patch("httpx.AsyncClient") as mock_client:
            mock_response = Mock()
            mock_response.status_code = 200
            mock_response.raise_for_status = Mock()
            mock_response.json.return_value = {
                "result": {"id": "test-doc", "metadata": {"category": "test"}}
            }
            mock_instance = mock_client.return_value.__aenter__.return_value
            mock_instance.get = AsyncMock(return_value=mock_response)

            result = await vector_store.fetch_document("test-doc")

            assert result is not None
            assert result["id"] == "test-doc"
            assert result["metadata"]["category"] == "test"

    @pytest.mark.asyncio
    async def test_update_metadata(self, vector_store):
        """Test updating document metadata."""
        with patch("httpx.AsyncClient") as mock_client:
            mock_response = Mock()
            mock_response.raise_for_status = Mock()
            mock_instance = mock_client.return_value.__aenter__.return_value
            mock_instance.post = AsyncMock(return_value=mock_response)

            result = await vector_store.update_metadata(
                "test-doc", {"new_field": "new_value"}, mode="overwrite"
            )

            assert result is True
            mock_instance.post.assert_called_once()

    @pytest.mark.asyncio
    async def test_error_handling(self, vector_store):
        """Test error handling in various operations."""
        with patch("httpx.AsyncClient") as mock_client:
            mock_instance = mock_client.return_value.__aenter__.return_value
            mock_instance.post = AsyncMock(side_effect=Exception("API Error"))

            # Test store failure
            result = await vector_store.embed_and_store("doc-1", "content")
            assert result is False

            # Test search failure
            results = await vector_store.search("query")
            assert results == []

            # Test delete failure
            result = await vector_store.delete_document("doc-1")
            assert result is False

    @pytest.mark.asyncio
    async def test_namespace_filtering(self, vector_store):
        """Test namespace isolation in search."""
        with patch("httpx.AsyncClient") as mock_client:
            mock_response = Mock()
            mock_response.raise_for_status = Mock()
            mock_response.json.return_value = {"result": {"matches": []}}
            mock_instance = mock_client.return_value.__aenter__.return_value
            mock_instance.post = AsyncMock(return_value=mock_response)

            await vector_store.search(query="test", namespace="user-123")

            call_args = mock_instance.post.call_args
            search_data = call_args[1]["json"]
            assert "filter" in search_data
            assert search_data["filter"]["namespace"]["$eq"] == "user-123"


@pytest.mark.asyncio
async def test_singleton_pattern():
    """Test that the module provides a singleton instance."""
    from src.storage.cloudflare_vector_store import cloudflare_vector_store

    # This should not raise an error if properly initialized
    assert cloudflare_vector_store is not None
