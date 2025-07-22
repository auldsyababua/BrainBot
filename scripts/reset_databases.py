#!/usr/bin/env python3
"""
Reset databases to clean state with only 10NetZero content.

This script:
1. Clears the vector store
2. Backs up 10NetZero folder
3. Clears entire notes folder
4. Restores 10NetZero folder
5. Re-indexes 10NetZero content
"""

import os
import sys
import asyncio
import shutil
from pathlib import Path
from datetime import datetime

# Add src to Python path
sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)), "src"))

from storage.vector_store import vector_store  # noqa: E402
from storage.storage_service import document_storage  # noqa: E402
from core.chunking import chunk_markdown_document  # noqa: E402


async def main():
    print("🧹 Cleaning databases...")
    print("=" * 50)

    # 1. Clear vector store
    print("\n1️⃣ Clearing vector store...")
    try:
        await vector_store.reset_store()
        print("✅ Vector store cleared successfully")
    except Exception as e:
        print(f"❌ Failed to clear vector store: {e}")
        return

    # 2. Backup 10NetZero folder
    print("\n2️⃣ Backing up 10NetZero folder...")
    notes_path = Path("notes")
    ten_net_path = notes_path / "10NetZero"
    backup_path = Path("/tmp/10netzero_backup")

    if ten_net_path.exists():
        if backup_path.exists():
            shutil.rmtree(backup_path)
        shutil.copytree(ten_net_path, backup_path, dirs_exist_ok=True)
        print(f"✅ Backed up to {backup_path}")
    else:
        print("⚠️  10NetZero folder not found, nothing to backup")

    # 3. Clear entire notes folder
    print("\n3️⃣ Clearing notes folder...")
    if notes_path.exists():
        # List what we're removing (for transparency)
        all_items = list(notes_path.rglob("*"))
        file_count = sum(1 for item in all_items if item.is_file())
        dir_count = sum(1 for item in all_items if item.is_dir())
        print(f"   Removing {file_count} files and {dir_count} directories")

        shutil.rmtree(notes_path)
        print("✅ Notes folder cleared")

    notes_path.mkdir(exist_ok=True)

    # 4. Restore 10NetZero
    print("\n4️⃣ Restoring 10NetZero folder...")
    if backup_path.exists():
        shutil.copytree(backup_path, ten_net_path)
        print("✅ 10NetZero folder restored")

        # Clean up backup
        shutil.rmtree(backup_path)
    else:
        print("⚠️  No backup found to restore")

    # 5. Re-index 10NetZero content
    print("\n5️⃣ Re-indexing 10NetZero content...")

    if not ten_net_path.exists():
        print("⚠️  10NetZero folder not found, nothing to index")
        print("\n✅ Database reset complete (empty state)!")
        return

    md_files = list(ten_net_path.rglob("*.md"))
    print(f"📄 Found {len(md_files)} markdown files to index")

    indexed_count = 0
    chunk_count = 0

    for file_path in md_files:
        try:
            print(f"\n📄 Processing: {file_path.relative_to('notes')}")

            # Read file content
            content = file_path.read_text(encoding="utf-8")

            # Extract metadata
            title = file_path.stem.replace("-", " ").replace("_", " ")
            folder = file_path.parent.name

            # Store in Supabase first
            try:
                document_data = await document_storage.store_and_return_document(
                    file_path=str(file_path),
                    content=content,
                    metadata={"title": title, "folder": folder},
                    category="10NetZero",
                    tags=["10netzero", folder.lower()],
                    created_by="reset_script",
                )

                if not document_data:
                    print("   ❌ Failed to store document in Supabase")
                    continue

                document_id = document_data["id"]
                print(f"   ✅ Stored in Supabase with ID: {document_id}")

            except Exception as e:
                print(f"   ❌ Error storing in Supabase: {e}")
                continue

            # Chunk and index
            chunk_metadata = {
                "title": title,
                "folder": folder,
                "source": "database_reset",
                "document_id": document_id,
            }

            chunks = chunk_markdown_document(
                content=content,
                file_path=str(file_path),
                metadata=chunk_metadata,
                chunk_size=1000,
                chunk_overlap=200,
            )
            print(f"   📊 Created {len(chunks)} chunks")

            # Store chunks in vector store
            for chunk_content, chunk_meta in chunks:
                chunk_id = f"{document_id}#chunk_{chunk_meta['chunk_index']}"

                chunk_meta.update(
                    {
                        "indexed_at": datetime.now().isoformat(),
                        "document_id": document_id,
                    }
                )

                success = await vector_store.embed_and_store(
                    chunk_id, chunk_content, chunk_meta
                )

                if success:
                    chunk_count += 1
                    # Store chunk reference in Supabase
                    if document_storage:
                        await document_storage.store_document_chunk(
                            document_id=document_id,
                            chunk_index=chunk_meta["chunk_index"],
                            chunk_text=chunk_content,
                            vector_id=chunk_id,
                            start_char=chunk_meta.get("start_char", 0),
                            end_char=chunk_meta.get("end_char", len(chunk_content)),
                            metadata=chunk_meta,
                        )

            indexed_count += 1

        except Exception as e:
            print(f"   ❌ Error processing {file_path}: {e}")

    print(
        f"\n✅ Indexed {indexed_count}/{len(md_files)} documents ({chunk_count} chunks total)"
    )

    # Wait for eventual consistency
    print("\n⏳ Waiting 5 seconds for eventual consistency...")
    await asyncio.sleep(5)

    # Verify with a test query
    print("\n🔍 Verifying index with test query...")
    results = await vector_store.search("10NetZero sites", top_k=3)

    if results:
        print(f"✅ Found {len(results)} results - index is working!")
    else:
        print("⚠️  No results found - index might need more time")

    print("\n✅ Database reset complete!")


if __name__ == "__main__":
    asyncio.run(main())
