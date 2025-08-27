"""Base processor class with shared functionality."""

import logging
from datetime import datetime, timedelta
from typing import Any, Dict, Optional, Tuple

logger = logging.getLogger(__name__)


class BaseProcessor:
    """Base class for all processors with shared functionality."""

    def __init__(self, supabase_client):
        self.supabase = supabase_client
        self._cache = {}
        self._cache_timestamps = {}
        self.cache_ttl = 300  # 5 minutes

    def _get_cached(self, key: str) -> Optional[Any]:
        """Get cached value if still valid."""
        if key in self._cache:
            timestamp = self._cache_timestamps.get(key)
            if timestamp and datetime.now() - timestamp < timedelta(seconds=self.cache_ttl):
                return self._cache[key]
        return None

    def _set_cache(self, key: str, value: Any):
        """Cache a value with timestamp."""
        self._cache[key] = value
        self._cache_timestamps[key] = datetime.now()

    async def _safe_db_operation(self, operation, default=None):
        """Execute database operation with error handling."""
        try:
            return await operation
        except TimeoutError as e:
            logger.error(f"Database operation timed out: {e}")
            return default
        except Exception as e:
            logger.error(f"Database operation failed: {e}")
            return default

    async def validate_operation(
        self, operation: str, data: dict[str, Any], user_role: str
    ) -> tuple[bool, str]:
        """Base validation method to be overridden by subclasses."""
        raise NotImplementedError("Subclasses must implement validate_operation")

    def get_extraction_schema(self, operation: str) -> str:
        """Base extraction schema method to be overridden by subclasses."""
        raise NotImplementedError("Subclasses must implement get_extraction_schema")

    def get_dynamic_extraction_schema(self, operation: str, prefilled_data: dict[str, Any]) -> str:
        """Generate dynamic extraction schema based on prefilled data.

        This method should be overridden by subclasses to provide operation-specific
        dynamic schemas that only ask for missing fields.

        Args:
            operation: The operation being performed
            prefilled_data: Data already extracted from preprocessing

        Returns:
            A schema string that only asks for missing fields
        """
        # Default implementation just returns the full schema
        return self.get_extraction_schema(operation)

    def get_confidence_boost_factors(self, message: str, operation: str) -> float:
        """Base confidence boost method to be overridden by subclasses."""
        return 0.0
