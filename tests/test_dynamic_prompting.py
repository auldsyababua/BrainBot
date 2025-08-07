"""Test suite for T2.1.2: Dynamic LLM Prompting System.

Tests the enhanced dynamic prompting capabilities including:
- Context-aware prompt generation
- Conditional execution logic
- Performance optimization
- Token usage reduction
"""

import os
import pytest
from unittest.mock import MagicMock

# Set required environment variables before imports
os.environ.setdefault("TELEGRAM_BOT_TOKEN", "test_token")
os.environ.setdefault("OPENAI_API_KEY", "test_key")
os.environ.setdefault("SUPABASE_URL", "http://test.supabase.co")
os.environ.setdefault("SUPABASE_KEY", "test_key")

from src.rails.router import KeywordRouter, RouteResult
from src.rails.dynamic_prompts import DynamicPromptGenerator, PromptContext
from src.core.llm import _determine_missing_fields


class TestDynamicPromptGeneration:
    """Test dynamic prompt generation based on preprocessing results."""

    def setup_method(self):
        """Set up test fixtures."""
        self.generator = DynamicPromptGenerator()

    def test_minimal_prompt_for_high_confidence(self):
        """Test that minimal prompts are used for high confidence scenarios."""
        context = PromptContext(
            entity_type="lists",
            operation="create",
            extracted_data={"list_name": "groceries", "items": ["milk", "bread"]},
            confidence_scores={"entity_confidence": 1.0, "operation_confidence": 1.0},
            cleaned_message="create list groceries",
            missing_fields=[],
        )

        prompt = self.generator.generate_optimized_system_prompt(context)

        # Should generate minimal prompt
        assert len(prompt) < 50  # Minimal prompts should be very short
        assert "Execute" in prompt or "provided data" in prompt

    def test_focused_prompt_for_medium_confidence(self):
        """Test focused prompts for medium confidence scenarios."""
        context = PromptContext(
            entity_type="tasks",
            operation="create",
            extracted_data={"assignee": "john"},
            confidence_scores={"entity_confidence": 0.8, "operation_confidence": 0.7},
            cleaned_message="new task for john",
            missing_fields=["task_title", "due_date"],
        )

        prompt = self.generator.generate_optimized_system_prompt(context)

        # Should generate focused prompt
        assert "task_title" in prompt or "Extract" in prompt
        assert len(prompt) < 200  # Focused prompts should be concise

    def test_full_prompt_for_low_confidence(self):
        """Test full prompts for low confidence scenarios."""
        context = PromptContext(
            entity_type=None,
            operation=None,
            extracted_data={},
            confidence_scores={"entity_confidence": 0.3, "operation_confidence": 0.2},
            cleaned_message="do something with the thing",
            missing_fields=["entity_type", "operation"],
        )

        prompt = self.generator.generate_system_prompt(context)

        # Should generate full analysis prompt
        assert "determine" in prompt.lower() or "extract" in prompt.lower()
        assert len(prompt) > 100  # Full prompts are more detailed

    def test_prompt_caching(self):
        """Test that prompts are cached for performance."""
        context = PromptContext(
            entity_type="lists",
            operation="add_items",
            extracted_data={"list_name": "shopping"},
            confidence_scores={"entity_confidence": 0.9, "operation_confidence": 0.9},
            cleaned_message="add to shopping",
            missing_fields=["items"],
        )

        # Generate prompt twice
        prompt1 = self.generator.generate_optimized_system_prompt(context)
        prompt2 = self.generator.generate_optimized_system_prompt(context)

        # Should be the same (from cache)
        assert prompt1 == prompt2

        # Check cache key is in cache
        cache_key = self.generator._generate_cache_key(context)
        assert cache_key in self.generator._prompt_cache


