"""End-to-end command processing integration tests."""

import asyncio
from unittest.mock import AsyncMock, MagicMock, patch

import pytest

from flrts_bmad.core.llm import process_message


class TestCommandProcessingIntegration:
    """Test end-to-end command processing flow."""

    def setup_method(self):
        """Set up test fixtures."""
        self.chat_id = "test_chat_123"
        self.mock_responses = {
            "lists": "Here are your lists:\n1. Shopping\n2. Tasks",
            "tasks": "Your tasks:\n- Fix generator\n- Check water levels",
            "field_reports": "Latest field report from Eagle Lake: All systems operational.",
        }

    @pytest.mark.asyncio
    async def test_rails_command_full_flow(self):
        """Test complete flow from command to response."""
        test_commands = [
            ("/lists", "lists"),
            ("/tnr", "tasks"),
            ("/fr", "field_reports"),
            ("/l", "lists"),
            ("/t", "tasks"),
        ]

        for command, expected_entity in test_commands:
            with (
                patch(
                    "src.rails.processors.list_processor.ListProcessor"
                ) as mock_list_proc,
                patch(
                    "src.rails.processors.task_processor.TaskProcessor"
                ) as mock_task_proc,
                patch(
                    "src.rails.processors.field_report_processor.FieldReportProcessor"
                ) as mock_fr_proc,
            ):
                # Setup processor mocks
                processors = {
                    "lists": mock_list_proc,
                    "tasks": mock_task_proc,
                    "field_reports": mock_fr_proc,
                }

                for entity, mock_class in processors.items():
                    mock_instance = AsyncMock()
                    mock_instance.process.return_value = self.mock_responses[entity]
                    mock_class.return_value = mock_instance

                # Process command
                response = await process_message(command, self.chat_id)

                # Verify correct processor was called
                assert response == self.mock_responses[expected_entity]
                processors[expected_entity].return_value.process.assert_called_once()

    @pytest.mark.asyncio
    async def test_non_rails_command_uses_llm(self):
        """Test that non-Rails commands go through LLM."""
        with patch("src.core.llm.resilient_client.chat_completion") as mock_llm:
            # Setup LLM response
            mock_response = MagicMock()
            mock_response.choices[0].message.content = "I can help you with that."
            mock_response.choices[0].message.function_call = None
            mock_llm.return_value = mock_response

            # Non-Rails commands
            non_rails_commands = [
                "What's the weather?",
                "Tell me a joke",
                "/unknown command",
                "How do I create a list?",
            ]

            for command in non_rails_commands:
                response = await process_message(command, self.chat_id)
                assert response == "I can help you with that."
                mock_llm.assert_called()

    @pytest.mark.asyncio
    async def test_command_with_parameters(self):
        """Test Rails commands with parameters."""
        parameterized_commands = [
            ("/lists add milk to shopping", "lists", "add_items", {"items": ["milk"]}),
            ("/tnr assign @joel", "tasks", "reassign", {"assignee": "joel"}),
            (
                "/fr new report for Eagle Lake",
                "field_reports",
                "create",
                {"site": "Eagle Lake"},
            ),
        ]

        for command, entity, operation, expected_data in parameterized_commands:
            with patch(
                f'src.rails.processors.{entity[:-1] if entity.endswith("s") else entity}_processor.{entity.title().replace("_", "")}Processor'
            ) as mock_proc:
                mock_instance = AsyncMock()
                mock_instance.process.return_value = (
                    f"Processed {operation} for {entity}"
                )
                mock_proc.return_value = mock_instance

                await process_message(command, self.chat_id)

                # Verify processor was called with correct params
                mock_instance.process.assert_called_once()
                call_args = mock_instance.process.call_args[0][0]
                assert call_args["operation"] == operation
                assert call_args["chat_id"] == self.chat_id

    @pytest.mark.asyncio
    async def test_command_processing_with_errors(self):
        """Test error handling in command processing."""
        error_scenarios = [
            (ImportError("Module not found"), "error occurred"),
            (AttributeError("Processor not found"), "error occurred"),
            (Exception("Generic error"), "error occurred"),
            (asyncio.TimeoutError("Timeout"), "error occurred"),
        ]

        for error, expected_in_response in error_scenarios:
            with patch(
                "src.rails.processors.list_processor.ListProcessor"
            ) as mock_proc:
                mock_instance = AsyncMock()
                mock_instance.process.side_effect = error
                mock_proc.return_value = mock_instance

                response = await process_message("/lists", self.chat_id)
                assert expected_in_response in response.lower()

    @pytest.mark.asyncio
    async def test_mixed_command_session(self):
        """Test a session with mixed Rails and LLM commands."""
        session_commands = [
            ("/lists", "rails", "Your lists: Shopping, Tasks"),
            (
                "What's on my shopping list?",
                "llm",
                "Your shopping list contains: milk, bread",
            ),
            (
                "/tnr create task Check generator",
                "rails",
                "Task created: Check generator",
            ),
            (
                "When should I check the generator?",
                "llm",
                "You should check it tomorrow at 3 PM",
            ),
            ("/fr", "rails", "Latest field report: All systems operational"),
        ]

        for command, command_type, expected_response in session_commands:
            if command_type == "rails":
                # Mock Rails processor
                with (
                    patch(
                        "src.rails.processors.list_processor.ListProcessor"
                    ) as mock_list,
                    patch(
                        "src.rails.processors.task_processor.TaskProcessor"
                    ) as mock_task,
                    patch(
                        "src.rails.processors.field_report_processor.FieldReportProcessor"
                    ) as mock_fr,
                ):
                    # Setup all processors
                    for mock_class in [mock_list, mock_task, mock_fr]:
                        mock_instance = AsyncMock()
                        mock_instance.process.return_value = expected_response
                        mock_class.return_value = mock_instance

                    response = await process_message(command, self.chat_id)
                    assert response == expected_response
            else:
                # Mock LLM
                with patch("src.core.llm.resilient_client.chat_completion") as mock_llm:
                    mock_response = MagicMock()
                    mock_response.choices[0].message.content = expected_response
                    mock_response.choices[0].message.function_call = None
                    mock_llm.return_value = mock_response

                    response = await process_message(command, self.chat_id)
                    assert response == expected_response

    @pytest.mark.asyncio
    async def test_concurrent_command_processing(self):
        """Test handling of concurrent commands."""
        commands = [
            "/lists",
            "/tnr",
            "/fr",
            "What's the weather?",
            "/lists add item",
        ]

        async def process_command_with_mocks(cmd):
            with (
                patch("src.rails.processors.list_processor.ListProcessor") as mock_list,
                patch("src.rails.processors.task_processor.TaskProcessor") as mock_task,
                patch(
                    "src.rails.processors.field_report_processor.FieldReportProcessor"
                ) as mock_fr,
                patch("src.core.llm.resilient_client.chat_completion") as mock_llm,
            ):
                # Setup Rails processors
                for mock_class, response in [
                    (mock_list, "Lists"),
                    (mock_task, "Tasks"),
                    (mock_fr, "Reports"),
                ]:
                    mock_instance = AsyncMock()
                    mock_instance.process.return_value = response
                    mock_class.return_value = mock_instance

                # Setup LLM
                mock_response = MagicMock()
                mock_response.choices[0].message.content = "LLM response"
                mock_response.choices[0].message.function_call = None
                mock_llm.return_value = mock_response

                return await process_message(cmd, self.chat_id)

        # Process commands concurrently
        results = await asyncio.gather(
            *[process_command_with_mocks(cmd) for cmd in commands]
        )

        # Verify all commands were processed
        assert len(results) == len(commands)
        assert all(result is not None for result in results)

    @pytest.mark.asyncio
    async def test_command_with_context_retrieval(self):
        """Test commands that trigger context retrieval from vector store."""
        with (
            patch("src.core.llm.search_knowledge_base") as mock_search,
            patch("src.core.llm.resilient_client.chat_completion") as mock_llm,
        ):
            # Setup knowledge base search
            mock_search.return_value = [
                {
                    "content": "Shopping list contains: milk, bread, eggs",
                    "score": 0.95,
                    "metadata": {"title": "Shopping List"},
                    "document_url": "doc://shopping-list",
                }
            ]

            # Setup LLM response
            mock_response = MagicMock()
            mock_response.choices[0].message.content = (
                "Based on your shopping list, you need: milk, bread, eggs"
            )
            mock_response.choices[0].message.function_call = None
            mock_llm.return_value = mock_response

            response = await process_message(
                "What's on my shopping list?", self.chat_id
            )

            # Verify context was searched
            mock_search.assert_called_once()
            # Verify response includes source
            assert "Sources:" in response
            assert "Shopping List" in response

    @pytest.mark.asyncio
    async def test_performance_benchmarks(self):
        """Test that command processing meets performance requirements."""
        import time

        # Test Rails command performance
        with patch("src.rails.processors.list_processor.ListProcessor") as mock_proc:
            mock_instance = AsyncMock()
            mock_instance.process.return_value = "Quick response"
            mock_proc.return_value = mock_instance

            start_time = time.time()
            response = await process_message("/lists", self.chat_id)
            elapsed_time = time.time() - start_time

            # Rails commands should be fast
            assert (
                elapsed_time < 0.5
            ), f"Rails command took {elapsed_time}s, expected < 0.5s"
            assert response == "Quick response"

    @pytest.mark.asyncio
    async def test_malicious_input_handling(self):
        """Test handling of potentially malicious inputs."""
        malicious_inputs = [
            "/lists'; DROP TABLE users; --",
            "/lists <script>alert('xss')</script>",
            "/lists \x00\x01\x02",
            "/lists " + "x" * 10000,  # Very long input
            "/lists\n/start\n/help",  # Command injection attempt
        ]

        for malicious_input in malicious_inputs:
            # Should handle without security issues
            with patch(
                "src.rails.processors.list_processor.ListProcessor"
            ) as mock_proc:
                mock_instance = AsyncMock()
                mock_instance.process.return_value = "Safely processed"
                mock_proc.return_value = mock_instance

                try:
                    response = await process_message(malicious_input, self.chat_id)
                    # Should either process safely or reject
                    assert response is not None
                except Exception as e:
                    # Should not crash with unhandled exceptions
                    pytest.fail(f"Failed to handle malicious input safely: {e}")

    @pytest.mark.asyncio
    async def test_state_consistency_across_failures(self):
        """Test that system maintains consistent state despite failures."""
        # First command succeeds
        with patch("src.rails.processors.list_processor.ListProcessor") as mock_proc:
            mock_instance = AsyncMock()
            mock_instance.process.return_value = "Lists shown"
            mock_proc.return_value = mock_instance

            response1 = await process_message("/lists", self.chat_id)
            assert response1 == "Lists shown"

        # Second command fails
        with patch("src.rails.processors.task_processor.TaskProcessor") as mock_proc:
            mock_instance = AsyncMock()
            mock_instance.process.side_effect = Exception("Processing failed")
            mock_proc.return_value = mock_instance

            response2 = await process_message("/tnr", self.chat_id)
            assert "error" in response2.lower()

        # Third command should still work
        with patch(
            "src.rails.processors.field_report_processor.FieldReportProcessor"
        ) as mock_proc:
            mock_instance = AsyncMock()
            mock_instance.process.return_value = "Report created"
            mock_proc.return_value = mock_instance

            response3 = await process_message("/fr", self.chat_id)
            assert response3 == "Report created"
