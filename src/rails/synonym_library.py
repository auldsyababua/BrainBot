"""Synonym library for natural language processing."""

import logging
import re
from typing import Dict

logger = logging.getLogger(__name__)


class SynonymLibrary:
    """Comprehensive synonym mapping based on 500+ natural language variations."""

    def __init__(self):
        # Based on natural_language_operations_comprehensive.yaml analysis
        self.operation_synonyms = {
            # List Operations - Add Items (High Confidence)
            "add_to_list": {
                "high_confidence": [
                    "add to list",
                    "add to the list",
                    "put on list",
                    "include in list",
                    "append to list",
                    "add item",
                    "add items",
                    "put item on",
                ],
                "medium_confidence": [
                    "list needs",
                    "should have",
                    "needs to include",
                    "missing from list",
                    "don't forget",
                    "make sure list has",
                    "list should contain",
                ],
                "low_confidence": [
                    "update list with",
                    "change list",
                    "modify list",
                    "fix list",
                ],
            },
            # List Operations - Remove Items (High Confidence)
            "remove_from_list": {
                "high_confidence": [
                    "remove from list",
                    "take off list",
                    "delete from list",
                    "take out",
                    "remove item",
                    "delete item",
                    "cross off",
                    "strike out",
                ],
                "medium_confidence": [
                    "don't need",
                    "no longer need",
                    "already have",
                    "got that",
                    "completed that",
                    "list doesn't need",
                ],
                "low_confidence": ["update list", "change list", "modify list"],
            },
            # Task Operations - Complete (Very High Confidence)
            "complete_task": {
                "high_confidence": [
                    "mark complete",
                    "mark as complete",
                    "task complete",
                    "finished task",
                    "done with task",
                    "completed task",
                    "check off",
                    "task done",
                    "✓",
                    "✔",
                    "done",
                    "finished",
                    "complete",
                ],
                "medium_confidence": [
                    "that's done",
                    "finished that",
                    "got it done",
                    "all set",
                    "wrapped up",
                    "taken care of",
                ],
                "low_confidence": ["update task", "change task status"],
            },
            # Task Operations - Reassign (High Confidence with user mention)
            "reassign_task": {
                "high_confidence": [
                    "assign to",
                    "reassign to",
                    "give to",
                    "hand to",
                    "transfer to",
                    "move to",
                    "delegate to",
                    "pass to",
                ],
                "medium_confidence": [
                    "for",
                    "should handle",
                    "can take",
                    "will do",
                    "handles",
                ],
                "context_required": True,  # Needs user mention for high confidence
            },
        }

        # Confidence multipliers
        self.confidence_multipliers = {
            "explicit_user_mention": 0.25,  # @username
            "implicit_user_mention": 0.15,  # username in text
            "time_reference": 0.10,  # tomorrow, 3pm, etc.
            "item_list": 0.05,  # comma-separated items
            "site_mention": 0.10,  # Eagle Lake, Crockett, etc.
            "telegram_command": 0.20,  # /tnr, /lists, etc.
            "position_boost": 0.10,  # keyword at start of message
            "length_boost": 0.05,  # longer, more specific keywords
        }

        # Ambiguity penalties
        self.ambiguity_penalties = {
            "generic_update": -0.15,
            "vague_change": -0.10,
            "unclear_modify": -0.10,
        }

    def calculate_operation_confidence(
        self, message: str, operation: str, base_match_confidence: float
    ) -> float:
        """Calculate confidence for a specific operation based on language patterns."""

        if operation not in self.operation_synonyms:
            return base_match_confidence

        message_lower = message.lower()
        synonyms = self.operation_synonyms[operation]
        confidence = base_match_confidence

        # Check confidence levels
        if any(
            phrase in message_lower for phrase in synonyms.get("high_confidence", [])
        ):
            confidence = max(confidence, 0.8)
        elif any(
            phrase in message_lower for phrase in synonyms.get("medium_confidence", [])
        ):
            confidence = max(confidence, 0.6)

        # Apply multipliers
        if "@" in message:
            confidence += self.confidence_multipliers["explicit_user_mention"]

        # Time references boost task operations
        time_words = ["tomorrow", "today", "next week", "at", "pm", "am", "o'clock"]
        if any(word in message_lower for word in time_words):
            confidence += self.confidence_multipliers["time_reference"]

        # Item lists boost list operations
        if "," in message and "list" in operation:
            confidence += self.confidence_multipliers["item_list"]

        # Site mentions boost field report operations
        sites = ["eagle lake", "crockett", "mathis"]
        if any(site in message_lower for site in sites):
            confidence += self.confidence_multipliers["site_mention"]

        # Apply penalties for ambiguous language
        ambiguous_words = ["update", "change", "modify", "fix"]
        if any(word in message_lower for word in ambiguous_words):
            confidence += self.ambiguity_penalties["generic_update"]

        return min(max(confidence, 0.0), 1.0)  # Clamp 0-1

    def extract_confidence_indicators(self, message: str) -> Dict[str, float]:
        """Extract all confidence indicators from message."""
        indicators = {}
        message_lower = message.lower()

        # User mentions
        if "@" in message:
            indicators["explicit_user_mention"] = self.confidence_multipliers[
                "explicit_user_mention"
            ]

        # Time references
        time_patterns = ["tomorrow", "today", "next week", r"\d+[ap]m", r"at \d"]
        if any(re.search(pattern, message_lower) for pattern in time_patterns):
            indicators["time_reference"] = self.confidence_multipliers["time_reference"]

        # Item lists (commas)
        if "," in message:
            indicators["item_list"] = self.confidence_multipliers["item_list"]

        # Position (early keywords)
        action_words = ["create", "new", "add", "remove", "show", "mark", "assign"]
        for word in action_words:
            if message_lower.find(word) < 10:  # Within first 10 characters
                indicators["position_boost"] = self.confidence_multipliers[
                    "position_boost"
                ]
                break

        return indicators