class TestExecutionStrategy:
    """Test conditional execution strategy determination."""

    def setup_method(self):
        """Set up test fixtures."""
        self.generator = DynamicPromptGenerator()

    def test_direct_execution_for_perfect_confidence(self):
        """Test direct execution is chosen for 100% confidence."""
        context = PromptContext(
            entity_type="tasks",
            operation="complete",
            extracted_data={"task_id": "123", "assignee": "jane"},
            confidence_scores={
                "entity_confidence": 1.0,
                "operation_confidence": 1.0,
                "assignee_confidence": 1.0,
            },
            cleaned_message="complete task 123",
            missing_fields=[],
        )

        strategy = self.generator.determine_execution_strategy(context)
        assert strategy == "direct"

    def test_focused_llm_for_medium_confidence(self):
        """Test focused LLM is chosen for medium confidence."""
        context = PromptContext(
            entity_type="lists",
            operation="create",
            extracted_data={},
            confidence_scores={"entity_confidence": 0.85, "operation_confidence": 0.8},
            cleaned_message="new shopping list",
            missing_fields=["list_name"],
        )

        strategy = self.generator.determine_execution_strategy(context)
        assert strategy == "focused_llm"

    def test_full_llm_for_low_confidence(self):
        """Test full LLM is chosen for low confidence."""
        context = PromptContext(
            entity_type="lists",
            operation=None,
            extracted_data={},
            confidence_scores={"entity_confidence": 0.5, "operation_confidence": 0.3},
            cleaned_message="maybe do something with a list",
            missing_fields=["operation", "list_name"],
        )

        strategy = self.generator.determine_execution_strategy(context)
        assert strategy == "full_llm"

    def test_direct_execution_with_minor_missing_fields(self):
        """Test direct execution can proceed with minor missing fields."""
        context = PromptContext(
            entity_type="tasks",
            operation="reassign",
            extracted_data={"task_id": "456", "assignee": "bob"},
            confidence_scores={
                "entity_confidence": 0.95,
                "operation_confidence": 0.95,
                "assignee_confidence": 0.95,
            },
            cleaned_message="reassign task 456 to @bob",
            missing_fields=["priority"],  # Non-critical field
        )

        strategy = self.generator.determine_execution_strategy(context)
        assert strategy == "direct"


class TestFunctionSchemaGeneration:
    """Test dynamic function schema generation."""

    def setup_method(self):
        """Set up test fixtures."""
        self.generator = DynamicPromptGenerator()

    def test_list_create_schema(self):
        """Test schema generation for list creation."""
        context = PromptContext(
            entity_type="lists",
            operation="create",
            extracted_data={"list_name": "tools"},
            confidence_scores={"entity_confidence": 1.0, "operation_confidence": 1.0},
        )

        prompt, schema = self.generator.generate_smart_function_prompt(context)

        assert schema is not None
        assert schema["name"] == "create_list"
        assert "list_name" in schema["parameters"]["properties"]
        assert schema["parameters"]["properties"]["list_name"]["default"] == "tools"

    def test_task_reassign_schema(self):
        """Test schema generation for task reassignment."""
        context = PromptContext(
            entity_type="tasks",
            operation="reassign",
            extracted_data={"assignee": "alice"},
            confidence_scores={"entity_confidence": 0.9, "operation_confidence": 0.9},
        )

        prompt, schema = self.generator.generate_smart_function_prompt(context)

        assert schema is not None
        assert schema["name"] == "update_task"
        assert "new_assignee" in schema["parameters"]["properties"]
        assert "task_id" in schema["parameters"]["required"]


class TestPerformanceMetrics:
    """Test performance metrics generation."""

    def setup_method(self):
        """Set up test fixtures."""
        self.generator = DynamicPromptGenerator()

    def test_zero_tokens_for_direct_execution(self):
        """Test that direct execution shows zero token usage."""
        context = PromptContext(
            entity_type="lists",
            operation="read",
            extracted_data={"list_name": "inventory"},
            confidence_scores={"entity_confidence": 1.0, "operation_confidence": 1.0},
            missing_fields=[],
        )

        metrics = self.generator.generate_performance_metrics(context)

        assert metrics["execution_strategy"] == "direct"
        assert metrics["estimated_tokens"] == 0
        assert metrics["missing_fields_count"] == 0

    def test_token_estimation_for_llm_usage(self):
        """Test token estimation for LLM-based execution."""
        context = PromptContext(
            entity_type="field_reports",
            operation="create",
            extracted_data={"site": "Eagle Lake"},
            confidence_scores={"entity_confidence": 0.7, "operation_confidence": 0.6},
            missing_fields=["report_content", "followups"],
        )

        metrics = self.generator.generate_performance_metrics(context)

        assert metrics["execution_strategy"] in ["focused_llm", "full_llm"]
        assert metrics["estimated_tokens"] > 0
        assert metrics["missing_fields_count"] == 2


