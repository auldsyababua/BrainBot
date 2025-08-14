#!/usr/bin/env python3
"""
Migration script to move existing 10NetZero markdown files to Upstash Vector database.
This will enable semantic search on all existing knowledge base content.
"""
import asyncio
import os
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Tuple

import yaml

from src.core.chunking import chunk_markdown_document
from src.storage.vector_store import vector_store

# Define notes folder locally for migration
NOTES_FOLDER = os.getenv("NOTES_FOLDER", "10nz_kb")

# Target folder for migration
TARGET_FOLDER = os.getenv("MIGRATION_FOLDER", "CompanyDocs")


def extract_frontmatter(content: str) -> Tuple[Dict, str]:
    """Extract YAML frontmatter and content from markdown file."""
    if content.startswith("---\n"):
        try:
            # Find the closing ---
            end_index = content.find("\n---\n", 4)
            if end_index != -1:
                yaml_content = content[4:end_index]
                markdown_content = content[end_index + 5 :].strip()

                # Parse YAML
                metadata = yaml.safe_load(yaml_content) or {}
                return metadata, markdown_content
        except yaml.YAMLError:
            pass

    # No frontmatter or parsing error
    return {}, content


async def migrate_file(file_path: str) -> bool:
    """Migrate a single markdown file to vector database."""
    try:
        # Read file content
        with open(file_path, "r", encoding="utf-8") as f:
            full_content = f.read()
        if not full_content:
            print(f"⚠️  Skipping empty file: {file_path}")
            return False

        # Extract frontmatter and content
        metadata, content = extract_frontmatter(full_content)

        # Create document ID from file path
        doc_id = (
            file_path.replace(NOTES_FOLDER, "").replace("/", "_").replace(".md", "")
        )
        if doc_id.startswith("_"):
            doc_id = doc_id[1:]

        # Prepare metadata for vector store
        vector_metadata = {
            "file_path": file_path,
            "title": metadata.get("title", Path(file_path).stem),
            "type": metadata.get("type", "note"),
            "tags": metadata.get("tags", []),
            "created": metadata.get("created", datetime.now().isoformat()),
            "folder": TARGET_FOLDER,
            "source": "migration",
        }

        # Add any custom metadata from frontmatter
        for key, value in metadata.items():
            if key not in vector_metadata and isinstance(
                value, (str, int, float, bool, list)
            ):
                vector_metadata[key] = value

        # Store in vector database
        success = await vector_store.embed_and_store(doc_id, content, vector_metadata)

        if success:
            print(f"✅ Migrated: {file_path}")
        else:
            print(f"❌ Failed to migrate: {file_path}")

        return success

    except Exception as e:
        print(f"❌ Error migrating {file_path}: {e}")
        return False


async def migrate_file_chunked(
    file_path: str, chunk_size: int = 1000, chunk_overlap: int = 200
) -> int:
    """Migrate a single markdown file to vector database using chunking.

    Args:
        file_path: Path to the markdown file
        chunk_size: Size of each chunk in characters
        chunk_overlap: Number of characters to overlap between chunks

    Returns:
        Number of chunks created (0 if failed)
    """
    try:
        # Read file content
        with open(file_path, "r", encoding="utf-8") as f:
            full_content = f.read()
        if not full_content:
            print(f"⚠️  Skipping empty file: {file_path}")
            return 0

        # Extract frontmatter and content
        metadata, content = extract_frontmatter(full_content)

        # Prepare base metadata for all chunks
        base_metadata = {
            "file_path": file_path,
            "title": metadata.get("title", Path(file_path).stem),
            "type": metadata.get("type", "note"),
            "tags": metadata.get("tags", []),
            "created": metadata.get("created", datetime.now().isoformat()),
            "folder": TARGET_FOLDER,
            "source": "migration_chunked",
        }

        # Add any custom metadata from frontmatter
        for key, value in metadata.items():
            if key not in base_metadata and isinstance(
                value, (str, int, float, bool, list)
            ):
                base_metadata[key] = value

        # Chunk the document
        chunks = chunk_markdown_document(
            content,
            file_path,
            base_metadata,
            chunk_size=chunk_size,
            chunk_overlap=chunk_overlap,
        )

        # Store each chunk in vector database
        success_count = 0
        for i, (chunk_text, chunk_metadata) in enumerate(chunks):
            # Create unique ID for this chunk
            chunk_id = chunk_metadata["chunk_id"]

            # Store in vector database
            success = await vector_store.embed_and_store(
                chunk_id, chunk_text, chunk_metadata
            )

            if success:
                success_count += 1
            else:
                print(f"  ❌ Failed to store chunk {i+1}/{len(chunks)} of {file_path}")

        if success_count == len(chunks):
            print(f"✅ Migrated {file_path} ({len(chunks)} chunks)")
        elif success_count > 0:
            print(
                f"⚠️  Partially migrated {file_path} ({success_count}/{len(chunks)} chunks)"
            )
        else:
            print(f"❌ Failed to migrate any chunks from {file_path}")

        return success_count

    except Exception as e:
        print(f"❌ Error migrating {file_path}: {e}")
        return 0


