# @performance - Performance Optimization Rules
**Trigger:** Manual (use @performance to activate)  
**Description:** Performance optimization guidelines and checklist

## Performance Optimization Checklist

### Before Optimizing
- [ ] Profile the code to identify actual bottlenecks
- [ ] Measure baseline performance metrics
- [ ] Identify performance requirements/SLAs
- [ ] Consider user impact vs development effort

### Smart Rails Specific
- [ ] Check confidence scoring efficiency
- [ ] Review token usage and savings
- [ ] Optimize prompt caching strategy
- [ ] Batch similar operations
- [ ] Use deterministic preprocessing where possible

### Database Performance
- [ ] Analyze slow queries with EXPLAIN
- [ ] Add appropriate indexes
- [ ] Use connection pooling (pool size: 10)
- [ ] Implement query result caching
- [ ] Batch database operations
- [ ] Consider denormalization for read-heavy operations

### Vector Store Optimization
- [ ] Cache search results (TTL: 300s)
- [ ] Batch embedding operations (>10 documents)
- [ ] Use appropriate VECTOR_TOP_K values
- [ ] Implement similarity threshold cutoffs
- [ ] Consider namespace partitioning

### API Performance
- [ ] Implement request/response caching
- [ ] Use async/await for concurrent operations
- [ ] Set appropriate timeouts
- [ ] Implement circuit breakers
- [ ] Use pagination for large datasets
- [ ] Compress payloads when appropriate

### Frontend Performance
- [ ] Implement lazy loading
- [ ] Use React.memo for expensive components
- [ ] Optimize re-renders with useMemo/useCallback
- [ ] Implement virtual scrolling for long lists
- [ ] Minimize bundle size
- [ ] Use code splitting

### Monitoring & Metrics
- [ ] Add performance logging with ⏱️ prefix
- [ ] Track p50, p95, p99 response times
- [ ] Monitor memory usage
- [ ] Set up alerts for performance degradation
- [ ] Create performance dashboards

### Target Metrics
- Command processing: <50ms
- Focused queries: <200ms (p50)
- Full analysis: <500ms (p95)
- Token reduction: 70% minimum
- Cache hit rate: >80%