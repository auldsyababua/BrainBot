"""
Test configuration for environment-aware testing.

This module provides configuration for tests to handle different environments
(CI, staging, production) appropriately. Tests should import from here to
determine what to run, skip, or mock.
"""

import os
import pytest
from functools import wraps

# Environment detection
IS_CI = os.getenv("CI") == "true" or os.getenv("GITHUB_ACTIONS") == "true"
IS_LOCAL = not IS_CI and os.getenv("LOCAL_DEV") == "true"

# Service availability checks
HAS_SUPABASE = bool(os.getenv("SUPABASE_URL")) and bool(os.getenv("SUPABASE_ANON_KEY"))
HAS_TELEGRAM = bool(os.getenv("TELEGRAM_BOT_TOKEN"))
HAS_OPENAI = bool(os.getenv("OPENAI_API_KEY"))
HAS_REDIS = bool(os.getenv("REDIS_URL"))
HAS_NEO4J = bool(os.getenv("NEO4J_URL"))

# Test categories that should run in CI
CI_TEST_CATEGORIES = [
    "unit",  # Always run unit tests
    "smoke",  # Basic functionality tests
    "security",  # Security validation tests
]

# Test categories that need external services
INTEGRATION_CATEGORIES = [
    "integration",  # Full integration tests
    "e2e",  # End-to-end tests
    "performance",  # Performance benchmarks
]


def requires_service(service_name):
    """
    Decorator to skip tests if required service is not available.

    Usage:
        @requires_service("supabase")
        def test_database_operation():
            pass
    """

    def decorator(func):
        service_map = {
            "supabase": HAS_SUPABASE,
            "telegram": HAS_TELEGRAM,
            "openai": HAS_OPENAI,
            "redis": HAS_REDIS,
            "neo4j": HAS_NEO4J,
        }

        if not service_map.get(service_name, False):
            return pytest.mark.skip(reason=f"{service_name} not available in current environment")(
                func
            )
        return func

    return decorator


def ci_safe(use_mock=True):
    """
    Decorator to make tests CI-safe by using mocks when in CI.

    Usage:
        @ci_safe(use_mock=True)
        def test_external_api_call(mock_api):
            # mock_api is automatically injected in CI
            pass
    """

    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            if IS_CI and use_mock:
                # Inject mocks for external services
                kwargs.update(
                    {
                        "mock_supabase": MockSupabase() if not HAS_SUPABASE else None,
                        "mock_telegram": MockTelegram() if not HAS_TELEGRAM else None,
                        "mock_openai": MockOpenAI() if not HAS_OPENAI else None,
                    }
                )
            return func(*args, **kwargs)

        return wrapper

    return decorator


class MockSupabase:
    """Mock Supabase client for CI testing."""

    def table(self, name):
        return self

    def select(self, *args):
        return self

    def insert(self, data):
        return self

    def update(self, data):
        return self

    def delete(self):
        return self

    def execute(self):
        return {"data": [], "error": None}


class MockTelegram:
    """Mock Telegram bot for CI testing."""

    async def send_message(self, chat_id, text, **kwargs):
        return {"ok": True, "result": {"message_id": 123, "chat": {"id": chat_id}}}

    async def answer_callback_query(self, callback_query_id, **kwargs):
        return {"ok": True}


class MockOpenAI:
    """Mock OpenAI client for CI testing."""

    def __init__(self):
        self.chat = self.Chat()

    class Chat:
        class Completions:
            async def create(self, **kwargs):
                return {"choices": [{"message": {"content": "Mocked AI response for testing"}}]}

        def __init__(self):
            self.completions = self.Completions()


# Test environment setup
def setup_ci_environment():
    """Set up mock environment variables for CI."""
    if IS_CI:
        defaults = {
            "SUPABASE_URL": "http://mock-supabase:54321",
            "SUPABASE_ANON_KEY": "mock-anon-key",
            "TELEGRAM_BOT_TOKEN": "0000000000:MOCK_TOKEN_FOR_CI_TESTING",
            "OPENAI_API_KEY": "sk-mock-testing-key",
            "ENVIRONMENT": "ci_test",
        }

        for key, value in defaults.items():
            if not os.getenv(key):
                os.environ[key] = value
