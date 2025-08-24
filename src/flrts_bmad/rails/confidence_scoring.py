"""Enhanced confidence scoring for Smart Rails (Phase 2.1).

This module provides sophisticated multi-factor confidence scoring
that considers pattern strength, context, user intent, and extraction quality.
"""

import logging
import re
from dataclasses import dataclass
from typing import Any, Dict, List, Optional, Tuple

logger = logging.getLogger(__name__)


@dataclass
class ConfidenceFactors:
    """Factors that influence confidence scoring."""

    pattern_match_strength: float = 0.0  # How well the pattern matches
    keyword_position: float = 0.0  # Position of keyword in message
    keyword_specificity: float = 0.0  # How specific/unique the keyword is
    context_clarity: float = 0.0  # Clarity of surrounding context
    extraction_completeness: float = 0.0  # How complete the extraction is
    syntax_explicitness: float = 0.0  # Use of explicit syntax like @ or /
    temporal_relevance: float = 0.0  # Presence of time indicators
    user_mention_clarity: float = 0.0  # Clarity of user assignments
    entity_disambiguation: float = 0.0  # How clear the entity type is
    operation_disambiguation: float = 0.0  # How clear the operation is

    def calculate_weighted_score(self, weights: Dict[str, float] = None) -> float:
        """Calculate weighted confidence score."""
        default_weights = {
            "pattern_match_strength": 0.25,
            "keyword_position": 0.10,
            "keyword_specificity": 0.15,
            "context_clarity": 0.10,
            "extraction_completeness": 0.10,
            "syntax_explicitness": 0.20,
            "temporal_relevance": 0.05,
            "user_mention_clarity": 0.05,
            "entity_disambiguation": 0.0,  # Used separately
            "operation_disambiguation": 0.0,  # Used separately
        }

        weights = weights or default_weights

        total_score = 0.0
        total_weight = 0.0

        for factor_name, weight in weights.items():
            if hasattr(self, factor_name):
                factor_value = getattr(self, factor_name)
                total_score += factor_value * weight
                total_weight += weight

        return total_score / total_weight if total_weight > 0 else 0.0


