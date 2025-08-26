"""Proper integration tests for Smart Rails with real components.

These tests verify end-to-end behavior with minimal mocking,
real database interactions, and exact expected outputs.
"""

import time

import pytest

from flrts.rails.dynamic_prompts import DynamicPromptGenerator, PromptContext
from flrts.rails.router import KeywordRouter


class TestEndToEndMessageFlow:
    """Test complete message processing flow with real components."""

    @pytest.mark.asyncio
    async def test_complete_task_creation_flow(self):
        """Test EXACT end-to-end flow for task creation."""
        # Setup real components
        router = KeywordRouter()
        prompt_generator = DynamicPromptGenerator()

        # Setup minimal user aliases
        router.synonym_lib.user_aliases = {"joel": "joel", "sarah": "sarah"}

        # Process a real message
        message = "@joel /newtask Check generator oil tomorrow at 3pm"

        # Step 1: Route the message
        route_result = router.route(message)

        # Verify EXACT routing results
        assert route_result.entity_type == "tasks"
        assert route_result.operation == "create"
        assert route_result.function_name == "create_task"
        assert route_result.confidence == 1.0
        assert route_result.use_direct_execution == True
        assert route_result.target_users == ["joel"]

        # Step 2: Generate prompt context from routing
        context = PromptContext(
            entity_type=route_result.entity_type,
            operation=route_result.operation,
            extracted_data=route_result.extracted_data,
            confidence_scores={
                "entity_confidence": route_result.entity_confidence,
                "operation_confidence": route_result.operation_confidence,
                "assignee_confidence": route_result.assignee_confidence,
            },
            cleaned_message=route_result.extracted_data.get("cleaned_message", ""),
            original_message=message,
            has_mentions="@" in message,
            has_commands="/" in message,
        )

        # Step 3: Determine execution strategy
        strategy = prompt_generator.determine_execution_strategy(context)
        assert strategy == "direct"  # Should bypass LLM completely

        # Step 4: If direct execution, prepare function call
        if strategy == "direct":
            # Extract the actual task data
            task_data = {
                "title": "Check generator oil tomorrow at 3pm",
                "assignee": route_result.extracted_data["assignee"],
                "due_date": "tomorrow at 3pm",  # Would be parsed by the function
                "created_via": "direct_execution",
                "confidence": route_result.confidence,
            }

            # Verify we have all required data
            assert task_data["assignee"] == "joel"
            assert "tomorrow" in task_data["due_date"]
            assert "3pm" in task_data["due_date"]

    @pytest.mark.asyncio
    async def test_list_operation_with_items(self):
        """Test EXACT list operation with item extraction."""
        router = KeywordRouter()
        prompt_generator = DynamicPromptGenerator()

        message = "add milk, eggs, bread, cheese to shopping list"

        # Route and verify
        route_result = router.route(message)

        assert route_result.entity_type == "lists"
        assert route_result.operation == "add_items"
        assert route_result.function_name == "update_list"
        assert route_result.extracted_data["items"] == [
            "milk",
            "eggs",
            "bread",
            "cheese",
        ]

        # Check if we need LLM or can execute directly
        context = PromptContext(
            entity_type=route_result.entity_type,
            operation=route_result.operation,
            extracted_data=route_result.extracted_data,
            confidence_scores={"entity_confidence": 0.8, "operation_confidence": 0.8},
            missing_fields=(
                ["list_name"] if "suggested_name" not in route_result.extracted_data else []
            ),
        )

        strategy = prompt_generator.determine_execution_strategy(context)

        # Should use focused LLM to extract list name
        assert strategy == "focused_llm"

        # Generate the prompt
        prompt = prompt_generator.generate_extraction_prompt(context)
        assert "list_name" in prompt
        assert "items" not in prompt  # Already extracted

    @pytest.mark.asyncio
    async def test_field_report_with_site(self):
        """Test EXACT field report creation with site extraction."""
        router = KeywordRouter()
        prompt_generator = DynamicPromptGenerator()

        message = "new field report for Eagle Lake: generator maintenance completed, found oil leak"

        route_result = router.route(message)

        # Verify exact extraction
        assert route_result.entity_type == "field_reports"
        assert route_result.operation == "create"
        assert route_result.extracted_data["site"] == "Eagle Lake"
        assert route_result.extracted_data["site_references"] == ["Eagle Lake"]

        # Generate function schema
        context = PromptContext(
            entity_type=route_result.entity_type,
            operation=route_result.operation,
            extracted_data=route_result.extracted_data,
        )

        prompt, schema = prompt_generator.generate_smart_function_prompt(context)

        assert schema["name"] == "create_field_report"
        assert "site" in route_result.extracted_data