class TestMissingFieldsDetermination:
    """Test missing fields determination logic."""

    def test_list_create_missing_fields(self):
        """Test missing fields for list creation."""
        route_result = RouteResult(
            entity_type="lists",
            operation="create",
            function_name="create_list",
            confidence=0.8,
            extracted_data={"items": ["hammer", "nails"]},
        )

        missing = _determine_missing_fields(route_result)
        assert "list_name" in missing

    def test_task_create_complete_fields(self):
        """Test no missing fields when all required data present."""
        route_result = RouteResult(
            entity_type="tasks",
            operation="create",
            function_name="create_task",
            confidence=0.9,
            extracted_data={"task_title": "Check generator", "assignee": "john"},
        )

        missing = _determine_missing_fields(route_result)
        assert "task_title" not in missing  # Already present

    def test_field_report_with_site_reference(self):
        """Test that site_references satisfies site requirement."""
        route_result = RouteResult(
            entity_type="field_reports",
            operation="create",
            function_name="create_field_report",
            confidence=0.85,
            extracted_data={
                "site_references": ["Eagle Lake"],
                "report_content": "All good",
            },
        )

        missing = _determine_missing_fields(route_result)
        assert "site" not in missing  # site_references should satisfy this


class TestIntegrationWithRouter:
    """Test integration between router and dynamic prompting."""

    @pytest.mark.asyncio
    async def test_high_confidence_direct_execution(self):
        """Test that high confidence routes use direct execution."""
        # Mock supabase client
        mock_supabase = MagicMock()

        router = KeywordRouter(supabase_client=mock_supabase)
        generator = DynamicPromptGenerator()

        # Test with 100% confidence command
        message = "/completetask generator maintenance"
        route_result = router.route(message)

        # Build prompt context
        context = PromptContext(
            entity_type=route_result.entity_type,
            operation=route_result.operation,
            extracted_data=route_result.extracted_data or {},
            confidence_scores={
                "entity_confidence": route_result.entity_confidence
                or route_result.confidence,
                "operation_confidence": route_result.operation_confidence
                or route_result.confidence,
            },
            cleaned_message=(
                route_result.extracted_data.get("cleaned_message", message)
                if route_result.extracted_data
                else message
            ),
            missing_fields=_determine_missing_fields(route_result),
        )

        strategy = generator.determine_execution_strategy(context)

        # Should use direct execution for hidden command
        assert strategy == "direct"
        assert route_result.confidence >= 0.95

    @pytest.mark.asyncio
    async def test_medium_confidence_focused_llm(self):
        """Test that medium confidence routes use focused LLM."""
        mock_supabase = MagicMock()

        router = KeywordRouter(supabase_client=mock_supabase)
        generator = DynamicPromptGenerator()

        # Test with medium confidence message
        message = "add milk and bread to shopping list"
        route_result = router.route(message)

        if route_result.entity_type:
            context = PromptContext(
                entity_type=route_result.entity_type,
                operation=route_result.operation,
                extracted_data=route_result.extracted_data or {},
                confidence_scores={
                    "entity_confidence": route_result.entity_confidence
                    or route_result.confidence,
                    "operation_confidence": route_result.operation_confidence
                    or route_result.confidence,
                },
                cleaned_message=message,
                missing_fields=_determine_missing_fields(route_result),
            )

            strategy = generator.determine_execution_strategy(context)

            # Should use focused LLM for keyword-based routing
            assert strategy in ["focused_llm", "direct"]
            assert route_result.confidence >= 0.7


if __name__ == "__main__":
    # Run tests
    pytest.main([__file__, "-v"])
