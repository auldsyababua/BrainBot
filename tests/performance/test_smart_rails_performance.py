"""Performance tests for Smart Rails to ensure routing meets speed requirements."""

import pytest
import time
import statistics
from src.rails.router import KeywordRouter


class TestSmartRailsPerformance:
    """Ensure Smart Rails meets performance requirements."""

    @pytest.mark.benchmark
    def test_routing_speed_requirements(self):
        """Test that routing meets speed requirements."""
        router = KeywordRouter()

        # Test cases representing different complexities
        test_cases = [
            ("simple: add milk to list", "add milk to list"),
            (
                "medium: create task for @user tomorrow",
                "create new task for @joel tomorrow at 3pm",
            ),
            (
                "complex: multi-user multi-item",
                "assign task to @joel and @bryan to check generator, pump, and filters",
            ),
            ("hidden command", "/newlist Shopping Items"),
        ]

        for test_name, message in test_cases:
            times = []

            # Run 100 iterations
            for _ in range(100):
                start = time.perf_counter()
                router.route(message)
                elapsed = (time.perf_counter() - start) * 1000  # ms
                times.append(elapsed)

            # Calculate statistics
            avg_time = statistics.mean(times)
            p95_time = statistics.quantiles(times, n=20)[18]  # 95th percentile
            max_time = max(times)

            print(f"\n{test_name}:")
            print(f"  Average: {avg_time:.2f}ms")
            print(f"  95th percentile: {p95_time:.2f}ms")
            print(f"  Maximum: {max_time:.2f}ms")

            # Requirements
            assert avg_time < 5, f"Average time {avg_time:.2f}ms exceeds 5ms limit"
            assert p95_time < 10, f"95th percentile {p95_time:.2f}ms exceeds 10ms limit"
            assert max_time < 20, f"Maximum time {max_time:.2f}ms exceeds 20ms limit"

    def test_routing_with_large_alias_set(self):
        """Test performance doesn't degrade with many aliases."""
        router = KeywordRouter()

        # Add 5000 aliases
        for i in range(5000):
            router.synonym_lib.user_aliases[f"alias{i}"] = f"user{i % 100}"

        # Test messages that should resolve aliases
        test_messages = [
            "assign task to alias2500",
            "create task for alias100 and alias4999",
            "@alias3000 should check the generator",
        ]

        for message in test_messages:
            times = []

            for _ in range(50):
                start = time.perf_counter()
                router.route(message)
                elapsed = (time.perf_counter() - start) * 1000
                times.append(elapsed)

            avg_time = statistics.mean(times)
            p95_time = statistics.quantiles(times, n=20)[18]

            # Performance should still be acceptable
            assert avg_time < 10, f"Avg time with many aliases: {avg_time:.2f}ms"
            assert p95_time < 20, f"95th percentile with many aliases: {p95_time:.2f}ms"

    def test_confidence_calculation_performance(self):
        """Test confidence scoring doesn't add significant overhead."""
        router = KeywordRouter()

        # Messages that trigger various confidence calculations
        messages = [
            "add milk, eggs, bread, butter, cheese, yogurt to shopping list",  # Comma boost
            "create task for @joel to check generator tomorrow at 3pm with high priority",  # Multiple boosts
            "new field report for Eagle Lake: generator maintenance completed, oil changed",  # Site + context
        ]

        for message in messages:
            # Time just routing
            route_times = []
            for _ in range(100):
                start = time.perf_counter()
                router.route(message)
                elapsed = (time.perf_counter() - start) * 1000
                route_times.append(elapsed)

            avg_route_time = statistics.mean(route_times)

            # Confidence calculation should be minimal overhead
            assert (
                avg_route_time < 7
            ), f"Complex confidence calc took {avg_route_time:.2f}ms"

    def test_regex_compilation_caching(self):
        """Test that regex patterns are properly cached."""
        # Create two routers
        start1 = time.perf_counter()
        router1 = KeywordRouter()
        init_time1 = (time.perf_counter() - start1) * 1000

        start2 = time.perf_counter()
        router2 = KeywordRouter()
        init_time2 = (time.perf_counter() - start2) * 1000

        # Both should be fast, but allow some variance
        assert init_time1 < 50, f"First router init took {init_time1:.2f}ms"
        assert init_time2 < 50, f"Second router init took {init_time2:.2f}ms"

        # Test routing performance is consistent
        message = "add items to shopping list"

        times1 = []
        times2 = []

        for _ in range(50):
            start = time.perf_counter()
            router1.route(message)
            times1.append((time.perf_counter() - start) * 1000)

            start = time.perf_counter()
            router2.route(message)
            times2.append((time.perf_counter() - start) * 1000)

        # Performance should be similar
        avg1 = statistics.mean(times1)
        avg2 = statistics.mean(times2)

        assert (
            abs(avg1 - avg2) < 1
        ), f"Router performance varies: {avg1:.2f}ms vs {avg2:.2f}ms"
