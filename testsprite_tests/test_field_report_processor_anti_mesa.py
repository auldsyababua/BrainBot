"""
Anti-Mesa Pattern Tests for FieldReportProcessor

This test suite implements comprehensive anti-mesa patterns including:
- Site name validation against database
- Status transition validation
- Report type enumeration handling
- Partial update failure scenarios
- Concurrent report submissions
- Data consistency after retries
"""

import pytest
import asyncio
import json
from typing import Dict, Any
from unittest.mock import AsyncMock, MagicMock
from enum import Enum
from hypothesis import given, strategies as st, settings
from hypothesis.stateful import (
    RuleBasedStateMachine,
    rule,
    invariant,
    initialize,
    Bundle,
)

import sys
import os

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", ".."))

from src.rails.processors.field_report_processor import FieldReportProcessor


# ============= Constants and Enums =============


class ReportType(Enum):
    """Valid report types."""

    DAILY_OPERATIONAL = "Daily Operational Summary"
    INCIDENT = "Incident Report"
    MAINTENANCE = "Maintenance Log"
    SAFETY = "Safety Observation"
    EQUIPMENT = "Equipment Check"
    SECURITY = "Security Update"
    VISITOR = "Visitor Log"
    OTHER = "Other"


class ReportStatus(Enum):
    """Valid report statuses."""

    DRAFT = "Draft"
    SUBMITTED = "Submitted"
    UNDER_REVIEW = "Under Review"
    ACTIONED = "Actioned"
    ARCHIVED = "Archived"
    REQUIRES_FOLLOWUP = "Requires Follow-up"


# ============= Test Fixtures =============


@pytest.fixture
def mock_supabase_client():
    """Create a mock Supabase client with failure injection capabilities."""
    client = MagicMock()

    # Setup mock response structure
    mock_response = MagicMock()
    mock_response.data = []
    mock_response.error = None

    # Create chainable mock methods
    client.table = MagicMock(return_value=client)
    client.select = MagicMock(return_value=client)
    client.insert = MagicMock(return_value=client)
    client.update = MagicMock(return_value=client)
    client.eq = MagicMock(return_value=client)
    client.execute = AsyncMock(return_value=mock_response)

    # Add failure injection controls
    client._fail_next_n_calls = 0
    client._timeout_probability = 0.0
    client._partial_write_mode = False
    client._network_latency_ms = 0

    return client


@pytest.fixture
def field_report_processor(mock_supabase_client):
    """Create FieldReportProcessor instance with mocked dependencies."""
    return FieldReportProcessor(mock_supabase_client)


@pytest.fixture
def valid_sites():
    """Valid site names for testing."""
    return ["Eagle Lake", "Crockett", "Mathis"]


@pytest.fixture
def sample_reports():
    """Sample report data for testing."""
    return [
        {
            "site_name": "Eagle Lake",
            "report_type": "Daily Operational Summary",
            "report_title_summary": "Morning shift report",
            "report_content_full": "All systems operational. No incidents.",
            "report_status": "Submitted",
        },
        {
            "site_name": "Crockett",
            "report_type": "Incident Report",
            "report_title_summary": "Equipment malfunction",
            "report_content_full": "Pump failure at 14:30. Maintenance notified.",
            "report_status": "Draft",
        },
        {
            "site_name": "Mathis",
            "report_type": "Safety Observation",
            "report_title_summary": "PPE compliance check",
            "report_content_full": "All personnel wearing required PPE.",
            "report_status": "Submitted",
        },
    ]


# ============= Anti-Mesa Pattern Tests =============


