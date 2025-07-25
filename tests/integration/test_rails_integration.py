"""Integration tests for the Smart Rails system."""

import pytest
import json
import time
import asyncio
from unittest.mock import AsyncMock, MagicMock
from src.rails.router import KeywordRouter
from src.rails.processors.list_processor import ListProcessor
from src.rails.processors.task_processor import TaskProcessor
from src.rails.processors.field_report_processor import FieldReportProcessor


class TestRailsIntegration:
    """Test the complete rails pipeline integration."""

    @pytest.mark.asyncio
    async def test_end_to_end_list_routing(self):
        """Test complete routing pipeline for list operations."""
        # Mock supabase client
        mock_supabase = AsyncMock()

        # Mock personnel data for alias loading
        mock_personnel_response = MagicMock()
        mock_personnel_response.data = [
            {
                "id": 1,
                "first_name": "Joel",
                "aliases": ["the canadian", "@joel"],
                "is_active": True,
            },
            {"id": 2, "first_name": "Bryan", "aliases": ["@bryan"], "is_active": True},
        ]

        # Mock sites data for validation
        mock_sites_response = MagicMock()
        mock_sites_response.data = [
            {"site_name": "Eagle Lake"},
            {"site_name": "Crockett"},
            {"site_name": "Mathis"},
        ]

        # Configure mock responses
        def table_mock(table_name):
            mock_table = AsyncMock()
            if table_name == "personnel":
                mock_table.select.return_value.eq.return_value.execute.return_value = (
                    mock_personnel_response
                )
            elif table_name == "sites":
                mock_table.select.return_value.execute.return_value = (
                    mock_sites_response
                )
            return mock_table

        mock_supabase.table = table_mock

        # Initialize router with supabase
        router = KeywordRouter(mock_supabase)
        await router.ensure_aliases_loaded()

        # Test list creation routing
        result = router.route("create new shopping list for Eagle Lake")
        assert result.entity_type == "lists"
        assert result.operation == "create"
        assert result.confidence > 0.8
        assert result.extracted_data.get("site") == "Eagle Lake"

        # Test add items routing
        result = router.route("add milk, eggs, bread to shopping list")
        assert result.entity_type == "lists"
        assert result.operation == "add_items"
        assert result.extracted_data.get("items") == ["milk", "eggs", "bread"]

        # Validate with processor
        processor = ListProcessor(mock_supabase)
        valid, msg = await processor.validate_operation(
            "add_items",
            {"list_name": "shopping list", "items": ["milk", "eggs"]},
            "user",
        )
        assert valid is True

    @pytest.mark.asyncio
    async def test_end_to_end_task_routing_with_aliases(self):
        """Test task routing with user alias resolution."""
        # Mock supabase client
        mock_supabase = AsyncMock()

        # Mock personnel data
        mock_response = MagicMock()
        mock_response.data = [
            {
                "id": 1,
                "first_name": "Joel",
                "aliases": ["the canadian", "@joel"],
                "is_active": True,
            }
        ]

        def table_mock(table_name):
            mock_table = AsyncMock()
            mock_table.select.return_value.eq.return_value.execute.return_value = (
                mock_response
            )
            return mock_table

        mock_supabase.table = table_mock

        # Initialize router
        router = KeywordRouter(mock_supabase)
        await router.ensure_aliases_loaded()

        # Test task assignment with alias
        result = router.route(
            "create new task for the canadian to check generator tomorrow"
        )
        assert result.entity_type == "tasks"
        assert result.operation == "create"
        assert "joel" in result.target_users
        assert result.confidence > 0.9  # Should be high due to user assignment

        # Test hidden command
        result = router.route("/newtask Check oil levels @joel")
        assert result.confidence == 1.0
        assert result.use_direct_execution is True
        assert "joel" in result.target_users

        # Validate with processor
        processor = TaskProcessor(mock_supabase)
        valid, msg = await processor.validate_operation(
            "create",
            {"task_title": "Check generator", "assigned_to": "the canadian"},
            "user",
        )
        assert valid is True

    @pytest.mark.asyncio
    async def test_field_report_routing_and_validation(self):
        """Test field report routing with site validation."""
        # Mock supabase client
        mock_supabase = AsyncMock()

        # Mock sites data
        mock_response = MagicMock()
        mock_response.data = [{"site_name": "Eagle Lake"}, {"site_name": "Crockett"}]

        def table_mock(table_name):
            mock_table = AsyncMock()
            mock_table.select.return_value.execute.return_value = mock_response
            return mock_table

        mock_supabase.table = table_mock

        # Initialize router
        router = KeywordRouter(mock_supabase)

        # Test field report creation
        result = router.route(
            "new field report for Eagle Lake: generator maintenance completed"
        )
        assert result.entity_type == "field_reports"
        assert result.operation == "create"
        assert result.confidence > 0.8
        assert result.extracted_data.get("site") == "Eagle Lake"

        # Validate with processor
        processor = FieldReportProcessor(mock_supabase)

        # Valid site
        valid, msg = await processor.validate_operation(
            "create",
            {
                "site_name": "Eagle Lake",
                "report_content_full": "Generator maintenance completed",
                "report_type": "Maintenance Log",
            },
            "user",
        )
        assert valid is True

        # Invalid site
        valid, msg = await processor.validate_operation(
            "create",
            {"site_name": "Unknown Site", "report_content_full": "Test report"},
            "user",
        )
        assert valid is False
        assert "Unknown site" in msg

    def test_telegram_command_routing(self):
        """Test Telegram command routing behaviors."""
        router = KeywordRouter()

        # Direct command routing
        result = router.route("/tnr show my tasks")
        assert result.entity_type == "tasks"
        assert result.confidence > 0.8

        # Interactive mode when no operation matches
        result = router.route("/lists")
        assert result.entity_type == "lists"
        assert result.operation == "interactive"
        assert result.confidence == 1.0
        assert result.use_direct_execution is False

        # Inline command boost
        result = router.route("show /fr for Eagle Lake")
        assert result.entity_type == "field_reports"

    def test_extraction_schema_integration(self):
        """Test that extraction schemas work together properly."""
        router = KeywordRouter()
        list_processor = ListProcessor(None)
        task_processor = TaskProcessor(None)
        FieldReportProcessor(None)

        # Route a message
        result = router.route("add milk to shopping list")

        # Get corresponding extraction schema
        schema = list_processor.get_extraction_schema(result.operation)
        parsed = json.loads(schema)

        # Verify schema matches what was extracted
        assert "list_name" in parsed
        assert "items" in parsed
        assert result.operation == "add_items"

        # Test task routing and schema
        result = router.route("reassign generator task to @joel")
        schema = task_processor.get_extraction_schema(result.operation)
        parsed = json.loads(schema)

        assert "task_title" in parsed
        assert "new_assignee" in parsed
        assert result.operation == "reassign"


