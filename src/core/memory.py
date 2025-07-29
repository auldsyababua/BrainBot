"""
Memory layer for the bot using mem0 for persistent, intelligent memory management.
Enables the bot to remember user preferences, learn from corrections, and provide
personalized responses based on past interactions.
"""

import os
import logging
from datetime import datetime
from typing import List, Dict, Optional, Any
from mem0 import Memory
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

logger = logging.getLogger(__name__)


class BotMemory:
    """Manages bot memory using mem0 for intelligent, persistent storage."""

    def __init__(self):
        """Initialize mem0 memory with Vector and optional Graph backend."""
        try:
            config = {"version": "v1.1"}

            # Configure LLM (required for mem0's intelligent extraction)
            if os.getenv("OPENAI_API_KEY"):
                config["llm"] = {
                    "provider": "openai",
                    "config": {
                        "model": os.getenv("MEM0_LLM_MODEL", "gpt-4o-mini"),
                        "api_key": os.getenv("OPENAI_API_KEY"),
                    },
                }

            # Configure Vector Store
            if os.getenv("UPSTASH_VECTOR_REST_URL") and os.getenv(
                "UPSTASH_VECTOR_REST_TOKEN"
            ):
                # Use Upstash Vector for production
                config["vector_store"] = {
                    "provider": "upstash",
                    "config": {
                        "url": os.getenv("UPSTASH_VECTOR_REST_URL"),
                        "token": os.getenv("UPSTASH_VECTOR_REST_TOKEN"),
                    },
                }
                logger.info("Using Upstash Vector for mem0 backend")

            # Configure Graph Store (optional - for relationship mapping)
            if os.getenv("NEO4J_URL") and os.getenv("NEO4J_PASSWORD"):
                config["graph_store"] = {
                    "provider": "neo4j",
                    "config": {
                        "url": os.getenv("NEO4J_URL", "bolt://localhost:7687"),
                        "username": os.getenv("NEO4J_USERNAME", "neo4j"),
                        "password": os.getenv("NEO4J_PASSWORD"),
                    },
                }
                logger.info("Using Neo4j for graph memory backend")
                self.has_graph = True
            else:
                self.has_graph = False
                
            # Configure memory settings
            if os.getenv("MEM0_MEMORY_THRESHOLD"):
                config["memory_threshold"] = float(os.getenv("MEM0_MEMORY_THRESHOLD"))
                
            # Configure webhook if provided
            self.webhook_url = os.getenv("MEM0_WEBHOOK_URL")
            self.webhook_headers = {}
            if self.webhook_url:
                webhook_token = os.getenv("MEM0_WEBHOOK_TOKEN")
                if webhook_token:
                    self.webhook_headers = {"Authorization": f"Bearer {webhook_token}"}
                logger.info(f"Webhook configured: {self.webhook_url}")

            # Initialize mem0 with config
            if "vector_store" in config or "graph_store" in config:
                self.memory = Memory.from_config(config)
                logger.info("BotMemory initialized with custom configuration")
            else:
                # Fallback to local memory for development
                self.memory = Memory()
                logger.info(
                    "Using local memory for mem0 (no backend credentials found)"
                )

            logger.info("BotMemory initialized successfully")

        except Exception as e:
            logger.error(f"Failed to initialize BotMemory: {e}")
            # Fallback to basic memory if mem0 fails
            self.memory = None
            self.has_graph = False
            self.webhook_url = None

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
            
            # Send webhook notification if configured
            if self.webhook_url and result:
                await self._send_webhook_notification(
                    event="memory_added",
                    user_id=user_id,
                    data=result
                )
            
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

    async def get_graph_relationships(
        self, user_id: str, entity: Optional[str] = None
    ) -> List[Dict[str, Any]]:
        """Retrieve relationship data from graph memory.

        Args:
            user_id: Unique identifier for the user
            entity: Optional specific entity to get relationships for

        Returns:
            List of relationships from the graph
        """
        if not self.memory or not self.has_graph:
            return []

        try:
            # Access graph store if available
            if hasattr(self.memory, "graph") and self.memory.graph:
                if entity:
                    # Query specific entity relationships
                    query = f"What is related to {entity}?"
                else:
                    # Get all user relationships
                    query = "What are all the relationships for this user?"

                results = self.memory.graph.search(
                    query=query, filters={"user_id": user_id}
                )

                logger.info(
                    f"Retrieved {len(results)} graph relationships for user {user_id}"
                )
                return results
            else:
                logger.warning("Graph store not available despite has_graph=True")
                return []

        except Exception as e:
            logger.error(f"Error retrieving graph relationships: {e}")
            return []

    async def get_memory_stats(self, user_id: str) -> Dict[str, Any]:
        """Get statistics about stored memories.

        Args:
            user_id: Unique identifier for the user

        Returns:
            Dictionary with memory statistics
        """
        stats = {
            "total_memories": 0,
            "memory_types": {},
            "has_graph": self.has_graph,
            "graph_entities": 0,
            "graph_relationships": 0,
        }

        try:
            # Get all memories
            memories = await self.get_all_memories(user_id)
            stats["total_memories"] = len(memories)

            # Count by type
            for mem in memories:
                mem_type = mem.get("metadata", {}).get("type", "other")
                stats["memory_types"][mem_type] = (
                    stats["memory_types"].get(mem_type, 0) + 1
                )

            # Get graph stats if available
            if self.has_graph:
                relationships = await self.get_graph_relationships(user_id)
                stats["graph_relationships"] = len(relationships)

                # Count unique entities
                entities = set()
                for rel in relationships:
                    if isinstance(rel, dict):
                        entities.add(rel.get("source", ""))
                        entities.add(rel.get("target", ""))
                stats["graph_entities"] = len(entities) - 1  # Subtract empty string

        except Exception as e:
            logger.error(f"Error getting memory stats: {e}")

        return stats
    
    async def _send_webhook_notification(
        self, event: str, user_id: str, data: Any
    ):
        """Send webhook notification for memory events."""
        if not self.webhook_url:
            return
            
        try:
            import aiohttp
            async with aiohttp.ClientSession() as session:
                payload = {
                    "event": event,
                    "user_id": user_id,
                    "data": data,
                    "timestamp": datetime.now().isoformat()
                }
                
                async with session.post(
                    self.webhook_url,
                    json=payload,
                    headers=self.webhook_headers
                ) as response:
                    if response.status == 200:
                        logger.info(f"Webhook notification sent: {event}")
                    else:
                        logger.warning(f"Webhook failed with status {response.status}")
                        
        except Exception as e:
            logger.error(f"Error sending webhook: {e}")
    
    def get_user_config(self, user_id: str) -> Dict[str, Any]:
        """Get user-specific memory configuration from environment."""
        user_config = {}
        
        # Check for user-specific settings
        user_prefix = f"MEM0_USER_{user_id.upper()}_"
        
        # Memory retention policy
        retention = os.getenv(f"{user_prefix}RETENTION_DAYS")
        if retention:
            user_config["retention_days"] = int(retention)
            
        # Memory categories allowed
        categories = os.getenv(f"{user_prefix}CATEGORIES")
        if categories:
            user_config["allowed_categories"] = categories.split(",")
            
        # Auto-extract preferences
        auto_extract = os.getenv(f"{user_prefix}AUTO_EXTRACT", "true")
        user_config["auto_extract"] = auto_extract.lower() == "true"
        
        return user_config


# Global instance
bot_memory = BotMemory()


async def seed_initial_memories():
    """Seed initial memories from environment configuration."""
    import json
    
    # Check for initial memories in environment
    initial_memories = os.getenv("MEM0_INITIAL_MEMORIES")
    if initial_memories:
        try:
            memories = json.loads(initial_memories)
            for memory in memories:
                user_id = memory.get("user_id", "system")
                content = memory.get("content")
                category = memory.get("category", "system")
                
                if content:
                    await bot_memory.store_preference(
                        user_id=user_id,
                        preference=content,
                        category=category
                    )
                    logger.info(f"Seeded memory for {user_id}: {content[:50]}...")
        except Exception as e:
            logger.error(f"Error seeding initial memories: {e}")
    
    # Check for webhook configuration
    webhook_url = os.getenv("MEM0_WEBHOOK_URL")
    if webhook_url:
        logger.info(f"Webhook URL configured: {webhook_url}")
