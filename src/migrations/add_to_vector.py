#!/usr/bin/env python3
"""
Add files to the vector store with chunking.
"""

import asyncio
import os
import sys

from src.migrations.migrate_to_vector import migrate_file, migrate_file_chunked
from src.storage.vector_store import vector_store


async def add_single_file(file_path: str, use_chunking: bool = True):
    """Add a single file to the vector store."""
    if not os.path.exists(file_path):
        print(f"❌ File not found: {file_path}")
        return

    print(f"\n📄 Adding file: {file_path}")
    print(f"   Method: {'Chunked' if use_chunking else 'Single document'}")

    if use_chunking:
        chunks_created = await migrate_file_chunked(file_path)
        if chunks_created > 0:
            print(f"✅ Successfully added {chunks_created} chunks")
        else:
            print("❌ Failed to add file")
    else:
        success = await migrate_file(file_path)
        if success:
            print("✅ Successfully added as single document")
        else:
            print("❌ Failed to add file")


async def add_folder(folder_path: str, use_chunking: bool = True):
    """Add all markdown files in a folder to the vector store."""
    if not os.path.exists(folder_path):
        print(f"❌ Folder not found: {folder_path}")
        return

    print(f"\n📁 Adding folder: {folder_path}")
    print(f"   Method: {'Chunked' if use_chunking else 'Single document'}")

    # Find all markdown files
    md_files = []
    for root, dirs, files in os.walk(folder_path):
        for file in files:
            if file.endswith(".md"):
                md_files.append(os.path.join(root, file))

    print(f"   Found {len(md_files)} markdown files")

    # Process each file
    success_count = 0
    for file_path in md_files:
        print(f"\n   Processing: {file_path}")

        if use_chunking:
            chunks = await migrate_file_chunked(file_path)
            if chunks > 0:
                success_count += 1
                print(f"     ✅ Added {chunks} chunks")
        else:
            if await migrate_file(file_path):
                success_count += 1
                print("     ✅ Added")

    print(f"\n🎯 Summary: Successfully added {success_count}/{len(md_files)} files")


async def add_content_directly(title: str, content: str, metadata: dict = None):
    """Add content directly to vector store without a file."""
    print(f"\n📝 Adding content: {title}")

    # Create a unique ID
    doc_id = title.lower().replace(" ", "_")

    # Prepare metadata
    if metadata is None:
        metadata = {}

    metadata.update(
        {"title": title, "type": metadata.get("type", "note"), "source": "direct_add"}
    )

    # Add to vector store
    success = await vector_store.embed_and_store(doc_id, content, metadata)

    if success:
        print("✅ Successfully added to vector store")
    else:
        print("❌ Failed to add to vector store")


async def main():
    if len(sys.argv) < 2:
        print(
            """
Usage:
    python add_to_vector.py file <path> [--no-chunk]     - Add single file
    python add_to_vector.py folder <path> [--no-chunk]   - Add all .md files in folder
    python add_to_vector.py content <title> <content>    - Add content directly
    
Examples:
    python add_to_vector.py file notes/10NetZero/about.md
    python add_to_vector.py folder notes/10NetZero --no-chunk
    python add_to_vector.py content "Meeting Notes" "Today we discussed..."
        """
        )
        return

    command = sys.argv[1].lower()

    if command == "file" and len(sys.argv) > 2:
        file_path = sys.argv[2]
        use_chunking = "--no-chunk" not in sys.argv
        await add_single_file(file_path, use_chunking)

    elif command == "folder" and len(sys.argv) > 2:
        folder_path = sys.argv[2]
        use_chunking = "--no-chunk" not in sys.argv
        await add_folder(folder_path, use_chunking)

    elif command == "content" and len(sys.argv) > 3:
        title = sys.argv[2]
        content = " ".join(sys.argv[3:])
        await add_content_directly(title, content)

    else:
        print("Invalid command. Run without arguments for usage.")


if __name__ == "__main__":
    asyncio.run(main())
