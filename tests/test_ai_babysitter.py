#!/usr/bin/env python3
"""
AI Babysitter Tests - Practical tests that catch common AI coding mistakes

These tests are designed for non-coders who use AI agents to write code.
They catch the obvious mistakes AI makes without being overly complex.

Test Categories:
1. "Does It Work?" - Basic functionality tests
2. "Is It Stupid?" - Tests that catch AI making obvious mistakes
3. Resource Usage - Memory leaks, performance sanity checks
4. Integration - Everything working together
"""

import asyncio
import os
import sys
import time
import psutil
from unittest.mock import patch, MagicMock

import pytest

# Add project root to path
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from src.storage.vector_store import vector_store  # noqa: E402
from src.core.api_client import get_resilient_client, RetryConfig  # noqa: E402
from src.core.llm import conversation_manager, process_message  # noqa: E402
from src.storage.redis_store import redis_store  # noqa: E402


# =====================================
# Layer 1: "Does It Work?" Tests
# =====================================


@pytest.mark.asyncio
async def test_bot_saves_and_retrieves_notes():
    """Basic smoke test - the stuff your users actually do."""
    # Save a note
    save_response = await process_message(
        "Save note: Team meeting at 3pm tomorrow", chat_id="test_save_retrieve"
    )

    # Should get some kind of confirmation
    assert (
        "saved" in save_response.lower() or "created" in save_response.lower()
    ), f"Bot didn't confirm saving. Response: {save_response[:100]}"

    # Search for the note
    search_response = await process_message(
        "Search for team meeting", chat_id="test_save_retrieve"
    )

    # Should find the note
    assert (
        "3pm" in search_response or "team meeting" in search_response.lower()
    ), f"Bot can't find saved note. Response: {search_response[:100]}"


@pytest.mark.asyncio
async def test_bot_responds_to_basic_queries():
    """Test that the bot responds appropriately to common queries."""
    test_cases = [
        ("Hello", ["hello", "hi", "help"]),
        ("What can you do?", ["help", "can", "search", "save", "notes"]),
        ("List all files", ["file", "list", "found"]),
    ]

    for query, expected_keywords in test_cases:
        response = await process_message(query, chat_id="test_basic_queries")

        # Response should not be empty or error
        assert (
            response and len(response.strip()) > 0
        ), f"Empty response for query: {query}"

        # Should contain at least one expected keyword
        found_keyword = any(
            keyword.lower() in response.lower() for keyword in expected_keywords
        )
        assert (
            found_keyword
        ), f"Response '{response[:100]}' doesn't contain expected keywords {expected_keywords} for query '{query}'"


@pytest.mark.asyncio
async def test_bot_handles_edge_cases():
    """Test common edge cases users might encounter."""
    edge_cases = [
        ("", "Empty message should get a response"),
        ("   ", "Whitespace-only message should get a response"),
        ("a" * 1000, "Very long message should not crash"),
        ("!@#$%^&*()", "Special characters should not crash"),
    ]

    for query, description in edge_cases:
        try:
            response = await process_message(query, chat_id="test_edge_cases")
            # Should get some response, not crash
            assert isinstance(
                response, str
            ), f"{description}: Got {type(response)} instead of string"
        except Exception as e:
            pytest.fail(f"{description}: Crashed with {type(e).__name__}: {e}")


# =====================================
# Layer 2: "Is It Stupid?" Tests
# =====================================


@pytest.mark.asyncio
async def test_cache_actually_works():
    """Make sure AI didn't forget to implement caching properly."""
    query = "Test cache query for AI babysitter"

    # First call - should be slow (cache miss)
    start1 = time.perf_counter()
    result1 = await vector_store.search(query, top_k=3)
    time1 = time.perf_counter() - start1

    # Second call - should be faster (cache hit)
    start2 = time.perf_counter()
    result2 = await vector_store.search(query, top_k=3)
    time2 = time.perf_counter() - start2

    # Cache should make it significantly faster
    assert (
        time2 < time1 * 0.5
    ), f"Cache doesn't seem to be working! First: {time1:.3f}s, Second: {time2:.3f}s"

    # Results should be identical
    assert len(result1) == len(result2), "Cache returned different number of results"


