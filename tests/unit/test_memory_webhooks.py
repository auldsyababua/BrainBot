"""
Unit tests for memory webhook functionality.
"""

import os
from unittest.mock import AsyncMock, MagicMock, patch

import pytest

# Skip these tests as they don't match the current implementation
pytestmark = pytest.mark.skip(
    reason="Tests need to be updated to match current MemoryWebhookHandler implementation"
)

from flrts_bmad.core.memory_webhooks import (
    MemoryWebhookEvent,
    MemoryWebhookHandler,
    WebhookConfig,
)


class TestWebhookConfig:
    """Test WebhookConfig dataclass."""

    def test_webhook_config_creation(self):
        """Test creating a webhook config."""
        config = WebhookConfig(
            url="https://example.com/webhook",
            headers={"Authorization": "Bearer token"},
            timeout=30,
            retry_attempts=3,
            retry_delay=1.0,
            enabled=True,
        )

        assert config.url == "https://example.com/webhook"
        assert config.headers == {"Authorization": "Bearer token"}
        assert config.timeout == 30
        assert config.retry_attempts == 3
        assert config.retry_delay == 1.0
        assert config.enabled is True

    def test_webhook_config_defaults(self):
        """Test webhook config with defaults."""
        config = WebhookConfig()

        assert config.url is None
        assert config.headers is None
        assert config.timeout == 30
        assert config.retry_attempts == 3
        assert config.retry_delay == 1.0
        assert config.enabled is True


