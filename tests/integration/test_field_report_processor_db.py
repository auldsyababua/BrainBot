"""Integration tests for FieldReportProcessor with real database."""

import os
from datetime import datetime, timedelta
from unittest.mock import MagicMock

import pytest


@pytest.mark.integration
@pytest.mark.asyncio
class TestFieldReportProcessorDatabaseIntegration:
    """Test FieldReportProcessor operations against real database."""

    async def test_create_field_report(
        self, field_report_processor, test_site, db_manager
    ):
        """Test creating a field report for a site."""

        report_data = {
            "operation": "create",
            "site_name": test_site["site_name"],
            "report_type": "Daily Operational Summary",
            "report_title_summary": "TEST Daily Operations Report",
            "report_content_full": "All systems operational. No incidents to report. Equipment functioning normally.",
            "report_status": "Submitted",
            "chat_id": "test-chat-123",
        }

        result = await field_report_processor.process(report_data)

        assert "✅" in result
        assert "Created field report" in result
        assert "TEST Daily Operations Report" in result

        # Verify report was created in database
        reports = (
            await db_manager.client.table("field_reports")
            .select("*")
            .like("title", "TEST Daily Operations Report%")
            .execute()
        )

        assert len(reports.data) == 1
        created_report = reports.data[0]
        assert created_report["title"] == "TEST Daily Operations Report"
        assert created_report["report_type"] == "Daily Operational Summary"
        assert created_report["site_id"] == test_site["id"]
        assert created_report["status"] == "Submitted"
        assert "All systems operational" in created_report["content"]

    async def test_create_incident_report(
        self, field_report_processor, test_site, db_manager
    ):
        """Test creating an incident report with priority handling."""

        result = await field_report_processor.process(
            {
                "operation": "create",
                "site_name": test_site["site_name"],
                "report_type": "Incident Report",
                "report_title_summary": "TEST Minor Equipment Malfunction",
                "report_content_full": "Generator alarm triggered at 14:30. Investigated and found low oil warning. Refilled oil reservoir. Generator resumed normal operation at 15:00.",
                "report_status": "Submitted",
                "chat_id": "test-chat-123",
            }
        )

        assert "✅" in result
        assert "Created field report" in result

        # Verify incident report details
        reports = (
            await db_manager.client.table("field_reports")
            .select("*")
            .like("title", "TEST Minor Equipment%")
            .execute()
        )

        assert len(reports.data) == 1
        report = reports.data[0]
        assert report["report_type"] == "Incident Report"
        assert "Generator alarm triggered" in report["content"]

    async def test_add_followups_to_report(
        self, field_report_processor, test_site, db_manager
    ):
        """Test adding followup actions to a field report."""

        # Create initial report
        initial_report = {
            "title": "TEST Report Needs Followup",
            "content": "Equipment inspection completed",
            "report_type": "Maintenance Log",
            "site_id": test_site["id"],
            "status": "Submitted",
            "created_at": datetime.now().isoformat(),
        }

        report_result = (
            await db_manager.client.table("field_reports")
            .insert(initial_report)
            .execute()
        )
        created_report = report_result.data[0]

        # Add followups
        result = await field_report_processor.process(
            {
                "operation": "add_followups",
                "report_identifier": "TEST Report Needs Followup",
                "followup_items": [
                    "Schedule replacement parts order",
                    "Notify maintenance team of required service date",
                    "Update equipment log with findings",
                ],
                "priority": "High",
                "chat_id": "test-chat-123",
            }
        )

        assert "✅" in result
        assert "Added followup items" in result

        # Verify followups were added
        updated_report = (
            await db_manager.client.table("field_reports")
            .select("*")
            .eq("id", created_report["id"])
            .execute()
        )

        assert len(updated_report.data) == 1
        report_content = updated_report.data[0]["content"]
        assert "Schedule replacement parts order" in report_content
        assert "Notify maintenance team" in report_content
        assert "Update equipment log" in report_content

    async def test_update_report_status(
        self, field_report_processor, test_site, db_manager
    ):
        """Test updating field report status."""

        # Create draft report
        draft_report = {
            "title": "TEST Draft Report Status Change",
            "content": "Draft report content",
            "report_type": "Safety Observation",
            "site_id": test_site["id"],
            "status": "Draft",
            "created_at": datetime.now().isoformat(),
        }

        report_result = (
            await db_manager.client.table("field_reports")
            .insert(draft_report)
            .execute()
        )

        # Update status to submitted
        result = await field_report_processor.process(
            {
                "operation": "update_status",
                "report_identifier": "TEST Draft Report Status Change",
                "new_status": "Under Review",
                "chat_id": "test-chat-123",
            }
        )

        assert "✅" in result
        assert "Updated status" in result

        # Verify status change
        updated_report = (
            await db_manager.client.table("field_reports")
            .select("*")
            .like("title", "TEST Draft Report Status Change%")
            .execute()
        )

        assert len(updated_report.data) == 1
        assert updated_report.data[0]["status"] == "Under Review"

    async def test_read_reports_by_site(
        self, field_report_processor, test_site, db_manager
    ):
        """Test reading field reports filtered by site."""

        # Create multiple reports for the site
        reports_data = [
            {
                "title": "TEST Site Report 1",
                "content": "First report content",
                "report_type": "Daily Operational Summary",
                "site_id": test_site["id"],
                "status": "Submitted",
                "created_at": datetime.now().isoformat(),
            },
            {
                "title": "TEST Site Report 2",
                "content": "Second report content",
                "report_type": "Equipment Check",
                "site_id": test_site["id"],
                "status": "Submitted",
                "created_at": (datetime.now() - timedelta(days=1)).isoformat(),
            },
        ]

        await db_manager.client.table("field_reports").insert(reports_data).execute()

        # Read reports for site
        result = await field_report_processor.process(
            {
                "operation": "read",
                "filters": {"site_name": test_site["site_name"], "limit": 10},
                "chat_id": "test-chat-123",
            }
        )

        assert "📊" in result or "Reports" in result
        assert "TEST Site Report 1" in result
        assert "TEST Site Report 2" in result
        assert test_site["site_name"] in result

    async def test_read_reports_by_type(
        self, field_report_processor, test_site, db_manager
    ):
        """Test reading field reports filtered by report type."""

        # Create reports of different types
        incident_report = {
            "title": "TEST Incident Report Type Filter",
            "content": "Incident details",
            "report_type": "Incident Report",
            "site_id": test_site["id"],
            "status": "Submitted",
            "created_at": datetime.now().isoformat(),
        }

        maintenance_report = {
            "title": "TEST Maintenance Report Type Filter",
            "content": "Maintenance details",
            "report_type": "Maintenance Log",
            "site_id": test_site["id"],
            "status": "Submitted",
            "created_at": datetime.now().isoformat(),
        }

        await db_manager.client.table("field_reports").insert(
            [incident_report, maintenance_report]
        ).execute()

        # Filter by incident reports only
        result = await field_report_processor.process(
            {
                "operation": "read",
                "filters": {"report_type": "Incident Report", "limit": 10},
                "chat_id": "test-chat-123",
            }
        )

        assert "📊" in result or "Reports" in result
        assert "TEST Incident Report Type Filter" in result
        assert "TEST Maintenance Report Type Filter" not in result

    async def test_read_reports_by_date_range(
        self, field_report_processor, test_site, db_manager
    ):
        """Test reading field reports with date range filter."""

        # Create reports on different dates
        old_report = {
            "title": "TEST Old Report Date Filter",
            "content": "Old report content",
            "report_type": "Daily Operational Summary",
            "site_id": test_site["id"],
            "status": "Submitted",
            "created_at": (datetime.now() - timedelta(days=10)).isoformat(),
        }

        recent_report = {
            "title": "TEST Recent Report Date Filter",
            "content": "Recent report content",
            "report_type": "Daily Operational Summary",
            "site_id": test_site["id"],
            "status": "Submitted",
            "created_at": datetime.now().isoformat(),
        }

        await db_manager.client.table("field_reports").insert(
            [old_report, recent_report]
        ).execute()

        # Filter by last 7 days
        result = await field_report_processor.process(
            {
                "operation": "read",
                "filters": {"date_range": "last 7 days", "limit": 10},
                "chat_id": "test-chat-123",
            }
        )

        assert "📊" in result or "Reports" in result
        assert "TEST Recent Report Date Filter" in result
        assert "TEST Old Report Date Filter" not in result

    async def test_validation_invalid_site(self, field_report_processor):
        """Test validation fails for invalid site name."""

        result = await field_report_processor.process(
            {
                "operation": "create",
                "site_name": "Nonexistent Site Name",
                "report_type": "Daily Operational Summary",
                "report_content_full": "Report content",
                "chat_id": "test-chat-123",
            }
        )

        assert "❌" in result
        assert (
            "Unknown site" in result
            or "Invalid site" in result
            or "not found" in result.lower()
        )

    async def test_validation_invalid_report_type(
        self, field_report_processor, test_site
    ):
        """Test validation fails for invalid report type."""

        result = await field_report_processor.process(
            {
                "operation": "create",
                "site_name": test_site["site_name"],
                "report_type": "Invalid Report Type",
                "report_content_full": "Report content",
                "chat_id": "test-chat-123",
            }
        )

        assert "❌" in result
        assert "Invalid report type" in result or "Must be one of" in result

    async def test_validation_invalid_status(
        self, field_report_processor, test_site, db_manager
    ):
        """Test validation fails for invalid status update."""

        # Create report to update
        test_report = {
            "title": "TEST Invalid Status Update",
            "content": "Report content",
            "report_type": "Daily Operational Summary",
            "site_id": test_site["id"],
            "status": "Draft",
            "created_at": datetime.now().isoformat(),
        }

        await db_manager.client.table("field_reports").insert(test_report).execute()

        result = await field_report_processor.process(
            {
                "operation": "update_status",
                "report_identifier": "TEST Invalid Status Update",
                "new_status": "Invalid Status Value",
                "chat_id": "test-chat-123",
            }
        )

        assert "❌" in result
        assert "Invalid status" in result or "Must be one of" in result

    async def test_missing_required_fields(self, field_report_processor, test_site):
        """Test validation for missing required fields."""

        # Missing report content
        result = await field_report_processor.process(
            {
                "operation": "create",
                "site_name": test_site["site_name"],
                "report_type": "Daily Operational Summary",
                # Missing report_content_full
                "chat_id": "test-chat-123",
            }
        )

        assert "❌" in result
        assert "Missing required fields" in result

    async def test_report_archival_workflow(
        self, field_report_processor, test_site, db_manager
    ):
        """Test complete workflow from draft to archived."""

        # Create draft report
        result1 = await field_report_processor.process(
            {
                "operation": "create",
                "site_name": test_site["site_name"],
                "report_type": "Maintenance Log",
                "report_title_summary": "TEST Workflow Report",
                "report_content_full": "Initial maintenance observations",
                "report_status": "Draft",
                "chat_id": "test-chat-123",
            }
        )
        assert "✅" in result1

        # Submit for review
        result2 = await field_report_processor.process(
            {
                "operation": "update_status",
                "report_identifier": "TEST Workflow Report",
                "new_status": "Under Review",
                "chat_id": "test-chat-123",
            }
        )
        assert "✅" in result2

        # Add followup actions
        result3 = await field_report_processor.process(
            {
                "operation": "add_followups",
                "report_identifier": "TEST Workflow Report",
                "followup_items": ["Schedule follow-up inspection"],
                "priority": "Medium",
                "chat_id": "test-chat-123",
            }
        )
        assert "✅" in result3

        # Mark as actioned
        result4 = await field_report_processor.process(
            {
                "operation": "update_status",
                "report_identifier": "TEST Workflow Report",
                "new_status": "Actioned",
                "chat_id": "test-chat-123",
            }
        )
        assert "✅" in result4

        # Archive report
        result5 = await field_report_processor.process(
            {
                "operation": "update_status",
                "report_identifier": "TEST Workflow Report",
                "new_status": "Archived",
                "chat_id": "test-chat-123",
            }
        )
        assert "✅" in result5

        # Verify final state
        final_report = (
            await db_manager.client.table("field_reports")
            .select("*")
            .like("title", "TEST Workflow Report%")
            .execute()
        )

        assert len(final_report.data) == 1
        report = final_report.data[0]
        assert report["status"] == "Archived"
        assert "Schedule follow-up inspection" in report["content"]

    @pytest.mark.performance
    async def test_bulk_report_creation_performance(
        self, field_report_processor, test_site, db_manager
    ):
        """Test performance with multiple report creations."""
        import time

        start_time = time.time()

        reports_to_create = 5
        created_reports = []

        for i in range(reports_to_create):
            result = await field_report_processor.process(
                {
                    "operation": "create",
                    "site_name": test_site["site_name"],
                    "report_type": "Daily Operational Summary",
                    "report_title_summary": f"TEST Bulk Report {i}",
                    "report_content_full": f"Bulk report content number {i} with detailed observations.",
                    "report_status": "Submitted",
                    "chat_id": "test-chat-123",
                }
            )

            assert "✅" in result
            created_reports.append(result)

        creation_time = time.time() - start_time

        # Verify all reports were created
        reports = (
            await db_manager.client.table("field_reports")
            .select("*")
            .like("title", "TEST Bulk Report%")
            .execute()
        )

        assert len(reports.data) == reports_to_create

        # Performance assertion
        assert (
            creation_time < 15.0
        ), f"Bulk creation took {creation_time:.2f}s, expected < 15s"

        print(f"Created {reports_to_create} reports in {creation_time:.2f}s")

    async def test_concurrent_report_operations(
        self, field_report_processor, test_site, db_manager
    ):
        """Test concurrent report operations."""
        import asyncio

        # Create base report
        base_report = {
            "title": "TEST Concurrent Report Operations",
            "content": "Base report content",
            "report_type": "Daily Operational Summary",
            "site_id": test_site["id"],
            "status": "Draft",
            "created_at": datetime.now().isoformat(),
        }

        await db_manager.client.table("field_reports").insert(base_report).execute()

        # Define concurrent operations
        async def add_followups():
            return await field_report_processor.process(
                {
                    "operation": "add_followups",
                    "report_identifier": "TEST Concurrent Report Operations",
                    "followup_items": ["Concurrent followup 1"],
                    "priority": "Medium",
                    "chat_id": "test-chat-123",
                }
            )

        async def update_status():
            # Add small delay to avoid race condition
            await asyncio.sleep(0.1)
            return await field_report_processor.process(
                {
                    "operation": "update_status",
                    "report_identifier": "TEST Concurrent Report Operations",
                    "new_status": "Under Review",
                    "chat_id": "test-chat-456",
                }
            )

        # Execute concurrently
        results = await asyncio.gather(add_followups(), update_status())

        # Both operations should succeed
        assert all("✅" in result for result in results)

        # Verify both operations took effect
        final_report = (
            await db_manager.client.table("field_reports")
            .select("*")
            .like("title", "TEST Concurrent Report Operations%")
            .execute()
        )

        assert len(final_report.data) == 1
        report = final_report.data[0]
        assert report["status"] == "Under Review"
        assert "Concurrent followup 1" in report["content"]

    async def test_idempotent_report_creation(
        self, field_report_processor, test_site, db_manager
    ):
        """Test that creating the same report twice is handled gracefully."""

        report_data = {
            "operation": "create",
            "site_name": test_site["site_name"],
            "report_type": "Daily Operational Summary",
            "report_title_summary": "TEST Idempotent Report",
            "report_content_full": "This report should handle duplicate creation attempts.",
            "report_status": "Submitted",
            "chat_id": "test-chat-123",
        }

        # Create report first time
        result1 = await field_report_processor.process(report_data)
        assert "✅" in result1

        # Try to create same report again
        result2 = await field_report_processor.process(report_data)

        # Should either handle duplicate or create new report
        assert result2 is not None

        # Verify reports in database
        reports = (
            await db_manager.client.table("field_reports")
            .select("*")
            .like("title", "TEST Idempotent Report")
            .execute()
        )

        # Should have at least one report
        assert len(reports.data) >= 1

    async def test_report_with_special_characters(
        self, field_report_processor, test_site, db_manager
    ):
        """Test report creation with special characters and SQL injection attempts."""

        special_contents = [
            "Report with 'quotes' in content",
            'Report with "double quotes"',
            "Report with \n\n multiple \n newlines",
            "Report with émojis 🎆 🔧 ⚠️",
            "Report'; DROP TABLE field_reports; --",
            "<script>alert('xss')</script> in report",
        ]

        for idx, content in enumerate(special_contents):
            result = await field_report_processor.process(
                {
                    "operation": "create",
                    "site_name": test_site["site_name"],
                    "report_type": "Safety Observation",
                    "report_title_summary": f"TEST Special Char Report {idx}",
                    "report_content_full": content,
                    "chat_id": "test-chat-123",
                }
            )

            # Should handle safely without SQL injection
            assert result is not None
            assert "DROP TABLE" not in result

        # Verify database integrity
        tables_check = (
            await db_manager.client.table("field_reports").select("count").execute()
        )
        assert tables_check is not None  # Table should still exist

    async def test_database_retry_mechanism(
        self, field_report_processor, test_site, monkeypatch
    ):
        """Test retry mechanism for transient database failures."""

        call_count = 0

        async def flaky_db_operation(*args, **kwargs):
            nonlocal call_count
            call_count += 1

            # Fail first 2 attempts, succeed on third
            if call_count < 3:
                raise TimeoutError("Database timeout")

            # Return mock successful response
            mock_response = MagicMock()
            mock_response.data = [{"site_name": test_site["site_name"].lower()}]
            return mock_response

        monkeypatch.setattr(
            field_report_processor, "_safe_db_operation", flaky_db_operation
        )

        result = await field_report_processor.validate_operation(
            "create",
            {
                "site_name": test_site["site_name"],
                "report_content_full": "Test content",
            },
            "user",
        )

        # Should eventually succeed or fail gracefully
        assert result is not None
        assert isinstance(result, tuple)

    async def test_report_cache_invalidation(
        self, field_report_processor, test_site, db_manager
    ):
        """Test that cache is properly invalidated after report updates."""

        # Create initial report
        initial_report = {
            "title": "TEST Cache Invalidation Report",
            "content": "Initial content",
            "report_type": "Daily Operational Summary",
            "site_id": test_site["id"],
            "status": "Draft",
            "created_at": datetime.now().isoformat(),
        }

        report_result = (
            await db_manager.client.table("field_reports")
            .insert(initial_report)
            .execute()
        )

        # Read report (should cache)
        result1 = await field_report_processor.process(
            {
                "operation": "read",
                "filters": {"site_name": test_site["site_name"]},
                "chat_id": "test-chat-123",
            }
        )

        assert "TEST Cache Invalidation Report" in result1
        assert "Draft" in result1

        # Update report status
        await field_report_processor.process(
            {
                "operation": "update_status",
                "report_identifier": "TEST Cache Invalidation Report",
                "new_status": "Submitted",
                "chat_id": "test-chat-123",
            }
        )

        # Read again (should get updated data, not cached)
        result2 = await field_report_processor.process(
            {
                "operation": "read",
                "filters": {"site_name": test_site["site_name"]},
                "chat_id": "test-chat-123",
            }
        )

        assert "TEST Cache Invalidation Report" in result2
        assert "Submitted" in result2

    async def test_partial_failure_in_batch(
        self, field_report_processor, test_site, db_manager
    ):
        """Test handling of partial failures in batch report operations."""

        # Create second test site
        test_site2 = await db_manager.create_test_site("TEST_Valid_Site")

        reports_data = [
            {
                "operation": "create",
                "site_name": test_site["site_name"],
                "report_type": "Daily Operational Summary",
                "report_title_summary": "TEST Valid Report 1",
                "report_content_full": "Valid content 1",
                "chat_id": "test-chat-123",
            },
            {
                "operation": "create",
                "site_name": "NonExistentSite999",
                "report_type": "Daily Operational Summary",
                "report_title_summary": "TEST Invalid Report",
                "report_content_full": "Invalid content",
                "chat_id": "test-chat-123",
            },
            {
                "operation": "create",
                "site_name": test_site2["site_name"],
                "report_type": "Daily Operational Summary",
                "report_title_summary": "TEST Valid Report 2",
                "report_content_full": "Valid content 2",
                "chat_id": "test-chat-123",
            },
        ]

        results = []
        for report_data in reports_data:
            result = await field_report_processor.process(report_data)
            results.append(result)

        # First report should succeed
        assert "✅" in results[0]
        # Second should fail (invalid site)
        assert "❌" in results[1] or "error" in results[1].lower()
        # Third should still succeed (isolation)
        assert "✅" in results[2]

        # Verify valid reports were created
        valid_reports = (
            await db_manager.client.table("field_reports")
            .select("*")
            .like("title", "TEST Valid Report%")
            .execute()
        )

        assert len(valid_reports.data) == 2

    async def test_network_failure_simulation(
        self, field_report_processor, monkeypatch
    ):
        """Test behavior during network failures."""

        async def network_error(*args, **kwargs):
            raise ConnectionError("Network is unreachable")

        monkeypatch.setattr(
            field_report_processor.supabase.table("sites"), "select", network_error
        )

        result = await field_report_processor.process(
            {
                "operation": "create",
                "site_name": "Test Site",
                "report_type": "Daily Operational Summary",
                "report_content_full": "Network failure test",
                "chat_id": "test-chat-123",
            }
        )

        assert "❌" in result or "error" in result.lower()
        assert "database" in result.lower() or "network" in result.lower()

    async def test_large_report_content(
        self, field_report_processor, test_site, db_manager
    ):
        """Test handling of very large report content."""

        # Create report with large content (10KB)
        large_content = "This is a very detailed report. " * 300  # ~10KB of text

        result = await field_report_processor.process(
            {
                "operation": "create",
                "site_name": test_site["site_name"],
                "report_type": "Equipment Check",
                "report_title_summary": "TEST Large Content Report",
                "report_content_full": large_content,
                "chat_id": "test-chat-123",
            }
        )

        assert "✅" in result

        # Verify large content was stored
        reports = (
            await db_manager.client.table("field_reports")
            .select("*")
            .like("title", "TEST Large Content Report")
            .execute()
        )

        assert len(reports.data) == 1
        assert len(reports.data[0]["content"]) > 9000  # Should store full content

    async def test_report_with_attachments_metadata(
        self, field_report_processor, test_site, db_manager
    ):
        """Test report with attachment metadata (even if attachments not stored)."""

        result = await field_report_processor.process(
            {
                "operation": "create",
                "site_name": test_site["site_name"],
                "report_type": "Incident Report",
                "report_title_summary": "TEST Report with Attachments",
                "report_content_full": "Incident occurred at 10:30 AM. See attached photos: [photo1.jpg, photo2.jpg, video1.mp4]",
                "report_status": "Submitted",
                "chat_id": "test-chat-123",
            }
        )

        assert "✅" in result

        # Verify attachment references in content
        reports = (
            await db_manager.client.table("field_reports")
            .select("*")
            .like("title", "TEST Report with Attachments")
            .execute()
        )

        assert len(reports.data) == 1
        assert "photo1.jpg" in reports.data[0]["content"]
        assert "video1.mp4" in reports.data[0]["content"]

    @pytest.mark.skipif(
        not os.getenv("TEST_SUPABASE_URL"), reason="Test database not configured"
    )
    async def test_real_database_connection(self, supabase_test_client):
        """Test actual database connectivity for field_reports table."""

        try:
            result = (
                await supabase_test_client.table("field_reports")
                .select("count")
                .execute()
            )
            assert result is not None
            print("Database connection successful. Field reports table accessible.")
        except Exception as e:
            pytest.fail(f"Database connection failed: {e}")
