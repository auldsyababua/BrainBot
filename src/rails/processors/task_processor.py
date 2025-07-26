"""Task operations processor working with existing tasks table."""

import logging
from typing import Dict, Any
from .base_processor import BaseProcessor

logger = logging.getLogger(__name__)


class TaskProcessor(BaseProcessor):
    """Handles task operations using existing tasks table."""

    def __init__(self, supabase_client):
        super().__init__(supabase_client)

    def get_extraction_schema(self, operation: str) -> str:
        """Get JSON schema for LLM data extraction based on operation."""

        if operation is None:
            raise ValueError("Operation cannot be None")

        if not isinstance(operation, str):
            raise TypeError(f"Operation must be a string, got {type(operation)}")

        if not operation:
            raise ValueError("Operation cannot be empty")

        if operation == "create":
            return """{
                "task_title": "title of the task",
                "task_description_detailed": "detailed description",
                "assigned_to": "username or alias",
                "site_name": "optional site name",
                "due_date": "YYYY-MM-DD format or relative like tomorrow",
                "priority": "High|Medium|Low",
                "reminder_time": "optional reminder datetime"
            }"""

        elif operation == "complete":
            return """{
                "task_title": "title or description of task to complete",
                "completion_notes": "optional completion notes"
            }"""

        elif operation == "reassign":
            return """{
                "task_title": "title of task to reassign",
                "new_assignee": "username or alias of new assignee",
                "reason": "optional reason for reassignment"
            }"""

        elif operation == "reschedule":
            return """{
                "task_title": "title of task to reschedule",
                "new_due_date": "new due date",
                "reason": "optional reason for reschedule"
            }"""

        elif operation == "add_notes":
            return """{
                "task_title": "title of task to add notes to",
                "notes": "notes to add to task description"
            }"""

        elif operation == "read":
            return """{
                "filters": {
                    "assigned_to": "optional username filter",
                    "site_name": "optional site filter", 
                    "status": "To Do|In Progress|Completed|Blocked|Cancelled",
                    "priority": "High|Medium|Low",
                    "date_range": "optional date range"
                }
            }"""

        else:
            raise KeyError(f"Unknown operation: {operation}")

    async def validate_operation(
        self, operation: str, data: Dict[str, Any], user_role: str = "user"
    ) -> tuple[bool, str]:
        """Validate if operation is allowed and data is complete."""

        # Validate required fields
        required_fields = {
            "create": ["task_title"],
            "complete": ["task_title"],
            "reassign": ["task_title", "new_assignee"],
            "reschedule": ["task_title", "new_due_date"],
            "add_notes": ["task_title", "notes"],
            "read": [],  # No required fields for read operations
        }

        if operation in required_fields:
            missing = [
                field for field in required_fields[operation] if field not in data
            ]
            if missing:
                return False, f"Missing required fields: {', '.join(missing)}"

        # Validate assignee exists if specified
        if (operation in ["create", "reassign"]) and (
            "assigned_to" in data or "new_assignee" in data
        ):
            assignee = data.get("assigned_to") or data.get("new_assignee")
            if assignee:
                try:
                    # Check if user exists in personnel table or aliases
                    response = await self._safe_db_operation(
                        self.supabase.table("personnel")
                        .select("id, first_name, aliases")
                        .eq("is_active", True)
                        .execute()
                    )

                    if response and response.data:
                        valid_users = []
                        for user in response.data:
                            valid_users.append(user["first_name"].lower())
                            if user.get("aliases"):
                                valid_users.extend(
                                    [alias.lower() for alias in user["aliases"]]
                                )

                        if assignee.lower() not in valid_users:
                            return (
                                False,
                                f"Unknown user: {assignee}. Please use a known username or alias.",
                            )
                    else:
                        # If we can't validate, let it through rather than blocking
                        logger.warning(
                            "Could not validate assignee - database unavailable"
                        )

                except Exception as e:
                    logger.warning(f"Could not validate assignee: {e}")
                    return False, "Database error occurred during validation"

        return True, "Valid"

    def get_confidence_boost_factors(self, message: str, operation: str) -> float:
        """Calculate confidence boost based on message analysis."""
        if message is None:
            raise ValueError("Message cannot be None")
        if operation is None:
            raise ValueError("Operation cannot be None")

        boost = 0.0
        message_lower = message.lower()

        # Specific operation keywords boost confidence
        operation_keywords = {
            "create": ["new task", "create task", "remind me", "task for"],
            "complete": ["mark complete", "finish", "done with", "completed"],
            "reassign": ["assign to", "reassign to", "give to", "transfer to"],
            "reschedule": ["reschedule", "move to", "change date", "push to"],
            "add_notes": ["add note", "note on", "update with", "add details"],
        }

        if operation in operation_keywords:
            if any(
                keyword in message_lower for keyword in operation_keywords[operation]
            ):
                boost += 0.1

        # Time references boost task operations
        time_indicators = [
            "tomorrow",
            "today",
            "next week",
            "at",
            "pm",
            "am",
            "deadline",
            "due",
        ]
        if any(indicator in message_lower for indicator in time_indicators):
            boost += 0.1

        # Priority indicators boost confidence
        priority_words = [
            "urgent",
            "asap",
            "high priority",
            "low priority",
            "important",
        ]
        if any(word in message_lower for word in priority_words):
            boost += 0.05

        # Site mentions boost confidence for site-specific tasks
        site_names = ["eagle lake", "crockett", "mathis"]
        if any(site in message_lower for site in site_names):
            boost += 0.1

        # User mentions boost assignment operations
        if "@" in message and operation in ["create", "reassign"]:
            boost += 0.15

        return boost

    def get_dynamic_extraction_schema(
        self, operation: str, prefilled_data: Dict[str, Any]
    ) -> str:
        """Generate dynamic extraction schema based on prefilled data."""

        if operation == "create":
            # If assignee is prefilled, don't ask for it
            if "assignee" in prefilled_data:
                return """{
                    "task_title": "title of the task",
                    "task_description_detailed": "detailed description",
                    "site_name": "optional site name",
                    "due_date": "YYYY-MM-DD format or relative like tomorrow",
                    "priority": "High|Medium|Low",
                    "reminder_time": "optional reminder datetime"
                }"""
            else:
                return self.get_extraction_schema(operation)

        elif operation == "complete":
            return """{
                "task_title": "title or description of task to complete",
                "completion_notes": "optional completion notes"
            }"""

        elif operation == "reassign":
            # If new assignee is prefilled, don't ask for it
            if "assignee" in prefilled_data:
                return """{
                    "task_title": "title of task to reassign",
                    "reason": "optional reason for reassignment"
                }"""
            else:
                return """{
                    "task_title": "title of task to reassign",
                    "new_assignee": "username or alias of new assignee",
                    "reason": "optional reason for reassignment"
                }"""

        elif operation == "reschedule":
            return """{
                "task_title": "title of task to reschedule",
                "new_due_date": "new due date",
                "reason": "optional reason for reschedule"
            }"""

        elif operation == "add_notes":
            return """{
                "task_title": "title of task to add notes to",
                "notes": "notes to add to task description"
            }"""

        elif operation == "read":
            # If assignee is prefilled, use it as a filter
            if "assignee" in prefilled_data:
                return """{
                    "filters": {
                        "site_name": "optional site filter", 
                        "status": "To Do|In Progress|Completed|Blocked|Cancelled",
                        "priority": "High|Medium|Low",
                        "date_range": "optional date range"
                    }
                }"""
            else:
                return self.get_extraction_schema(operation)

        # Fall back to full schema if operation unknown
        return self.get_extraction_schema(operation)