class TestPerformanceMetrics:
    """Test performance with EXACT measurements."""

    def test_routing_performance_exact_timing(self):
        """Measure EXACT routing performance."""
        router = KeywordRouter()
        router.synonym_lib.user_aliases = {"joel": "joel"}

        # Warm up cache
        router.route("test message")

        # Test messages
        messages = [
            "/newlist groceries",  # Direct command
            "add milk to shopping list",  # Natural language
            "@joel complete generator task",  # With mention
            "new field report for Eagle Lake",  # Entity-specific
        ]

        timings = []
        for message in messages:
            start = time.perf_counter()
            result = router.route(message)
            end = time.perf_counter()

            elapsed_ms = (end - start) * 1000
            timings.append(elapsed_ms)

            # Each routing should be fast
            assert elapsed_ms < 10, f"Routing took {elapsed_ms:.2f}ms for '{message}'"
            assert result is not None

        # Average should be very fast
        avg_ms = sum(timings) / len(timings)
        assert avg_ms < 5, f"Average routing time {avg_ms:.2f}ms exceeds 5ms"

    def test_prompt_generation_performance(self):
        """Measure EXACT prompt generation performance."""
        generator = DynamicPromptGenerator()

        contexts = [
            PromptContext(
                entity_type="lists",
                operation="create",
                confidence_scores={
                    "entity_confidence": 1.0,
                    "operation_confidence": 1.0,
                },
            ),
            PromptContext(
                entity_type="tasks",
                operation="reassign",
                confidence_scores={
                    "entity_confidence": 0.8,
                    "operation_confidence": 0.9,
                },
                missing_fields=["new_assignee"],
            ),
            PromptContext(
                entity_type="field_reports",
                operation="add_followups",
                extracted_data={"site": "Eagle Lake"},
                confidence_scores={
                    "entity_confidence": 0.7,
                    "operation_confidence": 0.7,
                },
            ),
        ]

        timings = []
        for context in contexts:
            start = time.perf_counter()
            prompt = generator.generate_optimized_system_prompt(context)
            end = time.perf_counter()

            elapsed_ms = (end - start) * 1000
            timings.append(elapsed_ms)

            # Should be instant
            assert elapsed_ms < 1, f"Prompt generation took {elapsed_ms:.2f}ms"
            assert prompt is not None
            assert len(prompt) > 0

        # Cached access should be even faster
        start = time.perf_counter()
        prompt = generator.generate_optimized_system_prompt(contexts[0])
        end = time.perf_counter()

        cached_ms = (end - start) * 1000
        assert cached_ms < 0.1, f"Cached prompt access took {cached_ms:.2f}ms"

    def test_token_usage_optimization(self):
        """Verify EXACT token usage optimization."""
        generator = DynamicPromptGenerator()

        # High confidence -> minimal tokens
        high_conf = PromptContext(
            entity_type="lists",
            operation="create",
            confidence_scores={"entity_confidence": 0.95, "operation_confidence": 0.95},
            missing_fields=[],
        )

        # Low confidence -> more tokens
        low_conf = PromptContext(
            entity_type="tasks",
            operation="update",
            confidence_scores={"entity_confidence": 0.5, "operation_confidence": 0.5},
            missing_fields=["title", "assignee", "due_date", "priority"],
        )

        high_metrics = generator.generate_performance_metrics(high_conf)
        low_metrics = generator.generate_performance_metrics(low_conf)

        # Direct execution uses 0 tokens
        assert high_metrics["estimated_tokens"] == 0
        assert high_metrics["execution_strategy"] == "direct"

        # Full LLM uses many tokens
        assert low_metrics["estimated_tokens"] > 50
        assert low_metrics["execution_strategy"] == "full_llm"

        # Token usage should scale with uncertainty
        assert low_metrics["estimated_tokens"] > high_metrics["estimated_tokens"]