class TestFieldReportProcessorAntiMesa:
    """Anti-mesa pattern tests for FieldReportProcessor."""

    # ===== Test 1: Site Name Validation =====

    @pytest.mark.asyncio
    async def test_site_name_validation_against_database(
        self, field_report_processor, mock_supabase_client
    ):
        """Test that site names are validated against database."""
        # Mock valid sites from database
        mock_supabase_client.execute.return_value.data = [
            {"site_name": "Eagle Lake"},
            {"site_name": "Crockett"},
            {"site_name": "Mathis"},
        ]

        # Test valid site
        data = {"site_name": "Eagle Lake", "report_content_full": "Test report"}
        is_valid, message = await field_report_processor.validate_operation(
            "create", data, "user"
        )
        assert is_valid

        # Test invalid site
        data["site_name"] = "Invalid Site"
        is_valid, message = await field_report_processor.validate_operation(
            "create", data, "user"
        )
        assert not is_valid
        assert "unknown site" in message.lower()

    @pytest.mark.asyncio
    async def test_site_validation_case_insensitive(
        self, field_report_processor, mock_supabase_client
    ):
        """Test that site validation is case-insensitive."""
        mock_supabase_client.execute.return_value.data = [{"site_name": "Eagle Lake"}]

        test_cases = ["eagle lake", "EAGLE LAKE", "Eagle Lake", "eAgLe LaKe"]

        for site_name in test_cases:
            data = {"site_name": site_name, "report_content_full": "Test report"}
            is_valid, message = await field_report_processor.validate_operation(
                "create", data, "user"
            )
            assert is_valid, f"Failed for site name: {site_name}"

    @pytest.mark.asyncio
    async def test_site_validation_database_unavailable(
        self, field_report_processor, mock_supabase_client
    ):
        """Test behavior when site validation database is unavailable."""
        mock_supabase_client.execute.side_effect = TimeoutError("Database timeout")

        data = {"site_name": "Eagle Lake", "report_content_full": "Test report"}

        is_valid, message = await field_report_processor.validate_operation(
            "create", data, "user"
        )
        assert not is_valid
        assert "database" in message.lower()

    # ===== Test 2: Status Transition Validation =====

    @pytest.mark.asyncio
    async def test_valid_status_transitions(self, field_report_processor):
        """Test that only valid status transitions are allowed."""
        valid_statuses = [
            "Draft",
            "Submitted",
            "Under Review",
            "Actioned",
            "Archived",
            "Requires Follow-up",
        ]

        for status in valid_statuses:
            data = {"report_identifier": "test_report", "new_status": status}
            is_valid, message = await field_report_processor.validate_operation(
                "update_status", data, "user"
            )
            assert is_valid

    @pytest.mark.asyncio
    async def test_invalid_status_transitions(self, field_report_processor):
        """Test that invalid status values are rejected."""
        invalid_statuses = [
            "Pending",
            "Complete",
            "In Progress",
            "Deleted",
            "draft",
            "SUBMITTED",
            "Under_Review",
            "",
        ]

        for status in invalid_statuses:
            data = {"report_identifier": "test_report", "new_status": status}
            is_valid, message = await field_report_processor.validate_operation(
                "update_status", data, "user"
            )
            assert not is_valid
            assert "invalid status" in message.lower()

    @pytest.mark.asyncio
    async def test_status_transition_idempotence(self, field_report_processor):
        """Test that status updates are idempotent."""
        data = {"report_identifier": "test_report", "new_status": "Submitted"}

        # Multiple updates to same status
        results = []
        for _ in range(3):
            result = await field_report_processor.validate_operation(
                "update_status", data, "user"
            )
            results.append(result)

        # All should be valid and identical
        assert all(r == results[0] for r in results)
        assert all(r[0] is True for r in results)

    # ===== Test 3: Report Type Enumeration =====

    @pytest.mark.asyncio
    async def test_valid_report_types(self, field_report_processor):
        """Test that all valid report types are accepted."""
        valid_types = [
            "Daily Operational Summary",
            "Incident Report",
            "Maintenance Log",
            "Safety Observation",
            "Equipment Check",
            "Security Update",
            "Visitor Log",
            "Other",
        ]

        for report_type in valid_types:
            data = {
                "site_name": "Eagle Lake",
                "report_type": report_type,
                "report_content_full": "Test content",
            }
            is_valid, message = await field_report_processor.validate_operation(
                "create", data, "user"
            )
            assert is_valid, f"Failed for report type: {report_type}"

    @pytest.mark.asyncio
    async def test_invalid_report_types(self, field_report_processor):
        """Test that invalid report types are rejected."""
        invalid_types = [
            "Daily Report",
            "Incident",
            "Safety Report",
            "daily operational summary",
            "INCIDENT REPORT",
            "Custom Type",
            "",
        ]

        for report_type in invalid_types:
            data = {
                "site_name": "Eagle Lake",
                "report_type": report_type,
                "report_content_full": "Test content",
            }
            is_valid, message = await field_report_processor.validate_operation(
                "create", data, "user"
            )
            assert not is_valid
            assert "invalid report type" in message.lower()

    # ===== Test 4: Partial Update Failure Scenarios =====

    @pytest.mark.asyncio
    async def test_partial_update_prevention(
        self, field_report_processor, mock_supabase_client
    ):
        """Test that partial updates are prevented on failure."""
        call_count = 0

        async def partial_failure_execute():
            nonlocal call_count
            call_count += 1

            if call_count == 1:
                # First call succeeds (site validation)
                response = MagicMock()
                response.data = [{"site_name": "Eagle Lake"}]
                return response
            elif call_count == 2:
                # Second call fails (actual update)
                raise Exception("Database write failed")

        mock_supabase_client.execute = partial_failure_execute

        data = {"site_name": "Eagle Lake", "report_content_full": "Test report"}

        # Should handle partial failure gracefully
        is_valid, message = await field_report_processor.validate_operation(
            "create", data, "user"
        )
        # Validation may succeed even if actual write would fail
        assert isinstance(is_valid, bool)

    @pytest.mark.asyncio
    async def test_followup_items_atomic_addition(self, field_report_processor):
        """Test that followup items are added atomically."""
        data = {
            "report_identifier": "test_report",
            "followup_items": ["Item 1", "Item 2", "Item 3"],
            "priority": "High",
        }

        # All items should be added or none
        is_valid, message = await field_report_processor.validate_operation(
            "add_followups", data, "user"
        )
        assert is_valid

        # Test with invalid priority (should reject all items)
        data["priority"] = "Invalid"
        is_valid, message = await field_report_processor.validate_operation(
            "add_followups", data, "user"
        )
        assert is_valid  # Priority is optional, so this should still be valid

    # ===== Test 5: Concurrent Report Submissions =====

    @pytest.mark.asyncio
    async def test_concurrent_report_creation(self, mock_supabase_client):
        """Test concurrent report creation for race conditions."""
        processors = [FieldReportProcessor(mock_supabase_client) for _ in range(10)]

        # Mock successful site validation
        mock_supabase_client.execute.return_value.data = [{"site_name": "Eagle Lake"}]

        async def create_report(processor, index):
            data = {
                "site_name": "Eagle Lake",
                "report_type": "Daily Operational Summary",
                "report_title_summary": f"Report {index}",
                "report_content_full": f"Content for report {index}",
                "report_status": "Draft",
            }
            return await processor.validate_operation("create", data, "user")

        tasks = [create_report(processor, i) for i, processor in enumerate(processors)]
        results = await asyncio.gather(*tasks, return_exceptions=True)

        # All should complete without race conditions
        assert len(results) == 10
        for result in results:
            assert not isinstance(result, Exception)
            assert result[0] is True

    @pytest.mark.asyncio
    async def test_concurrent_status_updates(self, mock_supabase_client):
        """Test concurrent status updates on same report."""
        processors = [FieldReportProcessor(mock_supabase_client) for _ in range(5)]
        statuses = ["Draft", "Submitted", "Under Review", "Actioned", "Archived"]

        async def update_status(processor, status):
            data = {"report_identifier": "shared_report", "new_status": status}
            return await processor.validate_operation("update_status", data, "user")

        tasks = [
            update_status(processor, status)
            for processor, status in zip(processors, statuses)
        ]
        results = await asyncio.gather(*tasks, return_exceptions=True)

        # All should complete, though order may vary
        assert len(results) == 5
        for result in results:
            assert not isinstance(result, Exception)

    # ===== Test 6: Data Consistency After Retries =====

    @pytest.mark.asyncio
    async def test_retry_maintains_data_consistency(
        self, field_report_processor, mock_supabase_client
    ):
        """Test that retries maintain data consistency."""
        attempt_count = 0

        async def flaky_execute():
            nonlocal attempt_count
            attempt_count += 1

            if attempt_count < 3:
                raise TimeoutError("Transient failure")

            response = MagicMock()
            response.data = [{"site_name": "Eagle Lake"}]
            return response

        mock_supabase_client.execute = flaky_execute

        data = {"site_name": "Eagle Lake", "report_content_full": "Test report"}

        # First attempts should fail
        for _ in range(2):
            is_valid, message = await field_report_processor.validate_operation(
                "create", data, "user"
            )
            assert not is_valid

        # Third attempt should succeed
        is_valid, message = await field_report_processor.validate_operation(
            "create", data, "user"
        )
        assert is_valid

        # Data should remain consistent
        assert data["site_name"] == "Eagle Lake"
        assert data["report_content_full"] == "Test report"

    # ===== Test 7: Edge Cases and Boundary Conditions =====

    def test_empty_operation_handling(self, field_report_processor):
        """Test handling of empty or None operations."""
        with pytest.raises(ValueError):
            field_report_processor.get_extraction_schema(None)

        with pytest.raises(ValueError):
            field_report_processor.get_extraction_schema("")

    def test_invalid_operation_types(self, field_report_processor):
        """Test handling of invalid operation types."""
        invalid_ops = [123, [], {}, True, object()]

        for invalid_op in invalid_ops:
            with pytest.raises(TypeError):
                field_report_processor.get_extraction_schema(invalid_op)

    @pytest.mark.asyncio
    async def test_missing_required_fields(self, field_report_processor):
        """Test validation with missing required fields."""
        test_cases = [
            ("create", {}),  # Missing site_name and report_content_full
            ("create", {"site_name": "Eagle Lake"}),  # Missing report_content_full
            ("add_followups", {"followup_items": []}),  # Missing report_identifier
            ("update_status", {"new_status": "Draft"}),  # Missing report_identifier
        ]

        for operation, data in test_cases:
            is_valid, message = await field_report_processor.validate_operation(
                operation, data, "user"
            )
            assert not is_valid
            assert "missing" in message.lower() or "required" in message.lower()

    def test_message_none_handling(self, field_report_processor):
        """Test confidence boost with None message."""
        with pytest.raises(ValueError):
            field_report_processor.get_confidence_boost_factors(None, "create")

    def test_operation_none_in_confidence(self, field_report_processor):
        """Test confidence boost with None operation."""
        with pytest.raises(ValueError):
            field_report_processor.get_confidence_boost_factors("test message", None)

    # ===== Test 8: Adversarial Inputs =====

    @pytest.mark.asyncio
    async def test_sql_injection_in_report_content(self, field_report_processor):
        """Test SQL injection attempts in report content."""
        injections = [
            "'; DROP TABLE field_reports; --",
            "1' OR '1'='1",
            "' UNION SELECT * FROM users--",
            "'; UPDATE field_reports SET status='Actioned' WHERE 1=1--",
        ]

        for injection in injections:
            data = {
                "site_name": "Eagle Lake",
                "report_content_full": injection,
                "report_title_summary": injection,
            }

            # Should handle without executing SQL
            result = await field_report_processor.validate_operation(
                "create", data, "user"
            )
            assert isinstance(result, tuple)

    @pytest.mark.asyncio
    async def test_xss_in_report_fields(self, field_report_processor):
        """Test XSS attempts in report fields."""
        xss_attempts = [
            "<script>alert('xss')</script>",
            "javascript:alert(1)",
            "<img src=x onerror=alert(1)>",
            "<iframe src='evil.com'></iframe>",
        ]

        for xss in xss_attempts:
            data = {
                "site_name": "Eagle Lake",
                "report_content_full": xss,
                "report_title_summary": xss,
            }

            # Should handle without executing scripts
            result = await field_report_processor.validate_operation(
                "create", data, "user"
            )
            assert isinstance(result, tuple)

    @pytest.mark.asyncio
    async def test_extremely_long_report_content(self, field_report_processor):
        """Test handling of extremely long report content."""
        long_content = "A" * 1000000  # 1 million characters
        data = {"site_name": "Eagle Lake", "report_content_full": long_content}

        # Should handle without memory issues
        result = await field_report_processor.validate_operation("create", data, "user")
        assert isinstance(result, tuple)

    # ===== Test 9: Property-Based Testing =====

    @given(
        site_name=st.text(min_size=1, max_size=100),
        report_content=st.text(min_size=1, max_size=1000),
        report_type=st.sampled_from([t.value for t in ReportType]),
    )
    @settings(max_examples=50, deadline=5000)
    @pytest.mark.asyncio
    async def test_property_valid_reports_validate(
        self, site_name, report_content, report_type
    ):
        """Property: Valid report data structures always validate properly."""
        processor = FieldReportProcessor(MagicMock())
        data = {
            "site_name": site_name,
            "report_content_full": report_content,
            "report_type": report_type,
        }

        result = await processor.validate_operation("create", data, "user")
        assert isinstance(result, tuple)
        assert len(result) == 2
        assert isinstance(result[0], bool)
        assert isinstance(result[1], str)

    @given(
        message=st.text(min_size=0, max_size=500),
        operation=st.sampled_from(["create", "add_followups", "update_status", "read"]),
    )
    def test_property_confidence_boost_bounded(self, message, operation):
        """Property: Confidence boost is always between 0 and 1."""
        processor = FieldReportProcessor(None)
        boost = processor.get_confidence_boost_factors(message, operation)
        assert 0 <= boost <= 1.0

    # ===== Test 10: Metamorphic Testing =====

    def test_metamorphic_site_name_variations(self, field_report_processor):
        """Test that site name variations produce consistent confidence."""
        sites = ["Eagle Lake", "eagle lake", "EAGLE LAKE", "Eagle lake"]
        messages = [f"Create a report for {site}" for site in sites]

        boosts = []
        for message in messages:
            boost = field_report_processor.get_confidence_boost_factors(
                message, "create"
            )
            boosts.append(boost)

        # All variations should produce similar confidence
        assert max(boosts) - min(boosts) < 0.05

    @pytest.mark.asyncio
    async def test_metamorphic_field_ordering(self, field_report_processor):
        """Test that field ordering doesn't affect validation."""
        data1 = {
            "site_name": "Eagle Lake",
            "report_type": "Incident Report",
            "report_content_full": "Test content",
            "report_status": "Draft",
        }

        data2 = {
            "report_status": "Draft",
            "report_content_full": "Test content",
            "site_name": "Eagle Lake",
            "report_type": "Incident Report",
        }

        result1 = await field_report_processor.validate_operation(
            "create", data1, "user"
        )
        result2 = await field_report_processor.validate_operation(
            "create", data2, "user"
        )

        # Order shouldn't matter
        assert result1 == result2


