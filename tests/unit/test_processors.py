"""Test processor functionality."""

import pytest
import json
from unittest.mock import AsyncMock, MagicMock
from src.rails.processors.list_processor import ListProcessor
from src.rails.processors.task_processor import TaskProcessor
from src.rails.processors.field_report_processor import FieldReportProcessor


class TestListProcessor:
    """Test list processor functionality."""

    def test_extraction_schemas_valid_json(self):
        """Test that all extraction schemas are valid JSON."""
        processor = ListProcessor(None)

        operations = [
            "create",
            "add_items",
            "remove_items",
            "rename",
            "clear",
            "read",
            "delete",
        ]

        for operation in operations:
            schema = processor.get_extraction_schema(operation)
            # Should parse as valid JSON without errors
            parsed = json.loads(schema)
            assert isinstance(parsed, dict)

            # Verify schema uses existing table field names
            if operation == "create":
                assert "list_name" in parsed  # matches lists.list_name
                assert "list_type" in parsed  # matches lists.list_type enum
            elif operation in ["add_items", "remove_items"]:
                assert "list_name" in parsed  # for finding existing list
                assert "items" in parsed  # for list_items.item_name_primary_text

    @pytest.mark.asyncio
    async def test_operation_validation(self):
        """Test operation validation logic."""
        # Mock supabase client with proper async response
        mock_supabase = MagicMock()
        mock_response = MagicMock()
        mock_response.data = []  # No sites, so no protection

        # Create an async function that returns the mock response
        async def async_execute():
            return mock_response

        # Make the execute() return a coroutine
        mock_table = MagicMock()
        mock_table.select.return_value.execute = async_execute
        mock_supabase.table.return_value = mock_table

        processor = ListProcessor(mock_supabase)

        # Valid operation
        valid, msg = await processor.validate_operation(
            "create", {"list_name": "shopping list"}, "user"
        )
        assert valid is True

        # Invalid operation (missing required field)
        valid, msg = await processor.validate_operation(
            "add_items", {"list_name": "shopping list"}, "user"  # missing 'items'
        )
        assert valid is False
        assert "Missing required fields" in msg

        # Admin-only operation
        valid, msg = await processor.validate_operation(
            "delete", {"list_name": "shopping list"}, "user"  # not admin
        )
        assert valid is False
        assert "admin privileges" in msg

    def test_confidence_boost_factors(self):
        """Test confidence boost calculation."""
        processor = ListProcessor(None)

        # Specific keywords boost (0.1)
        boost = processor.get_confidence_boost_factors(
            "add milk to shopping list", "add_items"
        )
        assert boost >= 0.1

        # Item enumeration boost (0.1 keyword + 0.05 comma = 0.15)
        boost = processor.get_confidence_boost_factors(
            "add milk, eggs, bread to list", "add_items"
        )
        assert boost >= 0.15  # Should have both keyword and comma boost

        # Site mention boost (0.1)
        boost = processor.get_confidence_boost_factors("list for Eagle Lake", "create")
        assert boost >= 0.1


class TestTaskProcessor:
    """Test task processor functionality."""

    def test_extraction_schemas_format(self):
        """Test extraction schema formats for all operations."""
        processor = TaskProcessor(None)

        # Test create schema
        schema = processor.get_extraction_schema("create")
        parsed = json.loads(schema)
        assert "task_title" in parsed
        assert "assigned_to" in parsed
        assert "due_date" in parsed
        assert "priority" in parsed

        # Test complete schema
        schema = processor.get_extraction_schema("complete")
        parsed = json.loads(schema)
        assert "task_title" in parsed
        assert "completion_notes" in parsed

        # Test reassign schema
        schema = processor.get_extraction_schema("reassign")
        parsed = json.loads(schema)
        assert "task_title" in parsed
        assert "new_assignee" in parsed

    @pytest.mark.asyncio
    async def test_assignee_validation(self):
        """Test that assignee validation works correctly."""
        # Mock supabase client
        mock_supabase = AsyncMock()
        mock_response = MagicMock()
        mock_response.data = [
            {"id": 1, "first_name": "Joel", "aliases": ["the canadian", "@joel"]},
            {"id": 2, "first_name": "Bryan", "aliases": ["@bryan"]},
        ]

        # Set up the mock to return properly
        mock_table = MagicMock()
        mock_table.select.return_value.eq.return_value.execute.return_value = (
            mock_response
        )
        mock_supabase.table.return_value = mock_table

        processor = TaskProcessor(mock_supabase)

        # Valid assignee by name
        valid, msg = await processor.validate_operation(
            "create", {"task_title": "Test task", "assigned_to": "joel"}, "user"
        )
        assert valid is True

        # Valid assignee by alias
        valid, msg = await processor.validate_operation(
            "reassign",
            {"task_title": "Test task", "new_assignee": "the canadian"},
            "user",
        )
        assert valid is True

        # Invalid assignee
        valid, msg = await processor.validate_operation(
            "create", {"task_title": "Test task", "assigned_to": "unknown_user"}, "user"
        )
        assert valid is False
        assert "Unknown user" in msg

    def test_confidence_boost_task_specific(self):
        """Test task-specific confidence boosts."""
        processor = TaskProcessor(None)

        # Time references boost - check what we actually get
        boost = processor.get_confidence_boost_factors(
            "new task for tomorrow at 3pm", "create"
        )
        # "new task" gives 0.1 (keyword), "tomorrow" and "at" and "pm" each give 0.1 (time indicators)
        assert boost >= 0.2

        # User mentions boost assignments
        boost = processor.get_confidence_boost_factors(
            "assign task to @joel", "reassign"
        )
        # "assign to" gives 0.1 (keyword), "@" gives 0.15 (user mention)
        assert boost >= 0.25  # keyword + @ mention

        # Priority indicators boost (0.05 for priority words)
        boost = processor.get_confidence_boost_factors(
            "urgent task high priority", "create"
        )
        assert boost >= 0.05