class EnhancedConfidenceScorer:
    """Enhanced confidence scoring with multi-factor analysis."""

    def __init__(self):
        """Initialize the enhanced confidence scorer."""
        # Define keyword specificity scores
        self.keyword_specificity = {
            # Very specific keywords (high confidence)
            "create list": 0.95,
            "add to list": 0.95,
            "remove from list": 0.95,
            "complete task": 0.95,
            "reassign to": 0.90,
            "field report for": 0.90,
            "/newtask": 1.0,
            "/addtolist": 1.0,
            "/completetask": 1.0,
            # Moderately specific keywords
            "new task": 0.80,
            "show list": 0.80,
            "show tasks": 0.80,
            "add items": 0.75,
            "remove items": 0.75,
            # Generic keywords (lower confidence)
            "add": 0.50,
            "remove": 0.50,
            "create": 0.60,
            "show": 0.50,
            "update": 0.40,
            "change": 0.40,
        }

        # Define operation clarity scores
        self.operation_clarity = {
            "create": 0.80,
            "read": 0.70,
            "add_items": 0.85,
            "remove_items": 0.85,
            "complete": 0.90,
            "reassign": 0.90,
            "reschedule": 0.85,
            "delete": 0.75,
            "update": 0.50,  # Generic update is less clear
        }

        # Compile patterns for analysis
        self._compile_analysis_patterns()

    def _compile_analysis_patterns(self):
        """Compile regex patterns for confidence analysis."""
        # Explicit syntax patterns
        self._at_mention_pattern = re.compile(r"@(\w+)")
        self._command_pattern = re.compile(r"/(\w+)")

        # Context patterns
        self._list_context_pattern = re.compile(
            r"\b(list|lists|shopping|grocery|inventory|checklist)\b", re.IGNORECASE
        )
        self._task_context_pattern = re.compile(
            r"\b(task|tasks|todo|reminder|assignment|deadline)\b", re.IGNORECASE
        )
        self._report_context_pattern = re.compile(
            r"\b(report|reports|site|field|inspection|incident)\b", re.IGNORECASE
        )

        # Temporal patterns
        self._time_pattern = re.compile(
            r"\b(today|tomorrow|monday|tuesday|wednesday|thursday|friday|saturday|sunday|"
            r"next week|next month|at \d+|in \d+ (hours?|days?|weeks?))\b",
            re.IGNORECASE,
        )

        # Quantifier patterns
        self._quantifier_pattern = re.compile(
            r"\b(all|every|each|some|any|first|last|next)\b", re.IGNORECASE
        )

    def calculate_confidence(
        self,
        message: str,
        entity_type: Optional[str],
        operation: Optional[str],
        extracted_data: Dict[str, Any],
        keyword_match: Optional[re.Match] = None,
    ) -> Tuple[float, ConfidenceFactors]:
        """Calculate confidence score with detailed factor analysis.

        T2.1.1: Enhanced confidence scoring that considers multiple factors
        and provides transparency about scoring decisions.

        Returns:
            Tuple of (confidence_score, confidence_factors)
        """
        factors = ConfidenceFactors()
        message_lower = message.lower()

        # 1. Pattern Match Strength
        if keyword_match:
            match_length = len(keyword_match.group(0))
            message_length = len(message)
            factors.pattern_match_strength = min(match_length / max(message_length * 0.3, 1), 1.0)

            # Keyword position factor
            match_position = keyword_match.start()
            if match_position == 0:
                factors.keyword_position = 1.0  # At beginning
            elif match_position < 10:
                factors.keyword_position = 0.9
            elif match_position < 20:
                factors.keyword_position = 0.7
            else:
                factors.keyword_position = 0.5

            # Keyword specificity
            matched_text = keyword_match.group(0).lower()
            factors.keyword_specificity = self.keyword_specificity.get(matched_text, 0.5)

        # 2. Syntax Explicitness (100% confidence for explicit syntax)
        has_command = bool(self._command_pattern.search(message))
        has_mention = bool(self._at_mention_pattern.search(message))

        if has_command:
            factors.syntax_explicitness = 1.0
        elif has_mention:
            factors.syntax_explicitness = 0.8
        else:
            factors.syntax_explicitness = 0.0

        # 3. Context Clarity
        context_score = 0.0
        context_matches = 0

        if entity_type == "lists" and self._list_context_pattern.search(message):
            context_score += 0.3
            context_matches += 1
        if entity_type == "tasks" and self._task_context_pattern.search(message):
            context_score += 0.3
            context_matches += 1
            #         if entity_type == "field_reports" and self._report_context_pattern.search(
            #             message
            #         ):
            context_score += 0.3
            context_matches += 1

        # Check for conflicting context
        all_contexts = [
            bool(self._list_context_pattern.search(message)),
            bool(self._task_context_pattern.search(message)),
            bool(self._report_context_pattern.search(message)),
        ]
        if sum(all_contexts) > 1:
            context_score *= 0.7  # Reduce score for ambiguous context

        factors.context_clarity = min(context_score + (0.2 if context_matches > 0 else 0), 1.0)

        # 4. Extraction Completeness
        required_extractions = self._get_required_fields(entity_type, operation)
        if required_extractions:
            extracted_count = sum(
                1
                for field in required_extractions
                if field in extracted_data and extracted_data[field]
            )
            factors.extraction_completeness = extracted_count / len(required_extractions)
        else:
            factors.extraction_completeness = 0.5  # No specific requirements

        # 5. Temporal Relevance (important for tasks)
        if entity_type == "tasks":
            has_time = bool(self._time_pattern.search(message))
            factors.temporal_relevance = 1.0 if has_time else 0.3
        else:
            factors.temporal_relevance = 0.5  # Neutral for non-tasks

        # 6. User Mention Clarity
        if extracted_data.get("assignee") or extracted_data.get("target_users"):
            factors.user_mention_clarity = 1.0 if has_mention else 0.7
        else:
            factors.user_mention_clarity = 0.5  # No user assignment

        # 7. Entity and Operation Disambiguation
        if entity_type:
            factors.entity_disambiguation = self._calculate_entity_clarity(
                message, entity_type, extracted_data
            )

        if operation:
            factors.operation_disambiguation = self.operation_clarity.get(operation, 0.5)

        # Calculate final confidence score
        confidence = factors.calculate_weighted_score()

        # Apply boosts for certain conditions
        if has_command and entity_type and operation:
            confidence = min(confidence + 0.2, 1.0)  # Command boost

        if extracted_data.get("direct_execution"):
            confidence = 1.0  # 100% for direct execution flags

        # Apply penalties for ambiguity
        if "maybe" in message_lower or "might" in message_lower or "possibly" in message_lower:
            confidence *= 0.8  # Uncertainty penalty

        if message_lower.count("or") > 1:
            confidence *= 0.9  # Multiple options penalty

        return confidence, factors

    def _get_required_fields(
        self, entity_type: Optional[str], operation: Optional[str]
    ) -> List[str]:
        """Get required fields for an entity-operation pair."""
        requirements = {
            ("lists", "create"): ["list_name", "list_type"],
            ("lists", "add_items"): ["list_name", "items"],
            ("lists", "remove_items"): ["list_name", "items"],
            ("lists", "read"): ["list_name"],
            ("tasks", "create"): ["task_title"],
            ("tasks", "complete"): ["task_title"],
            ("tasks", "reassign"): ["task_title", "new_assignee"],
            ("tasks", "reschedule"): ["task_title", "new_date"],
            #             ("field_reports", "create"): ["site", "report_content"],
            #             ("field_reports", "add_followups"): ["report_id", "followups"],
        }

        return requirements.get((entity_type, operation), [])

    def _calculate_entity_clarity(
        self, message: str, entity_type: str, extracted_data: Dict[str, Any]
    ) -> float:
        """Calculate how clearly the entity type is indicated."""
        clarity = 0.5  # Base score

        # Check for explicit entity mentions
        entity_keywords = {
            "lists": ["list", "lists", "checklist", "inventory"],
            "tasks": ["task", "tasks", "todo", "reminder", "assignment"],
            #             "field_reports": ["report", "field report", "site report", "inspection"],
        }

        keywords = entity_keywords.get(entity_type, [])
        for keyword in keywords:
            if keyword in message.lower():
                clarity = max(clarity, 0.8)
                break

        # Check for entity-specific patterns
        if entity_type == "lists" and "," in message:
            clarity += 0.1  # Lists often have comma-separated items

        if entity_type == "tasks" and self._time_pattern.search(message):
            clarity += 0.1  # Tasks often have time references

        #         if entity_type == "field_reports" and extracted_data.get("site"):
        #             clarity += 0.2  # Site mention strongly indicates field report

        return min(clarity, 1.0)

    def explain_confidence(self, confidence: float, factors: ConfidenceFactors) -> str:
        """Generate a human-readable explanation of the confidence score."""
        explanations = []

        if confidence >= 0.95:
            explanations.append("Very high confidence")
        elif confidence >= 0.8:
            explanations.append("High confidence")
        elif confidence >= 0.6:
            explanations.append("Moderate confidence")
        else:
            explanations.append("Low confidence")

        # Explain key factors
        if factors.syntax_explicitness >= 0.8:
            explanations.append("explicit syntax used")

        if factors.pattern_match_strength >= 0.8:
            explanations.append("strong pattern match")

        if factors.extraction_completeness >= 0.8:
            explanations.append("complete extraction")
        elif factors.extraction_completeness <= 0.3:
            explanations.append("incomplete extraction")

        if factors.context_clarity >= 0.7:
            explanations.append("clear context")
        elif factors.context_clarity <= 0.3:
            explanations.append("ambiguous context")

        return (
            f"{explanations[0]} ({confidence:.0%}): {', '.join(explanations[1:])}"
            if len(explanations) > 1
            else explanations[0]
        )
