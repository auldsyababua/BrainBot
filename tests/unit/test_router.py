"""Test enhanced router functionality."""

import pytest
import re
from unittest.mock import Mock
from src.rails.router import (
    KeywordRouter,
    SynonymLibrary,
    ConfidenceScorer,
)


class TestEnhancedRouter:
    """Test the enhanced router with synonym library and confidence scoring."""

    @pytest.mark.parametrize(
        "message,expected_op,expected_entity,min_confidence,max_confidence",
        [
            # Basic operations
            ("add milk to shopping list", "add_items", "lists", 0.8, 0.9),
            (
                "ADD MILK TO SHOPPING LIST",
                "add_items",
                "lists",
                0.8,
                0.9,
            ),  # Case insensitive
            # Position variations
            (
                "please add milk to the list",
                "add_items",
                "lists",
                0.8,
                0.95,
            ),  # Later position but still high confidence
            (
                "milk needs to be added to list",
                None,
                None,
                0.0,
                0.5,
            ),  # Passive voice, no direct keyword match
            # Comma boost testing
            ("add milk, eggs, bread to list", "add_items", "lists", 0.9, 1.0),
            (
                "add milk,eggs,bread to list",
                "add_items",
                "lists",
                0.9,
                1.0,
            ),  # No spaces
            # Edge cases
            ("renewed task list", None, None, 0.0, 0.5),  # Should NOT match "new task"
            (
                "addendum to list",
                None,
                None,
                0.0,
                0.5,
            ),  # Should NOT match "add to list"
            # Special characters
            ("add milk (2%) to list", "add_items", "lists", 0.8, 0.9),
            ("add @user's items to list", "add_items", "lists", 0.8, 0.9),
            # Ambiguous cases
            ("update the list", None, None, 0.0, 0.6),  # Too generic
            ("change something", None, None, 0.0, 0.4),  # Very ambiguous
            # Task operations
            ("create new task for tomorrow", "create", "tasks", 0.8, 1.0),
            ("mark generator task complete", "complete", "tasks", 0.9, 1.0),
            ("assign task to @joel", "reassign", "tasks", 0.8, 1.0),
            # Field report operations
            ("new field report for Eagle Lake", "create", "field_reports", 0.9, 1.0),
            ("show field report", "read", "field_reports", 0.8, 0.9),
        ],
    )
    def test_routing_variations(
        self, message, expected_op, expected_entity, min_confidence, max_confidence
    ):
        router = KeywordRouter()
        result = router.route(message)

        if expected_op:
            assert result.operation == expected_op
            assert result.entity_type == expected_entity
            assert min_confidence <= result.confidence <= max_confidence
        else:
            # Should have low confidence or no match
            assert result.confidence < max_confidence or result.operation is None

    def test_specific_operations_routing(self):
        """Test that specific operations replace generic 'update'."""
        router = KeywordRouter()

        # Test add_items routing
        result = router.route("add milk to shopping list")
        assert result.operation == "add_items"
        assert result.entity_type == "lists"
        assert result.confidence > 0.7

        # Test remove_items routing
        result = router.route("remove eggs from grocery list")
        assert result.operation == "remove_items"
        assert result.entity_type == "lists"

        # Test complete routing
        result = router.route("mark generator task complete")
        assert result.operation == "complete"
        assert result.entity_type == "tasks"
        assert result.confidence > 0.8

    def test_hidden_commands(self):
        """Test 100% confidence hidden commands."""
        router = KeywordRouter()

        # Test list creation hidden command
        result = router.route("/newlist shopping items")
        assert result.confidence == 1.0
        assert result.use_direct_execution is True
        assert result.operation == "create"
        assert result.entity_type == "lists"

        # Test task completion hidden command
        result = router.route("/completetask")
        assert result.confidence == 1.0
        assert result.operation == "complete"
        assert result.entity_type == "tasks"

    def test_telegram_command_boost(self):
        """Test confidence boost from Telegram commands."""
        router = KeywordRouter()

        # Test command at start
        result = router.route("/tnr create new task for tomorrow")
        assert result.entity_type == "tasks"
        assert result.confidence > 0.8  # Should have telegram boost

        # Test inline command boost
        result1 = router.route("create new list called shopping")
        result2 = router.route("create new /lists called shopping")

        # Inline command should have higher confidence
        assert result2.confidence > result1.confidence

    def test_user_assignment_confidence(self):
        """Test confidence boost for user assignments."""
        router = KeywordRouter()

        # Initialize with test user aliases
        router.synonym_lib.user_aliases = {
            "joel": "joel",
            "the canadian": "joel",
            "bryan": "bryan",
        }

        # High confidence for @ mention
        result = router.route("assign generator task to @joel")
        assert result.operation == "reassign"
        assert result.entity_type == "tasks"
        assert "joel" in result.target_users
        assert result.confidence > 0.9  # Should have high confidence with @ mention

        # Test alias resolution with pattern that matches
        result = router.route("assign task to the canadian")
        assert result.operation == "reassign"
        assert result.entity_type == "tasks"
        assert "joel" in result.target_users
        assert result.confidence > 0.8  # Should have good confidence

        # Test that user mentions are properly extracted
        result_multi = router.route("assign task to joel and bryan")
        assert "joel" in result_multi.target_users
        assert "bryan" in result_multi.target_users
        assert len(result_multi.target_users) == 2

        # Test that @ mentions work correctly
        result_at = router.route("task for @bryan")
        assert "bryan" in result_at.target_users

        # Verify high confidence when users are mentioned
        assert result_multi.confidence >= 0.9  # Should have high confidence

    def test_context_clues_boost(self):
        """Test confidence boosting from context clues."""
        router = KeywordRouter()

        # Time references boost task operations
        result = router.route("create task check oil tomorrow at 3pm")
        assert result.entity_type == "tasks"
        assert result.confidence > 0.8
        assert "time_reference" in result.extracted_data or "tomorrow" in str(
            result.extracted_data
        )

        # Site names boost field reports
        result = router.route("new field report for Eagle Lake")
        assert result.entity_type == "field_reports"
        assert result.confidence > 0.8
        assert result.extracted_data.get("site") == "Eagle Lake"

        # Item lists boost list operations
        result = router.route("add milk, eggs, bread to shopping list")
        assert result.entity_type == "lists"
        assert result.extracted_data.get("items") == ["milk", "eggs", "bread"]

    def test_interactive_telegram_routing(self):
        """Test Telegram command without specific operation."""
        router = KeywordRouter()

        result = router.route("/lists")
        assert result.entity_type == "lists"
        assert result.operation == "interactive"
        assert result.confidence == 1.0
        assert result.use_direct_execution is False

    def test_ambiguity_penalties(self):
        """Test that ambiguous language reduces confidence."""
        router = KeywordRouter()

        # Generic update should have lower confidence
        result = router.route("update the shopping list")
        # This should not match any specific operation with high confidence
        assert result.confidence < 0.7 or result.operation is None


