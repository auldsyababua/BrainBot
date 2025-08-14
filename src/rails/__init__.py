"""Smart Rails keyword-based CRUD system."""

from .processors import FieldReportProcessor, ListProcessor, TaskProcessor
from .router import KeywordRouter

__all__ = ["KeywordRouter", "ListProcessor", "FieldReportProcessor", "TaskProcessor"]
