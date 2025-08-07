"""
Unit tests for graph memory functionality in the markdown-brain-bot.
"""

import pytest
import asyncio
import os
from unittest.mock import Mock, AsyncMock, patch
from src.core.memory import BotMemory
from src.core.graph_memory_seeder import GraphMemorySeeder, seed_graph_memory


class TestGraphMemory:
    """Test cases for graph memory functionality."""

    @pytest.fixture
    def mock_memory(self):
        """Create a mock BotMemory instance with graph support."""
        memory = Mock(spec=BotMemory)
        memory.has_graph = True
        memory.memory = Mock()
        memory.memory.add = Mock(
            return_value={"id": "test-memory-id", "status": "created"}
        )
        memory.memory.search = Mock(return_value=[])
        memory.memory.get_all = Mock(return_value=[])
        memory.webhook_url = None
        return memory

    @pytest.fixture
    def mock_memory_no_graph(self):
        """Create a mock BotMemory instance without graph support."""
        memory = Mock(spec=BotMemory)
        memory.has_graph = False
        memory.memory = None
        return memory

    @pytest.mark.asyncio
    async def test_store_entity_relationship_success(self, mock_memory):
        """Test successful entity relationship storage."""
        # Create actual BotMemory instance and replace memory attribute
        bot_memory = BotMemory()
        bot_memory.memory = mock_memory.memory
        bot_memory.has_graph = True
        bot_memory.webhook_url = None

        result = await bot_memory.store_entity_relationship(
            user_id="test_user",
            source_entity="North Austin Facility",
            relationship="LOCATED_IN",
            target_entity="Austin",
            metadata={"confidence": 0.9},
        )

        assert result is not None
        assert result["id"] == "test-memory-id"

        # Verify the memory.add was called with correct parameters
        mock_memory.memory.add.assert_called_once()
        call_args = mock_memory.memory.add.call_args

        assert call_args[1]["user_id"] == "test_user"
        assert (
            "North Austin Facility located in Austin"
            in call_args[1]["messages"][0]["content"]
        )
        assert call_args[1]["metadata"]["type"] == "relationship"
        assert call_args[1]["metadata"]["source_entity"] == "North Austin Facility"
        assert call_args[1]["metadata"]["relationship"] == "LOCATED_IN"
        assert call_args[1]["metadata"]["target_entity"] == "Austin"

    @pytest.mark.asyncio
    async def test_store_entity_relationship_no_graph(self, mock_memory_no_graph):
        """Test entity relationship storage when graph is not available."""
        bot_memory = BotMemory()
        bot_memory.memory = mock_memory_no_graph.memory
        bot_memory.has_graph = False

        result = await bot_memory.store_entity_relationship(
            user_id="test_user",
            source_entity="Site A",
            relationship="CONNECTS_TO",
            target_entity="Site B",
        )

        assert result is None

    @pytest.mark.asyncio
    async def test_find_related_entities(self, mock_memory):
        """Test finding related entities."""
        # Mock search results with relationship memories
        mock_search_results = [
            {
                "id": "mem-1",
                "memory": "North Austin Facility located in Austin",
                "score": 0.9,
                "metadata": {
                    "type": "relationship",
                    "source_entity": "North Austin Facility",
                    "relationship": "LOCATED_IN",
                    "target_entity": "Austin",
                },
            },
            {
                "id": "mem-2",
                "memory": "North Austin Facility has GreenEnergy Capital",
                "score": 0.8,
                "metadata": {
                    "type": "relationship",
                    "source_entity": "North Austin Facility",
                    "relationship": "HAS_PARTNER",
                    "target_entity": "GreenEnergy Capital",
                },
            },
        ]

        mock_memory.memory.search.return_value = mock_search_results

        # Create actual BotMemory instance
        bot_memory = BotMemory()
        bot_memory.memory = mock_memory.memory
        bot_memory.has_graph = True

        relationships = await bot_memory.find_related_entities(
            user_id="test_user", entity="North Austin Facility"
        )

        assert "LOCATED_IN" in relationships
        assert "HAS_PARTNER" in relationships
        assert len(relationships["LOCATED_IN"]) == 1
        assert len(relationships["HAS_PARTNER"]) == 1
        assert relationships["LOCATED_IN"][0]["entity"] == "Austin"
        assert relationships["HAS_PARTNER"][0]["entity"] == "GreenEnergy Capital"

    @pytest.mark.asyncio
    async def test_get_entity_context(self, mock_memory):
        """Test getting comprehensive entity context."""
        # Mock vector search results
        mock_vector_results = [
            {
                "id": "vec-1",
                "memory": "North Austin Facility is our main production site",
                "score": 0.95,
            }
        ]

        mock_memory.memory.search.return_value = mock_vector_results

        # Create actual BotMemory instance
        bot_memory = BotMemory()
        bot_memory.memory = mock_memory.memory
        bot_memory.has_graph = True

        # Mock find_related_entities
        with patch.object(bot_memory, "find_related_entities") as mock_find_related:
            mock_find_related.return_value = {
                "LOCATED_IN": [{"entity": "Austin", "confidence": 0.9}]
            }

            context = await bot_memory.get_entity_context(
                user_id="test_user", entity="North Austin Facility"
            )

        assert context["entity"] == "North Austin Facility"
        assert len(context["direct_mentions"]) == 1
        assert context["confidence_score"] == 0.95
        assert "LOCATED_IN" in context["relationships"]
        assert "Austin" in context["related_concepts"]

    @pytest.mark.asyncio
    async def test_build_knowledge_graph(self, mock_memory):
        """Test building knowledge graph representation."""
        # Mock memories with relationships
        mock_memories = [
            {
                "id": "mem-1",
                "memory": "North Austin Facility located in Austin",
                "metadata": {
                    "type": "relationship",
                    "source_entity": "North Austin Facility",
                    "relationship": "LOCATED_IN",
                    "target_entity": "Austin",
                },
            },
            {
                "id": "mem-2",
                "memory": "GreenEnergy Capital invests in North Austin Facility",
                "metadata": {
                    "type": "relationship",
                    "source_entity": "GreenEnergy Capital",
                    "relationship": "INVESTS_IN",
                    "target_entity": "North Austin Facility",
                },
            },
        ]

        # Create actual BotMemory instance
        bot_memory = BotMemory()
        bot_memory.memory = mock_memory.memory
        bot_memory.has_graph = True

        with patch.object(bot_memory, "get_all_memories") as mock_get_all:
            mock_get_all.return_value = mock_memories

            graph = await bot_memory.build_knowledge_graph(user_id="test_user")

        assert "nodes" in graph
        assert "edges" in graph
        assert "stats" in graph

        # Check nodes
        node_labels = [node["label"] for node in graph["nodes"]]
        assert "North Austin Facility" in node_labels
        assert "Austin" in node_labels
        assert "GreenEnergy Capital" in node_labels

        # Check edges
        assert len(graph["edges"]) == 2
        relationships = [edge["relationship"] for edge in graph["edges"]]
        assert "LOCATED_IN" in relationships
        assert "INVESTS_IN" in relationships

        # Check stats
        assert graph["stats"]["total_nodes"] == 3
        assert graph["stats"]["total_edges"] == 2

    def test_infer_entity_type(self):
        """Test entity type inference."""
        bot_memory = BotMemory()

        # Test location entities
        assert bot_memory._infer_entity_type("North Austin Facility") == "location"
        assert bot_memory._infer_entity_type("Houston Plant") == "location"
        assert bot_memory._infer_entity_type("Eagle Lake") == "location"

        # Test equipment entities
        assert bot_memory._infer_entity_type("Water Pump") == "equipment"
        assert bot_memory._infer_entity_type("Control System") == "equipment"

        # Test organization entities
        assert bot_memory._infer_entity_type("GreenEnergy Capital") == "organization"
        assert bot_memory._infer_entity_type("10NetZero, Inc.") == "organization"

        # Test activity entities
        assert bot_memory._infer_entity_type("Daily Checklist") == "activity"
        assert bot_memory._infer_entity_type("Inventory Report") == "activity"

        # Test default
        assert bot_memory._infer_entity_type("Unknown Entity") == "concept"

    @pytest.mark.asyncio
    async def test_hybrid_search_with_graph(self, mock_memory):
        """Test hybrid search combining vector and graph data."""
        # Mock vector search results
        mock_vector_results = [
            {
                "id": "vec-1",
                "memory": "North Austin Facility pump maintenance",
                "score": 0.9,
            }
        ]

        mock_memory.memory.search.side_effect = [
            mock_vector_results,  # First call for base search
            [],  # Second call for related entities search
        ]

        # Create actual BotMemory instance
        bot_memory = BotMemory()
        bot_memory.memory = mock_memory.memory
        bot_memory.has_graph = True

        with patch.object(bot_memory, "find_related_entities") as mock_find_related:
            mock_find_related.return_value = {}

            results = await bot_memory.hybrid_search_with_graph(
                user_id="test_user", query="pump maintenance", limit=10
            )

        assert len(results) >= 1
        assert results[0]["source"] == "vector_search"
        assert "relationship_context" in results[0]

    @pytest.mark.asyncio
    async def test_suggest_connections(self, mock_memory):
        """Test connection suggestions."""
        # Mock entity context
        mock_context = {
            "entity": "North Austin Facility",
            "direct_mentions": [
                {
                    "memory": "North Austin Facility has GreenEnergy Capital as investor",
                    "score": 0.9,
                },
                {"memory": "Austin facility uses advanced pump systems", "score": 0.8},
            ],
            "relationships": {},
            "related_concepts": [],
            "confidence_score": 0.85,
        }

        # Create actual BotMemory instance
        bot_memory = BotMemory()
        bot_memory.memory = mock_memory.memory
        bot_memory.has_graph = True

        with patch.object(bot_memory, "get_entity_context") as mock_get_context:
            mock_get_context.return_value = mock_context

            suggestions = await bot_memory.suggest_connections(
                user_id="test_user", entity="North Austin Facility", limit=5
            )

        assert isinstance(suggestions, list)
        # Should suggest entities found in the same context
        if suggestions:
            assert all("entity" in suggestion for suggestion in suggestions)
            assert all("confidence" in suggestion for suggestion in suggestions)