class TestSynonymLibrary:
    """Test the synonym library functionality."""

    def test_user_alias_resolution(self):
        """Test that user aliases resolve correctly."""
        lib = SynonymLibrary()
        lib.user_aliases = {
            "joel": "joel",
            "the canadian": "joel",
            "@joel": "joel",
            "@bryan": "bryan",
            "bryan": "bryan",
        }

        # Test @ mention resolution
        users = lib.resolve_user_mentions("assign to @joel")
        assert users == ["joel"]

        # Test alias resolution
        users = lib.resolve_user_mentions("give this to the canadian")
        assert "joel" in users

        # Test multiple users
        users = lib.resolve_user_mentions("task for @joel and @bryan")
        assert set(users) == {"joel", "bryan"}

        # Test no users
        users = lib.resolve_user_mentions("no users here")
        assert len(users) == 0


class TestConfidenceScorer:
    """Test confidence calculation logic."""

    def test_operation_confidence_levels(self):
        """Test base confidence levels for different operations."""
        lib = SynonymLibrary()
        scorer = ConfidenceScorer(lib)

        # Create a mock match object
        class MockMatch:
            def start(self):
                return 5

            def group(self, n):
                return "add to list"

        match = MockMatch()

        # High confidence operations
        confidence = scorer.calculate_confidence(
            "add milk to list", "lists", "add_items", match, []
        )
        assert confidence >= 0.8

        # Very high confidence operations
        confidence = scorer.calculate_confidence(
            "mark task complete", "tasks", "complete", match, []
        )
        assert confidence >= 0.9

        # Lower confidence generic operations
        confidence = scorer.calculate_confidence(
            "update something", "lists", "update", match, []
        )
        assert confidence < 0.7

    def test_position_and_length_boosts(self):
        """Test that keyword position and length affect confidence."""
        lib = SynonymLibrary()
        scorer = ConfidenceScorer(lib)

        # Early position match
        class EarlyMatch:
            def start(self):
                return 0

            def group(self, n):
                return "new task"

        # Late position match
        class LateMatch:
            def start(self):
                return 30

            def group(self, n):
                return "new task"

        early = EarlyMatch()
        late = LateMatch()

        confidence_early = scorer.calculate_confidence(
            "new task for tomorrow", "tasks", "create", early, []
        )
        confidence_late = scorer.calculate_confidence(
            "please can you create a new task", "tasks", "create", late, []
        )

        assert confidence_early > confidence_late

    def test_confidence_never_exceeds_bounds(self):
        """Test that confidence is always between 0.0 and 1.0"""
        router = KeywordRouter()

        # Create scenario that would exceed 1.0 without clamping
        router.synonym_lib.user_aliases = {"@user": "user", "the boss": "user"}

        # Multiple boosts: hidden command (1.0) + user mention (0.2) + @ mention (0.05)
        result = router.route("/newlist for @user the boss")
        assert result.confidence == 1.0  # Should be clamped

        # Test negative confidence scenario
        scorer = ConfidenceScorer(SynonymLibrary())

        # Mock a match object
        match = Mock()
        match.start.return_value = 50  # Late position
        match.group.return_value = "x"  # Very short

        # Many penalties: ambiguous operation, late position, short match
        confidence = scorer.calculate_confidence(
            "please maybe possibly update change modify fix this",
            "lists",
            "update",
            match,
            [],
        )
        assert confidence >= 0.0  # Should never go negative

    def test_regex_match_edge_cases(self):
        """Test with actual regex match objects, not mocks"""
        router = KeywordRouter()

        # Test empty match
        pattern = re.compile(r"(nonexistent)")
        match = pattern.search("some text")
        assert match is None

        # Router should handle None matches
        result = router.route("random text with no keywords")
        assert result.operation is None or result.confidence < 0.5

        # Test multiple matches in same text
        result = router.route("create new list and add items to another list")
        # Should match the first/strongest operation
        assert result.operation in ["create", "add_items"]
        assert result.confidence > 0.7

    def test_word_boundary_matching(self):
        """Test that keyword matching respects word boundaries"""
        router = KeywordRouter()

        # "new" in "renewed" should NOT match "new task"
        result = router.route("renewed task needs attention")
        assert result.operation != "create" or result.entity_type != "tasks"

        # "add" in "addendum" should NOT match "add to list"
        result = router.route("addendum for the list")
        assert result.operation != "add_items"

        # But actual keywords should match
        result = router.route("add new items to list")
        assert result.operation == "add_items"
        assert result.entity_type == "lists"


