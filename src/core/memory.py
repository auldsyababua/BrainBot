"""
Memory layer for the bot using mem0 for persistent, intelligent memory management.
Enables the bot to remember user preferences, learn from corrections, and provide
personalized responses based on past interactions.
"""

import logging
from typing import List, Dict, Optional
from mem0 import Memory
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

logger = logging.getLogger(__name__)


class BotMemory:
    """Manages bot memory using mem0 for intelligent, persistent storage."""

    def __init__(self):
        """Initialize mem0 memory with Upstash Vector backend."""
        try:
            # For now, use local memory as POC
            # TODO: Configure with Upstash Vector when mem0 supports it
            # config = {
            #     "vector_store": {
            #         "provider": "qdrant",  # mem0 uses qdrant protocol
            #         "config": {
            #             "collection_name": "10netzero_memory",
            #             "embedding_model": "text-embedding-3-small",
            #             "api_key": os.getenv("OPENAI_API_KEY"),
            #         },
            #     },
            #     "version": "v1.1",
            # }
            self.memory = Memory()

            logger.info("BotMemory initialized successfully")

        except Exception as e:
            logger.error(f"Failed to initialize BotMemory: {e}")
            # Fallback to basic memory if mem0 fails
            self.memory = None

    async def remember_from_conversation(
        self, messages: List[Dict], user_id: str
    ) -> Optional[Dict]:
        """Extract and store important memories from a conversation.

        Args:
            messages: List of conversation messages
            user_id: Unique identifier for the user

        Returns:
            Result of memory storage operation
        """
        if not self.memory:
            return None

        try:
            # Mem0 intelligently extracts what's important to remember
            result = self.memory.add(
                messages=messages, user_id=user_id, metadata={"source": "conversation"}
            )

            logger.info(f"Stored memories for user {user_id}: {result}")
            return result

        except Exception as e:
            logger.error(f"Error storing memories: {e}")
            return None

    async def recall_context(
        self, query: str, user_id: str, limit: int = 5
    ) -> List[Dict]:
        """Retrieve relevant memories for the current context.

        Args:
            query: The current user query/message
            user_id: Unique identifier for the user
            limit: Maximum number of memories to retrieve

        Returns:
            List of relevant memories
        """
        if not self.memory:
            return []

        try:
            memories = self.memory.search(query=query, user_id=user_id, limit=limit)

            logger.info(f"Retrieved {len(memories)} memories for user {user_id}")
            return memories

        except Exception as e:
            logger.error(f"Error retrieving memories: {e}")
            return []

    async def store_preference(
        self, user_id: str, preference: str, category: str = "general"
    ):
        """Store an explicit user preference.

        Args:
            user_id: Unique identifier for the user
            preference: The preference to store
            category: Category of preference (location, equipment, etc.)
        """
        if not self.memory:
            return

        try:
            self.memory.add(
                messages=[{"role": "user", "content": preference}],
                user_id=user_id,
                metadata={"type": "preference", "category": category, "explicit": True},
            )

            logger.info(f"Stored preference for user {user_id}: {preference[:50]}...")

        except Exception as e:
            logger.error(f"Error storing preference: {e}")

    async def store_correction(
        self, user_id: str, original: str, corrected: str, context: str = ""
    ):
        """Store a correction to learn from user feedback.

        Args:
            user_id: Unique identifier for the user
            original: The original response/interpretation
            corrected: The corrected version
            context: Additional context about the correction
        """
        if not self.memory:
            return

        try:
            correction_content = f"User corrected: '{original}' should be '{corrected}'"
            if context:
                correction_content += f" Context: {context}"

            self.memory.add(
                messages=[{"role": "system", "content": correction_content}],
                user_id=user_id,
                metadata={
                    "type": "correction",
                    "original": original,
                    "corrected": corrected,
                },
            )

            logger.info(f"Stored correction for user {user_id}")

        except Exception as e:
            logger.error(f"Error storing correction: {e}")

    async def get_all_memories(
        self, user_id: str, memory_type: Optional[str] = None
    ) -> List[Dict]:
        """Retrieve all memories for a user, optionally filtered by type.

        Args:
            user_id: Unique identifier for the user
            memory_type: Optional filter for memory type (preference, correction, etc.)

        Returns:
            List of all user memories
        """
        if not self.memory:
            return []

        try:
            # Get all memories for the user
            all_memories = self.memory.get_all(user_id=user_id)

            # Filter by type if specified
            if memory_type and all_memories:
                filtered = [
                    mem
                    for mem in all_memories
                    if mem.get("metadata", {}).get("type") == memory_type
                ]
                return filtered

            return all_memories

        except Exception as e:
            logger.error(f"Error getting all memories: {e}")
            return []

    async def forget_memories(
        self, user_id: str, memory_ids: Optional[List[str]] = None
    ):
        """Delete specific memories or all memories for a user.

        Args:
            user_id: Unique identifier for the user
            memory_ids: Optional list of specific memory IDs to delete
        """
        if not self.memory:
            return

        try:
            if memory_ids:
                # Delete specific memories
                for memory_id in memory_ids:
                    self.memory.delete(memory_id=memory_id)
                logger.info(f"Deleted {len(memory_ids)} memories for user {user_id}")
            else:
                # Delete all memories for user
                all_memories = await self.get_all_memories(user_id)
                for mem in all_memories:
                    if mem.get("id"):
                        self.memory.delete(memory_id=mem["id"])
                logger.info(f"Deleted all memories for user {user_id}")

        except Exception as e:
            logger.error(f"Error deleting memories: {e}")

    async def extract_entities_from_text(
        self, text: str, user_id: str
    ) -> Dict[str, List[str]]:
        """Extract and store entities (locations, equipment, etc.) from text.

        Args:
            text: Text to extract entities from
            user_id: User ID for storing extracted preferences

        Returns:
            Dictionary of extracted entities by type
        """
        entities = {"locations": [], "equipment": [], "tasks": []}

        # Simple extraction for POC - could be enhanced with NER
        # Look for common patterns

        # Extract locations (simple pattern matching)
        location_keywords = ["Eagle Lake", "site", "facility", "location", "plant"]
        for keyword in location_keywords:
            if keyword.lower() in text.lower():
                # Extract surrounding context
                import re

                pattern = rf"\b\w+\s+{keyword}\s*\w*\b"
                matches = re.findall(pattern, text, re.IGNORECASE)
                entities["locations"].extend(matches)

        # Extract equipment mentions
        equipment_keywords = ["pump", "valve", "motor", "sensor", "system", "equipment"]
        for keyword in equipment_keywords:
            if keyword.lower() in text.lower():
                import re

                pattern = rf"\b\w*\s*{keyword}\s*\w*\b"
                matches = re.findall(pattern, text, re.IGNORECASE)
                entities["equipment"].extend(matches)

        # Store extracted entities as preferences
        for location in entities["locations"]:
            await self.store_preference(user_id, f"Works at {location}", "location")

        for equipment in entities["equipment"]:
            await self.store_preference(
                user_id, f"Has experience with {equipment}", "equipment"
            )

        return entities


# Global instance
bot_memory = BotMemory()
