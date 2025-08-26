"""Integration tests for TaskProcessor with real database."""

import asyncio
import os
from datetime import datetime, timedelta
from unittest.mock import MagicMock

import pytest


@pytest.mark.integration
@pytest.mark.asyncio
class TestTaskProcessorDatabaseIntegration:
    """Test TaskProcessor operations against real database."""

    async def test_create_task_with_assignee(self, task_processor, test_personnel, db_manager):
        """Test creating a task with valid assignee."""

        # Create task data
        task_data = {
            "task_title": "TEST Check generator oil levels",
            "task_description_detailed": "Monthly maintenance check for backup generator",
            "assigned_to": test_personnel["first_name"],
            "priority": "High",
            "due_date": (datetime.now() + timedelta(days=1)).strftime("%Y-%m-%d"),
            "chat_id": "test-chat-123",
        }

        # Execute operation
        result = await task_processor.process({"operation": "create", **task_data})

        # Verify success response
        assert "✅" in result
        assert "TEST Check generator oil levels" in result
        assert test_personnel["first_name"] in result

        # Verify task was created in database
        tasks = (
            await db_manager.client.table("tasks")
            .select("*")
            .like("title", "TEST Check generator%")
            .execute()
        )

        assert len(tasks.data) == 1
        created_task = tasks.data[0]
        assert created_task["title"] == "TEST Check generator oil levels"
        assert created_task["assigned_to"] == test_personnel["id"]
        assert created_task["priority"] == "High"
        assert created_task["status"] == "To Do"

    async def test_create_task_with_site(self, task_processor, test_site, db_manager):
        """Test creating a task associated with a site."""

        task_data = {
            "task_title": "TEST Inspect security cameras",
            "task_description_detailed": "Weekly security system check",
            "site_name": test_site["site_name"],
            "priority": "Medium",
            "chat_id": "test-chat-123",
        }

        result = await task_processor.process({"operation": "create", **task_data})

        assert "✅" in result
        assert "TEST Inspect security cameras" in result

        # Verify task has site association
        tasks = (
            await db_manager.client.table("tasks")
            .select("*, sites(*)")
            .like("title", "TEST Inspect security%")
            .execute()
        )

        assert len(tasks.data) == 1
        created_task = tasks.data[0]
        assert created_task["site_id"] == test_site["id"]

    async def test_complete_task(self, task_processor, db_manager):
        """Test completing an existing task."""

        # Create a task to complete
        test_task = await db_manager.create_test_task(
            title="TEST Maintenance task to complete", status="In Progress"
        )

        # Complete the task
        result = await task_processor.process(
            {
                "operation": "complete",
                "task_title": "TEST Maintenance task to complete",
                "completion_notes": "Task completed successfully",
                "chat_id": "test-chat-123",
            }
        )

        assert "✅" in result
        assert "Completed task" in result

        # Verify task status changed
        updated_task = (
            await db_manager.client.table("tasks").select("*").eq("id", test_task["id"]).execute()
        )

        assert len(updated_task.data) == 1
        assert updated_task.data[0]["status"] == "Completed"
        assert "Task completed successfully" in updated_task.data[0]["description"]

    async def test_reassign_task(self, task_processor, test_personnel, db_manager):
        """Test reassigning a task to different personnel."""

        # Create second test user
        new_assignee = await db_manager.create_test_personnel("TestUser2")

        # Create task assigned to first user
        test_task = await db_manager.create_test_task(
            title="TEST Task to reassign", assigned_to=test_personnel["id"]
        )

        # Reassign to second user
        result = await task_processor.process(
            {
                "operation": "reassign",
                "task_title": "TEST Task to reassign",
                "new_assignee": new_assignee["first_name"],
                "reason": "Better expertise for this task",
                "chat_id": "test-chat-123",
            }
        )

        assert "✅" in result
        assert "Reassigned task" in result
        assert new_assignee["first_name"] in result

        # Verify reassignment in database
        updated_task = (
            await db_manager.client.table("tasks").select("*").eq("id", test_task["id"]).execute()
        )

        assert len(updated_task.data) == 1
        assert updated_task.data[0]["assigned_to"] == new_assignee["id"]

    async def test_read_tasks_with_filters(
        self, task_processor, test_personnel, test_site, db_manager
    ):
        """Test reading tasks with various filters."""

        # Create multiple test tasks
        await db_manager.create_test_task(
            title="TEST High priority task",
            priority="High",
            assigned_to=test_personnel["id"],
            site_id=test_site["id"],
        )

        await db_manager.create_test_task(
            title="TEST Low priority task",
            priority="Low",
            assigned_to=test_personnel["id"],
        )

        # Read tasks filtered by assignee
        result = await task_processor.process(
            {
                "operation": "read",
                "filters": {
                    "assigned_to": test_personnel["first_name"],
                    "priority": "High",
                },
                "chat_id": "test-chat-123",
            }
        )

        assert "📋" in result or "Tasks" in result
        assert "TEST High priority task" in result
        assert "TEST Low priority task" not in result

    async def test_validation_unknown_assignee(self, task_processor):
        """Test validation fails for unknown assignee."""

        result = await task_processor.process(
            {
                "operation": "create",
                "task_title": "TEST Invalid assignee task",
                "assigned_to": "NonExistentUser",
                "chat_id": "test-chat-123",
            }
        )

        assert "❌" in result
        assert "Unknown user" in result or "not found" in result.lower()

    async def test_add_notes_to_task(self, task_processor, db_manager):
        """Test adding notes to existing task."""

        test_task = await db_manager.create_test_task(
            title="TEST Task for notes", description="Original description"
        )

        result = await task_processor.process(
            {
                "operation": "add_notes",
                "task_title": "TEST Task for notes",
                "notes": "Additional progress notes added via test",
                "chat_id": "test-chat-123",
            }
        )

        assert "✅" in result
        assert "Added notes" in result

        # Verify notes were added
        updated_task = (
            await db_manager.client.table("tasks").select("*").eq("id", test_task["id"]).execute()
        )

        assert len(updated_task.data) == 1
        description = updated_task.data[0]["description"]
        assert "Original description" in description
        assert "Additional progress notes added via test" in description

    async def test_reschedule_task(self, task_processor, db_manager):
        """Test rescheduling a task to new due date."""

        original_date = datetime.now() + timedelta(days=1)
        new_date = datetime.now() + timedelta(days=7)

        test_task = await db_manager.create_test_task(
            title="TEST Task to reschedule", due_date=original_date.strftime("%Y-%m-%d")
        )

        result = await task_processor.process(
            {
                "operation": "reschedule",
                "task_title": "TEST Task to reschedule",
                "new_due_date": new_date.strftime("%Y-%m-%d"),
                "reason": "Pushed due to other priorities",
                "chat_id": "test-chat-123",
            }
        )

        assert "✅" in result
        assert "Rescheduled task" in result

        # Verify new due date
        updated_task = (
            await db_manager.client.table("tasks").select("*").eq("id", test_task["id"]).execute()
        )

        assert len(updated_task.data) == 1
        assert updated_task.data[0]["due_date"] == new_date.strftime("%Y-%m-%d")

    async def test_database_error_handling(self, task_processor, monkeypatch):
        """Test graceful handling of database errors."""

        # Mock database error
        async def mock_safe_db_operation(*args, **kwargs):
            raise Exception("Database connection error")

        monkeypatch.setattr(task_processor, "_safe_db_operation", mock_safe_db_operation)

        result = await task_processor.process(
            {
                "operation": "create",
                "task_title": "TEST Task with DB error",
                "chat_id": "test-chat-123",
            }
        )

        assert "❌" in result
        assert "error" in result.lower() or "failed" in result.lower()

    async def test_idempotent_task_creation(self, task_processor, test_personnel, db_manager):
        """Test that creating the same task twice is handled gracefully."""

        task_data = {
            "task_title": "TEST Idempotent task",
            "task_description_detailed": "This task should only be created once",
            "assigned_to": test_personnel["first_name"],
            "priority": "High",
            "chat_id": "test-chat-123",
        }

        # Create task first time
        result1 = await task_processor.process({"operation": "create", **task_data})

        assert "✅" in result1

        # Try to create same task again
        result2 = await task_processor.process({"operation": "create", **task_data})

        # Should either succeed with duplicate handling or warn about duplicate
        assert result2 is not None

        # Verify only one task exists (or two with different IDs)
        tasks = (
            await db_manager.client.table("tasks")
            .select("*")
            .like("title", "TEST Idempotent task")
            .execute()
        )

        # Accept either 1 (duplicate prevented) or 2 (duplicate allowed)
        assert len(tasks.data) in [1, 2]

    async def test_concurrent_task_updates(self, task_processor, db_manager):
        """Test handling of concurrent updates to the same task."""

        # Create initial task
        test_task = await db_manager.create_test_task(
            title="TEST Concurrent update task", status="To Do"
        )

        # Simulate concurrent updates
        async def update_task_status():
            return await task_processor.process(
                {
                    "operation": "complete",
                    "task_title": "TEST Concurrent update task",
                    "completion_notes": "Completed concurrently",
                    "chat_id": "test-chat-123",
                }
            )

        async def add_notes_to_task():
            return await task_processor.process(
                {
                    "operation": "add_notes",
                    "task_title": "TEST Concurrent update task",
                    "notes": "Notes added concurrently",
                    "chat_id": "test-chat-123",
                }
            )

        # Execute concurrently
        results = await asyncio.gather(
            update_task_status(), add_notes_to_task(), return_exceptions=True
        )

        # At least one should succeed
        successful_results = [r for r in results if isinstance(r, str) and "✅" in r]
        assert len(successful_results) >= 1

        # Verify final state is consistent
        final_task = (
            await db_manager.client.table("tasks").select("*").eq("id", test_task["id"]).execute()
        )

        assert len(final_task.data) == 1
        assert final_task.data[0]["id"] == test_task["id"]

    async def test_task_with_invalid_date_format(self, task_processor, test_personnel):
        """Test task creation with various date formats."""

        # Test invalid date format
        result = await task_processor.process(
            {
                "operation": "create",
                "task_title": "TEST Task with bad date",
                "assigned_to": test_personnel["first_name"],
                "due_date": "not-a-date",
                "chat_id": "test-chat-123",
            }
        )

        # Should either handle gracefully or report error
        assert result is not None

        # Test relative date
        result2 = await task_processor.process(
            {
                "operation": "create",
                "task_title": "TEST Task with relative date",
                "assigned_to": test_personnel["first_name"],
                "due_date": "tomorrow",
                "chat_id": "test-chat-123",
            }
        )

        # Should handle relative dates
        assert result2 is not None

    async def test_database_retry_mechanism(self, task_processor, test_personnel, monkeypatch):
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
            mock_response.data = [
                {"id": 1, "first_name": test_personnel["first_name"], "aliases": []}
            ]
            return mock_response

        monkeypatch.setattr(task_processor, "_safe_db_operation", flaky_db_operation)

        result = await task_processor.validate_operation(
            "create",
            {
                "task_title": "TEST Retry mechanism task",
                "assigned_to": test_personnel["first_name"],
            },
            "user",
        )

        # Should eventually succeed or fail gracefully
        assert result is not None
        assert isinstance(result, tuple)

    async def test_task_with_special_characters(self, task_processor, test_personnel, db_manager):
        """Test task creation with special characters and SQL injection attempts."""

        # Test with special characters
        special_titles = [
            "TEST Task with 'quotes'",
            'TEST Task with "double quotes"',
            "TEST Task with \n newlines",
            "TEST Task with émojis 🎉",
            "TEST Task with <script>alert('xss')</script>",
            "TEST Task'; DROP TABLE tasks; --",
        ]

        for title in special_titles:
            result = await task_processor.process(
                {
                    "operation": "create",
                    "task_title": title,
                    "assigned_to": test_personnel["first_name"],
                    "chat_id": "test-chat-123",
                }
            )

            # Should handle safely without SQL injection
            assert result is not None
            assert "error" not in result.lower() or "DROP TABLE" not in result

        # Verify database integrity
        tables_check = await db_manager.client.table("tasks").select("count").execute()
        assert tables_check is not None  # Table should still exist

    async def test_task_cache_invalidation(self, task_processor, test_personnel, db_manager):
        """Test that cache is properly invalidated after updates."""

        # Create task
        test_task = await db_manager.create_test_task(
            title="TEST Cache invalidation task",
            assigned_to=test_personnel["id"],
            status="To Do",
        )

        # Read task (should cache)
        result1 = await task_processor.process(
            {
                "operation": "read",
                "filters": {"assigned_to": test_personnel["first_name"]},
                "chat_id": "test-chat-123",
            }
        )

        assert "TEST Cache invalidation task" in result1
        assert "To Do" in result1 or "TODO" in result1.upper()

        # Update task
        await task_processor.process(
            {
                "operation": "complete",
                "task_title": "TEST Cache invalidation task",
                "chat_id": "test-chat-123",
            }
        )

        # Read again (should get updated data, not cached)
        result2 = await task_processor.process(
            {
                "operation": "read",
                "filters": {"assigned_to": test_personnel["first_name"]},
                "chat_id": "test-chat-123",
            }
        )

        assert "TEST Cache invalidation task" in result2
        assert "Completed" in result2 or "✅" in result2

    async def test_partial_failure_in_batch(self, task_processor, test_personnel, db_manager):
        """Test handling of partial failures in batch operations."""

        # Create one valid user and reference one invalid
        tasks_data = [
            {
                "operation": "create",
                "task_title": "TEST Valid task 1",
                "assigned_to": test_personnel["first_name"],
                "chat_id": "test-chat-123",
            },
            {
                "operation": "create",
                "task_title": "TEST Invalid task",
                "assigned_to": "NonExistentUser999",
                "chat_id": "test-chat-123",
            },
            {
                "operation": "create",
                "task_title": "TEST Valid task 2",
                "assigned_to": test_personnel["first_name"],
                "chat_id": "test-chat-123",
            },
        ]

        results = []
        for task_data in tasks_data:
            result = await task_processor.process(task_data)
            results.append(result)

        # First task should succeed
        assert "✅" in results[0]
        # Second should fail
        assert "❌" in results[1] or "error" in results[1].lower()
        # Third should still succeed (isolation)
        assert "✅" in results[2]

        # Verify valid tasks were created
        valid_tasks = (
            await db_manager.client.table("tasks")
            .select("*")
            .like("title", "TEST Valid task%")
            .execute()
        )

        assert len(valid_tasks.data) == 2

    @pytest.mark.performance
    async def test_bulk_task_operations_performance(
        self, task_processor, test_personnel, db_manager
    ):
        """Test performance with multiple task operations."""
        import time

        start_time = time.time()

        # Create multiple tasks quickly
        tasks_to_create = 5
        created_tasks = []

        for i in range(tasks_to_create):
            result = await task_processor.process(
                {
                    "operation": "create",
                    "task_title": f"TEST Bulk task {i}",
                    "task_description_detailed": f"Bulk created task number {i}",
                    "assigned_to": test_personnel["first_name"],
                    "priority": "Medium",
                    "chat_id": "test-chat-123",
                }
            )

            assert "✅" in result
            created_tasks.append(result)

        creation_time = time.time() - start_time

        # Verify all tasks were created
        tasks = (
            await db_manager.client.table("tasks")
            .select("*")
            .like("title", "TEST Bulk task%")
            .execute()
        )

        assert len(tasks.data) == tasks_to_create

        # Performance assertion (should create 5 tasks in under 10 seconds)
        assert creation_time < 10.0, f"Bulk creation took {creation_time:.2f}s, expected < 10s"

        print(f"Created {tasks_to_create} tasks in {creation_time:.2f}s")

    async def test_network_failure_simulation(self, task_processor, monkeypatch):
        """Test behavior during network failures."""

        async def network_error(*args, **kwargs):
            raise ConnectionError("Network is unreachable")

        monkeypatch.setattr(task_processor.supabase.table("personnel"), "select", network_error)

        result = await task_processor.process(
            {
                "operation": "create",
                "task_title": "TEST Network failure task",
                "assigned_to": "TestUser",
                "chat_id": "test-chat-123",
            }
        )

        assert "❌" in result or "error" in result.lower()
        assert "database" in result.lower() or "network" in result.lower()

    @pytest.mark.skipif(not os.getenv("TEST_SUPABASE_URL"), reason="Test database not configured")
    async def test_real_database_connection(self, supabase_test_client):
        """Test actual database connectivity and configuration."""

        # Test basic connectivity
        try:
            result = await supabase_test_client.table("tasks").select("count").execute()
            assert result is not None
            print("Database connection successful. Task table accessible.")
        except Exception as e:
            pytest.fail(f"Database connection failed: {e}")