async def get_10netzero_files() -> List[str]:
    """Get all markdown files in the 10NetZero folder."""
    target_path = os.path.join(NOTES_FOLDER, TARGET_FOLDER)

    if not os.path.exists(target_path):
        print(f"❌ Target folder not found: {target_path}")
        return []

    files = []
    for root, _, filenames in os.walk(target_path):
        for filename in filenames:
            if filename.endswith(".md") and not filename.startswith("."):
                files.append(os.path.join(root, filename))

    return files


async def migrate_all():
    """Migrate all 10NetZero markdown files to vector database."""
    print(f"🚀 Starting migration of {TARGET_FOLDER} folder to Upstash Vector...")
    print(f"📁 Markdown directory: {NOTES_FOLDER}")

    # Get all files to migrate
    files = await get_10netzero_files()

    if not files:
        print(f"⚠️  No markdown files found in {TARGET_FOLDER} folder")
        return

    print(f"📊 Found {len(files)} files to migrate")

    # Skip confirmation if running in automated mode
    import sys

    if not sys.stdin.isatty():
        print("\n✅ Running in automated mode, proceeding with migration...")
    else:
        # Ask for confirmation
        response = input("\nProceed with migration? (yes/no): ")
        if response.lower() != "yes":
            print("❌ Migration cancelled")
            return

    # Migrate files in batches
    batch_size = 10
    total_migrated = 0

    for i in range(0, len(files), batch_size):
        batch = files[i : i + batch_size]
        print(
            f"\n📦 Processing batch {i//batch_size + 1}/{(len(files) + batch_size - 1)//batch_size}"
        )

        # Process batch concurrently
        results = await asyncio.gather(*[migrate_file(f) for f in batch])

        # Count successes
        successes = sum(1 for r in results if r)
        total_migrated += successes

        print(f"   Batch complete: {successes}/{len(batch)} files migrated")

        # Small delay between batches to avoid rate limits
        if i + batch_size < len(files):
            await asyncio.sleep(1)

    print("\n✅ Migration complete!")
    print(f"📊 Successfully migrated {total_migrated}/{len(files)} files")

    if total_migrated < len(files):
        print(f"⚠️  {len(files) - total_migrated} files failed to migrate")


async def test_search():
    """Test the vector search after migration."""
    print("\n🔍 Testing vector search...")

    test_queries = [
        "site information",
        "equipment maintenance",
        "company policies",
        "operational procedures",
        "safety protocols",
    ]

    for query in test_queries:
        print(f"\n📝 Query: '{query}'")
        results = await vector_store.search(query, top_k=3)

        if results:
            for i, result in enumerate(results, 1):
                print(f"   {i}. Score: {result['score']:.3f}")
                if result.get("metadata"):
                    print(
                        f"      File: {result['metadata'].get('file_path', 'Unknown')}"
                    )
                    print(f"      Title: {result['metadata'].get('title', 'Unknown')}")
                if result.get("content"):
                    preview = result["content"][:100].replace("\n", " ")
                    print(f"      Preview: {preview}...")
        else:
            print("   No results found")


async def main():
    """Main entry point."""
    # Run migration
    await migrate_all()

    # Optionally test search
    import sys

    if not sys.stdin.isatty():
        print("\n✅ Running in automated mode, testing search...")
        await test_search()
    else:
        response = input("\nTest vector search? (yes/no): ")
        if response.lower() == "yes":
            await test_search()


async def migrate_all_chunked():
    """Migrate all files using document chunking."""
    files = await get_10netzero_files()
    if not files:
        print(f"⚠️  No markdown files found in {TARGET_FOLDER} folder")
        return

    print(f"📊 Found {len(files)} files to migrate with chunking")
    print("📐 Chunk size: 1000 chars, Overlap: 200 chars")

    # Skip confirmation if running in automated mode
    import sys

    if not sys.stdin.isatty():
        print("\n✅ Running in automated mode, proceeding with chunked migration...")
    else:
        # Ask for confirmation
        response = input("\nProceed with chunked migration? (yes/no): ")
        if response.lower() != "yes":
            print("❌ Migration cancelled")
            return

    # Migrate files
    total_chunks = 0
    total_files = 0

    for i, file_path in enumerate(files, 1):
        print(f"\n📄 Processing file {i}/{len(files)}: {os.path.basename(file_path)}")

        # Migrate with chunking
        chunks_created = await migrate_file_chunked(file_path)

        if chunks_created > 0:
            total_chunks += chunks_created
            total_files += 1

        # Small delay to avoid rate limits
        if i < len(files):
            await asyncio.sleep(0.5)

    print("\n✅ Chunked migration complete!")
    print(f"📊 Successfully migrated {total_files}/{len(files)} files")
    print(f"📦 Total chunks created: {total_chunks}")
    if total_files > 0:
        print(f"📐 Average chunks per file: {total_chunks/total_files:.1f}")

    if total_files < len(files):
        print(f"⚠️  {len(files) - total_files} files failed to migrate")


if __name__ == "__main__":
    import sys

    # Check for command line argument
    if len(sys.argv) > 1 and sys.argv[1] == "--chunked":
        print("🔄 Starting chunked migration...")
        asyncio.run(migrate_all_chunked())
    else:
        print("🔄 Starting standard migration (no chunking)...")
        print("💡 Tip: Use --chunked flag for document chunking")
        asyncio.run(main())
