"""Smart Rails keyword-based CRUD system."""

from .router import KeywordRouter
from .processors import ListProcessor, FieldReportProcessor, TaskProcessor

__all__ = ["KeywordRouter", "ListProcessor", "FieldReportProcessor", "TaskProcessor"]