class TestGraphMemorySeeder:
    """Test cases for graph memory seeder functionality."""

    @pytest.fixture
    def mock_config_file(self, tmp_path):
        """Create a temporary config file for testing."""
        config_data = {
            "initial_memories": [
                {
                    "user_id": "system",
                    "content": "10NetZero, Inc. is the main company with ID 4e3daa5f-9015-4ae8-a79c-620ccc45757f",
                    "category": "organization",
                },
                {
                    "user_id": "system",
                    "content": "Active sites: North Austin Facility (S001, status: Running), West Houston Mining Center (S002, status: Commissioning)",
                    "category": "sites",
                },
                {
                    "user_id": "system",
                    "content": "Site-Partner relationships: North Austin Facility has GreenEnergy Capital (Primary Investor, 15% markup)",
                    "category": "partnerships",
                },
            ]
        }

        config_file = tmp_path / "test_config.json"
        import json

        with open(config_file, "w") as f:
            json.dump(config_data, f)

        return config_file

    @pytest.mark.asyncio
    async def test_seed_organizational_relationships(self, mock_config_file):
        """Test seeding organizational relationships from config."""
        # Mock the memory
        with patch("src.core.graph_memory_seeder.bot_memory") as mock_memory:
            mock_memory.has_graph = True
            mock_memory.store_entity_relationship = AsyncMock(
                return_value={"id": "test-relationship", "status": "created"}
            )

            seeder = GraphMemorySeeder()
            seeder.config_path = mock_config_file

            success = await seeder.seed_organizational_relationships()

        assert success is True
        # Verify relationships were created
        assert mock_memory.store_entity_relationship.call_count > 0

    def test_extract_relationships_organization(self):
        """Test relationship extraction from organization content."""
        seeder = GraphMemorySeeder()

        content = "10NetZero, Inc. is the main company with ID 4e3daa5f-9015-4ae8-a79c-620ccc45757f"
        relationships = seeder._extract_relationships_from_content(
            content, "organization"
        )

        assert len(relationships) > 0
        # Should create company relationship
        company_rel = next(
            (r for r in relationships if r["source"] == "10NetZero, Inc."), None
        )
        assert company_rel is not None
        assert company_rel["type"] == "IS_A"
        assert company_rel["target"] == "Company"

    def test_extract_relationships_sites(self):
        """Test relationship extraction from sites content."""
        seeder = GraphMemorySeeder()

        content = "Active sites: North Austin Facility (S001, status: Running), West Houston Mining Center (S002, status: Commissioning)"
        relationships = seeder._extract_relationships_from_content(content, "sites")

        assert len(relationships) > 0

        # Check for site relationships
        site_rels = [r for r in relationships if r["type"] == "HAS_SITE"]
        assert len(site_rels) >= 2

        # Check for status relationships
        status_rels = [r for r in relationships if r["type"] == "HAS_STATUS"]
        assert len(status_rels) >= 2

    def test_extract_relationships_partnerships(self):
        """Test relationship extraction from partnerships content."""
        seeder = GraphMemorySeeder()

        content = "Site-Partner relationships: North Austin Facility has GreenEnergy Capital (Primary Investor, 15% markup)"
        relationships = seeder._extract_relationships_from_content(
            content, "partnerships"
        )

        assert len(relationships) > 0

        # Check for partner relationship
        partner_rels = [r for r in relationships if r["type"] == "HAS_PARTNER"]
        assert len(partner_rels) >= 1

        # Check for role and markup relationships
        role_rels = [r for r in relationships if r["type"] == "HAS_ROLE"]
        markup_rels = [r for r in relationships if r["type"] == "HAS_MARKUP"]
        assert len(role_rels) >= 1
        assert len(markup_rels) >= 1

    @pytest.mark.asyncio
    async def test_seed_graph_memory_no_graph(self):
        """Test seed_graph_memory function when graph is not available."""
        with patch("src.core.graph_memory_seeder.bot_memory") as mock_memory:
            mock_memory.has_graph = False

            result = await seed_graph_memory()

        assert result is True  # Should succeed but skip seeding

    @pytest.mark.asyncio
    async def test_seed_graph_memory_success(self):
        """Test successful seed_graph_memory function."""
        with (
            patch("src.core.graph_memory_seeder.bot_memory") as mock_memory,
            patch("src.core.graph_memory_seeder.graph_seeder") as mock_seeder,
        ):
            mock_memory.has_graph = True
            mock_seeder.seed_organizational_relationships = AsyncMock(return_value=True)

            result = await seed_graph_memory()

        assert result is True
        mock_seeder.seed_organizational_relationships.assert_called_once()


