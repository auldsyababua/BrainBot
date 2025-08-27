"""
Integration tests for webhook endpoints.
"""

import os
from unittest.mock import patch

import pytest
from fastapi.testclient import TestClient

from brainbot.bot.webhook_bot import WebhookTelegramBot
from brainbot.core.memory_webhooks import MemoryWebhookEvent


class TestWebhookEndpoints:
    """Test webhook endpoints integration."""

    def setup_method(self):
        """Set up test environment."""
        self.env_vars = {
            "TELEGRAM_BOT_TOKEN": "test_bot_token",
            "MEM0_WEBHOOK_URL": "https://test.example.com/webhook",
            "MEM0_WEBHOOK_TOKEN": "test-token",
            "MEM0_WEBHOOK_SECRET": "test-secret",
            "MEM0_WEBHOOK_EVENTS": "all",
        }

    def test_memory_webhook_status_endpoint(self):
        """Test memory webhook status endpoint."""
        with patch.dict(os.environ, self.env_vars):
            bot = WebhookTelegramBot()
            client = TestClient(bot.get_fastapi_app())

            response = client.get("/webhooks/memory/status")

            assert response.status_code == 200
            data = response.json()

            assert data["status"] == "ok"
            assert "webhook_config" in data
            assert data["webhook_config"]["enabled"] is True
            assert data["webhook_config"]["webhook_url"] == "https://test.example.com/webhook"

    def test_memory_webhook_test_endpoint(self):
        """Test memory webhook test endpoint."""
        with patch.dict(os.environ, self.env_vars):
            bot = WebhookTelegramBot()
            client = TestClient(bot.get_fastapi_app())

            with patch(
                "src.core.memory_webhooks.memory_webhook_handler.send_webhook",
                return_value=True,
            ) as mock_send:
                response = client.post("/webhooks/memory/test")

                assert response.status_code == 200
                data = response.json()

                assert data["status"] == "ok"
                assert data["test_sent"] is True
                assert data["webhook_enabled"] is True

                # Verify webhook was called
                mock_send.assert_called_once()
                call_args = mock_send.call_args
                assert call_args[1]["event"] == MemoryWebhookEvent.MEMORY_ADDED
                assert call_args[1]["user_id"] == "test_user"
                assert call_args[1]["data"]["test"] is True

    def test_memory_webhook_test_endpoint_disabled(self):
        """Test memory webhook test endpoint when webhooks are disabled."""
        # No webhook URL configured
        env_vars = self.env_vars.copy()
        del env_vars["MEM0_WEBHOOK_URL"]

        with patch.dict(os.environ, env_vars, clear=True):
            bot = WebhookTelegramBot()
            client = TestClient(bot.get_fastapi_app())

            response = client.post("/webhooks/memory/test")

            assert response.status_code == 200
            data = response.json()

            assert data["status"] == "ok"  # Still returns ok, but indicates not sent
            assert data["test_sent"] is True  # Handler returns True when disabled
            assert data["webhook_enabled"] is False
            assert data["webhook_url"] is None

    def test_memory_webhook_incoming_valid(self):
        """Test incoming memory webhook with valid payload."""
        with patch.dict(os.environ, self.env_vars):
            bot = WebhookTelegramBot()
            client = TestClient(bot.get_fastapi_app())

            payload = {
                "event": "memory_added",
                "user_id": "test_user",
                "data": {"memory_id": "mem_123", "content": "Test memory content"},
                "timestamp": "2024-01-01T00:00:00",
                "source": "external-system",
            }

            response = client.post("/webhooks/memory", json=payload)

            assert response.status_code == 200
            data = response.json()

            assert data["status"] == "processed"
            assert data["action"] == "memory_logged"

    def test_memory_webhook_incoming_invalid_payload(self):
        """Test incoming memory webhook with invalid payload."""
        with patch.dict(os.environ, self.env_vars):
            bot = WebhookTelegramBot()
            client = TestClient(bot.get_fastapi_app())

            # Missing required fields
            payload = {
                "event": "memory_added",
                "user_id": "test_user",
                # Missing 'data' and 'timestamp'
            }

            response = client.post("/webhooks/memory", json=payload)

            assert response.status_code == 400
            assert "Invalid webhook payload" in response.json()["detail"]

    def test_memory_webhook_incoming_invalid_event(self):
        """Test incoming memory webhook with invalid event type."""
        with patch.dict(os.environ, self.env_vars):
            bot = WebhookTelegramBot()
            client = TestClient(bot.get_fastapi_app())

            payload = {
                "event": "invalid_event_type",
                "user_id": "test_user",
                "data": {"test": "data"},
                "timestamp": "2024-01-01T00:00:00",
            }

            response = client.post("/webhooks/memory", json=payload)

            assert response.status_code == 400
            assert "Invalid webhook payload" in response.json()["detail"]

    def test_memory_webhook_incoming_with_signature(self):
        """Test incoming memory webhook with signature validation."""
        with patch.dict(os.environ, self.env_vars):
            bot = WebhookTelegramBot()
            client = TestClient(bot.get_fastapi_app())

            payload = {
                "event": "memory_added",
                "user_id": "test_user",
                "data": {"test": "data"},
                "timestamp": "2024-01-01T00:00:00",
            }

            # Mock signature validation to return True
            with patch(
                "src.core.memory_webhooks.memory_webhook_handler.validate_incoming_webhook",
                return_value=True,
            ):
                response = client.post(
                    "/webhooks/memory",
                    json=payload,
                    headers={"X-Webhook-Signature": "valid_signature"},
                )

                assert response.status_code == 200

    def test_memory_webhook_incoming_invalid_signature(self):
        """Test incoming memory webhook with invalid signature."""
        with patch.dict(os.environ, self.env_vars):
            bot = WebhookTelegramBot()
            client = TestClient(bot.get_fastapi_app())

            payload = {
                "event": "memory_added",
                "user_id": "test_user",
                "data": {"test": "data"},
                "timestamp": "2024-01-01T00:00:00",
            }

            # Mock signature validation to return False
            with patch(
                "src.core.memory_webhooks.memory_webhook_handler.validate_incoming_webhook",
                return_value=False,
            ):
                response = client.post(
                    "/webhooks/memory",
                    json=payload,
                    headers={"X-Webhook-Signature": "invalid_signature"},
                )

                assert response.status_code == 400
                assert "Invalid webhook payload" in response.json()["detail"]

    def test_memory_webhook_incoming_server_error(self):
        """Test incoming memory webhook with server error."""
        with patch.dict(os.environ, self.env_vars):
            bot = WebhookTelegramBot()
            client = TestClient(bot.get_fastapi_app())

            payload = {
                "event": "memory_added",
                "user_id": "test_user",
                "data": {"test": "data"},
                "timestamp": "2024-01-01T00:00:00",
            }

            # Mock handler to raise an exception
            with patch(
                "src.core.memory_webhooks.memory_webhook_handler.handle_incoming_webhook",
                side_effect=Exception("Test error"),
            ):
                response = client.post("/webhooks/memory", json=payload)

                assert response.status_code == 500
                assert "Test error" in response.json()["detail"]

    def test_health_check_endpoint(self):
        """Test main health check endpoint."""
        with patch.dict(os.environ, self.env_vars):
            bot = WebhookTelegramBot()
            client = TestClient(bot.get_fastapi_app())

            response = client.get("/")

            assert response.status_code == 200
            data = response.json()

            assert data["status"] == "ok"
            assert data["bot"] == "Markdown Brain Bot"
            assert data["mode"] == "webhook"

    def test_metrics_endpoint(self):
        """Test metrics endpoint."""
        with patch.dict(os.environ, self.env_vars):
            bot = WebhookTelegramBot()
            client = TestClient(bot.get_fastapi_app())

            # Mock performance monitor
            with patch("src.core.benchmarks.get_performance_monitor") as mock_monitor:
                mock_monitor.return_value.get_performance_summary.return_value = {
                    "cache_hit_rate": 85.5,
                    "total_tokens_used": 1234,
                    "vector_search_duration": 0.15,
                }

                response = client.get("/metrics")

                assert response.status_code == 200
                data = response.json()

                assert data["status"] == "ok"
                assert "metrics" in data
                assert "description" in data


class TestWebhookEndpointsWithoutAuth:
    """Test webhook endpoints without authentication."""

    def test_memory_webhook_status_no_auth(self):
        """Test memory webhook status endpoint without authentication."""
        env_vars = {
            "TELEGRAM_BOT_TOKEN": "test_bot_token",
            "MEM0_WEBHOOK_URL": "https://test.example.com/webhook",
            # No token or secret
        }

        with patch.dict(os.environ, env_vars, clear=True):
            bot = WebhookTelegramBot()
            client = TestClient(bot.get_fastapi_app())

            response = client.get("/webhooks/memory/status")

            assert response.status_code == 200
            data = response.json()

            assert data["webhook_config"]["has_token"] is False
            assert data["webhook_config"]["has_secret"] is False


if __name__ == "__main__":
    pytest.main(["-v", __file__])
