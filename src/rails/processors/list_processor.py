"""List operations processor working with existing lists/list_items tables."""

import logging
from typing import Dict, Any, Tuple
from .base_processor import BaseProcessor

logger = logging.getLogger(__name__)


class ListProcessor(BaseProcessor):
    """Handles all list-related operations using existing lists and list_items tables."""

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
                "list_name": "name of the list",
                "items": ["item1", "item2"],
                "list_type": "Tools Inventory|Shopping List|Safety Checklist|Maintenance Procedure|Contact List|Other",
                "description": "optional description",
                "site_name": "optional site name if site-specific"
            }"""

        elif operation == "add_items":
            return """{
                "list_name": "name of the list to update",
                "items": ["items to add"],
                "operation_type": "add_items"
            }"""

        elif operation == "remove_items":
            return """{
                "list_name": "name of the list to update", 
                "items": ["items to remove"],
                "operation_type": "remove_items"
            }"""

        elif operation == "rename":
            return """{
                "current_list_name": "current list name",
                "new_list_name": "new list name",
                "operation_type": "rename"
            }"""

        elif operation == "clear":
            return """{
                "list_name": "name of the list to clear",
                "operation_type": "clear",
                "confirm": true
            }"""

        elif operation == "read":
            return """{
                "list_name": "name of the list to show",
                "filters": {
                    "show_completed": true,
                    "limit": 50,
                    "site_name": "optional site filter"
                }
            }"""

        elif operation == "delete":
            return """{
                "list_name": "name of the list to delete",
                "operation_type": "delete",
                "confirm": true
            }"""

        else:
            raise KeyError(f"Unknown operation: {operation}")

    async def validate_operation(
        self, operation: str, data: Dict[str, Any], user_role: str = "user"
    ) -> Tuple[bool, str]:
        """Validate if operation is allowed and data is complete."""

        if operation is None:
            raise ValueError("Operation cannot be None")

        if data is None:
            raise ValueError("Data cannot be None")

        if user_role is None:
            raise ValueError("User role cannot be None")

        if not operation:
            return False, "Operation cannot be empty"

        # Check admin-only operations
        if operation == "delete" and user_role != "admin":
            return False, "List deletion requires admin privileges"

        # Check for protected lists (site-specific)
        if "list_name" in data:
            list_name = data["list_name"].lower()

            # Check if this is a site-protected list by looking up in database
            try:
                response = await self._safe_db_operation(
                    self.supabase.table("sites").select("site_name").execute()
                )
                if response and response.data:
                    site_names = [site["site_name"].lower() for site in response.data]

                    for site_name in site_names:
                        if site_name in list_name and operation == "delete":
                            return (
                                False,
                                f"Cannot delete site-specific list: {data['list_name']}",
                            )
            except Exception as e:
                logger.warning(f"Could not validate site protection: {e}")
                return False, "Database error occurred during validation"

        # Validate required fields
        required_fields = {
            "create": ["list_name"],
            "add_items": ["list_name", "items"],
            "remove_items": ["list_name", "items"],
            "rename": ["current_list_name", "new_list_name"],
            "clear": ["list_name"],
            "read": ["list_name"],
            "delete": ["list_name"],
        }

        if operation in required_fields:
            missing = [
                field for field in required_fields[operation] if field not in data
            ]
            if missing:
                return False, f"Missing required fields: {', '.join(missing)}"

        return True, "Valid"

    def get_confidence_boost_factors(self, message: str, operation: str) -> float:
        """Calculate confidence boost based on message analysis."""
        boost = 0.0
        message_lower = message.lower()

        # Specific operation keywords boost confidence
        operation_keywords = {
            "add_items": ["add to", "put on", "include", "append"],
            "remove_items": ["remove from", "take off", "delete from"],
            "create": ["new list", "create list", "make list"],
            "clear": ["clear list", "empty list", "remove all"],
        }

        if operation in operation_keywords:
            if any(
                keyword in message_lower for keyword in operation_keywords[operation]
            ):
                boost += 0.1

        # Item enumeration boosts list operations
        if "," in message and operation in ["add_items", "remove_items", "create"]:
            boost += 0.05

        # List type specifications
        list_types = [
            "checklist",
            "shopping list",
            "todo list",
            "task list",
            "inventory",
            "tools",
        ]
        if any(list_type in message_lower for list_type in list_types):
            boost += 0.05

        # Site mentions boost confidence
        site_names = ["eagle lake", "crockett", "mathis"]
        if any(site in message_lower for site in site_names):
            boost += 0.1

        return boost

    def get_dynamic_extraction_schema(
        self, operation: str, prefilled_data: Dict[str, Any]
    ) -> str:
        """Generate dynamic extraction schema based on prefilled data."""

        if operation == "create":
            # We always need at least the list name
            return """{
                "list_name": "name of the list",
                "items": ["item1", "item2"],
                "list_type": "Tools Inventory|Shopping List|Safety Checklist|Maintenance Procedure|Contact List|Other",
                "description": "optional description",
                "site_name": "optional site name if site-specific"
            }"""

        elif operation == "add_items":
            # If we have prefilled assignee, we don't need to ask for it
            return """{
                "list_name": "name of the list to update",
                "items": ["items to add"]
            }"""

        elif operation == "remove_items":
            return """{
                "list_name": "name of the list to update", 
                "items": ["items to remove"]
            }"""

        elif operation == "rename":
            return """{
                "current_list_name": "current list name",
                "new_list_name": "new list name"
            }"""

        elif operation == "clear":
            return """{
                "list_name": "name of the list to clear",
                "confirm": true
            }"""

        elif operation == "read":
            # For read operations, we might have assignee prefilled
            if "assignee" in prefilled_data:
                return """{
                    "list_name": "name of the list to show",
                    "filters": {
                        "show_completed": true,
                        "limit": 50
                    }
                }"""
            else:
                return """{
                    "list_name": "name of the list to show",
                    "filters": {
                        "show_completed": true,
                        "limit": 50,
                        "site_name": "optional site filter"
                    }
                }"""

        elif operation == "delete":
            return """{
                "list_name": "name of the list to delete",
                "confirm": true
            }"""

        # Fall back to full schema if operation unknown
        return self.get_extraction_schema(operation)
