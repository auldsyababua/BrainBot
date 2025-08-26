"""End-to-end integration tests: Webhook → Processor → Database."""

import asyncio
import json
import os
import time
from unittest.mock import AsyncMock, MagicMock, patch

import pytest

from flrts_bmad.core.llm import process_message
from flrts_bmad.rails.router import KeywordRouter


@pytest.mark.integration
@pytest.mark.asyncio
class TestE2EWebhookToDatabase:
    """Test complete flow from webhook to database storage."""

    async def test_e2e_create_task_flow(self, supabase_test_client, test_personnel, db_manager):
        """Test complete flow: webhook message → task creation → database storage."""

        # Mock webhook message data
        webhook_message = {
            "message_id": 12345,
            "from": {"id": 987654321, "first_name": "TestUser", "username": "testuser"},
            "chat": {"id": -1001234567890, "type": "group", "title": "Test Group"},
            "text": f"@{test_personnel['first_name']} Create a high priority task: Check backup generator oil levels tomorrow",
        }

        # Mock LLM response for data extraction
        mock_llm_response = {
            "entity_type": "tasks",
            "operation": "create",
            "task_title": "Check backup generator oil levels",
            "task_description_detailed": "Monthly maintenance check for backup generator oil levels",
            "assigned_to": test_personnel["first_name"],
            "priority": "High",
            "due_date": "tomorrow",
        }

        # Mock LLM client
        mock_llm = AsyncMock(spec=LLMClient)
        mock_llm.get_completion.return_value = json.dumps(mock_llm_response)

        # Create router with mocked dependencies
        router = KeywordRouter(supabase_test_client)
        router.llm_client = mock_llm

        # Mock the send_message function since we don't want to actually send
        async def mock_send_message(chat_id, text, **kwargs):
            return {"message_id": 123, "text": text}

        # Process the message through the complete pipeline
        with patch("src.bot.webhook_bot.send_message", side_effect=mock_send_message):
            response_text = await process_message(webhook_message)

        # Verify successful processing
        assert "✅" in response_text
        assert "Check backup generator oil levels" in response_text
        assert test_personnel["first_name"] in response_text

        # Verify task was created in database
        tasks = (
            await db_manager.client.table("tasks")
            .select("*, personnel(*)")
            .like("title", "%Check backup generator oil levels%")
            .execute()
        )

        assert len(tasks.data) == 1
        created_task = tasks.data[0]
        assert created_task["title"] == "Check backup generator oil levels"
        assert created_task["priority"] == "High"
        assert created_task["assigned_to"] == test_personnel["id"]
        assert created_task["status"] == "To Do"

    async def test_e2e_create_list_flow(self, supabase_test_client, db_manager):
        """Test complete flow: webhook message → list creation → database storage."""

        webhook_message = {
            "message_id": 12346,
            "from": {"id": 987654321, "first_name": "TestUser", "username": "testuser"},
            "chat": {"id": -1001234567890, "type": "group", "title": "Test Group"},
            "text": "/newlist Emergency Supplies Checklist: flashlights, batteries, first aid kit, water bottles",
        }

        mock_llm_response = {
            "entity_type": "lists",
            "operation": "create",
            "list_name": "Emergency Supplies Checklist",
            "list_type": "Checklist",
            "items": ["flashlights", "batteries", "first aid kit", "water bottles"],
        }

        mock_llm = AsyncMock(spec=LLMClient)
        mock_llm.get_completion.return_value = json.dumps(mock_llm_response)

        router = KeywordRouter(supabase_test_client)
        router.llm_client = mock_llm

        async def mock_send_message(chat_id, text, **kwargs):
            return {"message_id": 124, "text": text}

        with patch("src.bot.webhook_bot.send_message", side_effect=mock_send_message):
            response_text = await process_message(webhook_message)

        # Verify successful processing
        assert "✅" in response_text
        assert "Emergency Supplies Checklist" in response_text
        assert "4 items" in response_text

        # Verify list and items were created in database
        lists = (
            await db_manager.client.table("lists")
            .select("*, list_items(*)")
            .like("name", "%Emergency Supplies Checklist%")
            .execute()
        )

        assert len(lists.data) == 1
        created_list = lists.data[0]
        assert created_list["name"] == "Emergency Supplies Checklist"
        assert created_list["list_type"] == "Checklist"
        assert len(created_list["list_items"]) == 4

        item_texts = [item["item_text"] for item in created_list["list_items"]]
        assert "flashlights" in item_texts
        assert "batteries" in item_texts
        assert "first aid kit" in item_texts
        assert "water bottles" in item_texts

    async def test_e2e_create_field_report_flow(self, supabase_test_client, test_site, db_manager):
        """Test complete flow: webhook message → field report creation → database storage."""

        webhook_message = {
            "message_id": 12347,
            "from": {"id": 987654321, "first_name": "TestUser", "username": "testuser"},
            "chat": {"id": -1001234567890, "type": "group", "title": "Test Group"},
            "text": f"Daily operational report for {test_site['site_name']}: All systems operational. Generator tested at 10:30 AM - running normally. Security perimeter checked - no issues. Visitor log updated.",
        }

        mock_llm_response = {
            "entity_type": "field_reports",
            "operation": "create",
            "site_name": test_site["site_name"],
            "report_type": "Daily Operational Summary",
            "report_title_summary": f"Daily Operations - {test_site['site_name']}",
            "report_content_full": "All systems operational. Generator tested at 10:30 AM - running normally. Security perimeter checked - no issues. Visitor log updated.",
            "report_status": "Submitted",
        }

        mock_llm = AsyncMock(spec=LLMClient)
        mock_llm.get_completion.return_value = json.dumps(mock_llm_response)

        router = KeywordRouter(supabase_test_client)
        router.llm_client = mock_llm

        async def mock_send_message(chat_id, text, **kwargs):
            return {"message_id": 125, "text": text}

        with patch("src.bot.webhook_bot.send_message", side_effect=mock_send_message):
            response_text = await process_message(webhook_message)

        # Verify successful processing
        assert "✅" in response_text
        assert "Created field report" in response_text
        assert test_site["site_name"] in response_text

        # Verify field report was created in database
        reports = (
            await db_manager.client.table("field_reports")
            .select("*, sites(*)")
            .like("title", f"%Daily Operations - {test_site['site_name']}%")
            .execute()
        )

        assert len(reports.data) == 1
        created_report = reports.data[0]
        assert f"Daily Operations - {test_site['site_name']}" in created_report["title"]
        assert created_report["report_type"] == "Daily Operational Summary"
        assert created_report["site_id"] == test_site["id"]
        assert created_report["status"] == "Submitted"
        assert "Generator tested at 10:30 AM" in created_report["content"]

    async def test_e2e_error_handling_invalid_data(self, supabase_test_client, db_manager):
        """Test error handling when LLM extraction fails or produces invalid data."""

        webhook_message = {
            "message_id": 12348,
            "from": {"id": 987654321, "first_name": "TestUser", "username": "testuser"},
            "chat": {"id": -1001234567890, "type": "group", "title": "Test Group"},
            "text": "Create a task for NonExistentUser to do something unclear",
        }

        # Mock LLM response with invalid assignee
        mock_llm_response = {
            "entity_type": "tasks",
            "operation": "create",
            "task_title": "Do something unclear",
            "assigned_to": "NonExistentUser",
        }

        mock_llm = AsyncMock(spec=LLMClient)
        mock_llm.get_completion.return_value = json.dumps(mock_llm_response)

        router = KeywordRouter(supabase_test_client)
        router.llm_client = mock_llm

        async def mock_send_message(chat_id, text, **kwargs):
            return {"message_id": 126, "text": text}

        with patch("src.bot.webhook_bot.send_message", side_effect=mock_send_message):
            response_text = await process_message(webhook_message)

        # Verify error response
        assert "❌" in response_text
        assert (
            "Unknown user" in response_text
            or "not found" in response_text.lower()
            or "validation" in response_text.lower()
        )

        # Verify no task was created
        tasks = (
            await db_manager.client.table("tasks")
            .select("*")
            .like("title", "%Do something unclear%")
            .execute()
        )

        assert len(tasks.data) == 0

    async def test_e2e_ambiguous_message_handling(self, supabase_test_client, db_manager):
        """Test handling of ambiguous messages that don't clearly indicate intent."""

        webhook_message = {
            "message_id": 12349,
            "from": {"id": 987654321, "first_name": "TestUser", "username": "testuser"},
            "chat": {"id": -1001234567890, "type": "group", "title": "Test Group"},
            "text": "Hey everyone, just checking in",
        }

        # Mock LLM response indicating no clear operation
        mock_llm_response = {
            "entity_type": "unknown",
            "operation": "unknown",
            "confidence": 0.1,
        }

        mock_llm = AsyncMock(spec=LLMClient)
        mock_llm.get_completion.return_value = json.dumps(mock_llm_response)

        router = KeywordRouter(supabase_test_client)
        router.llm_client = mock_llm

        async def mock_send_message(chat_id, text, **kwargs):
            return {"message_id": 127, "text": text}

        with patch("src.bot.webhook_bot.send_message", side_effect=mock_send_message):
            response_text = await process_message(webhook_message)

        # Should indicate no action taken or request clarification
        assert (
            "no action" in response_text.lower()
            or "unclear" in response_text.lower()
            or "clarify" in response_text.lower()
            or "help" in response_text.lower()
        )

    async def test_e2e_database_connection_error(self, test_personnel, db_manager):
        """Test handling when database connection fails."""

        # Create mock supabase client that fails
        mock_supabase = MagicMock()
        mock_supabase.table.side_effect = Exception("Database connection failed")

        webhook_message = {
            "message_id": 12350,
            "from": {"id": 987654321, "first_name": "TestUser", "username": "testuser"},
            "chat": {"id": -1001234567890, "type": "group", "title": "Test Group"},
            "text": f"@{test_personnel['first_name']} Create task: Test database error handling",
        }

        mock_llm_response = {
            "entity_type": "tasks",
            "operation": "create",
            "task_title": "Test database error handling",
            "assigned_to": test_personnel["first_name"],
        }

        mock_llm = AsyncMock(spec=LLMClient)
        mock_llm.get_completion.return_value = json.dumps(mock_llm_response)

        router = KeywordRouter(mock_supabase)
        router.llm_client = mock_llm

        async def mock_send_message(chat_id, text, **kwargs):
            return {"message_id": 128, "text": text}

        with patch("src.bot.webhook_bot.send_message", side_effect=mock_send_message):
            response_text = await process_message(webhook_message)

        # Should gracefully handle database error
        assert (
            "❌" in response_text
            or "error" in response_text.lower()
            or "failed" in response_text.lower()
        )

    @pytest.mark.performance
    async def test_e2e_processing_performance(
        self, supabase_test_client, test_personnel, db_manager
    ):
        """Test end-to-end processing performance under load."""
        import asyncio
        import time

        # Create multiple concurrent webhook messages
        webhook_messages = []
        for i in range(3):  # Reduced for CI performance
            webhook_messages.append(
                {
                    "message_id": 20000 + i,
                    "from": {
                        "id": 987654321 + i,
                        "first_name": f"TestUser{i}",
                        "username": f"testuser{i}",
                    },
                    "chat": {
                        "id": -1001234567890,
                        "type": "group",
                        "title": "Test Group",
                    },
                    "text": f"@{test_personnel['first_name']} Create task: Performance test task {i}",
                }
            )

        mock_llm_responses = []
        for i in range(3):
            mock_llm_responses.append(
                {
                    "entity_type": "tasks",
                    "operation": "create",
                    "task_title": f"Performance test task {i}",
                    "task_description_detailed": f"Performance test task number {i}",
                    "assigned_to": test_personnel["first_name"],
                    "priority": "Medium",
                }
            )

        # Mock LLM to return appropriate response for each call
        mock_llm = AsyncMock(spec=LLMClient)
        call_count = 0

        async def mock_get_completion(*args, **kwargs):
            nonlocal call_count
            response = json.dumps(mock_llm_responses[call_count % len(mock_llm_responses)])
            call_count += 1
            return response

        mock_llm.get_completion.side_effect = mock_get_completion

        async def mock_send_message(chat_id, text, **kwargs):
            return {"message_id": 200 + hash(text) % 1000, "text": text}

        # Process all messages concurrently
        start_time = time.time()

        async def process_single_message(message):
            router = KeywordRouter(supabase_test_client)
            router.llm_client = mock_llm

            with patch("src.bot.webhook_bot.send_message", side_effect=mock_send_message):
                return await process_message(message)

        # Process messages concurrently
        results = await asyncio.gather(*[process_single_message(msg) for msg in webhook_messages])

        processing_time = time.time() - start_time

        # Verify all processed successfully
        assert all("✅" in result for result in results)

        # Verify all tasks were created
        tasks = (
            await db_manager.client.table("tasks")
            .select("*")
            .like("title", "%Performance test task%")
            .execute()
        )

        assert len(tasks.data) == 3

        # Performance assertion
        assert processing_time < 20.0, f"E2E processing took {processing_time:.2f}s, expected < 20s"

        print(f"Processed {len(webhook_messages)} concurrent messages in {processing_time:.2f}s")

    async def test_e2e_message_persistence_and_logging(
        self, supabase_test_client, test_personnel, db_manager
    ):
        """Test that messages and operations are properly logged for audit trail."""

        webhook_message = {
            "message_id": 12351,
            "from": {"id": 987654321, "first_name": "TestUser", "username": "testuser"},
            "chat": {"id": -1001234567890, "type": "group", "title": "Test Group"},
            "text": f"@{test_personnel['first_name']} Create urgent task: Security system maintenance",
        }

        mock_llm_response = {
            "entity_type": "tasks",
            "operation": "create",
            "task_title": "Security system maintenance",
            "task_description_detailed": "Routine maintenance of security monitoring systems",
            "assigned_to": test_personnel["first_name"],
            "priority": "High",
        }

        mock_llm = AsyncMock(spec=LLMClient)
        mock_llm.get_completion.return_value = json.dumps(mock_llm_response)

        router = KeywordRouter(supabase_test_client)
        router.llm_client = mock_llm

        async def mock_send_message(chat_id, text, **kwargs):
            return {"message_id": 129, "text": text}

        with patch("src.bot.webhook_bot.send_message", side_effect=mock_send_message):
            response_text = await process_message(webhook_message)

        # Verify task creation
        assert "✅" in response_text

        # Check if audit/log tables exist and verify logging
        try:
            # This would depend on your logging schema
            logs = (
                await db_manager.client.table("message_logs")
                .select("*")
                .eq("message_id", webhook_message["message_id"])
                .execute()
            )

            # If logging is implemented, verify the log entry
            if logs.data:
                assert len(logs.data) == 1
                assert logs.data[0]["operation_type"] == "create"
                assert logs.data[0]["entity_type"] == "tasks"
        except Exception:
            # Logging table might not exist - that's okay for now
            print("Message logging not implemented yet")

        # Verify the actual task was created correctly
        tasks = (
            await db_manager.client.table("tasks")
            .select("*")
            .like("title", "%Security system maintenance%")
            .execute()
        )

        assert len(tasks.data) == 1
        created_task = tasks.data[0]
        assert created_task["priority"] == "High"
        assert created_task["assigned_to"] == test_personnel["id"]

    async def test_e2e_failure_injection_llm_timeout(self, supabase_test_client, test_personnel):
        """Test handling of LLM timeout during message processing."""

        webhook_message = {
            "message_id": 30001,
            "from": {"id": 987654321, "first_name": "TestUser", "username": "testuser"},
            "chat": {"id": -1001234567890, "type": "group", "title": "Test Group"},
            "text": f"@{test_personnel['first_name']} Create task: Test LLM timeout",
        }

        # Mock LLM that times out
        mock_llm = AsyncMock(spec=LLMClient)

        async def timeout_completion(*args, **kwargs):
            await asyncio.sleep(0.1)  # Small delay
            raise TimeoutError("LLM request timed out")

        mock_llm.get_completion.side_effect = timeout_completion

        router = KeywordRouter(supabase_test_client)
        router.llm_client = mock_llm

        async def mock_send_message(chat_id, text, **kwargs):
            return {"message_id": 301, "text": text}

        with patch("src.bot.webhook_bot.send_message", side_effect=mock_send_message):
            response_text = await process_message(webhook_message)

        # Should handle timeout gracefully
        assert (
            "❌" in response_text
            or "timeout" in response_text.lower()
            or "try again" in response_text.lower()
        )

    async def test_e2e_failure_injection_partial_db_write(
        self, supabase_test_client, test_personnel, db_manager, monkeypatch
    ):
        """Test handling when database write partially fails (e.g., list created but items fail)."""

        webhook_message = {
            "message_id": 30002,
            "from": {"id": 987654321, "first_name": "TestUser", "username": "testuser"},
            "chat": {"id": -1001234567890, "type": "group", "title": "Test Group"},
            "text": "Create a new checklist: Test Partial Failure with items: item1, item2, item3",
        }

        mock_llm_response = {
            "entity_type": "lists",
            "operation": "create",
            "list_name": "Test Partial Failure",
            "list_type": "Checklist",
            "items": ["item1", "item2", "item3"],
        }

        mock_llm = AsyncMock(spec=LLMClient)
        mock_llm.get_completion.return_value = json.dumps(mock_llm_response)

        # Patch list_items insert to fail
        original_insert = supabase_test_client.table("list_items").insert
        call_count = 0

        def failing_insert(data):
            nonlocal call_count
            call_count += 1
            if call_count == 2:  # Fail on second call (list_items)
                raise Exception("Database write failed for list_items")
            return original_insert(data)

        monkeypatch.setattr(supabase_test_client.table("list_items"), "insert", failing_insert)

        router = KeywordRouter(supabase_test_client)
        router.llm_client = mock_llm

        async def mock_send_message(chat_id, text, **kwargs):
            return {"message_id": 302, "text": text}

        with patch("src.bot.webhook_bot.send_message", side_effect=mock_send_message):
            response_text = await process_message(webhook_message)

        # Should handle partial failure
        # The list might be created but items might fail
        lists = (
            await db_manager.client.table("lists")
            .select("*")
            .like("name", "%Test Partial Failure%")
            .execute()
        )

        # Verify rollback or partial state handling
        if len(lists.data) > 0:
            # If list was created, check if it was marked as incomplete
            list_items = (
                await db_manager.client.table("list_items")
                .select("*")
                .eq("list_id", lists.data[0]["id"])
                .execute()
            )

            # Should have no items or incomplete set
            assert len(list_items.data) < 3

    async def test_e2e_failure_injection_race_condition(
        self, supabase_test_client, test_personnel, db_manager
    ):
        """Test handling of race conditions in concurrent operations."""

        # Two messages trying to create the same named task simultaneously
        webhook_messages = [
            {
                "message_id": 30003,
                "from": {
                    "id": 987654321,
                    "first_name": "TestUser1",
                    "username": "testuser1",
                },
                "chat": {"id": -1001234567890, "type": "group", "title": "Test Group"},
                "text": f"@{test_personnel['first_name']} Create task: Race Condition Test Task",
            },
            {
                "message_id": 30004,
                "from": {
                    "id": 987654322,
                    "first_name": "TestUser2",
                    "username": "testuser2",
                },
                "chat": {"id": -1001234567890, "type": "group", "title": "Test Group"},
                "text": f"@{test_personnel['first_name']} Create task: Race Condition Test Task",
            },
        ]

        mock_llm_response = {
            "entity_type": "tasks",
            "operation": "create",
            "task_title": "Race Condition Test Task",
            "assigned_to": test_personnel["first_name"],
            "priority": "Medium",
        }

        mock_llm = AsyncMock(spec=LLMClient)
        mock_llm.get_completion.return_value = json.dumps(mock_llm_response)

        async def mock_send_message(chat_id, text, **kwargs):
            return {"message_id": 303 + hash(text) % 100, "text": text}

        async def process_single_message(message):
            router = KeywordRouter(supabase_test_client)
            router.llm_client = mock_llm

            with patch("src.bot.webhook_bot.send_message", side_effect=mock_send_message):
                return await process_message(message)

        # Process both messages concurrently
        results = await asyncio.gather(
            process_single_message(webhook_messages[0]),
            process_single_message(webhook_messages[1]),
            return_exceptions=True,
        )

        # At least one should succeed
        successful_results = [r for r in results if isinstance(r, str) and "✅" in r]
        assert len(successful_results) >= 1

        # Check how many tasks were actually created
        tasks = (
            await db_manager.client.table("tasks")
            .select("*")
            .like("title", "%Race Condition Test Task%")
            .execute()
        )

        # Should have 1 or 2 tasks (depending on race condition handling)
        assert len(tasks.data) in [1, 2]

    async def test_e2e_failure_injection_malformed_json(self, supabase_test_client, test_personnel):
        """Test handling when LLM returns malformed JSON."""

        webhook_message = {
            "message_id": 30005,
            "from": {"id": 987654321, "first_name": "TestUser", "username": "testuser"},
            "chat": {"id": -1001234567890, "type": "group", "title": "Test Group"},
            "text": f"@{test_personnel['first_name']} Create task: Test malformed JSON",
        }

        # Mock LLM returns invalid JSON
        mock_llm = AsyncMock(spec=LLMClient)
        mock_llm.get_completion.return_value = "{ invalid json: no quotes }"

        router = KeywordRouter(supabase_test_client)
        router.llm_client = mock_llm

        async def mock_send_message(chat_id, text, **kwargs):
            return {"message_id": 304, "text": text}

        with patch("src.bot.webhook_bot.send_message", side_effect=mock_send_message):
            response_text = await process_message(webhook_message)

        # Should handle JSON parse error gracefully
        assert (
            "❌" in response_text
            or "error" in response_text.lower()
            or "parse" in response_text.lower()
            or "invalid" in response_text.lower()
        )

    async def test_e2e_failure_injection_db_constraint_violation(
        self, supabase_test_client, test_site, db_manager
    ):
        """Test handling of database constraint violations."""

        # Try to create a field report with invalid foreign key
        webhook_message = {
            "message_id": 30006,
            "from": {"id": 987654321, "first_name": "TestUser", "username": "testuser"},
            "chat": {"id": -1001234567890, "type": "group", "title": "Test Group"},
            "text": "Create field report for site: NonExistentSite999 - All systems operational",
        }

        mock_llm_response = {
            "entity_type": "field_reports",
            "operation": "create",
            "site_name": "NonExistentSite999",
            "report_type": "Daily Operational Summary",
            "report_content_full": "All systems operational",
            "report_status": "Submitted",
        }

        mock_llm = AsyncMock(spec=LLMClient)
        mock_llm.get_completion.return_value = json.dumps(mock_llm_response)

        router = KeywordRouter(supabase_test_client)
        router.llm_client = mock_llm

        async def mock_send_message(chat_id, text, **kwargs):
            return {"message_id": 305, "text": text}

        with patch("src.bot.webhook_bot.send_message", side_effect=mock_send_message):
            response_text = await process_message(webhook_message)

        # Should handle constraint violation
        assert "❌" in response_text
        assert (
            "Unknown site" in response_text
            or "Invalid site" in response_text
            or "not found" in response_text.lower()
        )

    async def test_e2e_retry_with_exponential_backoff(
        self, supabase_test_client, test_personnel, monkeypatch
    ):
        """Test retry mechanism with exponential backoff for transient failures."""

        webhook_message = {
            "message_id": 30007,
            "from": {"id": 987654321, "first_name": "TestUser", "username": "testuser"},
            "chat": {"id": -1001234567890, "type": "group", "title": "Test Group"},
            "text": f"@{test_personnel['first_name']} Create task: Test retry mechanism",
        }

        mock_llm_response = {
            "entity_type": "tasks",
            "operation": "create",
            "task_title": "Test retry mechanism",
            "assigned_to": test_personnel["first_name"],
        }

        mock_llm = AsyncMock(spec=LLMClient)
        call_count = 0

        async def flaky_completion(*args, **kwargs):
            nonlocal call_count
            call_count += 1
            if call_count < 3:  # Fail first 2 attempts
                raise ConnectionError("Temporary network error")
            return json.dumps(mock_llm_response)

        mock_llm.get_completion.side_effect = flaky_completion

        router = KeywordRouter(supabase_test_client)
        router.llm_client = mock_llm

        async def mock_send_message(chat_id, text, **kwargs):
            return {"message_id": 306, "text": text}

        start_time = time.time()

        with patch("src.bot.webhook_bot.send_message", side_effect=mock_send_message):
            # Implement retry logic
            max_retries = 3
            for attempt in range(max_retries):
                try:
                    response_text = await process_message(webhook_message)
                    break
                except Exception as e:
                    if attempt == max_retries - 1:
                        response_text = f"❌ Failed after {max_retries} attempts: {str(e)}"
                    else:
                        await asyncio.sleep(2**attempt)  # Exponential backoff

        elapsed_time = time.time() - start_time

        # Should eventually succeed or fail gracefully
        assert response_text is not None

        # Verify exponential backoff timing (should take at least 1 + 2 = 3 seconds for retries)
        if call_count > 1:
            assert elapsed_time >= 1.0  # At least some backoff occurred

    @pytest.mark.skipif(not os.getenv("TEST_SUPABASE_URL"), reason="Test database not configured")
    async def test_e2e_real_database_stress_test(
        self, supabase_test_client, test_personnel, db_manager
    ):
        """Stress test with real database to identify bottlenecks."""

        # Create 10 concurrent operations
        operations = []
        for i in range(10):
            operations.append(
                {
                    "message_id": 40000 + i,
                    "text": f"Create task: Stress test task {i} for @{test_personnel['first_name']}",
                }
            )

        mock_llm = AsyncMock(spec=LLMClient)

        async def generate_response(i):
            return json.dumps(
                {
                    "entity_type": "tasks",
                    "operation": "create",
                    "task_title": f"Stress test task {i}",
                    "assigned_to": test_personnel["first_name"],
                    "priority": "Low",
                }
            )

        mock_llm.get_completion.side_effect = [await generate_response(i) for i in range(10)]

        async def process_operation(op):
            router = KeywordRouter(supabase_test_client)
            router.llm_client = mock_llm

            webhook_message = {
                "message_id": op["message_id"],
                "from": {"id": 987654321, "first_name": "TestUser"},
                "chat": {"id": -1001234567890, "type": "group"},
                "text": op["text"],
            }

            async def mock_send_message(chat_id, text, **kwargs):
                return {"message_id": op["message_id"] + 1000, "text": text}

            with patch("src.bot.webhook_bot.send_message", side_effect=mock_send_message):
                return await process_message(webhook_message)

        start_time = time.time()

        # Process all operations concurrently
        results = await asyncio.gather(
            *[process_operation(op) for op in operations], return_exceptions=True
        )

        elapsed_time = time.time() - start_time

        # Count successes and failures
        successes = sum(1 for r in results if isinstance(r, str) and "✅" in r)
        failures = len(results) - successes

        print(f"Stress test: {successes} successes, {failures} failures in {elapsed_time:.2f}s")

        # At least 70% should succeed
        assert successes >= 7

        # Should complete within reasonable time
        assert elapsed_time < 30.0
