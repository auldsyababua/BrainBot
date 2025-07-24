#!/usr/bin/env python3
"""
Test script for performance benchmarking features.

This script tests all the performance optimization features:
1. Vector search caching
2. LLM retry logic
3. Conversation sliding window
4. Performance metrics collection
"""

import asyncio
import os
import sys
import time

# Add project root to path
sys.path.insert(
    0, os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
)

from src.storage.vector_store import vector_store  # noqa: E402
from src.core.api_client import get_resilient_client, RetryConfig  # noqa: E402
from src.core.llm import conversation_manager, process_message  # noqa: E402
from src.core.benchmarks import get_performance_monitor  # noqa: E402
from src.storage.redis_store import redis_store  # noqa: E402


async def test_vector_cache():
    """Test vector search caching functionality."""
    print("\n🔍 Testing Vector Search Cache...")

    # First search - should be cache miss
    query = "How to implement OAuth2 authentication?"
    print(f"Query: {query}")

    start_time = time.perf_counter()
    results1 = await vector_store.search(query, top_k=3)
    time1 = time.perf_counter() - start_time
    print(f"First search: {len(results1)} results in {time1:.3f}s (cache miss)")

    # Second search - should be cache hit
    start_time = time.perf_counter()
    results2 = await vector_store.search(query, top_k=3)
    time2 = time.perf_counter() - start_time
    print(f"Second search: {len(results2)} results in {time2:.3f}s (cache hit)")

    # Cache should be significantly faster
    if time2 < time1 * 0.5:
        print("✅ Cache is working! Second search was significantly faster.")
    else:
        print("⚠️  Cache might not be working properly.")

    # Verify results are identical
    assert len(results1) == len(results2), "Cache returned different number of results"
    print("✅ Cache returns consistent results")


async def test_llm_retry():
    """Test LLM retry logic with simulated failures."""
    print("\n🔄 Testing LLM Retry Logic...")

    client = get_resilient_client(RetryConfig(max_retries=3))

    # Test with a simple completion
    try:
        response = await client.chat_completion(
            messages=[
                {"role": "system", "content": "You are a helpful assistant."},
                {"role": "user", "content": "Say 'Hello, retry test!'"},
            ],
            model="gpt-4o",
            temperature=0.5,
            max_tokens=50,
        )
        print(f"✅ LLM call successful: {response.choices[0].message.content}")
    except Exception as e:
        print(f"❌ LLM call failed: {e}")


async def test_conversation_sliding_window():
    """Test conversation history sliding window."""
    print("\n🪟 Testing Conversation Sliding Window...")

    chat_id = "test_sliding_window"

    # Reset conversation first
    await redis_store.delete_conversation(chat_id)

    # Add messages beyond the window size
    print(f"Adding messages (window size: {conversation_manager.max_messages})...")

    # Get initial conversation (should create with system prompt)
    messages = await conversation_manager.get_conversation_history(chat_id)
    print(f"Initial messages: {len(messages)}")

    # Add messages up to and beyond the limit
    for i in range(25):
        await conversation_manager.add_message(
            chat_id, "user" if i % 2 == 0 else "assistant", f"Test message {i}"
        )

    # Check final conversation size
    final_messages = await conversation_manager.get_conversation_history(chat_id)
    print(f"Final message count: {len(final_messages)}")
    print(
        f"Expected max: {conversation_manager.max_messages + 1} (including system prompt)"
    )

    # Verify sliding window is working
    if len(final_messages) <= conversation_manager.max_messages + 1:
        print("✅ Sliding window is working correctly")
    else:
        print("❌ Sliding window not enforcing message limit")

    # Check that system prompt is preserved
    if final_messages[0]["role"] == "system":
        print("✅ System prompt preserved")
    else:
        print("❌ System prompt lost!")

    # Get conversation stats
    stats = await conversation_manager.get_conversation_stats(chat_id)
    print(f"Conversation stats: {stats}")


async def test_performance_metrics():
    """Test performance metrics collection."""
    print("\n📊 Testing Performance Metrics...")

    monitor = get_performance_monitor()

    # Test a full message processing flow
    print("Processing a test message...")
    response = await process_message(
        "What is the capital of France?", chat_id="test_metrics"
    )
    print(f"Response received: {response[:100]}...")

    # Wait a moment for metrics to be recorded
    await asyncio.sleep(1)

    # Get performance summary
    summary = monitor.get_performance_summary(
        metric_names=[
            "vector_search_duration",
            "llm_call_duration",
            "benchmark_process_message",
            "conversation_size",
        ],
        time_range_minutes=5,
    )

    print("\nPerformance Summary:")
    for metric, data in summary.items():
        if isinstance(data, dict):
            print(f"\n{metric}:")
            for key, value in data.items():
                print(f"  {key}: {value}")
        else:
            print(f"{metric}: {data}")

    # Check cache metrics
    if "cache_hit_rate" in summary:
        print(f"\n✅ Cache hit rate: {summary['cache_hit_rate']:.2%}")

    if "total_tokens_used" in summary:
        print(f"✅ Total tokens used: {summary['total_tokens_used']}")


async def main():
    """Run all performance tests."""
    print("🚀 Starting Performance Tests...")
    print("=" * 50)

    try:
        # Test vector cache
        await test_vector_cache()

        # Test LLM retry logic
        await test_llm_retry()

        # Test conversation sliding window
        await test_conversation_sliding_window()

        # Test performance metrics
        await test_performance_metrics()

        print("\n" + "=" * 50)
        print("✅ All performance tests completed!")

    except Exception as e:
        print(f"\n❌ Test failed with error: {e}")
        import traceback

        traceback.print_exc()


if __name__ == "__main__":
    asyncio.run(main())
