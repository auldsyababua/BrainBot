# Mem0 Integration Design for Markdown Brain Bot

## Overview

Integrating mem0 to transform the bot from stateless to stateful, enabling personalized interactions and continuous learning.

## Architecture Design

### 1. Memory Layers

```python
# src/core/memory.py
from mem0 import Memory
import os
from typing import List, Dict, Optional

class BotMemory:
    def __init__(self):
        # Option 1: Self-hosted with existing Upstash Redis
        self.memory = Memory(
            vector_store={
                "provider": "qdrant",  # Or use Upstash Vector
                "config": {
                    "collection_name": "10netzero_memory",
                    "url": os.getenv("UPSTASH_VECTOR_REST_URL"),
                    "token": os.getenv("UPSTASH_VECTOR_REST_TOKEN")
                }
            }
        )
        
        # Option 2: Mem0 Platform (managed)
        # self.memory = MemoryClient(api_key=os.getenv("MEM0_API_KEY"))
    
    async def remember_from_conversation(self, messages: List[Dict], user_id: str):
        """Extract and store important memories from conversation"""
        # Mem0 intelligently extracts what to remember
        result = await self.memory.add(messages, user_id=user_id)
        return result
    
    async def recall_context(self, query: str, user_id: str) -> List[Dict]:
        """Retrieve relevant memories for current context"""
        memories = await self.memory.search(
            query=query,
            user_id=user_id,
            limit=5
        )
        return memories
    
    async def store_preference(self, user_id: str, preference: str):
        """Store explicit user preference"""
        await self.memory.add(
            [{"role": "user", "content": preference}],
            user_id=user_id,
            metadata={"type": "preference"}
        )
    
    async def store_correction(self, user_id: str, original: str, corrected: str):
        """Store corrections for learning"""
        correction_data = {
            "original": original,
            "corrected": corrected,
            "type": "correction"
        }
        await self.memory.add(
            [{"role": "system", "content": f"User corrected: '{original}' to '{corrected}'"}],
            user_id=user_id,
            metadata=correction_data
        )
```

### 2. Integration Points

#### A. Message Processing Enhancement

```python
# Modify src/core/llm.py
async def process_message(user_message: str, chat_id: str = "default") -> str:
    # ... existing code ...
    
    # NEW: Recall user memories
    bot_memory = BotMemory()
    user_memories = await bot_memory.recall_context(user_message, chat_id)
    
    # Add memories to context
    memory_context = ""
    if user_memories:
        memory_context = "\n\n[User Context from Memory]\n"
        for memory in user_memories:
            memory_context += f"- {memory.get('memory', '')}\n"
    
    # Enhanced message with memories
    enhanced_message = f"{user_message}{memory_context}"
    
    # ... rest of processing ...
    
    # NEW: After response, extract memories
    await bot_memory.remember_from_conversation(
        messages[-4:],  # Last few messages
        user_id=chat_id
    )
```

#### B. Command Handlers

```python
# New commands in src/bot/handlers.py

async def remember_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Handle /remember command to explicitly store facts"""
    chat_id = str(update.effective_chat.id)
    text = update.message.text.replace('/remember', '').strip()
    
    if text:
        bot_memory = BotMemory()
        await bot_memory.store_preference(chat_id, text)
        await update.message.reply_text("✅ I'll remember that!")
    else:
        await update.message.reply_text("Please tell me what to remember: /remember [fact]")

async def correct_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Handle /correct command for teaching corrections"""
    # Format: /correct original -> corrected
    chat_id = str(update.effective_chat.id)
    text = update.message.text.replace('/correct', '').strip()
    
    if '->' in text:
        original, corrected = text.split('->', 1)
        bot_memory = BotMemory()
        await bot_memory.store_correction(
            chat_id, 
            original.strip(), 
            corrected.strip()
        )
        await update.message.reply_text("📝 Thanks for the correction! I'll learn from this.")

async def memories_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Show user what bot remembers about them"""
    chat_id = str(update.effective_chat.id)
    bot_memory = BotMemory()
    
    # Get all user memories
    memories = await bot_memory.memory.get_all(user_id=chat_id)
    
    if memories:
        response = "🧠 Here's what I remember about you:\n\n"
        for mem in memories[:10]:  # Limit to 10
            response += f"• {mem.get('memory', '')}\n"
    else:
        response = "I don't have any memories about you yet. Let's chat more!"
    
    await update.message.reply_text(response)
```

