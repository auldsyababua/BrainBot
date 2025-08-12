#!/usr/bin/env python3
"""Test script to reproduce the task processor error."""

import asyncio
import sys
import os

# Add src to path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "src"))

from src.rails.processors.task_processor import TaskProcessor


async def test_task_processor_error():
    """Test the TaskProcessor instantiation error."""

    print("Testing TaskProcessor instantiation...")

    try:
        # This should fail - missing required supabase_client parameter
        processor = TaskProcessor()
        print("✅ TaskProcessor instantiated successfully (unexpected)")
        return processor
    except Exception as e:
        print(f"❌ TaskProcessor instantiation failed: {e}")
        print(f"Error type: {type(e).__name__}")
        return None


async def test_with_supabase_client():
    """Test with a proper supabase client."""

    print("\nTesting with proper supabase client...")

    try:
        from storage.storage_service import DocumentStorage

        storage = DocumentStorage()

        processor = TaskProcessor(supabase_client=storage.supabase)
        print("✅ TaskProcessor instantiated with supabase_client successfully")

        # Test a simple operation
        params = {
            "operation": "create",
            "chat_id": "test",
            "task_title": "Test task",
            "assigned_to": "bryan",
        }

        # This should work now
        schema = processor.get_extraction_schema("create")
        print(f"✅ Schema retrieved: {len(schema)} characters")

        return processor

    except Exception as e:
        print(f"❌ Test with supabase_client failed: {e}")
        print(f"Error type: {type(e).__name__}")
        return None


if __name__ == "__main__":
    asyncio.run(test_task_processor_error())
    asyncio.run(test_with_supabase_client())
