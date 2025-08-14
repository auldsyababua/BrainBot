"""Comprehensive edge case tests for Rails router integration."""

import asyncio
import time
from unittest.mock import AsyncMock, MagicMock, Mock, patch

import pytest

from src.core.llm import _process_rails_command, process_message
from src.rails.router import KeywordRouter, RouteResult


class TestRouterEdgeCases:
    """Test non-happy path scenarios for the Rails router."""

    def setup_method(self):
        """Set up test fixtures."""
        self.router = KeywordRouter()
        self.chat_id = "test_chat_123"

    def test_malformed_commands(self):
        """Test router behavior with malformed commands."""
        malformed_commands = [
            "/lists@#$%",  # Special characters
            "/lists\n\ntest",  # Newlines in command
            "/lists<script>alert('xss')</script>",  # HTML injection attempt
            "/lists' OR 1=1--",  # SQL injection attempt
            "/lists\x00null",  # Null byte
            "/lists" * 1000,  # Extremely long command
            "//lists",  # Double slash
            "/ lists",  # Space after slash
            "/",  # Just slash
            "/123lists",  # Numbers before command
            "/lists\t\ttabs",  # Tab characters
            "/lists\r\nCRLF",  # CRLF injection
        ]

        for cmd in malformed_commands:
            result = self.router.route(cmd)
            # Router should safely handle malformed commands
            assert result is not None, f"Router returned None for: {cmd}"
            # Should either return no match or low confidence
            if result.entity_type:
                assert result.confidence < 0.5, f"High confidence for malformed: {cmd}"

    def test_empty_and_invalid_inputs(self):
        """Test router with empty and invalid inputs."""
        invalid_inputs = [
            None,
            "",
            " ",
            "\n",
            "\t",
            123,  # Non-string
            [],  # List
            {},  # Dict
            object(),  # Object
        ]

        for inp in invalid_inputs:
            result = self.router.route(inp)
            assert result is not None
            assert result.entity_type is None
            assert result.confidence == 0.0

    @pytest.mark.asyncio
    async def test_router_initialization_failure(self):
        """Test behavior when router fails to initialize."""
        with patch("src.core.llm.KeywordRouter") as mock_router_class:
            mock_router_class.side_effect = Exception("Router init failed")

            # The module should handle initialization failure gracefully
            from importlib import reload

            import src.core.llm

            with patch("logging.Logger.error") as mock_logger:
                reload(src.core.llm)
                # Should log the error
                mock_logger.assert_called()
                # keyword_router should be None
                assert src.core.llm.keyword_router is None

    @pytest.mark.asyncio
    async def test_database_connection_failure(self):
        """Test router behavior when database connection fails during alias loading."""
        mock_supabase = Mock()
        mock_supabase.table.side_effect = Exception("Database connection failed")

        router = KeywordRouter(supabase_client=mock_supabase)

        # Try to load aliases
        await router.ensure_aliases_loaded()

        # Router should continue working without aliases
        result = router.route("/lists add milk")
        assert result is not None
        assert result.entity_type == "lists"

    @pytest.mark.asyncio
    async def test_processor_execution_timeout(self):
        """Test handling of processor execution timeouts."""
        route_result = RouteResult(
            entity_type="lists",
            operation="create",
            function_name="create_list",
            confidence=0.9,
            extracted_data={"suggested_name": "test list"},
            use_direct_execution=True,
            target_users=[],
        )

        # Mock a processor that times out
        with patch(
            "src.rails.processors.list_processor.ListProcessor"
        ) as mock_processor_class:
            mock_instance = AsyncMock()
            mock_processor_class.return_value = mock_instance

            # Simulate a timeout
            async def timeout_process(*args, **kwargs):
                await asyncio.sleep(10)  # Long delay

            mock_instance.process = timeout_process

            # Use asyncio.wait_for to simulate timeout handling
            with pytest.raises(asyncio.TimeoutError):
                await asyncio.wait_for(
                    _process_rails_command(route_result, self.chat_id), timeout=0.1
                )

    @pytest.mark.asyncio
    async def test_processor_memory_exhaustion(self):
        """Test handling when processor causes memory issues."""
        route_result = RouteResult(
            entity_type="lists",
            operation="create",
            function_name="create_list",
            confidence=0.9,
            extracted_data={"suggested_name": "x" * 10**6},  # Very long name
            use_direct_execution=True,
            target_users=[],
        )

        with patch(
            "src.rails.processors.list_processor.ListProcessor"
        ) as mock_processor_class:
            mock_instance = AsyncMock()
            mock_processor_class.return_value = mock_instance

            # Simulate memory error
            mock_instance.process.side_effect = MemoryError("Out of memory")

            response = await _process_rails_command(route_result, self.chat_id)
            assert "error occurred" in response.lower()

    def test_concurrent_routing_conflicts(self):
        """Test router behavior under concurrent access."""
        import queue
        import threading

        results_queue = queue.Queue()
        errors_queue = queue.Queue()

        def route_command(cmd, result_q, error_q):
            try:
                result = self.router.route(cmd)
                result_q.put(result)
            except Exception as e:
                error_q.put(e)

        # Create multiple threads routing different commands
        threads = []
        commands = ["/lists add item", "/tasks create task", "/fr new report"] * 10

        for cmd in commands:
            t = threading.Thread(
                target=route_command, args=(cmd, results_queue, errors_queue)
            )
            threads.append(t)
            t.start()

        # Wait for all threads
        for t in threads:
            t.join()

        # Check no errors occurred
        assert errors_queue.empty(), "Errors occurred during concurrent routing"

        # Check all results are valid
        while not results_queue.empty():
            result = results_queue.get()
            assert result is not None
            assert result.entity_type in ["lists", "tasks", "field_reports"]

    @pytest.mark.asyncio
    async def test_rails_router_returning_none(self):
        """Test handling when Rails router returns None results."""
        with patch("src.core.llm.keyword_router") as mock_router:
            mock_router.route.return_value = None

            # Should fall back to LLM
            with patch("src.core.llm.resilient_client.chat_completion") as mock_llm:
                mock_response = MagicMock()
                mock_response.choices[0].message.content = "LLM response"
                mock_response.choices[0].message.function_call = None
                mock_llm.return_value = mock_response

                response = await process_message("/lists", self.chat_id)
                assert response == "LLM response"
                mock_llm.assert_called_once()

    @pytest.mark.asyncio
    async def test_invalid_route_result_structure(self):
        """Test handling of invalid RouteResult structures."""
        # Create route results with missing attributes
        invalid_results = [
            Mock(entity_type=None, operation="create"),
            Mock(entity_type="lists", operation=None),
            Mock(),  # No attributes
            RouteResult(
                entity_type="invalid_type",
                operation="create",
                function_name=None,
                confidence=0.9,
            ),
        ]

        for result in invalid_results:
            response = await _process_rails_command(result, self.chat_id)
            # Should handle gracefully
            assert response is None or "error" in response.lower()

    @pytest.mark.asyncio
    async def test_processor_import_failure(self):
        """Test handling when processor modules fail to import."""
        route_result = RouteResult(
            entity_type="lists",
            operation="create",
            function_name="create_list",
            confidence=0.9,
        )

        with patch("builtins.__import__", side_effect=ImportError("Module not found")):
            response = await _process_rails_command(route_result, self.chat_id)
            assert "error occurred" in response.lower()

    def test_cache_overflow_handling(self):
        """Test router behavior when cache exceeds limits."""
        # Generate many unique commands to overflow cache
        for i in range(100):  # More than cache limit
            cmd = f"/lists add item{i}"
            result = self.router.route(cmd)
            assert result is not None

        # Check cache size is within limits
        assert len(self.router._recent_routes) <= self.router._max_cache_size

        # Verify oldest entries are evicted
        early_cmd = "/lists add item0"
        cache_key = hash(early_cmd)
        assert cache_key not in self.router._recent_routes

    @pytest.mark.asyncio
    async def test_fallback_to_llm_on_routing_exception(self):
        """Test that exceptions in routing fall back to LLM gracefully."""
        with patch("src.core.llm.keyword_router.route") as mock_route:
            mock_route.side_effect = Exception("Routing failed")

            with patch("src.core.llm.resilient_client.chat_completion") as mock_llm:
                mock_response = MagicMock()
                mock_response.choices[0].message.content = "Fallback response"
                mock_response.choices[0].message.function_call = None
                mock_llm.return_value = mock_response

                response = await process_message("/lists add milk", self.chat_id)
                assert response == "Fallback response"
                mock_llm.assert_called_once()

    def test_performance_under_load(self):
        """Test router performance with many rapid requests."""
        commands = [
            "/lists add milk",
            "/tasks create task",
            "/fr new report",
            "/lists show",
            "/tnr assign @user",
        ] * 100  # 500 total commands

        start_time = time.time()
        results = []

        for cmd in commands:
            result = self.router.route(cmd)
            results.append(result)

        elapsed_time = time.time() - start_time
        avg_time_ms = (elapsed_time / len(commands)) * 1000

        # Performance assertions
        assert avg_time_ms < 10, f"Average routing time {avg_time_ms}ms exceeds 10ms"

        # Verify all results are valid
        for result in results:
            assert result is not None
            assert result.entity_type in ["lists", "tasks", "field_reports", None]

    @pytest.mark.asyncio
    async def test_chat_id_validation(self):
        """Test handling of invalid chat IDs."""
        route_result = RouteResult(
            entity_type="lists",
            operation="create",
            function_name="create_list",
            confidence=0.9,
        )

        invalid_chat_ids = [
            None,
            "",
            "<script>alert('xss')</script>",
            "'; DROP TABLE users; --",
            "x" * 1000,  # Very long ID
            123,  # Non-string
            ["list"],  # List
            {"id": "test"},  # Dict
        ]

        for chat_id in invalid_chat_ids:
            # Should handle gracefully without crashing
            try:
                response = await _process_rails_command(route_result, chat_id)
                assert response is not None
            except Exception as e:
                pytest.fail(f"Failed to handle chat_id {chat_id}: {e}")

    def test_message_preprocessing_edge_cases(self):
        """Test message preprocessing with edge cases."""
        edge_cases = [
            ("/lists @", {}),  # @ without username
            ("/lists @@double", {}),  # Double @
            ("/lists @123invalid", {}),  # Invalid username format
            ("/lists @ space", {}),  # Space after @
            ("/lists@nospace", {"entity_type": "lists"}),  # No space after command
            ("@user /lists", {"assignee": "user"}),  # @ before command
            ("/lists /tasks", {"entity_type": "lists"}),  # Multiple commands
        ]

        for message, expected_prefilled in edge_cases:
            cleaned, prefilled, _ = self.router.preprocess_message(message)
            for key, value in expected_prefilled.items():
                assert (
                    prefilled.get(key) == value
                ), f"Failed for {message}: expected {key}={value}"