### 3. Smart Preprocessing Pipeline

```python
# src/core/preprocessing.py
class SmartProcessor:
    def __init__(self):
        self.memory = BotMemory()
    
    async def process_document(self, content: str, user_id: str):
        """Enhanced document processing with memory extraction"""
        # Extract entities and context
        entities = await self.extract_entities(content)
        
        # Store document-specific memories
        if entities.get('locations'):
            for location in entities['locations']:
                await self.memory.store_preference(
                    user_id,
                    f"Works with equipment at {location}"
                )
        
        if entities.get('equipment'):
            for equipment in entities['equipment']:
                await self.memory.store_preference(
                    user_id,
                    f"Has experience with {equipment}"
                )
        
        # Extract action items
        if entities.get('tasks'):
            for task in entities['tasks']:
                await self.memory.add(
                    [{"role": "system", "content": f"Task: {task}"}],
                    user_id=user_id,
                    metadata={"type": "task", "status": "pending"}
                )
    
    async def extract_entities(self, content: str) -> Dict:
        """Extract entities using LLM"""
        # Use GPT to extract structured data
        prompt = f"""
        Extract the following from this field service report:
        1. Locations mentioned
        2. Equipment/systems mentioned
        3. Action items or tasks
        4. Dates/temporal markers
        
        Content: {content[:1000]}
        
        Return as JSON.
        """
        # ... LLM call to extract ...
```

### 4. Learning from Patterns

```python
# src/core/learning.py
class PatternLearner:
    def __init__(self):
        self.memory = BotMemory()
    
    async def track_query_success(self, user_id: str, query: str, response: str, helpful: bool):
        """Track which responses are helpful"""
        await self.memory.add(
            [{
                "role": "system",
                "content": f"Query: {query}\nResponse helpful: {helpful}"
            }],
            user_id=user_id,
            metadata={"type": "feedback", "helpful": helpful}
        )
    
    async def get_user_patterns(self, user_id: str) -> Dict:
        """Analyze user interaction patterns"""
        # Get all feedback memories
        feedbacks = await self.memory.search(
            query="feedback",
            user_id=user_id,
            filters={"type": "feedback"}
        )
        
        # Analyze patterns
        patterns = {
            "preferred_response_style": "concise",  # Default
            "common_queries": [],
            "correction_patterns": []
        }
        
        # ... analyze feedbacks to determine patterns ...
        return patterns
```

## Implementation Phases

### Phase 1: Basic Memory Integration (Week 1)
1. Set up mem0 (self-hosted or platform)
2. Implement BotMemory class
3. Add memory recall to message processing
4. Add /remember and /memories commands

### Phase 2: Smart Extraction (Week 2)
1. Implement entity extraction for documents
2. Auto-store location/equipment preferences
3. Track temporal patterns
4. Enhanced search with memory context

### Phase 3: Learning & Corrections (Week 3)
1. Implement /correct command
2. Build correction tracking
3. Add pattern analysis
4. Dynamic prompt adjustment

### Phase 4: Advanced Features (Week 4)
1. A/B testing framework
2. Feedback collection
3. Memory decay/cleanup
4. Performance optimization

## Configuration Options

### Option 1: Self-Hosted (Recommended for Start)
```python
# .env additions
MEM0_VECTOR_PROVIDER=upstash  # or qdrant
MEM0_COLLECTION=10netzero_memory
```

### Option 2: Mem0 Platform
```python
# .env additions
MEM0_API_KEY=your-api-key
USE_MEM0_PLATFORM=true
```

## Benefits

1. **Personalized Responses**: Bot remembers user preferences and history
2. **Learning from Corrections**: Improves accuracy over time
3. **Context Awareness**: Better understanding of user's work patterns
4. **Reduced Repetition**: User doesn't need to re-explain context
5. **Intelligent Search**: Memory-enhanced document retrieval

## Monitoring & Metrics

```python
# Track memory performance
class MemoryMetrics:
    - Memory retrieval latency
    - Memory hit rate
    - Correction frequency
    - User satisfaction scores
    - Memory storage size
```

## Security Considerations

1. **User Isolation**: Each user's memories are completely separate
2. **Data Retention**: Configure TTL for memory expiration
3. **Privacy Controls**: Add /forget command to delete memories
4. **Encryption**: Ensure memory storage is encrypted

## Next Steps

1. Choose hosting option (self-hosted vs platform)
2. Create proof-of-concept with basic memory
3. Test with sample conversations
4. Iterate based on results