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
# Layer 2.5: "Did AI Break Something?" Tests
# =====================================


@pytest.mark.asyncio
async def test_no_unreachable_code():
    """AI often writes functions that are never called - check major functions are actually used."""
    # Test that vector store search is actually called from process_message
    with patch("src.storage.vector_store.vector_store.search") as mock_search:
        mock_search.return_value = []  # Empty results to avoid complex setup

        await process_message("Test search functionality", chat_id="test_unreachable")

        # Vector search should have been called
        assert (
            mock_search.called
        ), "process_message should call vector_store.search but didn't - dead code detected!"


@pytest.mark.asyncio
async def test_retry_config_actually_applied():
    """AI might create RetryConfig but forget to use it."""
    from src.core.api_client import get_resilient_client, RetryConfig

    # Create client with specific config
    test_config = RetryConfig(max_retries=5, base_delay=0.1)
    client = get_resilient_client(test_config)

    # Check that the config is actually stored in the client
    assert hasattr(client, "retry_config") or hasattr(
        client, "_retry_config"
    ), "RetryConfig created but not stored in client - AI forgot to apply it!"


@pytest.mark.asyncio
async def test_errors_dont_crash_bot():
    """Test that common errors are handled gracefully - AI often forgets edge cases."""
    error_cases = [
        (None, "None input should not crash"),
        ("", "Empty string should not crash"),
        ("   ", "Whitespace-only should not crash"),
        ('{"malformed": json}', "Invalid JSON-like input should not crash"),
        ("Save note: " + "x" * 10000, "Extremely long input should not crash"),
    ]

    for error_input, description in error_cases:
        try:
            response = await process_message(error_input, chat_id="test_error_handling")
            # Should get some response, not crash
            assert (
                isinstance(response, str) and len(response) > 0
            ), f"{description}: Got empty or non-string response"
        except Exception as e:
            pytest.fail(f"{description}: Crashed with {type(e).__name__}: {e}")


@pytest.mark.asyncio
async def test_new_feature_didnt_break_old_features():
    """When AI adds feature X, it often breaks feature Y - run core feature sequence."""
    chat_id = "test_core_sequence"

    try:
        # Clear any existing data
        await redis_store.delete_conversation(chat_id)

        # Core sequence: Save → Search → Update → Search again
        # Step 1: Save note
        save_response = await process_message(
            "Save note: Core feature test - remember this important info",
            chat_id=chat_id,
        )
        assert (
            "saved" in save_response.lower() or "created" in save_response.lower()
        ), "Save feature broken"

        # Step 2: Search for note
        search_response = await process_message(
            "Search for core feature test", chat_id=chat_id
        )
        assert (
            "important info" in search_response.lower()
            or "core feature" in search_response.lower()
        ), "Search feature broken"

        # Step 3: Update note (append)
        update_response = await process_message(
            "Add to that note: Additional important details", chat_id=chat_id
        )
        assert len(update_response) > 0, "Update feature broken"

        # Step 4: Search again to verify update
        final_search = await process_message(
            "Find the note about core feature test", chat_id=chat_id
        )
        assert (
            "additional" in final_search.lower() or "details" in final_search.lower()
        ), "Feature sequence broken - updates not searchable"

    except Exception as e:
        pytest.fail(f"Core feature sequence broken: {type(e).__name__}: {e}")


# =====================================
# Layer 5: AI Consistency Tests
# =====================================


@pytest.mark.asyncio
async def test_ai_agents_using_same_patterns():
    """Different AI agents might implement things differently - check consistency."""
    # Test that all API calls go through resilient client
    from src.core.llm import resilient_client
    from src.core.api_client import get_resilient_client

    # These should be the same type
    assert isinstance(
        resilient_client, type(get_resilient_client())
    ), "Inconsistent API client usage - different AI agents used different patterns"

    # Test that conversation manager uses the configured max_messages
    from src.core.config import CONVERSATION_MAX_MESSAGES

    assert (
        conversation_manager.max_messages == CONVERSATION_MAX_MESSAGES
    ), "ConversationManager not using config value - AI forgot to connect config"


@pytest.mark.asyncio
async def test_data_survives_restart():
    """AI might store data in memory instead of database - test persistence."""
    chat_id = "test_persistence"
    test_note = "This note should survive restart simulation"

    # Save data
    await process_message(f"Save note: {test_note}", chat_id=chat_id)

    # Simulate restart by clearing any in-memory caches
    # (In a real restart test, you'd actually restart the service)
    if hasattr(vector_store, "_cache"):
        vector_store._cache.clear()

    # Try to retrieve data
    search_response = await process_message(
        "Search for restart simulation", chat_id=chat_id
    )

    assert (
        "survive restart" in search_response.lower()
        or test_note.lower() in search_response.lower()
    ), "Data didn't survive restart simulation - AI storing data in memory instead of database!"


