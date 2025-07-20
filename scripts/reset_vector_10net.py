#!/usr/bin/env python3
"""
Reset vector store and index only 10NetZero documents.

This script:
1. Clears the entire vector store
2. Indexes only documents from notes/10NetZero
3. Runs test queries to verify indexing
"""

import os
import sys
import asyncio
from pathlib import Path
from datetime import datetime

# Add src to Python path
sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)), "src"))

from storage.vector_store import vector_store  # noqa: E402
from storage.storage_service import document_storage  # noqa: E402
from core.chunking import chunk_markdown_document  # noqa: E402


async def main():
    print("🚀 10NetZero Vector Store Reset and Reindex")
    print("=" * 50)

    # Step 1: Clear the vector store
    print("\n1️⃣ Clearing entire vector store...")
    try:
        await vector_store.reset_store()
        print("✅ Vector store cleared successfully")
    except Exception as e:
        print(f"❌ Failed to clear vector store: {e}")
        return

    # Step 2: Find all 10NetZero documents
    print("\n2️⃣ Finding 10NetZero documents...")
    notes_dir = Path("notes/10NetZero")
    if not notes_dir.exists():
        print(f"❌ Directory not found: {notes_dir}")
        return

    md_files = list(notes_dir.rglob("*.md"))
    print(f"📄 Found {len(md_files)} markdown files")

    # Step 3: Index each document
    print("\n3️⃣ Indexing documents...")
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

            # First, store document in Supabase
            try:
                document_data = await document_storage.store_and_return_document(
                    file_path=str(file_path),
                    content=content,
                    metadata={"title": title, "folder": folder},
                    category="10NetZero",
                    tags=["10netzero", folder.lower()],
                    created_by="indexing_script",
                )

                if not document_data:
                    print(f"   ❌ Failed to store document in Supabase: {file_path}")
                    continue

                document_id = document_data["id"]
                print(f"   ✅ Stored in Supabase with ID: {document_id}")

            except Exception as e:
                print(f"   ❌ Error storing document in Supabase: {e}")
                continue

            # Chunk the document with document_id in metadata
            chunk_metadata = {
                "title": title,
                "folder": folder,
                "source": "10net_reindex",
                "document_id": document_id,  # Add document_id for Supabase lookups
            }

            chunks = chunk_markdown_document(
                content=content,
                file_path=str(file_path),
                metadata=chunk_metadata,
                chunk_size=1000,
                chunk_overlap=200,
            )
            print(f"   📊 Created {len(chunks)} chunks")

            # Store each chunk in vector store
            for chunk_content, chunk_meta in chunks:
                chunk_id = f"{document_id}#chunk_{chunk_meta['chunk_index']}"

                # Add indexing timestamp and ensure document_id is in metadata
                chunk_meta.update(
                    {
                        "indexed_at": datetime.now().isoformat(),
                        "document_id": document_id,  # Ensure document_id is always present
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
                else:
                    print(f"   ❌ Failed to store chunk {chunk_id}")

            indexed_count += 1

        except Exception as e:
            print(f"   ❌ Error processing {file_path}: {e}")

    print(
        f"\n✅ Indexed {indexed_count}/{len(md_files)} documents ({chunk_count} chunks total)"
    )

    # Wait for indexing to complete (Upstash Vector has eventual consistency)
    print("\n⏳ Waiting 10 seconds for eventual consistency...")
    await asyncio.sleep(10)

    # Step 4: Run test queries
    print("\n4️⃣ Running test queries...")
    test_queries = [
        "How many sites does 10NetZero have?",
        "What are the aliases for Eagle Lake?",
        "Who are the partners at each site?",
        "FLRTS implementation",
        "Todoist webhook",
    ]

    for query in test_queries:
        print(f"\n🔍 Query: '{query}'")
        results = await vector_store.search(query, top_k=3)

        if results:
            print(f"   Found {len(results)} results:")
            for i, result in enumerate(results, 1):
                score = result.get("score", 0)
                metadata = result.get("metadata", {})
                title = metadata.get("title", "Unknown")
                file_path = metadata.get("file_path", "Unknown")
                preview = (
                    result.get("content", "")[:100] + "..."
                    if result.get("content")
                    else "No preview"
                )

                print(f"   {i}. [{score:.4f}] {title}")
                print(f"      📁 {file_path}")
                print(f"      📝 {preview}")
        else:
            print("   ❌ No results found")

    print("\n✅ Vector store reset and reindex complete!")


if __name__ == "__main__":
    asyncio.run(main())