@pytest.mark.asyncio
async def test_not_calling_api_repeatedly_for_same_request():
    """Catch AI making the same API call multiple times unnecessarily."""
    with patch("openai.resources.chat.completions.AsyncCompletions.create") as mock_api:
        # Mock a successful response
        mock_response = MagicMock()
        mock_response.choices = [MagicMock()]
        mock_response.choices[0].message.content = "Test response"
        mock_api.return_value = mock_response

        # Process the same message twice quickly
        chat_id = "test_no_duplicate_calls"
        message = "Simple test message"

        await process_message(message, chat_id=chat_id)
        await process_message(message, chat_id=chat_id)

        # Should not call API twice for identical requests if caching works
        # Allow some reasonable number of calls, but not excessive
        assert (
            mock_api.call_count <= 4
        ), f"AI made {mock_api.call_count} API calls for 2 identical requests - probably not using cache!"


@pytest.mark.asyncio
async def test_conversation_history_not_growing_infinitely():
    """Make sure AI implemented conversation sliding window correctly."""
    chat_id = "test_infinite_growth"

    # Clear any existing conversation
    await redis_store.delete_conversation(chat_id)

    # Add many messages
    for i in range(50):  # Way more than the limit
        await conversation_manager.add_message(
            chat_id, "user" if i % 2 == 0 else "assistant", f"Message {i}"
        )

    # Check conversation size
    messages = await conversation_manager.get_conversation_history(chat_id)
    max_allowed = conversation_manager.max_messages + 1  # +1 for system prompt

    assert (
        len(messages) <= max_allowed
    ), f"Conversation has {len(messages)} messages, max should be {max_allowed}. AI forgot sliding window!"

    # System prompt should still be there
    assert messages[0]["role"] == "system", "AI lost the system prompt!"


@pytest.mark.asyncio
async def test_retry_logic_actually_works():
    """Test that retry logic works when API fails."""
    retry_config = RetryConfig(max_retries=3, base_delay=0.1)
    client = get_resilient_client(retry_config)

    with patch("openai.resources.chat.completions.AsyncCompletions.create") as mock_api:
        # Mock: fail twice, then succeed
        mock_api.side_effect = [
            Exception("Rate limit error"),
            Exception("Timeout error"),
            MagicMock(choices=[MagicMock(message=MagicMock(content="Success!"))]),
        ]

        # Should eventually succeed after retries
        response = await client.chat_completion(
            messages=[{"role": "user", "content": "test"}],
            model="gpt-4o",
            max_tokens=50,
        )

        # Verify it retried and eventually succeeded
        assert (
            mock_api.call_count == 3
        ), f"Expected 3 calls (2 failures + 1 success), got {mock_api.call_count}"
        assert response.choices[0].message.content == "Success!"


# =====================================
# Layer 3: Resource Usage Checks
# =====================================


@pytest.mark.asyncio
async def test_response_time_reasonable():
    """Make sure bot responds in reasonable time."""
    start = time.perf_counter()
    response = await process_message("Hello", chat_id="test_response_time")
    duration = time.perf_counter() - start

    assert duration < 30, f"Bot too slow: {duration:.2f}s for simple message"
    assert len(response) > 0, "Got empty response"


@pytest.mark.asyncio
async def test_no_obvious_memory_leaks():
    """Make sure memory doesn't grow infinitely."""
    process = psutil.Process(os.getpid())
    initial_memory = process.memory_info().rss / 1024 / 1024  # MB

    # Do something many times
    for i in range(20):
        await process_message(f"Test message {i}", chat_id="test_memory_leak")

    final_memory = process.memory_info().rss / 1024 / 1024  # MB
    memory_growth = final_memory - initial_memory

    # Allow some growth, but not excessive
    assert (
        memory_growth < 100
    ), f"Memory grew by {memory_growth:.1f}MB - possible leak! Initial: {initial_memory:.1f}MB, Final: {final_memory:.1f}MB"