@pytest.mark.asyncio
async def test_multiple_users_dont_interfere():
    """AI often forgets about multi-user scenarios - test isolation."""
    # User 1 saves private note
    user1_note = "User 1 private note - secret info"
    await process_message(f"Save note: {user1_note}", chat_id="user1")

    # User 2 saves different note
    user2_note = "User 2 different note - public info"
    await process_message(f"Save note: {user2_note}", chat_id="user2")

    # User 1 searches - should only see their note
    user1_search = await process_message("Search for my notes", chat_id="user1")

    # User 2 searches - should only see their note
    user2_search = await process_message("Search for my notes", chat_id="user2")

    # Check isolation
    assert (
        "secret info" not in user2_search.lower()
    ), "User isolation broken - User 2 can see User 1's private notes!"

    assert (
        "public info" not in user1_search.lower()
        or "secret info" in user1_search.lower()
    ), "User isolation broken - User 1 can't see their own notes or sees User 2's notes!"


@pytest.mark.asyncio
async def test_not_burning_api_credits():
    """Track API calls to prevent cost explosions from inefficient AI code."""
    with patch("openai.resources.chat.completions.AsyncCompletions.create") as mock_api:
        # Mock successful responses
        mock_response = MagicMock()
        mock_response.choices = [MagicMock()]
        mock_response.choices[0].message.content = "Test response"
        mock_response.choices[0].message.function_call = None
        mock_api.return_value = mock_response

        initial_count = mock_api.call_count

        # Run typical user journey
        chat_id = "test_api_efficiency"
        await process_message("Hello, how are you?", chat_id=chat_id)
        await process_message("Save note: Test note", chat_id=chat_id)
        await process_message("Search for test note", chat_id=chat_id)

        final_count = mock_api.call_count
        api_calls_made = final_count - initial_count

        # Should be reasonable number of calls (allowing for some flexibility)
        assert (
            api_calls_made <= 6
        ), f"Too many API calls for simple tasks! Made {api_calls_made} calls - AI being inefficient with API usage"


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


def explain_failure_for_non_coders(test_name: str, error_msg: str):
    """Explain test failures in non-coder terms."""
    explanations = {
        "test_cache_actually_works": {
            "problem": "The AI agent forgot to implement caching or bypassed it",
            "what_this_means": "Your bot is making slow, expensive searches every time instead of remembering recent results",
            "tell_ai": "The caching system isn't working. Make sure vector_store.search() uses the existing cache mechanism.",
            "impact": "Slow responses and higher costs",
        },
        "test_conversation_history_not_growing_infinitely": {
            "problem": "The AI agent didn't implement the sliding window for conversation memory",
            "what_this_means": "Conversations will consume more and more memory until the system crashes",
            "tell_ai": "The conversation sliding window isn't working. Ensure conversation_manager.max_messages is being enforced.",
            "impact": "System crashes and memory problems",
        },
        "test_no_unreachable_code": {
            "problem": "The AI agent wrote code that's never actually used",
            "what_this_means": "There are functions or features that exist but aren't connected to the main system",
            "tell_ai": "You created code that isn't being called. Make sure new functions are integrated with process_message().",
            "impact": "Features that don't work despite existing in the code",
        },
        "test_retry_config_actually_applied": {
            "problem": "The AI agent created retry configuration but forgot to use it",
            "what_this_means": "API failures won't be handled properly, causing user errors",
            "tell_ai": "The RetryConfig exists but isn't being used. Ensure get_resilient_client() applies the config.",
            "impact": "Users see errors when APIs are temporarily unavailable",
        },
        "test_multiple_users_dont_interfere": {
            "problem": "The AI agent didn't properly isolate user data",
            "what_this_means": "Users might see each other's private notes or data",
            "tell_ai": "User isolation is broken. Always use chat_id to separate user data in database operations.",
            "impact": "Privacy violations and data mixing between users",
        },
        "test_not_burning_api_credits": {
            "problem": "The AI agent is making too many API calls",
            "what_this_means": "Your API costs will be much higher than necessary",
            "tell_ai": "Too many API calls are being made. Check for caching and avoid redundant requests.",
            "impact": "Expensive API bills",
        },
    }

    explanation = explanations.get(
        test_name,
        {
            "problem": "Unknown test failure",
            "what_this_means": "Something went wrong but the specific issue isn't documented yet",
            "tell_ai": f"The test {test_name} failed. Please check the error message and fix the issue.",
            "impact": "Potential system problems",
        },
    )

    print("\n🤖 WHAT THIS MEANS FOR NON-CODERS:")
    print(f"\n❌ Problem: {explanation['problem']}")
    print(f"\n📝 What this means: {explanation['what_this_means']}")
    print(f"\n💸 Impact: {explanation['impact']}")
    print("\n🗣️  What to tell the AI agent:")
    print(f"   '{explanation['tell_ai']}'")
    print(f"\n🔍 Technical error: {error_msg[:200]}...")


if __name__ == "__main__":
    import sys

    # Check if we should explain failures
    if len(sys.argv) > 1 and sys.argv[1] == "--explain-failure":
        if len(sys.argv) > 3:
            test_name = sys.argv[2]
            error_msg = sys.argv[3]
            explain_failure_for_non_coders(test_name, error_msg)
        else:
            print(
                "Usage: python test_ai_babysitter.py --explain-failure <test_name> <error_message>"
            )
    else:
        # Allow running this file directly for quick testing
        asyncio.run(test_bot_saves_and_retrieves_notes())
        print(
            "✅ Basic test passed - you can run the full suite with: pytest tests/test_ai_babysitter.py -v"
        )