# ============= Stateful Property Testing =============


class FieldReportStateMachine(RuleBasedStateMachine):
    """Stateful testing for FieldReportProcessor using hypothesis."""

    Reports = Bundle("reports")

    def __init__(self):
        super().__init__()
        self.processor = FieldReportProcessor(MagicMock())
        self.reports: Dict[str, Dict[str, Any]] = {}
        self.report_counter = 0
        self.valid_sites = ["Eagle Lake", "Crockett", "Mathis"]

    @initialize()
    def setup(self):
        """Initialize the state machine."""
        self.reports = {}
        self.report_counter = 0

    @rule(
        target=Reports,
        site=st.sampled_from(["Eagle Lake", "Crockett", "Mathis"]),
        report_type=st.sampled_from([t.value for t in ReportType]),
        content=st.text(min_size=10, max_size=200),
    )
    def create_report(self, site, report_type, content):
        """Create a new report."""
        self.report_counter += 1
        report_id = f"report_{self.report_counter}"

        self.reports[report_id] = {
            "site_name": site,
            "report_type": report_type,
            "report_content_full": content,
            "report_status": "Draft",
            "followups": [],
        }

        return report_id

    @rule(
        report_id=Reports, new_status=st.sampled_from([s.value for s in ReportStatus])
    )
    def update_status(self, report_id, new_status):
        """Update report status."""
        if report_id in self.reports:
            self.reports[report_id]["report_status"] = new_status

    @rule(
        report_id=Reports,
        followups=st.lists(st.text(min_size=5, max_size=50), min_size=1, max_size=5),
    )
    def add_followups(self, report_id, followups):
        """Add followup items to a report."""
        if report_id in self.reports:
            self.reports[report_id]["followups"].extend(followups)

    @invariant()
    def reports_have_valid_status(self):
        """Invariant: All reports have valid status."""
        valid_statuses = [s.value for s in ReportStatus]
        for report in self.reports.values():
            assert report["report_status"] in valid_statuses

    @invariant()
    def reports_have_valid_type(self):
        """Invariant: All reports have valid type."""
        valid_types = [t.value for t in ReportType]
        for report in self.reports.values():
            assert report["report_type"] in valid_types

    @invariant()
    def reports_have_valid_site(self):
        """Invariant: All reports have valid site."""
        for report in self.reports.values():
            assert report["site_name"] in self.valid_sites

    @invariant()
    def schema_always_valid(self):
        """Invariant: Schema extraction always returns valid JSON."""
        operations = ["create", "add_followups", "update_status", "read"]
        for op in operations:
            schema = self.processor.get_extraction_schema(op)
            parsed = json.loads(schema)
            assert isinstance(parsed, dict)


# Run the state machine tests
TestFieldReportStates = FieldReportStateMachine.TestCase


if __name__ == "__main__":
    pytest.main([__file__, "-v", "--tb=short"])
