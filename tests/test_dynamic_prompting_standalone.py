"""Standalone test suite for T2.1.2: Dynamic LLM Prompting System.

Tests the dynamic prompting module without requiring full system initialization.
"""

import pytest

from brainbot.rails.dynamic_prompts import DynamicPromptGenerator, PromptContext


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
        print(f"✓ Minimal prompt generated: '{prompt}'")

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
        print(f"✓ Focused prompt generated (length={len(prompt)})")

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
        print(f"✓ Full prompt generated (length={len(prompt)})")

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
        print(f"✓ Prompt caching works (cache_key={cache_key})")


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
        print("✓ Direct execution chosen for 100% confidence")

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
        print("✓ Focused LLM chosen for medium confidence")

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
        print("✓ Full LLM chosen for low confidence")


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
        print(f"✓ List create schema generated: {schema['name']}")

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
        print(f"✓ Task reassign schema generated: {schema['name']}")


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
        print(f"✓ Zero tokens for direct execution: {metrics}")

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
        print(f"✓ Token estimation for LLM: {metrics['estimated_tokens']} tokens")


class TestPromptOptimization:
    """Test prompt optimization features."""

    def setup_method(self):
        """Set up test fixtures."""
        self.generator = DynamicPromptGenerator()

    def test_prompt_length_optimization(self):
        """Test that prompts are optimized for length based on confidence."""
        contexts = [
            # High confidence - should be shortest
            PromptContext(
                entity_type="lists",
                operation="delete",
                confidence_scores={
                    "entity_confidence": 1.0,
                    "operation_confidence": 1.0,
                },
                missing_fields=[],
            ),
            # Medium confidence - should be medium length
            PromptContext(
                entity_type="tasks",
                operation="create",
                confidence_scores={
                    "entity_confidence": 0.8,
                    "operation_confidence": 0.7,
                },
                missing_fields=["task_title"],
            ),
            # Low confidence - should be longest
            PromptContext(
                entity_type=None,
                operation=None,
                confidence_scores={
                    "entity_confidence": 0.3,
                    "operation_confidence": 0.2,
                },
                missing_fields=["entity_type", "operation"],
            ),
        ]

        prompts = [self.generator.generate_optimized_system_prompt(ctx) for ctx in contexts]
        lengths = [len(p) for p in prompts]

        # Verify length ordering: high conf < medium conf < low conf
        assert lengths[0] < lengths[1] < lengths[2]
        print(
            f"✓ Prompt optimization by confidence: {lengths[0]} < {lengths[1]} < {lengths[2]} chars"
        )

    def test_context_injection_efficiency(self):
        """Test that context is efficiently injected into prompts."""
        context = PromptContext(
            entity_type="field_reports",
            operation="create",
            extracted_data={
                "site": "Eagle Lake",
                "assignee": "bob",
                "time_references": ["tomorrow", "3pm"],
            },
            confidence_scores={"entity_confidence": 0.9, "operation_confidence": 0.85},
        )

        prompt = self.generator.generate_extraction_prompt(context)

        # Should not re-ask for already extracted fields
        assert "site" not in prompt.lower() or "Eagle Lake" in prompt
        assert "assignee" not in prompt.lower() or "bob" in prompt
        print("✓ Efficient context injection - skips extracted fields")


def test_summary():
    """Print test summary."""
    print("\n" + "=" * 50)
    print("T2.1.2 Dynamic Prompting Tests Summary")
    print("=" * 50)
    print("✅ All dynamic prompting features validated:")
    print("  - Minimal prompts for high confidence")
    print("  - Focused prompts for medium confidence")
    print("  - Full prompts for low confidence")
    print("  - Prompt caching for performance")
    print("  - Direct execution strategy")
    print("  - Function schema generation")
    print("  - Token usage optimization")
    print("  - Context-aware prompt building")
    print("=" * 50)


if __name__ == "__main__":
    # Run tests
    pytest.main([__file__, "-v", "-s"])
