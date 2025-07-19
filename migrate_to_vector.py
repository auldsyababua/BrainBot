#!/usr/bin/env python3
"""
Migration script to move existing 10NetZero markdown files to Upstash Vector database.
This will enable semantic search on all existing knowledge base content.
"""
import os
import asyncio
from pathlib import Path
from typing import List, Tuple, Dict
import yaml
from datetime import datetime

from vector_store import vector_store
from tools import read_file
from config import NOTES_FOLDER

# Target folder for migration
TARGET_FOLDER = "10NetZero"


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
        full_content = read_file(file_path)
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
        "Eagle Lake site information",
        "10% markup",
        "Flober LLC",
        "waste management",
        "financial data",
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


if __name__ == "__main__":
    asyncio.run(main())