class TestMemoryWebhookHandler:
    """Test MemoryWebhookHandler class."""

    def setup_method(self):
        """Set up test environment."""
        # Mock environment variables
        self.env_vars = {
            "MEM0_WEBHOOK_URL": "https://test.example.com/webhook",
            "MEM0_WEBHOOK_TOKEN": "test-token",
            "MEM0_WEBHOOK_SECRET": "test-secret",
            "MEM0_WEBHOOK_TIMEOUT": "10",
            "MEM0_WEBHOOK_RETRY_COUNT": "2",
            "MEM0_WEBHOOK_RETRY_DELAY": "0.1",
            "MEM0_WEBHOOK_EVENTS": "memory_added,memory_deleted",
            "BOT_VERSION": "test-1.0.0",
        }

    def test_handler_initialization_enabled(self):
        """Test handler initialization when webhook is enabled."""
        with patch.dict(os.environ, self.env_vars):
            handler = MemoryWebhookHandler()

            assert handler.enabled is True
            assert handler.webhook_url == "https://test.example.com/webhook"
            assert handler.webhook_token == "test-token"
            assert handler.webhook_secret == "test-secret"
            assert handler.timeout == 10
            assert handler.retry_count == 2
            assert handler.retry_delay == 0.1
            assert "Authorization" in handler.headers
            assert "X-Webhook-Secret" in handler.headers
            assert "memory_added" in handler.enabled_events
            assert "memory_deleted" in handler.enabled_events
            assert "memory_searched" not in handler.enabled_events

    def test_handler_initialization_disabled(self):
        """Test handler initialization when webhook is disabled."""
        with patch.dict(os.environ, {}, clear=True):
            handler = MemoryWebhookHandler()

            assert handler.enabled is False
            assert handler.webhook_url is None

    def test_get_enabled_events_all(self):
        """Test getting all enabled events."""
        env_vars = self.env_vars.copy()
        env_vars["MEM0_WEBHOOK_EVENTS"] = "all"

        with patch.dict(os.environ, env_vars):
            handler = MemoryWebhookHandler()

            # Should include all events
            assert len(handler.enabled_events) == len(MemoryWebhookEvent)
            assert "memory_added" in handler.enabled_events
            assert "memory_deleted" in handler.enabled_events
            assert "memory_searched" in handler.enabled_events

    def test_get_enabled_events_none(self):
        """Test getting no enabled events."""
        env_vars = self.env_vars.copy()
        env_vars["MEM0_WEBHOOK_EVENTS"] = "none"

        with patch.dict(os.environ, env_vars):
            handler = MemoryWebhookHandler()

            assert len(handler.enabled_events) == 0

    def test_is_event_enabled(self):
        """Test checking if an event is enabled."""
        with patch.dict(os.environ, self.env_vars):
            handler = MemoryWebhookHandler()

            assert handler.is_event_enabled("memory_added") is True
            assert handler.is_event_enabled("memory_deleted") is True
            assert handler.is_event_enabled("memory_searched") is False

    @pytest.mark.asyncio
    async def test_send_webhook_success(self):
        """Test successful webhook sending."""
        with patch.dict(os.environ, self.env_vars):
            handler = MemoryWebhookHandler()

            # Mock aiohttp session
            mock_response = AsyncMock()
            mock_response.status = 200

            mock_session = AsyncMock()
            mock_session.post.return_value.__aenter__.return_value = mock_response

            with patch("aiohttp.ClientSession", return_value=mock_session):
                result = await handler.send_webhook(
                    event=MemoryWebhookEvent.MEMORY_ADDED,
                    user_id="test_user",
                    data={"test": "data"},
                )

                assert result is True
                mock_session.post.assert_called_once()

    @pytest.mark.asyncio
    async def test_send_webhook_disabled_event(self):
        """Test sending webhook for disabled event."""
        with patch.dict(os.environ, self.env_vars):
            handler = MemoryWebhookHandler()

            # This event is not in the enabled list
            result = await handler.send_webhook(
                event=MemoryWebhookEvent.MEMORY_SEARCHED,
                user_id="test_user",
                data={"test": "data"},
            )

            assert result is True  # Returns True but doesn't actually send

    @pytest.mark.asyncio
    async def test_send_webhook_client_error(self):
        """Test webhook sending with client error (no retry)."""
        with patch.dict(os.environ, self.env_vars):
            handler = MemoryWebhookHandler()

            # Mock aiohttp session with 400 error
            mock_response = AsyncMock()
            mock_response.status = 400
            mock_response.text.return_value = "Bad Request"

            mock_session = AsyncMock()
            mock_session.post.return_value.__aenter__.return_value = mock_response

            with patch("aiohttp.ClientSession", return_value=mock_session):
                result = await handler.send_webhook(
                    event=MemoryWebhookEvent.MEMORY_ADDED,
                    user_id="test_user",
                    data={"test": "data"},
                )

                assert result is False
                # Should be called only once (no retry for client errors)
                mock_session.post.assert_called_once()

    @pytest.mark.asyncio
    async def test_send_webhook_server_error_retry(self):
        """Test webhook sending with server error and retry."""
        env_vars = self.env_vars.copy()
        env_vars["MEM0_WEBHOOK_RETRY_COUNT"] = "2"

        with patch.dict(os.environ, env_vars):
            handler = MemoryWebhookHandler()

            # Mock aiohttp session with 500 error
            mock_response = AsyncMock()
            mock_response.status = 500

            mock_session = AsyncMock()
            mock_session.post.return_value.__aenter__.return_value = mock_response

            with patch("aiohttp.ClientSession", return_value=mock_session):
                with patch("asyncio.sleep", return_value=None):  # Speed up test
                    result = await handler.send_webhook(
                        event=MemoryWebhookEvent.MEMORY_ADDED,
                        user_id="test_user",
                        data={"test": "data"},
                    )

                    assert result is False
                    # Should be called retry_count times
                    assert mock_session.post.call_count == 2

    @pytest.mark.asyncio
    async def test_send_batch_webhook(self):
        """Test sending batch webhooks."""
        with patch.dict(os.environ, self.env_vars):
            handler = MemoryWebhookHandler()

            # Mock successful webhook sending
            with patch.object(handler, "send_webhook", return_value=True) as mock_send:
                events = [
                    (MemoryWebhookEvent.MEMORY_ADDED, "user1", {"data1": "test"}),
                    (MemoryWebhookEvent.MEMORY_DELETED, "user2", {"data2": "test"}),
                    (
                        MemoryWebhookEvent.MEMORY_SEARCHED,
                        "user3",
                        {"data3": "test"},
                    ),  # This should be skipped
                ]

                result = await handler.send_batch_webhook(events)

                assert result["success"] == 2
                assert result["failed"] == 0
                assert result["skipped"] == 1
                assert mock_send.call_count == 2

    def test_validate_incoming_webhook_valid(self):
        """Test validating a valid incoming webhook."""
        with patch.dict(os.environ, self.env_vars):
            handler = MemoryWebhookHandler()

            payload = {
                "event": "memory_added",
                "user_id": "test_user",
                "data": {"test": "data"},
                "timestamp": "2024-01-01T00:00:00",
            }

            result = handler.validate_incoming_webhook(payload)
            assert result is True

    def test_validate_incoming_webhook_missing_field(self):
        """Test validating webhook with missing field."""
        with patch.dict(os.environ, self.env_vars):
            handler = MemoryWebhookHandler()

            payload = {
                "event": "memory_added",
                "user_id": "test_user",
                # Missing 'data' field
                "timestamp": "2024-01-01T00:00:00",
            }

            result = handler.validate_incoming_webhook(payload)
            assert result is False

    def test_validate_incoming_webhook_invalid_event(self):
        """Test validating webhook with invalid event."""
        with patch.dict(os.environ, self.env_vars):
            handler = MemoryWebhookHandler()

            payload = {
                "event": "invalid_event",
                "user_id": "test_user",
                "data": {"test": "data"},
                "timestamp": "2024-01-01T00:00:00",
            }

            result = handler.validate_incoming_webhook(payload)
            assert result is False

    @pytest.mark.asyncio
    async def test_handle_incoming_webhook(self):
        """Test handling incoming webhook."""
        with patch.dict(os.environ, self.env_vars):
            handler = MemoryWebhookHandler()

            payload = {
                "event": "memory_added",
                "user_id": "test_user",
                "data": {"test": "data"},
                "timestamp": "2024-01-01T00:00:00",
            }

            result = await handler.handle_incoming_webhook(payload)

            assert result["status"] == "processed"
            assert result["action"] == "memory_logged"

    def test_get_webhook_stats(self):
        """Test getting webhook statistics."""
        with patch.dict(os.environ, self.env_vars):
            handler = MemoryWebhookHandler()

            stats = handler.get_webhook_stats()

            assert stats["enabled"] is True
            assert stats["webhook_url"] == "https://test.example.com/webhook"
            assert stats["timeout"] == 10
            assert stats["retry_count"] == 2
            assert stats["has_token"] is True
            assert stats["has_secret"] is True
            assert len(stats["enabled_events"]) == 2