# Test fixtures and utilities
@pytest.fixture
def event_loop():
    """Create an instance of the default event loop for the test session."""
    loop = asyncio.get_event_loop_policy().new_event_loop()
    yield loop
    loop.close()


class TestProperAsyncMocking:
    """Tests with proper async mock configuration."""

    @pytest.mark.asyncio
    async def test_store_entity_relationship_with_proper_mocks(self):
        """Test entity relationship storage with correctly configured mocks."""
        # Mock the Memory class at the import level
        with patch("src.core.memory.Memory") as MockMemory:
            # Create a mock instance with synchronous methods (as mem0 uses)
            mock_memory_instance = Mock()
            mock_memory_instance.add = Mock(
                return_value={"id": "test-id", "status": "created"}
            )
            mock_memory_instance.search = Mock(return_value=[])
            mock_memory_instance.get_all = Mock(return_value=[])

            # Configure the mock class to return our mock instance
            MockMemory.from_config.return_value = mock_memory_instance

            # Create BotMemory with proper Neo4j config
            with patch.dict(
                os.environ,
                {
                    "NEO4J_URL": "bolt://localhost:7687",
                    "NEO4J_USERNAME": "neo4j",
                    "NEO4J_PASSWORD": "password",
                    "OPENAI_API_KEY": "test-key",
                },
            ):
                bot_memory = BotMemory()

                # Test the async wrapper method
                result = await bot_memory.store_entity_relationship(
                    user_id="test_user",
                    source_entity="Site A",
                    relationship="CONNECTS_TO",
                    target_entity="Site B",
                )

                # Verify the result
                assert result is not None
                assert result["id"] == "test-id"

                # Verify the synchronous mem0 method was called correctly
                mock_memory_instance.add.assert_called_once()
                call_args = mock_memory_instance.add.call_args
                assert call_args[1]["user_id"] == "test_user"
                assert call_args[1]["metadata"]["type"] == "relationship"

    @pytest.mark.asyncio
    async def test_recall_context_with_proper_mocks(self):
        """Test memory recall with correctly configured mocks."""
        with patch("src.core.memory.Memory") as MockMemory:
            # Mock search results
            search_results = [
                {"memory": "User works at Site A", "score": 0.9},
                {"memory": "Site A connected to Site B", "score": 0.8},
            ]

            mock_memory_instance = Mock()
            mock_memory_instance.search = Mock(return_value=search_results)
            MockMemory.from_config.return_value = mock_memory_instance

            with patch.dict(os.environ, {"OPENAI_API_KEY": "test-key"}):
                bot_memory = BotMemory()

                # Test the async wrapper
                results = await bot_memory.recall_context(
                    query="Tell me about Site A", user_id="test_user", limit=5
                )

                # Verify results
                assert len(results) == 2
                assert results[0]["score"] == 0.9

                # Verify the synchronous method was called
                mock_memory_instance.search.assert_called_once_with(
                    query="Tell me about Site A", user_id="test_user", limit=5
                )


if __name__ == "__main__":
    pytest.main([__file__])
