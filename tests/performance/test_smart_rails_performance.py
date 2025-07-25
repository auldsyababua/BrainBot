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

        # EDGE CASE TESTING ADDITIONS

        # Test 1: Null/None inputs
        with pytest.raises((ValueError, AttributeError, TypeError)):
            router.route(None)

        # Test 2: Empty string performance
        empty_times = []
        for _ in range(100):
            start = time.perf_counter()
            result = router.route("")
            elapsed = (time.perf_counter() - start) * 1000
            empty_times.append(elapsed)

        avg_empty = statistics.mean(empty_times)
        assert avg_empty < 5, f"Empty string routing too slow: {avg_empty:.2f}ms"

        # Test 3: Extremely long messages
        extremely_long = (
            "add " + ", ".join([f"item{i}" for i in range(1000)]) + " to list"
        )
        long_times = []
        for _ in range(10):  # Fewer iterations for long messages
            start = time.perf_counter()
            result = router.route(extremely_long)
            elapsed = (time.perf_counter() - start) * 1000
            long_times.append(elapsed)

        avg_long = statistics.mean(long_times)
        assert avg_long < 50, f"Long message routing too slow: {avg_long:.2f}ms"

        # Test 4: Special characters and unicode
        special_cases = [
            "add café, naïve, résumé to list",  # Unicode
            "create task for 用户 and المستخدم",  # Non-latin
            "add item\x00with\x00nulls",  # Null bytes
            "create task\n\rwith\tnewlines\fand\vvertical\btabs",  # Control chars
            "add <script>alert(1)</script> to list",  # HTML/XSS
            "task'; DROP TABLE tasks--",  # SQL injection
        ]

        for special_msg in special_cases:
            special_times = []
            for _ in range(50):
                start = time.perf_counter()
                result = router.route(special_msg)
                elapsed = (time.perf_counter() - start) * 1000
                special_times.append(elapsed)

            avg_special = statistics.mean(special_times)
            assert (
                avg_special < 10
            ), f"Special char routing slow for '{special_msg[:30]}...': {avg_special:.2f}ms"

        # Test 5: Repeated routing (warm cache)
        cache_test_msg = "add milk to shopping list"
        cold_start = time.perf_counter()
        router.route(cache_test_msg)
        cold_time = (time.perf_counter() - cold_start) * 1000

        # Warm runs
        warm_times = []
        for _ in range(100):
            start = time.perf_counter()
            router.route(cache_test_msg)
            elapsed = (time.perf_counter() - start) * 1000
            warm_times.append(elapsed)

        avg_warm = statistics.mean(warm_times)
        # Warm runs should be as fast or faster
        assert (
            avg_warm <= cold_time * 1.5
        ), f"No cache benefit: cold={cold_time:.2f}ms, warm={avg_warm:.2f}ms"

        # Test 6: Invalid command formats
        invalid_commands = [
            "//double_slash command",
            "/123numeric",
            "/special!@#$%^&*()",
            "////multiple_slashes",
        ]

        for invalid_cmd in invalid_commands:
            invalid_times = []
            for _ in range(50):
                start = time.perf_counter()
                result = router.route(invalid_cmd)
                elapsed = (time.perf_counter() - start) * 1000
                invalid_times.append(elapsed)

            avg_invalid = statistics.mean(invalid_times)
            assert avg_invalid < 5, f"Invalid command routing slow: {avg_invalid:.2f}ms"

    def test_routing_with_large_alias_set_properties(self):
        """Test routing behavior with many aliases using property validation."""
        router = KeywordRouter()

        # Create test data without assuming implementation
        num_aliases = 1000
        aliases = {}

        # Create diverse alias patterns
        patterns = [
            ("team_", "Engineering team members"),
            ("dept_", "Department personnel"),
            ("contractor_", "External contractors"),
            ("bot_", "Automated systems"),
            ("admin_", "Administrators"),
        ]

        # Build aliases with realistic distribution
        alias_to_user = {}
        user_counts = {}

        for i in range(num_aliases):
            # Rotate through patterns
            pattern, _ = patterns[i % len(patterns)]
            alias = f"{pattern}{i}"

            # Assign to users in a way that creates realistic distribution
            # Some users get many aliases, some get few
            if i < 100:
                user = f"power_user_{i % 10}"  # 10 power users
            elif i < 500:
                user = f"regular_user_{i % 50}"  # 50 regular users
            else:
                user = f"occasional_user_{i % 200}"  # 200 occasional users

            alias_to_user[alias] = user
            user_counts[user] = user_counts.get(user, 0) + 1

        router.synonym_lib.user_aliases = alias_to_user

        # Test invariants that should hold regardless of implementation

        # Property 1: Alias resolution should be consistent
        test_aliases = ["team_50", "dept_150", "bot_600", "admin_999"]
        resolved_users = {}

        for alias in test_aliases:
            if alias in alias_to_user:
                # Route multiple times to check consistency
                results = []
                for _ in range(5):
                    msg = f"assign task to {alias}"
                    result = router.route(msg)
                    if result.target_users:
                        results.append(tuple(sorted(result.target_users)))

                # All resolutions should be identical
                assert (
                    len(set(results)) <= 1
                ), f"Inconsistent alias resolution for {alias}"

                if results:
                    resolved_users[alias] = results[0]

        # Property 2: Performance should scale reasonably
        time_measurements = []

        # Test with varying message complexities
        test_messages = [
            f"simple task for {test_aliases[0]}",
            f"assign to {test_aliases[1]} and {test_aliases[2]}",
            f"complex task for @{test_aliases[0]}, @{test_aliases[1]}, and @{test_aliases[3]} with high priority",
        ]

        for msg in test_messages:
            times = []
            for _ in range(30):
                start = time.perf_counter()
                result = router.route(msg)
                elapsed = (time.perf_counter() - start) * 1000
                times.append(elapsed)

            avg_time = statistics.mean(times)
            time_measurements.append(avg_time)

            # Performance requirement
            assert (
                avg_time < 15
            ), f"Routing too slow with many aliases: {avg_time:.2f}ms"

        # Property 3: Complex messages shouldn't be disproportionately slow
        simple_time = time_measurements[0]
        complex_time = time_measurements[2]

        # Complex messages can be slower but not by huge factor
        assert (
            complex_time < simple_time * 5
        ), f"Complex messages too slow: {complex_time:.2f}ms vs {simple_time:.2f}ms"

        # Property 4: Test edge cases
        edge_cases = [
            "task for nonexistent_alias_xyz",  # Non-existent alias
            f"task for {test_aliases[0]} {test_aliases[0]} {test_aliases[0]}",  # Repeated alias
            f"@@@{test_aliases[1]}",  # Multiple @ symbols
            "task for " + " ".join(test_aliases[:10]),  # Many aliases at once
        ]

        for edge_case in edge_cases:
            start = time.perf_counter()
            result = router.route(edge_case)
            elapsed = (time.perf_counter() - start) * 1000

            # Should handle edge cases efficiently
            assert elapsed < 20, f"Edge case too slow: {edge_case[:50]}..."
            assert result is not None, "Should handle edge cases gracefully"

        # Property 5: Verify no memory leaks with repeated routing
        import gc

        gc.collect()
        initial_objects = len(gc.get_objects())

        # Route many messages
        for i in range(100):
            router.route(f"task for team_{i % num_aliases}")

        gc.collect()
        final_objects = len(gc.get_objects())

        # Object count shouldn't grow significantly
        object_growth = final_objects - initial_objects
        assert (
            object_growth < 1000
        ), f"Possible memory leak: {object_growth} new objects"

        # EDGE CASE TESTING ADDITIONS

        # Test 1: Null/None in aliases
        router_null = KeywordRouter()
        router_null.synonym_lib.user_aliases = {
            None: "null_user",
            "": "empty_user",
            "normal": None,
            "user1": "",
        }

        # Should handle null aliases gracefully
        for test_input in [None, "", "normal", "user1"]:
            try:
                result = router_null.route(f"task for {test_input}")
                assert result is not None
            except (ValueError, AttributeError, TypeError):
                pass  # Null handling may raise exceptions

        # Test 2: Circular alias references
        router_circular = KeywordRouter()
        router_circular.synonym_lib.user_aliases = {
            "alias1": "alias2",
            "alias2": "alias3",
            "alias3": "alias1",  # Circular
            "alias4": "alias4",  # Self-reference
        }

        # Should not hang on circular references
        start = time.perf_counter()
        result = router_circular.route("task for alias1")
        elapsed = (time.perf_counter() - start) * 1000
        assert elapsed < 50, f"Circular alias resolution too slow: {elapsed:.2f}ms"

        # Test 3: Unicode and special characters in aliases
        router_unicode = KeywordRouter()
        special_aliases = {
            "café_user": "user1",
            "用户": "user2",
            "emoji_🎉": "user3",
            "tab\tuser": "user4",
            "newline\nuser": "user5",
            "<script>xss</script>": "user6",
            "sql'; DROP--": "user7",
        }
        router_unicode.synonym_lib.user_aliases = special_aliases

        for alias in special_aliases:
            start = time.perf_counter()
            result = router_unicode.route(f"task for {alias}")
            elapsed = (time.perf_counter() - start) * 1000
            assert elapsed < 15, f"Unicode alias routing slow: {elapsed:.2f}ms"

        # Test 4: Extreme alias counts
        router_extreme = KeywordRouter()
        extreme_aliases = {}

        # One user with many aliases
        for i in range(500):
            extreme_aliases[f"alias_{i}"] = "power_user"

        # Many users with one alias each
        for i in range(500, 1500):
            extreme_aliases[f"alias_{i}"] = f"user_{i}"

        router_extreme.synonym_lib.user_aliases = extreme_aliases

        # Performance with skewed distribution
        test_messages = [
            "task for alias_100",  # Power user alias
            "task for alias_1000",  # Individual user
            "task for alias_0 and alias_999",  # Mixed
        ]

        for msg in test_messages:
            times = []
            for _ in range(30):
                start = time.perf_counter()
                result = router_extreme.route(msg)
                elapsed = (time.perf_counter() - start) * 1000
                times.append(elapsed)

            avg_time = statistics.mean(times)
            assert avg_time < 20, f"Extreme alias count slow: {avg_time:.2f}ms"

        # Test 5: Concurrent alias modifications
        import threading

        router_concurrent = KeywordRouter()
        router_concurrent.synonym_lib.user_aliases = {"base": "user"}
        errors = []

        def modify_aliases(thread_id):
            try:
                for i in range(100):
                    # Add alias
                    router_concurrent.synonym_lib.user_aliases[f"t{thread_id}_a{i}"] = (
                        f"user_{thread_id}"
                    )
                    # Route with it
                    router_concurrent.route(f"task for t{thread_id}_a{i}")
                    # Remove it
                    if (
                        f"t{thread_id}_a{i}"
                        in router_concurrent.synonym_lib.user_aliases
                    ):
                        del router_concurrent.synonym_lib.user_aliases[
                            f"t{thread_id}_a{i}"
                        ]
            except Exception as e:
                errors.append(e)

        threads = [threading.Thread(target=modify_aliases, args=(i,)) for i in range(5)]
        for t in threads:
            t.start()
        for t in threads:
            t.join()

        # Should handle concurrent modifications
        assert (
            len(errors) < 5
        ), f"Too many errors during concurrent access: {len(errors)}"

        # Test 6: Case sensitivity edge cases
        router_case = KeywordRouter()
        router_case.synonym_lib.user_aliases = {
            "JoEl": "user1",
            "joel": "user2",
            "JOEL": "user3",
            "Joel": "user4",  # Added another case variant
        }

        case_tests = ["JoEl", "joel", "JOEL", "jOeL", "Joel"]
        results = {}

        for name in case_tests:
            result = router_case.route(f"task for {name}")
            if result.target_users:
                results[name] = tuple(sorted(result.target_users))

        # Verify case handling is consistent
        assert len(results) > 0, "Should resolve at least some aliases"

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

        # EDGE CASE TESTING ADDITIONS

        # Test 1: Null/None confidence inputs
        with pytest.raises((ValueError, AttributeError, TypeError)):
            router.route(None)

        # Test 2: Empty string confidence
        empty_times = []
        for _ in range(100):
            start = time.perf_counter()
            result = router.route("")
            elapsed = (time.perf_counter() - start) * 1000
            empty_times.append(elapsed)

        avg_empty = statistics.mean(empty_times)
        assert avg_empty < 5, f"Empty string confidence calc slow: {avg_empty:.2f}ms"

        # Verify confidence is low for empty input
        result = router.route("")
        assert result.confidence < 0.1 or result.operation is None

        # Test 3: Maximum boost scenarios
        max_boost_messages = [
            # Multiple boost factors combined
            "@joel @bryan @user3 task tomorrow at 3pm high priority urgent /tnr",
            # Many items with commas
            "add " + ", ".join([f"item{i}" for i in range(100)]) + " to shopping list",
            # Multiple sites mentioned
            "field report for Eagle Lake, Crockett, Mathis with incident urgent high priority",
        ]

        for msg in max_boost_messages:
            boost_times = []
            for _ in range(50):
                start = time.perf_counter()
                result = router.route(msg)
                elapsed = (time.perf_counter() - start) * 1000
                boost_times.append(elapsed)

            avg_boost = statistics.mean(boost_times)
            assert avg_boost < 15, f"Max boost calc slow: {avg_boost:.2f}ms"
            # Should have high confidence
            assert result.confidence > 0.7

        # Test 4: Conflicting confidence signals
        conflicting_messages = [
            "delete create add remove list task field report",  # Multiple entities
            "assign to nobody and everybody",  # Contradictory
            "/tnr /lists /fr all commands",  # Multiple commands
        ]

        for msg in conflicting_messages:
            conflict_times = []
            for _ in range(50):
                start = time.perf_counter()
                result = router.route(msg)
                elapsed = (time.perf_counter() - start) * 1000
                conflict_times.append(elapsed)

            avg_conflict = statistics.mean(conflict_times)
            assert avg_conflict < 10, f"Conflicting signals slow: {avg_conflict:.2f}ms"

        # Test 5: Unicode and special chars in confidence calc
        special_confidence = [
            "café résumé naïve task",  # Accented chars
            "任务 for 用户 with 优先级",  # Chinese
            "task\x00with\x00nulls\x00",  # Null bytes
            "<confidence>0.99</confidence>",  # HTML-like
            "confidence'; DROP TABLE--",  # SQL injection
        ]

        for msg in special_confidence:
            special_times = []
            for _ in range(50):
                start = time.perf_counter()
                result = router.route(msg)
                elapsed = (time.perf_counter() - start) * 1000
                special_times.append(elapsed)

            avg_special = statistics.mean(special_times)
            assert (
                avg_special < 10
            ), f"Special char confidence slow: {avg_special:.2f}ms"

        # Test 6: Performance degradation over time
        degradation_msg = "create task for @user tomorrow at 3pm"
        time_buckets = []

        for bucket in range(5):
            bucket_times = []
            for _ in range(100):
                start = time.perf_counter()
                result = router.route(degradation_msg)
                elapsed = (time.perf_counter() - start) * 1000
                bucket_times.append(elapsed)
            time_buckets.append(statistics.mean(bucket_times))

        # Check for performance degradation
        first_bucket = time_buckets[0]
        last_bucket = time_buckets[-1]

        assert (
            last_bucket < first_bucket * 1.5
        ), f"Performance degraded: {first_bucket:.2f}ms -> {last_bucket:.2f}ms"

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

        # EDGE CASE TESTING ADDITIONS

        # Test 1: Many routers created rapidly
        router_creation_times = []
        routers = []

        for i in range(20):
            start = time.perf_counter()
            router = KeywordRouter()
            elapsed = (time.perf_counter() - start) * 1000
            router_creation_times.append(elapsed)
            routers.append(router)

        # Creation time should be consistent (caching benefit)
        first_five_avg = statistics.mean(router_creation_times[:5])
        last_five_avg = statistics.mean(router_creation_times[-5:])

        assert (
            last_five_avg <= first_five_avg * 2
        ), f"Router creation slowing down: {first_five_avg:.2f}ms -> {last_five_avg:.2f}ms"

        # Test 2: Regex patterns with special characters
        special_patterns = [
            "task for user@domain.com",  # Email-like
            "add item (with parens)",  # Parentheses
            "create [bracketed] list",  # Brackets
            "field report: line1\nline2",  # Newlines
            "task with $pecial ch@rs!",  # Special chars
            "regex .* test .+",  # Regex metacharacters
        ]

        router_special = KeywordRouter()

        for pattern in special_patterns:
            pattern_times = []
            for _ in range(50):
                start = time.perf_counter()
                result = router_special.route(pattern)
                elapsed = (time.perf_counter() - start) * 1000
                pattern_times.append(elapsed)

            avg_pattern = statistics.mean(pattern_times)
            assert (
                avg_pattern < 10
            ), f"Special pattern slow: '{pattern}' took {avg_pattern:.2f}ms"

        # Test 3: Router state isolation with regex
        router_a = KeywordRouter()
        router_b = KeywordRouter()

        # Heavily use one router
        for _ in range(1000):
            router_a.route("add many items to list")

        # Second router should still be fast
        fresh_times = []
        for _ in range(100):
            start = time.perf_counter()
            router_b.route("simple message")
            elapsed = (time.perf_counter() - start) * 1000
            fresh_times.append(elapsed)

        avg_fresh = statistics.mean(fresh_times)
        assert (
            avg_fresh < 5
        ), f"Fresh router slow after heavy use of another: {avg_fresh:.2f}ms"

        # Test 4: Memory efficiency with many routers
        import gc

        gc.collect()
        initial_memory = len(gc.get_objects())

        # Create and destroy many routers
        for _ in range(100):
            temp_router = KeywordRouter()
            temp_router.route("test message")
            del temp_router

        gc.collect()
        final_memory = len(gc.get_objects())

        memory_growth = final_memory - initial_memory
        assert (
            memory_growth < 500
        ), f"Memory leak detected: {memory_growth} objects remain"

        # Test 5: Concurrent router creation
        import threading

        creation_errors = []
        created_routers = []

        def create_router():
            try:
                router = KeywordRouter()
                result = router.route("test concurrent creation")
                created_routers.append((router, result))
            except Exception as e:
                creation_errors.append(e)

        threads = [threading.Thread(target=create_router) for _ in range(10)]

        start_concurrent = time.perf_counter()
        for t in threads:
            t.start()
        for t in threads:
            t.join()
        concurrent_time = (time.perf_counter() - start_concurrent) * 1000

        assert (
            len(creation_errors) == 0
        ), f"Errors during concurrent creation: {creation_errors}"
        assert len(created_routers) == 10, "Not all routers created"
        assert (
            concurrent_time < 200
        ), f"Concurrent creation too slow: {concurrent_time:.2f}ms"

        # Test 6: Regex edge cases
        regex_edge_cases = [
            "",  # Empty pattern
            "a" * 1000,  # Very long pattern
            "\\",  # Escape character
            "(?:non-capturing)",  # Regex group
            "[a-zA-Z0-9]*",  # Character class
            "^start.*end$",  # Anchors
        ]

        router_regex = KeywordRouter()

        for edge_pattern in regex_edge_cases:
            try:
                result = router_regex.route(edge_pattern)
                assert result is not None
            except Exception:
                # Some patterns may be invalid
                pass