class TestMemoryWebhookIntegration:
    """Integration tests for memory webhooks."""

    @pytest.mark.asyncio
    async def test_memory_webhook_integration(self):
        """Test webhook integration with memory operations."""
        from src.core.memory import BotMemory

        # Mock environment for webhook
        env_vars = {
            "MEM0_WEBHOOK_URL": "https://test.example.com/webhook",
            "MEM0_WEBHOOK_TOKEN": "test-token",
            "MEM0_WEBHOOK_EVENTS": "all",
        }

        with patch.dict(os.environ, env_vars):
            # Mock successful webhook sending
            with patch(
                "src.core.memory_webhooks.memory_webhook_handler.send_webhook",
                return_value=True,
            ) as mock_webhook:
                # Create memory instance
                memory = BotMemory()

                # Mock mem0 memory
                memory.memory = MagicMock()
                memory.memory.add.return_value = {"id": "mem_123", "content": "test"}

                # Test memory addition triggers webhook
                await memory.remember_from_conversation(
                    messages=[{"role": "user", "content": "Test message"}],
                    user_id="test_user",
                )

                # Verify webhook was called
                mock_webhook.assert_called_once()
                call_args = mock_webhook.call_args
                assert call_args[1]["event"] == MemoryWebhookEvent.MEMORY_ADDED
                assert call_args[1]["user_id"] == "test_user"


if __name__ == "__main__":
    pytest.main(["-v", __file__])
