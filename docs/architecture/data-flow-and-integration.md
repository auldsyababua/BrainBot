# Data Flow and Integration Architecture

## 1. Message Processing Flow

```mermaid
sequenceDiagram
    participant User
    participant TG as Telegram
    participant Bot as Bot Handler
    participant Router as Smart Rails
    participant Proc as Processor
    participant LLM as LLM Service
    participant DB as Storage

    User->>TG: Send message
    TG->>Bot: Webhook/polling
    Bot->>Router: Route message
    Router->>Router: Extract patterns
    
    alt High Confidence (100%)
        Router->>Proc: Direct execution
        Proc->>DB: Store result
        Proc->>TG: Confirmation
    else Medium Confidence (80-99%)
        Router->>LLM: Focused prompt
        LLM->>Proc: Structured response
        Proc->>DB: Store result
        Proc->>TG: Confirmation
    else Low Confidence (<80%)
        Router->>LLM: Full analysis
        LLM->>Proc: Detailed response
        Proc->>DB: Store result
        Proc->>TG: Response
    end
```

## 2. Search and Retrieval Flow

```mermaid
sequenceDiagram
    participant User
    participant Bot
    participant Cache as Cloudflare KV
    participant Vector as Cloudflare Vectorize
    participant DB as Document DB

    User->>Bot: Search query
    Bot->>Cache: Check cache
    
    alt Cache Hit
        Cache->>Bot: Cached results
    else Cache Miss
        Bot->>Vector: Semantic search
        Vector->>DB: Fetch documents
        DB->>Vector: Document data
        Vector->>Bot: Search results
        Bot->>Cache: Store results
    end
    
    Bot->>User: Formatted response
```

## 3. Integration Points

### External APIs
- **Telegram Bot API**: Primary interface for user interaction
- **OpenAI API**: Natural language processing and generation
- **Supabase API**: Database operations and real-time subscriptions
- **Cloudflare APIs**: KV and Vectorize operations (migrating from Upstash - see [Stories 2.13](../stories/2.13.story.md) and [2.14](../stories/2.14.story.md))
- **Neo4j API**: Graph memory operations (when enabled)
- **Cloudflare Workers**: Queue processing and webhook handling

### Webhook Endpoints
- **Telegram Webhook**: `/webhook/telegram` - Receive message updates
- **Process Endpoint**: `/process` - Handle queued messages from Cloudflare
- **Memory Webhooks**: `/webhook/mem0` - Graph memory notifications
- **Health Check**: `/health` - Service availability monitoring
- **Detailed Health**: `/health/detailed` - Component-level health status

### Mini App Integration
- **WebSocket Connection**: Real-time updates between bot and app
- **REST API**: Standard CRUD operations for entities
- **Authentication**: Telegram Web App authentication
- **Session Management**: Cloudflare KV session storage (migrating from Redis - see [Story 2.13](../stories/2.13.story.md))

## 4. Core Components Integration

### Bot Handler
- Receives messages from Telegram
- Manages user sessions
- Handles command processing
- Sends responses back to users

### Smart Rails Router
- Pattern recognition and extraction
- Confidence scoring
- Dynamic prompt generation
- Intent classification

### Processors
- Task processor for task management
- List processor for inventory management
- Report processor for field reports
- Direct database operations

### Storage Layer
- Supabase for structured data
- Cloudflare KV for caching (migrating from Upstash Redis - see [Story 2.13](../stories/2.13.story.md))
- Cloudflare Vectorize for semantic search (migrating from Upstash Vector - see [Story 2.14](../stories/2.14.story.md))
- Neo4j for graph relationships (optional)