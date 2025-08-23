"""Field report operations processor working with existing field_reports table."""

import logging
from typing import Any, Dict, List

from .base_processor import BaseProcessor

logger = logging.getLogger(__name__)


class FieldReportProcessor(BaseProcessor):
    """Handles field report operations using existing field_reports table."""

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
                "site_name": "site name (Eagle Lake, Crockett, Mathis)",
                "report_type": "Daily Operational Summary|Incident Report|Maintenance Log|Safety Observation|Equipment Check|Security Update|Visitor Log|Other",
                "report_title_summary": "brief title/summary",
                "report_content_full": "detailed report content",
                "report_status": "Draft|Submitted"
            }"""

        elif operation == "add_followups":
            return """{
                "report_identifier": "report title or ID to add followups to",
                "followup_items": ["followup item 1", "followup item 2"],
                "priority": "High|Medium|Low"
            }"""

        elif operation == "update_status":
            return """{
                "report_identifier": "report title or ID to update",
                "new_status": "Draft|Submitted|Under Review|Actioned|Archived|Requires Follow-up"
            }"""

        elif operation == "read":
            return """{
                "filters": {
                    "site_name": "optional site filter",
                    "report_type": "optional type filter",
                    "date_range": "optional date range",
                    "status": "optional status filter",
                    "limit": 20
                }
            }"""

        else:
            raise KeyError(f"Unknown operation: {operation}")

    async def validate_operation(
        self, operation: str, data: Dict[str, Any], user_role: str = "user"
    ) -> tuple[bool, str]:
        """Validate if operation is allowed and data is complete."""

        # Validate required fields
        required_fields: Dict[str, List[str]] = {
            "create": ["site_name", "report_content_full"],
            "add_followups": ["report_identifier", "followup_items"],
            "update_status": ["report_identifier", "new_status"],
            "read": [],  # No required fields for read operations
        }

        if operation in required_fields:
            missing = [
                field for field in required_fields[operation] if field not in data
            ]
            if missing:
                return False, f"Missing required fields: {', '.join(missing)}"

        # Validate site exists if specified
        if "site_name" in data:
            site_name = data["site_name"]
            try:
                response = await self._safe_db_operation(
                    self.supabase.table("sites").select("site_name").execute()
                )
                if response and response.data:
                    valid_sites = [site["site_name"].lower() for site in response.data]

                    if site_name.lower() not in valid_sites:
                        return (
                            False,
                            f"Unknown site: {site_name}. Available sites: {', '.join([s.title() for s in valid_sites])}",
                        )
                else:
                    # If we can't validate, fail gracefully
                    logger.warning(
                        "Could not validate site name - database unavailable"
                    )
                    return False, "Could not validate site - database unavailable"

            except Exception as e:
                logger.warning(f"Could not validate site: {e}")
                return False, "Database error occurred during validation"

        # Validate report status values
        if "new_status" in data:
            valid_statuses = [
                "Draft",
                "Submitted",
                "Under Review",
                "Actioned",
                "Archived",
                "Requires Follow-up",
            ]
            if data["new_status"] not in valid_statuses:
                return (
                    False,
                    f"Invalid status. Must be one of: {', '.join(valid_statuses)}",
                )

        # Validate report type values
        if "report_type" in data:
            valid_types = [
                "Daily Operational Summary",
                "Incident Report",
                "Maintenance Log",
                "Safety Observation",
                "Equipment Check",
                "Security Update",
                "Visitor Log",
                "Other",
            ]
            if data["report_type"] not in valid_types:
                return (
                    False,
                    f"Invalid report type. Must be one of: {', '.join(valid_types)}",
                )

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
            "create": ["new field report", "create field report", "report for"],
            "add_followups": [
                "add followup",
                "followup for",
                "action item",
                "needs followup",
            ],
            "update_status": [
                "mark report",
                "report status",
                "finalize report",
                "draft report",
            ],
            "read": ["show field report", "latest field report", "reports for"],
        }

        if operation in operation_keywords:
            if any(
                keyword in message_lower for keyword in operation_keywords[operation]
            ):
                boost += 0.1

        # Site mentions strongly boost field report confidence
        site_names = ["eagle lake", "crockett", "mathis"]
        if any(site in message_lower for site in site_names):
            boost += 0.15

        # Report type indicators boost confidence
        report_indicators = [
            "incident",
            "maintenance",
            "safety",
            "equipment",
            "security",
            "visitor",
            "operational",
            "daily",
            "summary",
        ]
        if any(indicator in message_lower for indicator in report_indicators):
            boost += 0.1

        # Status change indicators
        status_words = ["draft", "submit", "finalize", "review", "action", "archive"]
        if (
            any(word in message_lower for word in status_words)
            and operation == "update_status"
        ):
            boost += 0.1

        # Time references suggest operational reports
        time_words = ["today", "yesterday", "this morning", "this afternoon", "shift"]
        if any(word in message_lower for word in time_words):
            boost += 0.05

        return boost