class TestFieldReportProcessor:
    """Test field report processor functionality."""

    def test_extraction_schemas_enums(self):
        """Test that extraction schemas include proper enums."""
        processor = FieldReportProcessor(None)

        # Create schema should have report types
        schema = processor.get_extraction_schema("create")
        parsed = json.loads(schema)
        assert "report_type" in parsed
        assert "Daily Operational Summary" in parsed["report_type"]
        assert "Incident Report" in parsed["report_type"]

        # Update status schema should have status enums
        schema = processor.get_extraction_schema("update_status")
        parsed = json.loads(schema)
        assert "new_status" in parsed
        assert "Draft" in parsed["new_status"]
        assert "Submitted" in parsed["new_status"]

    @pytest.mark.asyncio
    async def test_site_validation(self):
        """Test site name validation."""
        # Mock supabase client
        mock_supabase = AsyncMock()
        mock_response = MagicMock()
        mock_response.data = [
            {"site_name": "Eagle Lake"},
            {"site_name": "Crockett"},
            {"site_name": "Mathis"},
        ]

        # Set up the mock properly
        mock_table = MagicMock()
        mock_table.select.return_value.execute.return_value = mock_response
        mock_supabase.table.return_value = mock_table

        processor = FieldReportProcessor(mock_supabase)

        # Valid site
        valid, msg = await processor.validate_operation(
            "create",
            {"site_name": "Eagle Lake", "report_content_full": "Test report"},
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

    @pytest.mark.asyncio
    async def test_status_and_type_validation(self):
        """Test validation of status and report type values."""
        processor = FieldReportProcessor(None)

        # Valid status
        valid, msg = await processor.validate_operation(
            "update_status",
            {"report_identifier": "Report 1", "new_status": "Under Review"},
            "user",
        )
        assert valid is True

        # Invalid status
        valid, msg = await processor.validate_operation(
            "update_status",
            {"report_identifier": "Report 1", "new_status": "Invalid Status"},
            "user",
        )
        assert valid is False
        assert "Invalid status" in msg

        # Valid report type
        valid, msg = await processor.validate_operation(
            "create",
            {
                "site_name": "Eagle Lake",
                "report_content_full": "Test",
                "report_type": "Incident Report",
            },
            "user",
        )
        assert valid is True

    def test_confidence_boost_field_report_specific(self):
        """Test field report specific confidence boosts."""
        processor = FieldReportProcessor(None)

        # Site mention provides strong boost
        boost = processor.get_confidence_boost_factors(
            "field report for Eagle Lake", "create"
        )
        assert boost >= 0.15

        # Report type indicators boost
        boost = processor.get_confidence_boost_factors(
            "incident report about safety issue", "create"
        )
        assert boost >= 0.1

        # Status words boost update operations
        boost = processor.get_confidence_boost_factors(
            "finalize the report", "update_status"
        )
        assert boost >= 0.1

        # Time references boost
        boost = processor.get_confidence_boost_factors(
            "report from this morning shift", "create"
        )
        assert boost >= 0.05


@pytest.mark.asyncio
class TestProcessorErrorHandling:
    """Test processor behavior during failures."""

    async def test_database_connection_failure(self):
        """Test handling of database connection errors."""
        mock_supabase = AsyncMock()
        mock_supabase.table.side_effect = Exception("Connection refused")

        processor = ListProcessor(mock_supabase)
        valid, msg = await processor.validate_operation(
            "create", {"list_name": "test"}, "user"
        )

        assert valid is False
        assert "database" in msg.lower() or "error" in msg.lower()

    async def test_malformed_database_response(self):
        """Test handling of unexpected database responses."""
        mock_supabase = AsyncMock()

        # Set up the mock to return None
        mock_table = MagicMock()
        mock_table.select.return_value.eq.return_value.execute.return_value = None
        mock_supabase.table.return_value = mock_table

        processor = TaskProcessor(mock_supabase)
        valid, msg = await processor.validate_operation(
            "create", {"task_title": "Test", "assigned_to": "joel"}, "user"
        )

        # When response is None, it should be handled as no users found
        assert valid is False
        assert "unknown user" in msg.lower() or "error" in msg.lower()

    async def test_empty_aliases_array(self):
        """Test user validation with empty aliases."""
        mock_supabase = AsyncMock()
        mock_response = MagicMock()
        mock_response.data = [
            {"id": 1, "first_name": "Joel", "aliases": []},  # Empty aliases
            {"id": 2, "first_name": "Bryan"},  # Missing aliases field
        ]

        # Set up the mock properly
        mock_table = MagicMock()
        mock_table.select.return_value.eq.return_value.execute.return_value = (
            mock_response
        )
        mock_supabase.table.return_value = mock_table

        processor = TaskProcessor(mock_supabase)

        # Should still validate by first_name
        valid, msg = await processor.validate_operation(
            "create", {"task_title": "Test", "assigned_to": "joel"}, "user"
        )
        assert valid is True

        # Unknown user should fail
        valid, msg = await processor.validate_operation(
            "create", {"task_title": "Test", "assigned_to": "unknown"}, "user"
        )
        assert valid is False

    async def test_database_timeout(self):
        """Test handling of database timeouts."""
        mock_supabase = AsyncMock()

        # Set up the mock to raise TimeoutError
        mock_table = MagicMock()
        mock_table.select.return_value.execute.side_effect = TimeoutError(
            "Database query timed out"
        )
        mock_supabase.table.return_value = mock_table

        processor = FieldReportProcessor(mock_supabase)
        valid, msg = await processor.validate_operation(
            "create", {"site_name": "Test", "report_content_full": "Content"}, "user"
        )

        # The validate_operation should handle the timeout and return a validation error
        assert valid is False
        assert "error" in msg.lower() or "validation" in msg.lower()


@pytest.mark.parametrize(
    "operation,data,user_role,should_pass,error_contains",
    [
        # Required fields validation
        ("create", {}, "user", False, "Missing required fields"),
        ("create", {"list_name": "test"}, "user", True, None),
        # Admin-only operations
        ("delete", {"list_name": "test"}, "user", False, "admin privileges"),
        ("delete", {"list_name": "test"}, "admin", True, None),
        # Site-protected lists
        (
            "delete",
            {"list_name": "Eagle Lake Inventory"},
            "admin",
            False,
            "site-specific",
        ),
        ("delete", {"list_name": "Regular List"}, "admin", True, None),
        # Case sensitivity
        (
            "delete",
            {"list_name": "eagle lake inventory"},
            "admin",
            False,
            "site-specific",
        ),
        (
            "delete",
            {"list_name": "EAGLE LAKE INVENTORY"},
            "admin",
            False,
            "site-specific",
        ),
        # Task operations
        ("create", {"task_title": ""}, "user", False, "Missing required"),
        ("create", {"task_title": "Test", "assigned_to": "joel"}, "user", True, None),
        ("reassign", {"task_title": "Test"}, "user", False, "Missing required"),
        (
            "reassign",
            {"task_title": "Test", "new_assignee": "bryan"},
            "user",
            True,
            None,
        ),
        # Field report operations
        ("create", {"report_content_full": "Test"}, "user", False, "Missing required"),
        (
            "create",
            {"site_name": "Test", "report_content_full": "Content"},
            "user",
            True,
            None,
        ),
        (
            "update_status",
            {"report_identifier": "123", "new_status": "Invalid"},
            "user",
            False,
            "Invalid status",
        ),
    ],
)
async def test_validation_comprehensive(
    operation, data, user_role, should_pass, error_contains
):
    """Test all validation paths with various inputs."""
    # Mock sites for protected list checking
    mock_supabase = AsyncMock()
    mock_sites_response = MagicMock()
    mock_sites_response.data = [
        {"site_name": "Eagle Lake"},
        {"site_name": "Crockett"},
        {"site_name": "Mathis"},
    ]

    mock_personnel_response = MagicMock()
    mock_personnel_response.data = [
        {"id": 1, "first_name": "Joel", "aliases": []},
        {"id": 2, "first_name": "Bryan", "aliases": []},
    ]

    def table_mock(table_name):
        mock_table = MagicMock()
        if table_name == "sites":
            mock_table.select.return_value.execute.return_value = mock_sites_response
        elif table_name == "personnel":
            mock_table.select.return_value.eq.return_value.execute.return_value = (
                mock_personnel_response
            )
        return mock_table

    mock_supabase.table = table_mock

    # Determine which processor to use based on operation
    if operation in [
        "create",
        "delete",
        "add_items",
        "remove_items",
        "rename",
        "clear",
        "read",
    ]:
        if "list" in str(data):
            processor = ListProcessor(mock_supabase)
        elif "task" in str(data):
            processor = TaskProcessor(mock_supabase)
        else:
            processor = ListProcessor(mock_supabase)
    elif operation in ["reassign", "complete", "reschedule", "add_notes"]:
        processor = TaskProcessor(mock_supabase)
    elif operation in ["update_status", "add_followups"]:
        processor = FieldReportProcessor(mock_supabase)
    else:
        processor = ListProcessor(mock_supabase)

    valid, msg = await processor.validate_operation(operation, data, user_role)

    assert valid == should_pass
    if error_contains:
        assert error_contains in msg
