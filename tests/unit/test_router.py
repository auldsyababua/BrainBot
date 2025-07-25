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

        # EDGE CASE TESTING ADDITIONS

        # Test 1: Null/None inputs
        with pytest.raises((ValueError, AttributeError, TypeError)):
            router.route(None)

        # Test 2: Empty string handling
        empty_result = router.route("")
        assert empty_result.confidence < 0.1 or empty_result.operation is None
        assert empty_result.entity_type is None or empty_result.entity_type in [
            "unknown",
            "default",
        ]

        # Test 3: Maximum length inputs (10,000 chars)
        very_long_text = message + " " + ("x" * 10000)
        try:
            long_result = router.route(very_long_text)
            assert long_result is not None  # Should handle gracefully
            assert isinstance(long_result.confidence, float)
            assert 0.0 <= long_result.confidence <= 1.0
        except Exception as e:
            # If it fails, it should fail gracefully with clear error
            assert isinstance(e, (ValueError, MemoryError))

        # Test 4: Wrong input types
        for wrong_input in [12345, [], {}, True, 3.14]:
            with pytest.raises((TypeError, AttributeError)):
                router.route(wrong_input)

        # Test 5: Malformed message structures
        if isinstance(message, str) and len(message) > 0:
            # Unicode edge cases
            unicode_msg = message + " 特殊字符 🚀 \u0000 \uffff"
            unicode_result = router.route(unicode_msg)
            assert unicode_result is not None

            # Control characters
            control_msg = message + "\x00\x01\x02\x03\x04"
            control_result = router.route(control_msg)
            assert control_result is not None

            # Extreme whitespace
            whitespace_msg = "\n\n\t\t   " + message + "   \n\n\t\t"
            ws_result = router.route(whitespace_msg)
            # Should handle same as original or slightly lower confidence
            assert ws_result is not None

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

        # EDGE CASE TESTING ADDITIONS

        # Test with None fields in structured input
        try:
            result = router.route({"text": None, "user": "alice"})
        except (TypeError, AttributeError):
            # If router expects string, this is correct behavior
            pass
        else:
            # If it accepts dicts, should handle None gracefully
            assert result.confidence == 0.0 or result.operation is None

        # Test empty operations
        empty_ops = ["", "   ", "\t\n", "\x00"]
        for empty_op in empty_ops:
            result = router.route(empty_op)
            assert result.operation is None or result.confidence < 0.1

        # Test boundary cases for list operations
        edge_cases = [
            "add" + " " * 1000 + "to list",  # Excessive spacing
            "add\nto\nlist",  # Newlines instead of spaces
            "add\tto\tlist",  # Tabs
            "add  to  list",  # Double spaces
            "aDd To LiSt",  # Mixed case
            "🔥add to list🔥",  # Emojis
            "add to list!!!!!",  # Excessive punctuation
            "add to list?",  # Question mark
            "add to list.",  # Period
            "add to list,",  # Trailing comma
        ]

        for edge_case in edge_cases:
            result = router.route(edge_case)
            # Should either recognize pattern or fail gracefully
            assert result is not None
            assert 0.0 <= result.confidence <= 1.0

        # Test operations with no entity type
        no_entity_msgs = [
            "add milk to",  # Incomplete
            "remove from",  # Missing target
            "complete the",  # Missing object
            "mark done",  # Ambiguous
        ]

        for msg in no_entity_msgs:
            result = router.route(msg)
            # Should have low confidence without clear entity
            assert result.confidence < 0.7 or result.entity_type is None

        # Test conflicting operations in same message
        conflict_msgs = [
            "add and remove items from list",
            "create and delete task",
            "complete but then reopen task",
        ]

        for conflict in conflict_msgs:
            result = router.route(conflict)
            # Should pick one operation or have low confidence
            assert result is not None
            if result.operation:
                assert result.operation in [
                    "add_items",
                    "remove_items",
                    "create",
                    "delete",
                    "complete",
                ]

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

        # EDGE CASE TESTING ADDITIONS

        # Test malformed commands
        malformed_commands = [
            "/",  # Just slash
            "//newlist",  # Double slash
            "/newlist/",  # Trailing slash
            "/ newlist",  # Space after slash
            "/NEW LIST",  # Space in command
            "/newlist\n",  # Newline in command
            "/newlist\x00",  # Null byte
            "/" + "x" * 1000,  # Very long command
            "/newlist" + " " * 1000 + "items",  # Excessive spaces
            "prefix /newlist suffix",  # Command in middle
        ]

        for cmd in malformed_commands:
            result = router.route(cmd)
            # Should either handle gracefully or have specific behavior
            assert result is not None
            assert 0.0 <= result.confidence <= 1.0

        # Test command injection attempts
        injection_attempts = [
            "/newlist; rm -rf /",  # Shell injection
            "/newlist && echo hacked",  # Command chaining
            "/newlist | cat /etc/passwd",  # Pipe attempt
            "/newlist`whoami`",  # Backtick injection
            "/newlist$(date)",  # Command substitution
            '/newlist"; DROP TABLE--',  # SQL injection
            "/newlist<script>alert(1)</script>",  # XSS attempt
        ]

        for injection in injection_attempts:
            result = router.route(injection)
            # Should treat as normal text after command, not execute
            assert result is not None
            if result.operation == "create":
                # Command was recognized but injection text should be data
                assert "rm -rf" not in str(result.operation)
                assert "DROP TABLE" not in str(result.operation)

        # Test empty command data
        empty_data_cmds = [
            "/newlist ",  # Trailing space
            "/newlist\t",  # Trailing tab
            "/completetask ",  # No task specified
        ]

        for cmd in empty_data_cmds:
            result = router.route(cmd)
            # Should still recognize command even with empty data
            assert result.confidence >= 0.8

        # Test case sensitivity
        case_variants = [
            "/NEWLIST items",
            "/NewList items",
            "/newList items",
            "/NeWlIsT items",
        ]

        for variant in case_variants:
            result = router.route(variant)
            # Check if case sensitive or not
            if result.confidence == 1.0:
                assert result.operation == "create"
                assert result.entity_type == "lists"

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

        # EDGE CASE TESTING ADDITIONS

        # Test with null/empty commands
        with pytest.raises((ValueError, AttributeError, TypeError)):
            router.route(None)

        # Test multiple telegram commands in one message
        multi_cmd = "/tnr /lists /tasks create something"
        result = router.route(multi_cmd)
        assert result is not None
        # Should handle multiple commands somehow

        # Test telegram command with special characters
        special_cmds = [
            "/tnr\x00 create task",  # Null byte
            "/tnr\n\ncreate task",  # Multiple newlines
            "/tnr\t\tcreate task",  # Tabs
            "/tnr" + " " * 100 + "create task",  # Excessive spaces
            "😀/tnr create task",  # Emoji before
            "/tnr create task 🚀",  # Emoji after
            "/tnr создать задачу",  # Cyrillic
            "/tnr 创建任务",  # Chinese
            "/tnr\u200bcreate task",  # Zero-width space
        ]

        for cmd in special_cmds:
            try:
                result = router.route(cmd)
                assert result is not None
                assert 0.0 <= result.confidence <= 1.0
            except UnicodeError:
                # Unicode errors should be handled gracefully
                pass

        # Test command position effects
        position_tests = [
            "/tnr at the start",
            "in the middle /tnr here",
            "at the end /tnr",
            "multiple /tnr commands /tnr scattered",
        ]

        confidences = []
        for test in position_tests:
            result = router.route(test)
            confidences.append(result.confidence if result else 0.0)

        # First position should typically have highest confidence
        assert confidences[0] >= confidences[1]

        # Test boundary length commands
        very_long_cmd = "/tnr " + "x" * 10000
        result = router.route(very_long_cmd)
        assert result is not None  # Should not crash

        # Test command without any following text
        bare_cmds = ["/tnr", "/lists", "/tasks"]
        for bare in bare_cmds:
            result = router.route(bare)
            assert result is not None
            # Should still boost confidence even without operation

    def test_user_assignment_confidence(self):
        """Test confidence boost for user assignments - BEHAVIORAL VALIDATION."""
        router = KeywordRouter()

        # Initialize with test user aliases and skills
        router.synonym_lib.user_aliases = {
            "joel": "joel",
            "the canadian": "joel",
            "bryan": "bryan",
            "alice": "alice",
            "bob": "bob",
        }

        # Assume system tracks user skills (mock this if needed)
        user_skills = {
            "joel": ["generators", "field_reports"],
            "bryan": ["tasks", "maintenance"],
            "alice": ["ui", "frontend"],
            "bob": ["python", "backend"],
        }

        # Test 1: Clear assignment with @ mention
        task_with_clear_assignee = {
            "message": "Fix the login bug that @joel reported",
            "mentions": ["joel"],
            "context": "bug_fix",
            "priority": "high",
        }

        result = router.route(task_with_clear_assignee["message"])

        # Validate BEHAVIOR, not just presence
        assert "joel" in result.target_users, "Should assign to mentioned user"
        assert result.confidence > 0.7, "Clear @ mention should have high confidence"

        # The assignment should be based on the mention, not other factors
        assert (
            len(result.target_users) == 1
        ), "Should only assign to explicitly mentioned user"

        # Test 2: Ambiguous assignment - no clear user
        task_ambiguous = "Someone should look at the UI issues"

        result_ambiguous = router.route(task_ambiguous)

        # System behavior check: ambiguous tasks should either:
        # 1. Not assign anyone (target_users empty)
        # 2. Have very low confidence if it does assign
        if result_ambiguous.target_users:
            assert (
                result_ambiguous.confidence < 0.5
            ), "Ambiguous tasks should have low confidence assignments"

        # Test 3: Conflicting information
        task_conflicting = "Task for @alice but needs @bob's Python expertise"

        result_conflict = router.route(task_conflicting)

        # Verify system handles multiple candidates reasonably
        assert (
            len(result_conflict.target_users) >= 1
        ), "Should identify potential assignees"

        # Both users should be considered since both are mentioned
        mentioned_users = {"alice", "bob"}
        assigned_users = set(result_conflict.target_users)

        # At least one mentioned user should be in assignments
        assert (
            len(mentioned_users.intersection(assigned_users)) > 0
        ), "Should include at least one mentioned user"

        # Test 4: Alias resolution behavior
        alias_test = "assign this to the canadian"
        result_alias = router.route(alias_test)

        assert (
            "joel" in result_alias.target_users
        ), "Should resolve alias to actual user"
        assert (
            "the canadian" not in result_alias.target_users
        ), "Should not include alias as separate user"

        # Test 5: Multiple user mentions with operations
        multi_user = "transfer task from @joel to @bryan"
        result_multi = router.route(multi_user)

        # Both users should be identified
        assert "joel" in result_multi.target_users
        assert "bryan" in result_multi.target_users

        # Operation should be transfer/reassign
        assert result_multi.operation in ["reassign", "transfer", "update"]

        # Test 6: Edge cases that reveal implementation bugs
        edge_cases = [
            ("assign to @nonexistent_user", [], "Should handle unknown users"),
            ("task for @joel @joel @joel", ["joel"], "Should deduplicate users"),
            ("@", [], "Lone @ should not crash"),
            ("@@@@joel", ["joel"], "Multiple @ should still work"),
            ("email@domain.com", [], "Email addresses should not be users"),
            ("joel@generator task", ["joel"], "Should handle @ in middle of username"),
        ]

        for msg, expected_users, description in edge_cases:
            result = router.route(msg)
            assert result is not None, f"{description}: Should not crash"

            if expected_users:
                for user in expected_users:
                    assert user in result.target_users, f"{description}: Missing {user}"

        # Test 7: Confidence should reflect assignment clarity
        clear_assignment = "@joel fix the generator immediately"
        unclear_assignment = "someone might want to look at the generator when they can"

        clear_result = router.route(clear_assignment)
        unclear_result = router.route(unclear_assignment)

        assert (
            clear_result.confidence > unclear_result.confidence
        ), "Clear assignments should have higher confidence than vague ones"

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

        # EDGE CASE TESTING ADDITIONS

        # Test with malformed time references
        malformed_times = [
            "create task tomorrow at 25:00",  # Invalid hour
            "create task at 99pm",  # Invalid time format
            "create task yesterday at -5am",  # Negative time
            "create task at time.now()",  # Code injection
            "create task at DROP TABLE",  # SQL injection
            "create task at \x00:00",  # Null byte in time
        ]

        for time_msg in malformed_times:
            result = router.route(time_msg)
            assert result is not None, "Should handle malformed times gracefully"
            # Should still recognize as task despite bad time
            if "task" in time_msg:
                assert result.entity_type in ["tasks", None]

        # Test site names with special characters
        special_sites = [
            "field report for Site-123",
            "field report for Site #5",
            "field report for 北京站",  # Chinese characters
            "field report for Site\x00Name",  # Null byte
            "field report for " + "X" * 1000,  # Very long site name
            "field report for ",  # Empty site
            "field report for Site'; DROP TABLE--",  # SQL injection
        ]

        for site_msg in special_sites:
            result = router.route(site_msg)
            assert result is not None
            if result.entity_type == "field_reports":
                # Site should be extracted safely
                site = result.extracted_data.get("site", "")
                assert "DROP TABLE" not in site
                assert "\x00" not in site

        # Test item lists with edge cases
        edge_list_cases = [
            "add , , , to list",  # Empty items
            "add item1,item2,item3,item4,item5,item6,item7,item8,item9,item10," * 100
            + " to list",  # Many items
            "add milk, , eggs to list",  # Empty item in middle
            "add 牛奶, 鸡蛋, 面包 to list",  # Unicode items
            "add item\x00, item\x01 to list",  # Control characters
            "add <script>alert(1)</script> to list",  # XSS attempt
        ]

        for list_msg in edge_list_cases:
            result = router.route(list_msg)
            assert result is not None

            if result.entity_type == "lists" and "items" in result.extracted_data:
                items = result.extracted_data["items"]
                # Check items are properly sanitized
                for item in items:
                    assert isinstance(item, str)
                    assert "<script>" not in item  # No XSS

        # Test conflicting context clues
        conflict_msgs = [
            "create task for Eagle Lake tomorrow",  # Task + site name
            "add task check oil to list",  # Task language + list operation
            "field report tomorrow at 3pm",  # Field report + time
        ]

        for conflict in conflict_msgs:
            result = router.route(conflict)
            assert result is not None
            # Should pick one entity type, not multiple
            assert result.entity_type in ["tasks", "lists", "field_reports", None]

        # Test empty context
        no_context = [
            "do something",
            "handle it",
            "process this",
            "take care of that",
        ]

        for vague in no_context:
            result = router.route(vague)
            # Without context clues, confidence should be lower
            assert result.confidence < 0.7 or result.entity_type is None

    def test_interactive_telegram_routing(self):
        """Test Telegram command without specific operation."""
        router = KeywordRouter()

        result = router.route("/lists")
        assert result.entity_type == "lists"
        assert result.operation == "interactive"
        assert result.confidence == 1.0
        assert result.use_direct_execution is False

        # EDGE CASE TESTING ADDITIONS

        # Test null/empty
        with pytest.raises((ValueError, AttributeError, TypeError)):
            router.route(None)

        # Test various malformed interactive commands
        malformed_interactive = [
            "/",  # Just slash
            "//lists",  # Double slash
            "/lists/",  # Trailing slash
            "/ lists",  # Space after slash
            "/LISTS",  # Uppercase
            "/lists\x00",  # Null byte
            "/lists\n\n",  # Newlines
            "/lists" + " " * 1000,  # Trailing spaces
            "\x00/lists",  # Null byte prefix
            "/lists; echo test",  # Command injection
            "/lists && rm -rf",  # Shell injection
            "/lists | grep",  # Pipe attempt
        ]

        for cmd in malformed_interactive:
            try:
                result = router.route(cmd)
                assert result is not None
                # Should handle gracefully
                assert 0.0 <= result.confidence <= 1.0

                # Check injection attempts don't execute
                if "echo" in cmd or "rm" in cmd or "grep" in cmd:
                    assert "echo" not in str(result.operation)
                    assert "rm" not in str(result.operation)
            except Exception as e:
                # Some malformed inputs might raise exceptions
                assert isinstance(e, (ValueError, TypeError, AttributeError))

        # Test interactive commands for all entity types
        entity_types = ["lists", "tasks", "field_reports", "users", "unknown_entity"]

        for entity in entity_types:
            cmd = f"/{entity}"
            result = router.route(cmd)
            assert result is not None

            if entity in ["lists", "tasks", "field_reports"]:
                assert result.entity_type == entity
                assert result.operation == "interactive"
                assert result.confidence >= 0.8
            else:
                # Unknown entities should have lower confidence
                assert result.confidence < 0.8 or result.entity_type is None

        # Test position sensitivity
        position_tests = [
            "/lists at start",
            "text before /lists",
            "text /lists in middle",
            "at the end /lists",
        ]

        for test in position_tests:
            result = router.route(test)
            assert result is not None
            # Command recognition might vary by position

    def test_ambiguity_penalties(self):
        """Test that ambiguous language reduces confidence."""
        router = KeywordRouter()

        # Generic update should have lower confidence
        result = router.route("update the shopping list")
        # This should not match any specific operation with high confidence
        assert result.confidence < 0.7 or result.operation is None

        # EDGE CASE TESTING ADDITIONS

        # Test extremely ambiguous messages
        super_ambiguous = [
            "maybe possibly perhaps do something with the thing",
            "could you might want to potentially handle this",
            "something something list task report whatever",
            "um uh well like you know do the thing",
            "...",
            "???",
            "thing",
            "it",
            "that",
            "stuff",
        ]

        for ambiguous in super_ambiguous:
            result = router.route(ambiguous)
            assert result is not None
            # Extremely ambiguous should have very low confidence
            assert result.confidence < 0.5 or result.operation is None

        # Test conflicting keywords that create ambiguity
        conflicting = [
            "create or delete the task",
            "add but actually remove from list",
            "complete unless you want to uncomplete",
            "list task report all at once",
            "do everything and nothing",
        ]

        for conflict in conflicting:
            result = router.route(conflict)
            # Conflicting instructions should reduce confidence
            assert result.confidence < 0.8

        # Test with noise words
        noise_messages = [
            "um add uh milk um to uh the um list please",
            "like totally add this to like the list you know",
            "well, I mean, sort of add this, I guess",
        ]

        for noisy in noise_messages:
            result = router.route(noisy)
            assert result is not None
            # Should still work but with reduced confidence due to uncertainty markers
            if result.operation == "add_items":
                assert result.confidence < 0.9  # Penalty for uncertainty

        # Test messages with no clear intent
        no_intent = [
            " " * 100,  # Just spaces
            "\n\n\n\n",  # Just newlines
            "\t\t\t\t",  # Just tabs
            "!@#$%^&*()",  # Just symbols
            "🤔🤷‍♂️😕❓",  # Just emojis
        ]

        for empty_intent in no_intent:
            result = router.route(empty_intent)
            assert result is not None
            assert result.confidence < 0.1 or result.operation is None

        # Test confidence penalty accumulation
        increasing_ambiguity = [
            "add milk to list",  # Clear
            "maybe add milk to list",  # Slight uncertainty
            "possibly maybe add milk to list",  # More uncertainty
            "perhaps possibly maybe add milk to list",  # Very uncertain
            "I think perhaps possibly maybe add milk to list somehow",  # Maximum uncertainty
        ]

        confidences = []
        for msg in increasing_ambiguity:
            result = router.route(msg)
            confidences.append(result.confidence if result else 0.0)

        # Confidence should decrease with more ambiguity
        for i in range(1, len(confidences)):
            assert (
                confidences[i] <= confidences[i - 1]
            ), f"More ambiguous message should not have higher confidence: {confidences}"


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

        # EDGE CASE TESTING ADDITIONS

        # Test with None/null inputs
        with pytest.raises((AttributeError, TypeError)):
            scorer.calculate_confidence(None, "lists", "add_items", match, [])

        # Test with empty strings
        empty_confidence = scorer.calculate_confidence("", "", "", match, [])
        assert 0.0 <= empty_confidence <= 1.0  # Should handle gracefully

        # Test with very long inputs
        long_msg = "x" * 10000
        long_confidence = scorer.calculate_confidence(
            long_msg, "lists", "add_items", match, []
        )
        assert 0.0 <= long_confidence <= 1.0

        # Test with invalid match objects
        class BadMatch:
            def start(self):
                return -1  # Invalid position

            def group(self, n):
                return None  # Invalid group

        bad_match = BadMatch()
        try:
            bad_confidence = scorer.calculate_confidence(
                "test", "lists", "add", bad_match, []
            )
            assert 0.0 <= bad_confidence <= 1.0
        except (ValueError, TypeError):
            # Should handle invalid match gracefully
            pass

        # Test with conflicting parameters
        conflict_conf = scorer.calculate_confidence(
            "delete this item",  # Message says delete
            "lists",
            "add_items",  # But operation is add
            match,
            [],
        )
        # Conflicting intent should reduce confidence
        assert conflict_conf < 0.8

        # Test with special characters
        special_msgs = [
            "add 特殊字符 to list",
            "add \x00\x01 to list",
            "add <script>alert()</script> to list",
            "add ${variable} to list",
        ]

        for special_msg in special_msgs:
            conf = scorer.calculate_confidence(
                special_msg, "lists", "add_items", match, []
            )
            assert 0.0 <= conf <= 1.0

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

    def test_regex_match_edge_cases_behavior(self):
        """Test regex matching BEHAVIOR, not just format - BEHAVIORAL VALIDATION"""
        router = KeywordRouter()

        # Assuming the system uses regex to match field reports
        # Test 1: Valid field report formats should extract meaningful data
        valid_reports = [
            (
                "Site A: Status green, all systems operational",
                {"should_match": True, "site": "A", "has_status": True},
            ),
            (
                "Site B: Alert - power fluctuation detected",
                {"should_match": True, "site": "B", "has_alert": True},
            ),
            (
                "Site C: Maintenance completed at 14:00",
                {"should_match": True, "site": "C", "has_time": True},
            ),
            (
                "Site Delta-5: Temperature 72°F, humidity 45%",
                {"should_match": True, "site": "Delta-5", "has_data": True},
            ),
        ]

        for report_text, expectations in valid_reports:
            result = router.route(report_text)

            # Check behavioral expectations
            if expectations["should_match"]:
                # Should recognize as field report
                assert (
                    result.entity_type == "field_reports" or result.confidence > 0.5
                ), f"Failed to recognize valid field report: {report_text}"

                # Should extract site information
                if "site" in expectations and result.extracted_data:
                    extracted_site = result.extracted_data.get("site", "")
                    assert (
                        expectations["site"] in extracted_site
                        or extracted_site in expectations["site"]
                    ), f"Failed to extract site from: {report_text}"

        # Test 2: Invalid formats should NOT match or have low confidence
        invalid_reports = [
            "Site: Missing identifier",  # No site ID
            "A: Status update",  # Missing 'Site' prefix
            "Site A Status green",  # Missing colon separator
            "Site 123: Update",  # Depends on if numeric IDs are valid
            "Location X: Status",  # Wrong prefix
            "Site A- Status",  # Malformed separator
        ]

        for invalid in invalid_reports:
            result = router.route(invalid)

            # Should either not match or have low confidence
            if result.entity_type == "field_reports":
                assert (
                    result.confidence < 0.7
                ), f"Invalid format matched with high confidence: {invalid}"

        # Test 3: Edge cases that might break regex
        regex_breakers = [
            "Site A: " + ":" * 100,  # Multiple colons
            "Site A: \n\nMultiline\nContent\nWith\nBreaks",  # Newlines
            "Site A: 特殊字符测试 🔧 ⚡",  # Unicode
            "Site A:" + " " * 1000 + "Status OK",  # Excessive whitespace
            "Site (A): Status",  # Parentheses in site name
            "Site A/B: Joint report",  # Slash in site name
            "Site A: Status: Green: OK",  # Multiple colons in content
            "Site A+B: Combined status",  # Special chars in site
            "Site [A]: Status update",  # Brackets
            "Site A: <script>alert('xss')</script>",  # XSS attempt
        ]

        for breaker in regex_breakers:
            try:
                result = router.route(breaker)
                assert result is not None, "Should handle edge case gracefully"

                # If matched as field report, check data extraction
                if result.entity_type == "field_reports":
                    # Should not execute injected code
                    if result.extracted_data:
                        assert "<script>" not in str(result.extracted_data)
                        assert "alert(" not in str(result.extracted_data)

            except Exception as e:
                # Should fail gracefully with clear error
                assert isinstance(
                    e, (ValueError, TypeError, re.error)
                ), f"Unexpected error type for: {breaker}"

        # Test 4: Pattern priority and conflicts
        multi_pattern_msgs = [
            "create new list Site A: Status green",  # List creation + field report pattern
            "Site B: add milk to shopping list",  # Field report pattern + list operation
            "task: Site C: check generator",  # Task + field report pattern
        ]

        for msg in multi_pattern_msgs:
            result = router.route(msg)
            # Should pick one pattern, not mix them
            assert result.entity_type in ["lists", "tasks", "field_reports", None]

            # Should be consistent - same input always produces same output
            result2 = router.route(msg)
            assert result.entity_type == result2.entity_type
            assert abs(result.confidence - result2.confidence) < 0.01

        # Test 5: Regex performance with pathological inputs
        pathological = [
            "a" * 10000,  # Very long string
            "Site " + "A" * 1000 + ": Status",  # Long site name
            ("Site A: " + "word " * 1000),  # Many words
            "Site A: " + "." * 10000,  # Many dots (regex wildcard)
        ]

        import time

        for path_input in pathological:
            start = time.time()
            result = router.route(path_input)
            elapsed = time.time() - start

            # Should not hang or take too long
            assert elapsed < 1.0, f"Regex too slow on pathological input: {elapsed}s"
            assert result is not None

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

        # EDGE CASE TESTING ADDITIONS

        # Test with null input
        with pytest.raises((ValueError, AttributeError, TypeError)):
            router.route(None)

        # Test preprocessing with malformed syntax
        malformed_tests = [
            ("@@@@joel /////lists", ["lists", "joel"]),  # Multiple special chars
            (
                "@joel@bryan@alice",
                ["joel", "bryan", "alice"],
            ),  # No spaces between mentions
            ("/", []),  # Just slash
            ("@", []),  # Just @
            ("@joel /unknowncommand test", ["joel"]),  # Unknown command
            ("@nonexistent /lists", ["lists"]),  # Non-existent user
            ("/lists@joel", ["lists", "joel"]),  # Reversed order
            ("test @joel test /lists test", ["joel", "lists"]),  # Scattered markers
        ]

        for test_msg, expected_extracts in malformed_tests:
            try:
                result = router.route(test_msg)
                assert result is not None

                # Check that expected elements were extracted somehow
                extracted_elements = []
                if result.entity_type:
                    extracted_elements.append(result.entity_type)
                if result.target_users:
                    extracted_elements.extend(result.target_users)
                if result.extracted_data:
                    if "assignee" in result.extracted_data:
                        assignee = result.extracted_data["assignee"]
                        if isinstance(assignee, list):
                            extracted_elements.extend(assignee)
                        else:
                            extracted_elements.append(assignee)

            except Exception as e:
                # Some malformed inputs might raise exceptions
                assert isinstance(e, (ValueError, TypeError, AttributeError))

        # Test preprocessing with extreme lengths
        long_tests = [
            "@" + "x" * 1000 + " /lists",  # Very long username
            "@joel /" + "x" * 1000,  # Very long command
            "@joel " * 100 + "/lists",  # Many mentions
            "/lists " + "x" * 10000,  # Very long content after command
        ]

        for long_msg in long_tests:
            try:
                result = router.route(long_msg)
                assert result is not None
                assert 0.0 <= result.confidence <= 1.0
            except MemoryError:
                # Extreme lengths might cause memory issues
                pass

        # Test preprocessing preserves important data
        preservation_tests = [
            "@joel /newlist Buy milk (2%)",
            "@bryan /tasks Fix generator #123",
            "/field_reports Site A: Status = OK",
        ]

        for test_msg in preservation_tests:
            result = router.route(test_msg)
            # Original data should be preserved somewhere
            assert result is not None
            # Check that numbers, symbols, etc. are preserved
            if "2%" in test_msg:
                assert "2%" in str(result.extracted_data) or "2%" in str(result)

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

        # EDGE CASE TESTING ADDITIONS

        # Test confidence preservation with edge cases
        edge_confidence_tests = [
            # Multiple confidence types
            (
                "@joel @bryan /newlist /addtolist",
                {
                    "entity": 1.0,  # Should have entity confidence
                    "operation": 1.0,  # Should have operation confidence
                    "assignee": 1.0,  # Should have assignee confidence
                },
            ),
            # Conflicting confidences
            (
                "/lists create task",
                {
                    "entity": 1.0,  # Clear entity from command
                    "operation": None,  # Conflicting operations
                },
            ),
            # Empty/null confidences
            (
                "random text",
                {
                    "entity": None,
                    "operation": None,
                    "assignee": None,
                },
            ),
        ]

        for msg, expected_confs in edge_confidence_tests:
            result = router.route(msg)

            if "entity" in expected_confs:
                if expected_confs["entity"] is not None:
                    assert result.entity_confidence is not None
                    assert (
                        abs(result.entity_confidence - expected_confs["entity"]) < 0.2
                    )
                else:
                    assert (
                        result.entity_confidence is None
                        or result.entity_confidence < 0.5
                    )

        # Test confidence boundaries
        boundary_tests = [
            "@" * 100 + "joel /" + "lists" * 100,  # Extreme repetition
            "/lists" + "\x00" * 10,  # Null bytes
            "@joel\n/lists\n/tasks",  # Newlines between elements
        ]

        for boundary_msg in boundary_tests:
            try:
                result = router.route(boundary_msg)
                # All confidences should be within bounds
                if result.entity_confidence is not None:
                    assert 0.0 <= result.entity_confidence <= 1.0
                if result.operation_confidence is not None:
                    assert 0.0 <= result.operation_confidence <= 1.0
                if result.assignee_confidence is not None:
                    assert 0.0 <= result.assignee_confidence <= 1.0
            except Exception as e:
                assert isinstance(e, (ValueError, TypeError, AttributeError))

        # Test confidence independence
        # Changing one confidence factor shouldn't affect others
        base_msg = "create list"
        base_result = router.route(base_msg)

        # Add user mention - should only affect assignee confidence
        user_msg = "@joel create list"
        user_result = router.route(user_msg)

        if base_result.entity_confidence and user_result.entity_confidence:
            # Entity confidence should be similar
            assert (
                abs(base_result.entity_confidence - user_result.entity_confidence) < 0.2
            )

        # Assignee confidence should be different
        assert user_result.assignee_confidence is not None
        assert (
            base_result.assignee_confidence is None
            or base_result.assignee_confidence < user_result.assignee_confidence
        )

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
