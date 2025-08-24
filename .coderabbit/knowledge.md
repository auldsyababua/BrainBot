# FLRTS Project Knowledge Base for CodeRabbit

## Project Overview
FLRTS (Field Logistics & Remote Telemetry System) is a comprehensive Telegram bot platform designed for field operations management in the energy sector, specifically for 10NetZero's microgrid operations.

## Architecture Principles

### 1. Smart Rails System
- Dynamic routing based on message content confidence scoring
- Specialized processors for different content types (tasks, lists, field reports)
- Fallback to general LLM processing for unmatched content
- Confidence threshold: 0.7 for specialized routing

### 2. Multi-Site Operations
Currently supporting three sites:
- Eagle Lake: Primary operations site
- Crockett: Secondary site with field reports
- Mathis: Support site with limited operations

### 3. Storage Strategy
- **Supabase**: Primary database for structured data (tasks, lists, documents)
- **Redis**: Session management and caching
- **Upstash Vector**: Semantic search and document embeddings
- **S3**: Media and large file storage
- **Mem0**: Conversation memory and context management

## Code Standards

### Python Backend
1. **Always use type hints** for function parameters and returns
2. **Exception handling**: Use `except Exception:` never bare `except:`
3. **Async patterns**: Always await coroutines in telegram bot handlers
4. **Environment variables**: Never hardcode secrets, use python-dotenv
5. **Database queries**: Always consider RLS policies when using Supabase

### React/TypeScript Frontend
1. **No `any` types**: Use proper TypeScript types or `unknown`
2. **Component structure**: Functional components with hooks only
3. **State management**: Use Context API for global state
4. **Error boundaries**: Wrap major sections in error boundaries
5. **Telegram WebApp**: Always check `window.Telegram.WebApp` availability

### CloudFlare Workers
1. **Size limit**: Keep bundle under 1MB
2. **Environment variables**: Use wrangler secrets for sensitive data
3. **KV namespaces**: Use for persistent storage
4. **Response caching**: Implement proper cache headers

## Common Patterns

### Task Processing Flow
```python
1. Message received → confidence scoring
2. If confidence > 0.7 → specialized processor
3. Process with specific schema validation
4. Store in Supabase with proper indexing
5. Update vector store for semantic search
6. Send confirmation to user
```

### Error Handling Pattern
```python
try:
    result = await process_message(message)
    await send_success_response(result)
except ValidationError as e:
    logger.warning(f"Validation failed: {e}")
    await send_user_error(e.message)
except Exception as e:
    logger.error(f"Unexpected error: {e}")
    await send_generic_error()
```

### React Component Pattern
```typescript
interface ComponentProps {
  data: DataType
  onAction: (id: string) => Promise<void>
  loading?: boolean
}

export const Component: React.FC<ComponentProps> = ({ 
  data, 
  onAction, 
  loading = false 
}) => {
  const [error, setError] = useState<Error | null>(null)
  
  const handleAction = useCallback(async (id: string) => {
    try {
      await onAction(id)
    } catch (err) {
      setError(err as Error)
    }
  }, [onAction])
  
  if (error) return <ErrorDisplay error={error} />
  if (loading) return <LoadingSpinner />
  
  return <>{/* component JSX */}</>
}
```

## Security Considerations

1. **API Keys**: All stored in environment variables
2. **RLS Policies**: Enabled on all Supabase tables
3. **Input Validation**: All user inputs sanitized before processing
4. **CORS**: Properly configured for Telegram Mini App
5. **Rate Limiting**: Implemented at CloudFlare Worker level

## Testing Strategy

1. **Unit Tests**: Core business logic with pytest
2. **Integration Tests**: API endpoints and database operations
3. **Performance Tests**: Load testing with Locust
4. **Anti-Mesa Tests**: Edge cases and error conditions
5. **Frontend Tests**: Component testing with Vitest and MSW

## Deployment Pipeline

1. **Local Development**: Docker compose for services
2. **Testing**: GitHub Actions CI/CD
3. **Staging**: Render.com preview environments
4. **Production**: Render.com with CloudFlare Workers

## Known Issues and Workarounds

1. **Telegram Webhook Timeouts**: Implement async processing with job queues
2. **Vector Store Limits**: Batch operations to avoid rate limits
3. **Supabase RLS**: Some operations require service role key
4. **CloudFlare Size**: Use dynamic imports for large dependencies

## Performance Benchmarks

- Message processing: < 500ms for simple tasks
- Vector search: < 200ms for 10k documents
- Database queries: < 100ms with proper indexing
- Frontend load: < 2s on 3G networks

## Monitoring and Alerts

1. **Supabase Logger**: All operations logged to logs table
2. **Error Tracking**: Critical errors sent to Telegram admin
3. **Performance Metrics**: Response times tracked in Redis
4. **Health Checks**: Endpoints at /health for all services

## AI/LLM Integration

- **Primary Model**: GPT-4 for complex understanding
- **Fallback Model**: GPT-3.5-turbo for simple queries
- **Embeddings**: text-embedding-ada-002 for vector search
- **Prompt Engineering**: Dynamic prompts based on content type
- **Context Window**: Manage with Mem0 for long conversations

## Best Practices

1. **Always run linters** before committing (ruff for Python, biome for TS)
2. **Write tests** for new features and bug fixes
3. **Document API changes** in the appropriate docs/ file
4. **Use semantic commits** for clear history
5. **Review security** implications of all changes
6. **Consider performance** impact of new features
7. **Maintain backwards compatibility** for API changes

## Contact and Resources

- **Project Lead**: Colin Aulds (colin@10netzero.com)
- **Documentation**: /docs directory
- **API Specs**: /docs/smart-rails-api.md
- **Architecture**: /docs/smart-rails-architecture.md
- **Deployment Guide**: /docs/DEPLOYMENT_GUIDE.md