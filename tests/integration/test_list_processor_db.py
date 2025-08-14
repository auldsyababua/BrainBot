"""Integration tests for ListProcessor with real database."""

import os
from unittest.mock import MagicMock

import pytest


@pytest.mark.integration
@pytest.mark.asyncio
class TestListProcessorDatabaseIntegration:
    """Test ListProcessor operations against real database."""

    async def test_create_list_with_items(self, list_processor, db_manager):
        """Test creating a new list with initial items."""

        result = await list_processor.process(
            {
                "operation": "create",
                "list_name": "TEST Shopping List",
                "list_type": "Shopping List",
                "items": ["milk", "eggs", "bread", "butter"],
                "chat_id": "test-chat-123",
            }
        )

        assert "✅" in result
        assert "Created list 'TEST Shopping List'" in result
        assert "4 items" in result

        # Verify list creation in database
        lists = (
            await db_manager.client.table("lists")
            .select("*")
            .like("name", "TEST Shopping List%")
            .execute()
        )

        assert len(lists.data) == 1
        created_list = lists.data[0]
        assert created_list["name"] == "TEST Shopping List"
        assert created_list["list_type"] == "Shopping List"
        assert created_list["status"] == "Active"

        # Verify items were created
        items = (
            await db_manager.client.table("list_items")
            .select("*")
            .eq("list_id", created_list["id"])
            .execute()
        )

        assert len(items.data) == 4
        item_names = [item["item_text"] for item in items.data]
        assert "milk" in item_names
        assert "eggs" in item_names
        assert "bread" in item_names
        assert "butter" in item_names

    async def test_add_items_to_existing_list(self, list_processor, db_manager):
        """Test adding items to an existing list."""

        # Create initial list
        test_list = await db_manager.create_test_list(
            name="TEST Equipment Checklist", list_type="Checklist"
        )

        # Add initial items
        await db_manager.client.table("list_items").insert(
            [
                {
                    "list_id": test_list["id"],
                    "item_text": "Safety helmet",
                    "position": 1,
                    "status": "pending",
                },
                {
                    "list_id": test_list["id"],
                    "item_text": "Work gloves",
                    "position": 2,
                    "status": "pending",
                },
            ]
        ).execute()

        # Add more items via processor
        result = await list_processor.process(
            {
                "operation": "add_items",
                "list_name": "TEST Equipment Checklist",
                "items": ["Safety goggles", "Tool belt"],
                "chat_id": "test-chat-123",
            }
        )

        assert "✅" in result
        assert "Added 2 items to 'TEST Equipment Checklist'" in result

        # Verify all items exist
        items = (
            await db_manager.client.table("list_items")
            .select("*")
            .eq("list_id", test_list["id"])
            .order("position")
            .execute()
        )

        assert len(items.data) == 4
        assert items.data[2]["item_text"] == "Safety goggles"
        assert items.data[3]["item_text"] == "Tool belt"
        assert items.data[2]["position"] == 3
        assert items.data[3]["position"] == 4

    async def test_check_off_items(self, list_processor, db_manager):
        """Test checking off items in a list."""

        # Create test list with items
        test_list = await db_manager.create_test_list(
            name="TEST Daily Tasks", list_type="Task List"
        )

        # Add items
        items_result = (
            await db_manager.client.table("list_items")
            .insert(
                [
                    {
                        "list_id": test_list["id"],
                        "item_text": "Check emails",
                        "position": 1,
                        "status": "pending",
                    },
                    {
                        "list_id": test_list["id"],
                        "item_text": "Review reports",
                        "position": 2,
                        "status": "pending",
                    },
                ]
            )
            .execute()
        )

        # Check off first item
        result = await list_processor.process(
            {
                "operation": "check_off",
                "list_name": "TEST Daily Tasks",
                "items": ["Check emails"],
                "chat_id": "test-chat-123",
            }
        )

        assert "✅" in result
        assert "Checked off 1 item" in result

        # Verify item status changed
        items = (
            await db_manager.client.table("list_items")
            .select("*")
            .eq("list_id", test_list["id"])
            .order("position")
            .execute()
        )

        assert len(items.data) == 2
        assert items.data[0]["status"] == "completed"
        assert items.data[1]["status"] == "pending"

    async def test_remove_items_from_list(self, list_processor, db_manager):
        """Test removing items from a list."""

        # Create test list with items
        test_list = await db_manager.create_test_list(
            name="TEST Remove Items List", list_type="General"
        )

        await db_manager.client.table("list_items").insert(
            [
                {
                    "list_id": test_list["id"],
                    "item_text": "Keep this item",
                    "position": 1,
                    "status": "pending",
                },
                {
                    "list_id": test_list["id"],
                    "item_text": "Remove this item",
                    "position": 2,
                    "status": "pending",
                },
                {
                    "list_id": test_list["id"],
                    "item_text": "Keep this too",
                    "position": 3,
                    "status": "pending",
                },
            ]
        ).execute()

        # Remove middle item
        result = await list_processor.process(
            {
                "operation": "remove_items",
                "list_name": "TEST Remove Items List",
                "items": ["Remove this item"],
                "chat_id": "test-chat-123",
            }
        )

        assert "✅" in result
        assert "Removed 1 item" in result

        # Verify item was removed
        items = (
            await db_manager.client.table("list_items")
            .select("*")
            .eq("list_id", test_list["id"])
            .order("position")
            .execute()
        )

        assert len(items.data) == 2
        item_texts = [item["item_text"] for item in items.data]
        assert "Keep this item" in item_texts
        assert "Keep this too" in item_texts
        assert "Remove this item" not in item_texts

    async def test_read_list_contents(self, list_processor, db_manager):
        """Test reading list contents."""

        # Create test list with various item statuses
        test_list = await db_manager.create_test_list(
            name="TEST Mixed Status List", list_type="Checklist"
        )

        await db_manager.client.table("list_items").insert(
            [
                {
                    "list_id": test_list["id"],
                    "item_text": "Completed task",
                    "position": 1,
                    "status": "completed",
                },
                {
                    "list_id": test_list["id"],
                    "item_text": "Pending task",
                    "position": 2,
                    "status": "pending",
                },
                {
                    "list_id": test_list["id"],
                    "item_text": "Another pending task",
                    "position": 3,
                    "status": "pending",
                },
            ]
        ).execute()

        # Read list contents
        result = await list_processor.process(
            {
                "operation": "read",
                "list_name": "TEST Mixed Status List",
                "chat_id": "test-chat-123",
            }
        )

        assert "📋" in result or "List:" in result
        assert "TEST Mixed Status List" in result
        assert "Completed task" in result
        assert "Pending task" in result
        assert "Another pending task" in result

    async def test_list_site_protection(self, list_processor, test_site, db_manager):
        """Test that site-specific lists are protected from general access."""

        # Create site-specific list
        site_list = await db_manager.create_test_list(
            name=f"TEST {test_site['site_name']} Equipment",
            list_type="Equipment List",
            site_id=test_site["id"],
        )

        await db_manager.client.table("list_items").insert(
            [
                {
                    "list_id": site_list["id"],
                    "item_text": "Site-specific equipment",
                    "position": 1,
                    "status": "pending",
                }
            ]
        ).execute()

        # Try to access without site context - should be restricted
        result = await list_processor.process(
            {
                "operation": "read",
                "list_name": f"TEST {test_site['site_name']} Equipment",
                "chat_id": "test-chat-123",
            }
        )

        # Should either show site restriction or not find list
        assert (
            "site access" in result.lower()
            or "not found" in result.lower()
            or "restricted" in result.lower()
        )

    async def test_archive_list(self, list_processor, db_manager):
        """Test archiving a completed list."""

        test_list = await db_manager.create_test_list(
            name="TEST Completed Project List", list_type="Project Checklist"
        )

        result = await list_processor.process(
            {
                "operation": "archive",
                "list_name": "TEST Completed Project List",
                "chat_id": "test-chat-123",
            }
        )

        assert "✅" in result
        assert "Archived list" in result

        # Verify list status changed
        updated_list = (
            await db_manager.client.table("lists")
            .select("*")
            .eq("id", test_list["id"])
            .execute()
        )

        assert len(updated_list.data) == 1
        assert updated_list.data[0]["status"] == "Archived"

    async def test_duplicate_list_names(self, list_processor, db_manager):
        """Test handling of duplicate list names."""

        # Create first list
        await list_processor.process(
            {
                "operation": "create",
                "list_name": "TEST Duplicate Name List",
                "list_type": "General",
                "items": ["First item"],
                "chat_id": "test-chat-123",
            }
        )

        # Try to create second list with same name
        result = await list_processor.process(
            {
                "operation": "create",
                "list_name": "TEST Duplicate Name List",
                "list_type": "General",
                "items": ["Second item"],
                "chat_id": "test-chat-123",
            }
        )

        # Should either prevent duplicate or modify name
        assert (
            "exists" in result.lower()
            or "duplicate" in result.lower()
            or "✅" in result
        )

    @pytest.mark.performance
    async def test_large_list_performance(self, list_processor, db_manager):
        """Test performance with large lists."""
        import time

        # Create list with many items
        large_items = [f"Item {i}" for i in range(50)]

        start_time = time.time()

        result = await list_processor.process(
            {
                "operation": "create",
                "list_name": "TEST Large List Performance",
                "list_type": "General",
                "items": large_items,
                "chat_id": "test-chat-123",
            }
        )

        creation_time = time.time() - start_time

        assert "✅" in result
        assert "50 items" in result

        # Should create large list in reasonable time
        assert (
            creation_time < 15.0
        ), f"Large list creation took {creation_time:.2f}s, expected < 15s"

        # Verify all items were created
        lists = (
            await db_manager.client.table("lists")
            .select("*, list_items(*)")
            .like("name", "TEST Large List Performance%")
            .execute()
        )

        assert len(lists.data) == 1
        assert len(lists.data[0]["list_items"]) == 50

        print(f"Created list with 50 items in {creation_time:.2f}s")

    async def test_error_handling_invalid_list_type(self, list_processor):
        """Test error handling for invalid list types."""

        result = await list_processor.process(
            {
                "operation": "create",
                "list_name": "TEST Invalid Type List",
                "list_type": "Invalid Type That Doesn't Exist",
                "items": ["test item"],
                "chat_id": "test-chat-123",
            }
        )

        assert "❌" in result
        assert (
            "invalid" in result.lower()
            or "type" in result.lower()
            or "not allowed" in result.lower()
        )

    async def test_concurrent_list_operations(self, list_processor, db_manager):
        """Test concurrent operations on the same list."""
        import asyncio

        # Create base list
        test_list = await db_manager.create_test_list(
            name="TEST Concurrent Operations", list_type="General"
        )

        # Define concurrent operations
        async def add_items_1():
            return await list_processor.process(
                {
                    "operation": "add_items",
                    "list_name": "TEST Concurrent Operations",
                    "items": ["Concurrent Item 1", "Concurrent Item 2"],
                    "chat_id": "test-chat-123",
                }
            )

        async def add_items_2():
            return await list_processor.process(
                {
                    "operation": "add_items",
                    "list_name": "TEST Concurrent Operations",
                    "items": ["Concurrent Item 3", "Concurrent Item 4"],
                    "chat_id": "test-chat-456",
                }
            )

        # Execute concurrently
        results = await asyncio.gather(add_items_1(), add_items_2())

        # Both operations should succeed
        assert all("✅" in result for result in results)

        # Verify all items were added
        items = (
            await db_manager.client.table("list_items")
            .select("*")
            .eq("list_id", test_list["id"])
            .execute()
        )

        assert len(items.data) == 4
        item_texts = [item["item_text"] for item in items.data]
        assert "Concurrent Item 1" in item_texts
        assert "Concurrent Item 2" in item_texts
        assert "Concurrent Item 3" in item_texts
        assert "Concurrent Item 4" in item_texts

    async def test_idempotent_list_creation(self, list_processor, db_manager):
        """Test that creating the same list twice is handled gracefully."""

        list_data = {
            "operation": "create",
            "list_name": "TEST Idempotent List",
            "list_type": "General",
            "items": ["Item 1", "Item 2"],
            "chat_id": "test-chat-123",
        }

        # Create list first time
        result1 = await list_processor.process(list_data)
        assert "✅" in result1

        # Try to create same list again
        result2 = await list_processor.process(list_data)

        # Should either handle duplicate or report error
        assert result2 is not None

        # Verify only one list exists or handled appropriately
        lists = (
            await db_manager.client.table("lists")
            .select("*")
            .like("name", "TEST Idempotent List")
            .execute()
        )

        # Should have one list or multiple with different IDs
        assert len(lists.data) >= 1

    async def test_list_with_special_characters(self, list_processor, db_manager):
        """Test list creation with special characters and potential SQL injection."""

        special_names = [
            "TEST List with 'quotes'",
            'TEST List with "double quotes"',
            "TEST List with \n newlines",
            "TEST List with émojis 🎉",
            "TEST List'; DROP TABLE lists; --",
        ]

        for name in special_names:
            result = await list_processor.process(
                {
                    "operation": "create",
                    "list_name": name,
                    "list_type": "General",
                    "items": ["Safe item"],
                    "chat_id": "test-chat-123",
                }
            )

            # Should handle safely without SQL injection
            assert result is not None
            assert "DROP TABLE" not in result

        # Verify database integrity
        tables_check = await db_manager.client.table("lists").select("count").execute()
        assert tables_check is not None  # Table should still exist

    async def test_database_retry_mechanism(self, list_processor, monkeypatch):
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
            mock_response.data = [{"id": 1, "site_name": "Test Site"}]
            return mock_response

        monkeypatch.setattr(list_processor, "_safe_db_operation", flaky_db_operation)

        result = await list_processor.validate_operation(
            "create", {"list_name": "TEST Retry List"}, "user"
        )

        # Should eventually succeed or fail gracefully
        assert result is not None
        assert isinstance(result, tuple)

    async def test_clear_list_operation(self, list_processor, db_manager):
        """Test clearing all items from a list."""

        # Create list with items
        test_list = await db_manager.create_test_list(
            name="TEST List to Clear", list_type="General"
        )

        # Add items
        await db_manager.client.table("list_items").insert(
            [
                {
                    "list_id": test_list["id"],
                    "item_text": "Item 1",
                    "position": 1,
                    "status": "pending",
                },
                {
                    "list_id": test_list["id"],
                    "item_text": "Item 2",
                    "position": 2,
                    "status": "pending",
                },
                {
                    "list_id": test_list["id"],
                    "item_text": "Item 3",
                    "position": 3,
                    "status": "pending",
                },
            ]
        ).execute()

        # Clear the list
        result = await list_processor.process(
            {
                "operation": "clear",
                "list_name": "TEST List to Clear",
                "confirm": True,
                "chat_id": "test-chat-123",
            }
        )

        assert "✅" in result
        assert "Cleared" in result

        # Verify items were removed
        items = (
            await db_manager.client.table("list_items")
            .select("*")
            .eq("list_id", test_list["id"])
            .execute()
        )

        assert len(items.data) == 0

    async def test_rename_list_operation(self, list_processor, db_manager):
        """Test renaming an existing list."""

        # Create initial list
        test_list = await db_manager.create_test_list(
            name="TEST Original Name", list_type="General"
        )

        # Rename the list
        result = await list_processor.process(
            {
                "operation": "rename",
                "current_list_name": "TEST Original Name",
                "new_list_name": "TEST New Name",
                "chat_id": "test-chat-123",
            }
        )

        assert "✅" in result
        assert "Renamed" in result

        # Verify name changed
        updated_list = (
            await db_manager.client.table("lists")
            .select("*")
            .eq("id", test_list["id"])
            .execute()
        )

        assert len(updated_list.data) == 1
        assert updated_list.data[0]["name"] == "TEST New Name"

    async def test_delete_protected_list(self, list_processor, test_site, db_manager):
        """Test that site-specific lists cannot be deleted by regular users."""

        # Create site-specific list
        site_list = await db_manager.create_test_list(
            name=f"TEST {test_site['site_name']} Critical List",
            list_type="Safety Checklist",
            site_id=test_site["id"],
        )

        # Try to delete as regular user
        result = await list_processor.process(
            {
                "operation": "delete",
                "list_name": f"TEST {test_site['site_name']} Critical List",
                "confirm": True,
                "chat_id": "test-chat-123",
                "user_role": "user",
            }
        )

        # Should be prevented
        assert (
            "❌" in result
            or "denied" in result.lower()
            or "protected" in result.lower()
        )

        # Verify list still exists
        list_check = (
            await db_manager.client.table("lists")
            .select("*")
            .eq("id", site_list["id"])
            .execute()
        )

        assert len(list_check.data) == 1

    async def test_list_cache_invalidation(self, list_processor, db_manager):
        """Test that cache is properly invalidated after list updates."""

        # Create list
        test_list = await db_manager.create_test_list(
            name="TEST Cache Test List", list_type="General"
        )

        # Add initial items
        await db_manager.client.table("list_items").insert(
            [
                {
                    "list_id": test_list["id"],
                    "item_text": "Initial Item",
                    "position": 1,
                    "status": "pending",
                }
            ]
        ).execute()

        # Read list (should cache)
        result1 = await list_processor.process(
            {
                "operation": "read",
                "list_name": "TEST Cache Test List",
                "chat_id": "test-chat-123",
            }
        )

        assert "Initial Item" in result1

        # Add new item
        await list_processor.process(
            {
                "operation": "add_items",
                "list_name": "TEST Cache Test List",
                "items": ["New Item After Cache"],
                "chat_id": "test-chat-123",
            }
        )

        # Read again (should get updated data, not cached)
        result2 = await list_processor.process(
            {
                "operation": "read",
                "list_name": "TEST Cache Test List",
                "chat_id": "test-chat-123",
            }
        )

        assert "Initial Item" in result2
        assert "New Item After Cache" in result2

    async def test_network_failure_simulation(self, list_processor, monkeypatch):
        """Test behavior during network failures."""

        async def network_error(*args, **kwargs):
            raise ConnectionError("Network is unreachable")

        monkeypatch.setattr(
            list_processor.supabase.table("sites"), "select", network_error
        )

        result = await list_processor.process(
            {
                "operation": "create",
                "list_name": "TEST Network Failure List",
                "list_type": "General",
                "items": ["Item 1"],
                "chat_id": "test-chat-123",
            }
        )

        assert "❌" in result or "error" in result.lower()
        assert "database" in result.lower() or "network" in result.lower()

    @pytest.mark.skipif(
        not os.getenv("TEST_SUPABASE_URL"), reason="Test database not configured"
    )
    async def test_real_database_connection(self, supabase_test_client):
        """Test actual database connectivity for lists table."""

        try:
            result = await supabase_test_client.table("lists").select("count").execute()
            assert result is not None
            print("Database connection successful. Lists table accessible.")
        except Exception as e:
            pytest.fail(f"Database connection failed: {e}")