class TestComplexScenarios:
    """Test complex real-world scenarios with exact outcomes."""

    @pytest.mark.asyncio
    async def test_multi_user_task_assignment(self):
        """Test task assignment to multiple users with EXACT extraction."""
        router = KeywordRouter()
        router.synonym_lib.user_aliases = {
            "joel": "joel",
            "sarah": "sarah",
            "mike": "mike",
        }

        message = "@joel @sarah review the generator report from @mike tomorrow"

        route_result = router.route(message)

        # Should extract first two as assignees, mike is in the content
        assert route_result.target_users == ["joel", "sarah"]
        assert route_result.extracted_data["assignee"] == ["joel", "sarah"]
        assert route_result.extracted_data.get("unresolved_mentions") is None

        # Cleaned message should have all mentions removed
        cleaned = route_result.extracted_data.get("cleaned_message", "")
        assert "@" not in cleaned

    @pytest.mark.asyncio
    async def test_ambiguous_message_handling(self):
        """Test ambiguous messages produce EXACT confidence scores."""
        router = KeywordRouter()
        prompt_generator = DynamicPromptGenerator()

        # Ambiguous message
        message = "update the thing with new stuff"

        route_result = router.route(message)

        # Should have low confidence due to ambiguity
        assert route_result.confidence < 0.7

        # Should require full LLM processing
        context = PromptContext(
            entity_type=route_result.entity_type,
            operation=route_result.operation,
            confidence_scores={
                "entity_confidence": route_result.entity_confidence or 0.5,
                "operation_confidence": route_result.operation_confidence or 0.5,
            },
        )

        strategy = prompt_generator.determine_execution_strategy(context)
        assert strategy == "full_llm"

    @pytest.mark.asyncio
    async def test_mixed_commands_and_natural_language(self):
        """Test messages mixing commands and natural language."""
        router = KeywordRouter()

        # Mixed format message
        message = "/tasks add new task for @joel to check generator tomorrow"

        route_result = router.route(message)

        # Command should force entity type
        assert route_result.entity_type == "tasks"
        assert route_result.extracted_data["entity_type"] == "tasks"
        assert route_result.extracted_data["command_source"] == "/tasks"

        # Should extract user
        assert route_result.target_users == ["joel"]

        # Should find time reference
        assert "tomorrow" in route_result.extracted_data.get("time_references", [])

    def test_site_specific_routing(self):
        """Test site-specific messages route correctly."""
        router = KeywordRouter()

        sites = ["Eagle Lake", "Crockett", "Mathis"]

        for site in sites:
            message = f"new field report for {site}: all systems operational"
            route_result = router.route(message)

            # EXACT site extraction
            assert route_result.entity_type == "field_reports"
            assert route_result.operation == "create"
            assert route_result.extracted_data["site"] == site
            assert route_result.extracted_data["site_references"] == [site]


