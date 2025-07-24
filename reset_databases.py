#!/usr/bin/env python3
"""
Reset Vector and Supabase databases to t=0 state

This script:
1. Clears all data from Vector and Supabase
2. Loads production data from notes/10NetZero/
3. Loads test fixture data for reliable test execution
4. Ensures both databases are synchronized

Usage: python reset_databases.py
"""

import asyncio
import json
import sys
from pathlib import Path
from typing import Dict, List, Any
import logging

# Add project root to path
sys.path.insert(0, str(Path(__file__).parent))

from src.storage.vector_store import vector_store
from src.storage.storage_service import document_storage
from src.core.utils import parse_frontmatter

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class DatabaseResetter:
    """Handles resetting both Vector and Supabase to synchronized t=0 state."""

    def __init__(self):
        self.notes_dir = Path("10nz_kb")
        self.test_docs_dir = Path("10nz_kb/db_test_docs_do_not_modify")
        self.fixtures_file = Path("tests/fixtures/pdf_content.json")
        self.documents_loaded = []

    async def reset_all(self):
        """Complete reset workflow."""
        logger.info("🚀 Starting database reset to t=0 state...")

        # Step 1: Clear existing data
        await self.clear_databases()

        # Step 2: Load production data
        await self.load_production_data()

        # Step 3: Load test fixture data
        await self.load_test_fixtures()

        # Step 4: Load additional test-required documents
        await self.load_test_documents()

        logger.info(f"✅ Reset complete! Loaded {len(self.documents_loaded)} documents")
        self.print_summary()

    async def clear_databases(self):
        """Clear all data from Vector and Supabase."""
        logger.info("🧹 Clearing existing data...")

        try:
            # Clear Vector store (resets entire index)
            success = await vector_store.reset_store()
            if success:
                logger.info("   ✅ Vector store cleared")
            else:
                logger.warning("   ⚠️  Vector store clear returned False")
        except Exception as e:
            logger.warning(f"   ⚠️  Vector store clear failed: {e}")

        try:
            # Clear Supabase (delete all documents)
            if document_storage:
                await document_storage.clear_all_documents()
                logger.info("   ✅ Supabase cleared")
        except Exception as e:
            logger.warning(f"   ⚠️  Supabase clear failed: {e}")

    async def load_production_data(self):
        """Load all documents from 10nz_kb/ excluding test documents."""
        logger.info("📁 Loading production data from 10nz_kb/...")

        if not self.notes_dir.exists():
            logger.error(f"Production data directory not found: {self.notes_dir}")
            return

        for md_file in self.notes_dir.rglob("*.md"):
            # Skip README files and test documents directory
            if (
                md_file.name in ["README.md", "index.md"]
                or self.test_docs_dir in md_file.parents
            ):
                continue

            await self.load_markdown_file(md_file, source="production")

        logger.info(
            f"   📁 Loaded {len([d for d in self.documents_loaded if d['source'] == 'production'])} production documents"
        )

    async def load_test_fixtures(self):
        """Load test fixture data from PDF content JSON."""
        logger.info("🧪 Loading test fixture data...")

        if not self.fixtures_file.exists():
            logger.warning(f"Test fixtures file not found: {self.fixtures_file}")
            return

        with open(self.fixtures_file) as f:
            fixtures = json.load(f)

        for fixture_id, fixture_data in fixtures.items():
            await self.load_fixture_document(fixture_id, fixture_data)

        logger.info(
            f"   🧪 Loaded {len([d for d in self.documents_loaded if d['source'] == 'fixture'])} test fixtures"
        )

    async def load_test_documents(self):
        """Load test documents from db_test_docs_do_not_modify directory."""
        logger.info("📝 Loading test-required documents...")

        if not self.test_docs_dir.exists():
            logger.warning(f"Test documents directory not found: {self.test_docs_dir}")
            return

        for md_file in self.test_docs_dir.glob("*.md"):
            if md_file.name in ["README.md", "index.md"]:
                continue

            await self.load_markdown_file(md_file, source="test_required")

        logger.info(
            f"   📝 Loaded {len([d for d in self.documents_loaded if d['source'] == 'test_required'])} test-required documents"
        )

    async def load_markdown_file(self, file_path: Path, source: str):
        """Load a single markdown file into both databases."""
        try:
            content = file_path.read_text(encoding="utf-8")
            frontmatter, body = parse_frontmatter(content)

            title = frontmatter.get(
                "title", file_path.stem.replace("-", " ").replace("_", " ").title()
            )
            # doc_type = frontmatter.get("type", "note")  # Reserved for future use
            tags = frontmatter.get("tags", [])

            # Determine category from file path - keep 10NetZero as root
            relative_path = file_path.relative_to(
                self.notes_dir
            )  # Relative to '10nz_kb'
            category = (
                str(relative_path.parent)
                if relative_path.parent != Path(".")
                else "10NetZero"
            )

            # Clean up category path
            if category.startswith("10nz_kb"):
                category = category.replace("10nz_kb", "10NetZero", 1)
            elif category == ".":
                category = "10NetZero"

            await self.store_document(
                title=title,
                content=body,
                category=category,
                tags=tags,
                source=source,
                file_path=str(file_path),
            )

            logger.debug(f"   📄 Loaded: {title}")

        except Exception as e:
            logger.error(f"   ❌ Failed to load {file_path}: {e}")

    async def load_fixture_document(
        self, fixture_id: str, fixture_data: Dict[str, Any]
    ):
        """Load a test fixture document."""
        try:
            title = fixture_data.get("file", fixture_id).replace(".pdf", "")

            # Combine test content chunks
            content_parts = []
            test_content = fixture_data.get("test_content", {})
            for chunk_key, chunk_text in test_content.items():
                content_parts.append(chunk_text)

            content = "\n\n".join(content_parts)

            if content:
                await self.store_document(
                    title=title,
                    content=content,
                    category="10NetZero/core-knowledge",
                    tags=fixture_data.get("key_concepts", []),
                    source="fixture",
                )

                logger.debug(f"   📚 Loaded fixture: {title}")

        except Exception as e:
            logger.error(f"   ❌ Failed to load fixture {fixture_id}: {e}")

    async def store_document(
        self,
        title: str,
        content: str,
        category: str,
        tags: List[str],
        source: str,
        file_path: str = None,
    ):
        """Store document in both Vector and Supabase.

        ARCHITECTURE NOTE:
        - Supabase: Stores content + file_path as metadata (human organization)
        - Vector: Stores mathematical embeddings + file_path as searchable metadata
        - file_path is just a string - Vector DB doesn't care about folder structure
        - Vector search finds documents by content similarity, not file location
        - Both DBs share same document IDs for sync
        """
        try:
            # Create synthetic file path if not provided
            if not file_path:
                file_path = f"{category}/{title.lower().replace(' ', '-')}.md"

            metadata = {
                "title": title,
                "type": "note",
                "tags": tags,
                "category": category,
                "file_path": file_path,
                "source": source,
            }

            # Store in Supabase
            if document_storage:
                doc_result = await document_storage.store_document(
                    file_path=file_path,
                    content=content,
                    metadata=metadata,
                    category=category,
                    tags=tags,
                    telegram_chat_id=None,
                    created_by="reset_script",
                )

                doc_id = (
                    doc_result
                    if doc_result
                    else f"{category}_{title}".replace("/", "_").replace(" ", "_")
                )
            else:
                doc_id = f"{category}_{title}".replace("/", "_").replace(" ", "_")

            # Store in Vector (namespace="")
            await vector_store.embed_and_store(
                str(doc_id), content, metadata, namespace=""
            )

            self.documents_loaded.append(
                {
                    "title": title,
                    "category": category,
                    "source": source,
                    "doc_id": doc_id,
                }
            )

        except Exception as e:
            logger.error(f"   ❌ Failed to store document '{title}': {e}")

    def print_summary(self):
        """Print summary of loaded documents."""
        logger.info("\n📊 Database Reset Summary:")

        by_source = {}
        for doc in self.documents_loaded:
            source = doc["source"]
            if source not in by_source:
                by_source[source] = []
            by_source[source].append(doc)

        for source, docs in by_source.items():
            logger.info(f"   {source}: {len(docs)} documents")
            for doc in docs[:5]:  # Show first 5
                logger.info(f"     - {doc['title']} ({doc['category']})")
            if len(docs) > 5:
                logger.info(f"     ... and {len(docs) - 5} more")

        logger.info(
            f"\n🎯 Total: {len(self.documents_loaded)} documents loaded into both Vector and Supabase"
        )
        logger.info("   Vector namespace: '' (shared namespace for MVP)")
        logger.info("   Supabase: All documents with metadata")


async def main():
    """Main execution function."""
    resetter = DatabaseResetter()
    await resetter.reset_all()


if __name__ == "__main__":
    asyncio.run(main())