class TestPreprocessing:
    """Test message preprocessing functionality."""

    @pytest.mark.parametrize(
        "message,expected_cleaned,expected_prefilled,expected_confidences",
        [
            # Basic @ mention extraction
            (
                "@joel /lists add milk",
                "add milk",
                {"assignee": "joel", "entity_type": "lists"},
                {"assignee_confidence": 1.0, "entity_confidence": 1.0},
            ),
            # Multiple markers
            (
                "@bryan /newtask fix gate",
                "fix gate",
                {"assignee": "bryan", "entity_type": "tasks", "operation": "create"},
                {
                    "assignee_confidence": 1.0,
                    "entity_confidence": 1.0,
                    "operation_confidence": 1.0,
                },
            ),
            # Unknown user (removed from message but not prefilled)
            ("@unknownuser do something", "do something", {}, {}),
            # Just command
            (
                "/lists grocery items",
                "grocery items",
                {"entity_type": "lists"},
                {"entity_confidence": 1.0},
            ),
            # Operation command
            (
                "/addtolist milk and eggs",
                "milk and eggs",
                {"entity_type": "lists", "operation": "add_items"},
                {"entity_confidence": 1.0, "operation_confidence": 1.0},
            ),
            # Task commands
            (
                "/showtasks",
                "",
                {"entity_type": "tasks", "operation": "read"},
                {"entity_confidence": 1.0, "operation_confidence": 1.0},
            ),
            # Multiple @ mentions (collects all valid)
            (
                "@joel @bryan /lists",
                "",
                {"assignee": ["joel", "bryan"], "entity_type": "lists"},
                {"assignee_confidence": 1.0, "entity_confidence": 1.0},
            ),
            # Command in middle of message
            (
                "please /newlist for groceries",
                "please for groceries",
                {"entity_type": "lists", "operation": "create"},
                {"entity_confidence": 1.0, "operation_confidence": 1.0},
            ),
            # Multiple spaces cleanup
            (
                "@joel    /lists    add    milk",
                "add milk",
                {"assignee": "joel", "entity_type": "lists"},
                {"assignee_confidence": 1.0, "entity_confidence": 1.0},
            ),
        ],
    )
    def test_preprocessing(
        self, message, expected_cleaned, expected_prefilled, expected_confidences
    ):
        """Test preprocessing extracts syntax correctly."""
        router = KeywordRouter()
        # Set up test aliases
        router.synonym_lib.user_aliases = {"joel": "joel", "bryan": "bryan"}

        cleaned, prefilled, confidences = router.preprocess_message(message)

        assert cleaned == expected_cleaned
        assert prefilled == expected_prefilled
        assert confidences == expected_confidences

    def test_preprocessing_with_routing(self):
        """Test that preprocessing improves routing accuracy."""
        router = KeywordRouter()
        router.synonym_lib.user_aliases = {"joel": "joel", "bryan": "bryan"}

        # Test that command extraction leads to 100% confidence
        result = router.route("@joel /newlist grocery items")
        assert result.entity_type == "lists"
        assert result.operation == "create"
        assert result.confidence == 1.0
        assert result.use_direct_execution is True
        assert result.extracted_data.get("assignee") == "joel"

        # Test that entity extraction works even without operation
        result = router.route("/tasks for this week")
        assert result.entity_type == "tasks"
        assert result.operation == "interactive"
        assert result.confidence == 1.0

        # Test that assignee is properly passed through
        result = router.route("@bryan add milk to shopping list")
        assert (
            "bryan" in result.target_users
            or result.extracted_data.get("assignee") == "bryan"
        )

    def test_preprocessing_preserves_separate_confidences(self):
        """Test that preprocessing stores separate confidence scores."""
        router = KeywordRouter()
        router.synonym_lib.user_aliases = {"joel": "joel"}

        # Full command with all components
        result = router.route("@joel /newtask check generator")
        assert result.entity_confidence == 1.0
        assert result.operation_confidence == 1.0
        assert result.assignee_confidence == 1.0

        # Partial command - only entity
        result = router.route("/lists")
        assert result.entity_confidence == 1.0
        assert result.operation_confidence is None
        assert result.assignee_confidence is None

        # Natural language with user mention - user extracted but no keyword match
        result = router.route("@joel assign task to bryan")
        # Should have both users in target_users from preprocessing
        assert "joel" in result.target_users

    def test_preprocessing_removes_syntax_from_llm(self):
        """Test that syntax markers are removed before LLM processing."""
        router = KeywordRouter()
        router.synonym_lib.user_aliases = {"joel": "joel"}

        # The cleaned message should not contain @ or / markers
        cleaned, _, _ = router.preprocess_message("@joel /lists add milk, eggs")
        assert "@" not in cleaned
        assert "/" not in cleaned
        assert cleaned == "add milk, eggs"

        # Test multiple removals
        cleaned, _, _ = router.preprocess_message(
            "@joel @bryan /newlist /addtolist items"
        )
        assert "@joel" not in cleaned
        assert "@bryan" not in cleaned
        # Only the first command is processed, so /addtolist should remain
        assert "/newlist" not in cleaned
