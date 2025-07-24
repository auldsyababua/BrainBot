#!/usr/bin/env python3
import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)), "src"))

from storage.vector_store import vector_store
import asyncio


async def test_update():
    # Try to call update method directly
    try:
        # First store a test document
        await vector_store.embed_and_store(
            "test_update_doc", "Test content", {"original": "value"}
        )
        print("✅ Stored test document")

        # Try the update method
        result = vector_store.index.update(
            "test_update_doc", metadata={"updated": "new_value"}
        )
        print(f"✅ Update succeeded: {result}")

        # Fetch to verify
        fetched = await vector_store.fetch_document("test_update_doc")
        print(f"📄 Fetched document: {fetched}")

        # Cleanup
        await vector_store.delete_document("test_update_doc")

    except AttributeError as e:
        print(f"❌ Update method not found: {e}")
    except Exception as e:
        print(f"❌ Error: {e}")


asyncio.run(test_update())