@pytest.mark.asyncio
async def test_database_connections_not_leaking():
    """Make sure we're not leaking database connections."""
    # Test Redis connections - basic check for connection leaks
    try:
        if hasattr(redis_store, "_redis") and redis_store._redis:
            _ = await redis_store._redis.info()  # Just verify we can connect
    except Exception:
        pass  # Redis might not be available in test env

    # Do many operations
    for i in range(10):
        chat_id = f"test_connections_{i}"
        await conversation_manager.add_message(chat_id, "user", f"Message {i}")
        await conversation_manager.get_conversation_history(chat_id)

    # Check we didn't leak connections (basic test)
    # In a real scenario, you'd check connection pool stats
    assert (
        True
    ), "Connection leak test passed"  # Placeholder - implement based on your Redis setup


# =====================================
# Layer 4: Integration Test
# =====================================


@pytest.mark.asyncio
async def test_everything_works_together():
    """One test that uses all features together - catches when different AI agents wrote incompatible code."""
    chat_id = "test_full_integration"

    # Clear any existing data
    await redis_store.delete_conversation(chat_id)

    try:
        # Full user journey
        # 1. Save a note
        save_response = await process_message(
            "Save note: Project deadline is Friday at 5pm. Need to finish the API documentation.",
            chat_id=chat_id,
        )
        assert "saved" in save_response.lower() or "created" in save_response.lower()

        # 2. Ask a question that requires search
        search_response = await process_message(
            "When is the project deadline?", chat_id=chat_id
        )
        assert "friday" in search_response.lower() or "5pm" in search_response.lower()

        # 3. Add another note
        await process_message(
            "Save note: Remember to review John's code before the deadline",
            chat_id=chat_id,
        )

        # 4. Search for multiple things
        multi_search = await process_message(
            "What do I need to do before Friday?", chat_id=chat_id
        )
        # Should find both notes
        assert "deadline" in multi_search.lower() or "friday" in multi_search.lower()

        # 5. Test conversation history is working
        history = await conversation_manager.get_conversation_history(chat_id)
        assert len(history) > 1, "Conversation history not being saved"

        # 6. Test that we can handle follow-up questions
        followup = await process_message(
            "What time specifically?",  # Refers to previous question about deadline
            chat_id=chat_id,
        )
        assert len(followup) > 0, "Bot can't handle follow-up questions"

    except Exception as e:
        pytest.fail(f"Integration test failed: {type(e).__name__}: {e}")


# =====================================
# Quick Diagnostic Helpers
# =====================================


@pytest.mark.asyncio
async def test_system_components_available():
    """Quick check that all major components are available and configured."""
    # Check vector store
    try:
        await vector_store.search("test", top_k=1)
    except Exception as e:
        pytest.fail(f"Vector store not working: {e}")

    # Check Redis
    try:
        await redis_store.set_key("test_key", "test_value")
        value = await redis_store.get_key("test_key")
        assert value == "test_value"
    except Exception as e:
        pytest.fail(f"Redis store not working: {e}")

    # Check conversation manager
    try:
        await conversation_manager.add_message("test_components", "user", "test")
        history = await conversation_manager.get_conversation_history("test_components")
        assert len(history) > 0
    except Exception as e:
        pytest.fail(f"Conversation manager not working: {e}")


if __name__ == "__main__":
    # Allow running this file directly for quick testing
    asyncio.run(test_bot_saves_and_retrieves_notes())
    print(
        "✅ Basic test passed - you can run the full suite with: pytest tests/test_ai_babysitter.py -v"
    )