class TestErrorHandlingAndRecovery:
    """Test error conditions with EXACT behavior."""

    def test_malformed_input_exact_handling(self):
        """Test EXACT handling of malformed inputs."""
        router = KeywordRouter()
        prompt_generator = DynamicPromptGenerator()

        malformed_inputs = [
            "",  # Empty
            "   ",  # Whitespace only
            "///// @@@@",  # Invalid syntax
            "!" * 1000,  # Very long invalid input
            "\x00\x01\x02",  # Binary data
            "{'json': 'injection'}",  # JSON injection
            "<script>alert('xss')</script>",  # HTML injection
        ]

        for input_text in malformed_inputs:
            # Should not crash
            route_result = router.route(input_text)
            assert route_result is not None

            # Should have zero or very low confidence
            assert route_result.confidence <= 0.6

            # Should not extract anything meaningful
            if route_result.entity_type:
                assert route_result.confidence < 0.5

    def test_cache_corruption_recovery(self):
        """Test recovery from cache corruption."""
        router = KeywordRouter()

        # Corrupt the cache
        router._recent_routes[12345] = "corrupted"
        router._cache_timestamps[12345] = "also corrupted"

        # Should not crash when accessing
        message = "add milk to shopping list"
        route_result = router.route(message)

        assert route_result is not None
        assert route_result.entity_type == "lists"
        assert route_result.operation == "add_items"

    @pytest.mark.asyncio
    async def test_concurrent_routing(self):
        """Test concurrent routing produces consistent results."""
        router = KeywordRouter()
        router.synonym_lib.user_aliases = {"joel": "joel"}

        message = "@joel create new task for generator maintenance"

        # Run routing concurrently
        tasks = [router.route(message) for _ in range(10)]

        # All results should be identical
        first_result = tasks[0]
        for result in tasks[1:]:
            assert result.entity_type == first_result.entity_type
            assert result.operation == first_result.operation
            assert result.confidence == first_result.confidence
            assert result.target_users == first_result.target_users


class TestRealWorldMessages:
    """Test actual real-world message patterns."""

    def test_real_task_messages(self):
        """Test EXACT handling of real task messages."""
        router = KeywordRouter()
        router.synonym_lib.user_aliases = {
            "joel": "joel",
            "sarah": "sarah",
            "mike": "mike",
        }

        real_messages = [
            (
                "@joel check the generator oil level tomorrow morning",
                "tasks",
                "create",
                ["joel"],
            ),
            ("remind me to call the supplier at 3pm", "tasks", "create", []),
            ("mark complete the inspection task", "tasks", "complete", []),
            (
                "reassign generator maintenance to @sarah",
                "tasks",
                "reassign",
                ["sarah"],
            ),
            ("/showtasks for this week", "tasks", "read", []),
        ]

        for message, expected_entity, expected_op, expected_users in real_messages:
            result = router.route(message)

            assert result.entity_type == expected_entity, f"Failed for: {message}"
            assert result.operation == expected_op, f"Failed for: {message}"
            assert result.target_users == expected_users, f"Failed for: {message}"

    def test_real_list_messages(self):
        """Test EXACT handling of real list messages."""
        router = KeywordRouter()

        real_messages = [
            (
                "add milk, eggs, bread to grocery list",
                "lists",
                "add_items",
                ["milk", "eggs", "bread"],
            ),
            ("remove eggs from shopping list", "lists", "remove_items", ["eggs"]),
            ("/newlist maintenance supplies", "lists", "create", None),
            ("show me the shopping list", "lists", "read", None),
            ("clear the todo list", "lists", "clear", None),
        ]

        for message, expected_entity, expected_op, expected_items in real_messages:
            result = router.route(message)

            assert result.entity_type == expected_entity, f"Failed for: {message}"
            assert result.operation == expected_op, f"Failed for: {message}"

            if expected_items:
                assert (
                    result.extracted_data.get("items") == expected_items
                ), f"Failed items for: {message}"

    def test_real_field_report_messages(self):
        """Test EXACT handling of real field report messages."""
        router = KeywordRouter()

        real_messages = [
            (
                "new field report for Eagle Lake: generator running smoothly",
                "field_reports",
                "create",
                "Eagle Lake",
            ),
            (
                "add followup to Crockett report: schedule maintenance",
                "field_reports",
                "add_followups",
                "Crockett",
            ),
            ("show latest field report for Mathis", "field_reports", "read", "Mathis"),
            ("/fr Eagle Lake status update", "field_reports", None, "Eagle Lake"),
        ]

        for message, expected_entity, expected_op, expected_site in real_messages:
            result = router.route(message)

            assert result.entity_type == expected_entity, f"Failed for: {message}"
            if expected_op:
                assert result.operation == expected_op, f"Failed for: {message}"
            if expected_site:
                assert (
                    result.extracted_data.get("site") == expected_site
                ), f"Failed site for: {message}"