class TestPerformance:
    """Test performance requirements are met."""

    def test_routing_performance(self):
        """Router should process messages under 10ms."""
        router = KeywordRouter()

        # Warm up
        router.route("test message")

        # Test various message complexities
        messages = [
            "add milk to list",  # Simple
            "add milk, eggs, bread, butter, cheese to shopping list",  # Complex
            "create new task for @user to check generator tomorrow at 3pm with high priority",  # Very complex
        ]

        for message in messages:
            start = time.perf_counter()
            result = router.route(message)
            elapsed = (time.perf_counter() - start) * 1000  # Convert to ms

            assert elapsed < 10, f"Routing took {elapsed:.2f}ms for: {message}"
            assert result is not None

    @pytest.mark.asyncio
    async def test_concurrent_routing(self):
        """Test router handles concurrent requests without issues."""
        router = KeywordRouter()

        async def route_message(msg):
            return router.route(msg)

        # Create 100 concurrent routing requests
        messages = [f"add item{i} to list" for i in range(100)]

        start = time.perf_counter()
        results = await asyncio.gather(*[route_message(msg) for msg in messages])
        elapsed = time.perf_counter() - start

        # Should complete 100 requests in under 1 second
        assert elapsed < 1.0
        assert len(results) == 100
        assert all(r.operation == "add_items" for r in results)

    @pytest.mark.asyncio
    async def test_router_state_isolation(self):
        """Test that router instances don't share state."""
        # Create two routers with different configs
        router1 = KeywordRouter()
        router2 = KeywordRouter()

        # Modify router1's aliases
        router1.synonym_lib.user_aliases = {"custom_alias": "user1"}

        # router2 should not have this alias
        assert "custom_alias" not in router2.synonym_lib.user_aliases

        # Both should route independently
        result1 = router1.route("assign to custom_alias")
        result2 = router2.route("assign to custom_alias")

        # router1 should find the alias
        assert "user1" in result1.target_users or len(result1.target_users) > 0
        # router2 should not
        assert "user1" not in result2.target_users

    def test_performance_with_many_aliases(self):
        """Test routing performance doesn't degrade with many aliases."""
        router = KeywordRouter()

        # Add many aliases
        for i in range(1000):
            router.synonym_lib.user_aliases[f"alias{i}"] = f"user{i % 10}"

        # Test performance is still acceptable
        start = time.perf_counter()
        result = router.route("assign task to alias500")
        elapsed = (time.perf_counter() - start) * 1000

        assert elapsed < 20, f"Routing with many aliases took {elapsed:.2f}ms"
        assert "user0" in result.target_users  # alias500 maps to user0

    @pytest.mark.asyncio
    async def test_database_operation_performance(self):
        """Test database operations complete in reasonable time."""
        mock_supabase = AsyncMock()

        # Mock a slow database response
        async def slow_response():
            await asyncio.sleep(0.1)  # 100ms delay
            return MagicMock(data=[{"id": 1, "first_name": "Test"}])

        mock_supabase.table().select().eq().execute = slow_response

        processor = TaskProcessor(mock_supabase)

        start = time.perf_counter()
        valid, msg = await processor.validate_operation(
            "create", {"task_title": "Test", "assigned_to": "test"}, "user"
        )
        elapsed = time.perf_counter() - start

        # Should complete even with slow DB
        assert elapsed < 0.5  # 500ms max
        assert valid is True
