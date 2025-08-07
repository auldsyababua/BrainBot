# Smart Rails Developer Guide

## Overview

This guide provides detailed instructions for developers extending and maintaining the Smart Rails system. Smart Rails combines deterministic preprocessing with dynamic prompt generation to optimize message routing and execution.

## System Architecture

### Core Components

```
src/rails/
├── router.py              # Main routing engine with preprocessing
├── dynamic_prompts.py     # Dynamic prompt generation
├── confidence_scoring.py  # Multi-factor confidence analysis
└── __init__.py
```

### Key Classes

#### KeywordRouter (router.py)
- Main routing engine
- Preprocessing pipeline
- Cache management
- Pattern compilation

#### DynamicPromptGenerator (dynamic_prompts.py)
- Context-aware prompt generation
- Execution strategy selection
- Prompt caching

#### EnhancedConfidenceScorer (confidence_scoring.py)
- Multi-factor confidence calculation
- Pattern analysis
- Confidence explanation

## Adding New Entity Types

### Step 1: Define Entity Configuration

Add to `router.py`:

```python
self.operations["new_entity"] = {
    "create": {
        "keywords": ["new widget", "create widget", "make widget"],
        "function": "create_widget",
        "example": "new widget called dashboard"
    },
    "read": {
        "keywords": ["show widget", "display widget"],
        "function": "read_widget",
        "example": "show widget dashboard"
    },
    # Add more operations...
}
```

### Step 2: Add Entity Context

Update `dynamic_prompts.py`:

```python
self.entity_prompts["new_entity"] = {
    "focus": "widget management operations",
    "examples": ["dashboards", "controls", "displays"],
    "key_fields": ["widget_name", "widget_type", "configuration"]
}
```

### Step 3: Add Confidence Patterns

Update `confidence_scoring.py`:

```python
# Add context pattern
self._widget_context_pattern = re.compile(
    r'\b(widget|dashboard|control|display)\b',
    re.IGNORECASE
)

# Update entity clarity calculation
if entity_type == "widgets" and self._widget_context_pattern.search(message):
    context_score += 0.3
```

### Step 4: Compile and Test

```python
# Recompile patterns after adding entity
router._compile_patterns()

# Test the new entity
result = router.route("create new widget for dashboard")
assert result.entity_type == "widgets"
```

## Adding New Commands

### High-Confidence Commands (100%)

Add to `hidden_commands` in `router.py`:

```python
self.hidden_commands["/newwidget"] = ("widgets", "create")
self.hidden_commands["/showwidget"] = ("widgets", "read")
self.hidden_commands["/deletewidget"] = ("widgets", "delete")
```

### Entity-Type Commands

Add to preprocessing in `router.py`:

```python
elif command in ["widget", "widgets", "w"]:
    prefilled["entity_type"] = "widgets"
    confidences["entity_confidence"] = 1.0
    prefilled["command_source"] = f"/{command}"
```

### Operation Commands

Add to preprocessing for combined entity+operation:

```python
elif command == "newwidget":
    prefilled["entity_type"] = "widgets"
    prefilled["operation"] = "create"
    confidences["entity_confidence"] = 1.0
    confidences["operation_confidence"] = 1.0
    prefilled["direct_execution"] = True
```

## Extending Confidence Scoring

### Adding New Confidence Factors

1. **Define the Factor**

```python
# In ConfidenceFactors class
@dataclass
class ConfidenceFactors:
    # ... existing factors ...
    domain_specificity: float = 0.0  # New factor
```

2. **Calculate the Factor**

```python
def calculate_confidence(self, ...):
    # Calculate domain specificity
    if self._is_domain_specific(message, entity_type):
        factors.domain_specificity = 0.9
    else:
        factors.domain_specificity = 0.3
```

3. **Update Weights**

```python
default_weights = {
    # ... existing weights ...
    "domain_specificity": 0.05  # Add weight
}
```

### Adjusting Confidence Thresholds

```python
# In router.py, adjust execution thresholds
def route(self, message: str) -> RouteResult:
    # Custom threshold for your use case
    HIGH_CONFIDENCE_THRESHOLD = 0.85  # Default is 0.8
    
    use_direct = confidence >= HIGH_CONFIDENCE_THRESHOLD
```

## Testing Guidelines

### Unit Testing Router Components

```python
import pytest
from src.rails.router import KeywordRouter

class TestRouterExtensions:
    def test_new_entity_routing(self):
        router = KeywordRouter()
        
        # Test entity detection
        result = router.route("/widgets show dashboard")
        assert result.entity_type == "widgets"
        assert result.operation == "read"
        assert result.confidence == 1.0
    
    def test_preprocessing_extraction(self):
        router = KeywordRouter()
        
        cleaned, prefilled, confidences = router.preprocess_message(
            "/newwidget Dashboard Alpha for @admin"
        )
        
        assert prefilled["entity_type"] == "widgets"
        assert prefilled["operation"] == "create"
        assert "@admin" not in cleaned
```

### Integration Testing

```python
class TestSmartRailsIntegration:
    @pytest.mark.asyncio
    async def test_end_to_end_flow(self):
        # Initialize with database
        router = KeywordRouter(supabase_client=client)
        await router.ensure_aliases_loaded()
        
        # Test complete flow
        message = "/newwidget for @joel: Dashboard Alpha"
        result = router.route(message)
        
        # Verify routing
        assert result.use_direct_execution
        assert result.target_users == ["joel"]
        
        # Test execution
        response = await execute_route(result)
        assert response.success
```

### Performance Testing

```python
import time

def test_routing_performance():
    router = KeywordRouter()
    messages = [
        "/newtask Check generator",
        "add milk to shopping list",
        "@joel needs to complete the report"
    ] * 100
    
    start = time.time()
    for message in messages:
        router.route(message)
    elapsed = time.time() - start
    
    assert elapsed < 1.0  # Should process 300 messages in < 1 second
    
    # Check cache effectiveness
    assert len(router._recent_routes) > 0
    assert router._cache_hits > 100  # Should have cache hits
```

## Performance Optimization

### Cache Tuning

```python
# Adjust cache parameters in router.py
self._max_cache_size = 100  # Increase for more caching
self._cache_ttl = 3600  # Increase TTL to 1 hour

# Monitor cache performance
def get_cache_stats(self):
    return {
        "size": len(self._recent_routes),
        "hit_rate": self._cache_hits / (self._cache_hits + self._cache_misses),
        "avg_age": sum(time.time() - t for t in self._cache_timestamps.values()) / len(self._cache_timestamps)
    }
```

### Pattern Optimization

```python
# Pre-compile complex patterns
class OptimizedRouter(KeywordRouter):
    def _compile_patterns(self):
        super()._compile_patterns()
        
        # Add optimized patterns
        self._optimized_patterns = {
            "quick_task": re.compile(r"^/t\s+(.+)$"),  # Fast task parsing
            "quick_list": re.compile(r"^/l\s+(.+)$"),   # Fast list parsing
        }
    
    def quick_parse(self, message):
        # Fast path for common patterns
        for name, pattern in self._optimized_patterns.items():
            if match := pattern.match(message):
                return self._handle_quick_match(name, match)
        return None
```

### Memory Management

```python
# Implement memory-efficient caching
from functools import lru_cache
from weakref import WeakValueDictionary

class MemoryEfficientRouter(KeywordRouter):
    def __init__(self):
        super().__init__()
        # Use weak references for large objects
        self._weak_cache = WeakValueDictionary()
        
        # Limit string interning
        self._interned_strings = set()
        self._max_interned = 1000
    
    def _intern_string(self, s: str) -> str:
        if len(self._interned_strings) < self._max_interned:
            self._interned_strings.add(s)
            return sys.intern(s)
        return s
```

## Debugging and Monitoring

### Enable Debug Logging

```python
import logging

# Configure logging
logging.basicConfig(
    level=logging.DEBUG,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)

# Enable specific component logging
logging.getLogger('src.rails.router').setLevel(logging.DEBUG)
logging.getLogger('src.rails.confidence_scoring').setLevel(logging.INFO)
```

### Performance Profiling

```python
import cProfile
import pstats

def profile_routing():
    profiler = cProfile.Profile()
    
    router = KeywordRouter()
    messages = generate_test_messages(1000)
    
    profiler.enable()
    for message in messages:
        router.route(message)
    profiler.disable()
    
    stats = pstats.Stats(profiler)
    stats.sort_stats('cumulative')
    stats.print_stats(20)  # Top 20 time consumers
```

### Monitoring Metrics

```python
class MonitoredRouter(KeywordRouter):
    def __init__(self):
        super().__init__()
        self.metrics = {
            "total_routes": 0,
            "direct_executions": 0,
            "cache_hits": 0,
            "avg_confidence": 0,
            "error_count": 0
        }
    
    def route(self, message: str) -> RouteResult:
        self.metrics["total_routes"] += 1
        
        try:
            result = super().route(message)
            
            if result.use_direct_execution:
                self.metrics["direct_executions"] += 1
            
            # Update running average
            n = self.metrics["total_routes"]
            avg = self.metrics["avg_confidence"]
            self.metrics["avg_confidence"] = (avg * (n-1) + result.confidence) / n
            
            return result
        except Exception as e:
            self.metrics["error_count"] += 1
            raise
    
    def get_metrics(self):
        return {
            **self.metrics,
            "direct_execution_rate": self.metrics["direct_executions"] / max(1, self.metrics["total_routes"]),
            "cache_hit_rate": self.metrics["cache_hits"] / max(1, self.metrics["total_routes"])
        }
```

## Common Patterns and Solutions

### Pattern: Multi-Entity Messages

```python
# Handle messages that might reference multiple entities
def handle_multi_entity(self, message: str):
    # Check for multiple entity references
    entities_found = []
    
    for entity_type in self.operations.keys():
        if self._has_entity_context(message, entity_type):
            entities_found.append(entity_type)
    
    if len(entities_found) > 1:
        # Reduce confidence due to ambiguity
        return self._handle_ambiguous_entities(entities_found, message)
    
    return entities_found[0] if entities_found else None
```

### Pattern: Contextual Commands

```python
# Support commands that depend on conversation context
class ContextualRouter(KeywordRouter):
    def __init__(self):
        super().__init__()
        self.context_stack = []
    
    def route_with_context(self, message: str, context: dict = None):
        if context:
            self.context_stack.append(context)
        
        # Check if message references context
        if self._is_contextual_reference(message):
            message = self._expand_with_context(message)
        
        result = self.route(message)
        
        # Store result in context for next message
        self.context_stack.append({
            "last_entity": result.entity_type,
            "last_operation": result.operation
        })
        
        return result
```

### Pattern: Batch Operations

```python
# Handle multiple operations in one message
def handle_batch_operations(self, message: str):
    # Split by conjunctions
    parts = re.split(r'\s+and\s+|\s+then\s+', message, flags=re.IGNORECASE)
    
    results = []
    for part in parts:
        result = self.route(part.strip())
        if result.confidence > 0.5:
            results.append(result)
    
    return results
```

## Migration Strategies

### Gradual Feature Adoption

```python
class MigrationRouter(KeywordRouter):
    def __init__(self, feature_flags=None):
        super().__init__()
        self.features = feature_flags or {}
    
    def route(self, message: str):
        # Check feature flags
        if not self.features.get("preprocessing", False):
            # Skip preprocessing for gradual rollout
            return self._legacy_route(message)
        
        if not self.features.get("direct_execution", False):
            # Always use LLM even for high confidence
            result = super().route(message)
            result.use_direct_execution = False
            return result
        
        # Full Smart Rails routing
        return super().route(message)
```

### A/B Testing

```python
import random

class ABTestRouter:
    def __init__(self):
        self.smart_router = KeywordRouter()
        self.legacy_router = LegacyRouter()
        self.metrics = {"smart": [], "legacy": []}
    
    def route(self, message: str, user_id: str):
        # Consistent routing per user
        use_smart = hash(user_id) % 2 == 0
        
        if use_smart:
            start = time.time()
            result = self.smart_router.route(message)
            elapsed = time.time() - start
            self.metrics["smart"].append(elapsed)
        else:
            start = time.time()
            result = self.legacy_router.route(message)
            elapsed = time.time() - start
            self.metrics["legacy"].append(elapsed)
        
        return result
```

## Best Practices

### 1. Always Load Aliases Before Routing

```python
async def initialize_router():
    router = KeywordRouter(supabase_client=client)
    await router.ensure_aliases_loaded()  # Critical for @mention resolution
    return router
```

### 2. Handle Edge Cases Gracefully

```python
def safe_route(router, message):
    try:
        if not message or not isinstance(message, str):
            return RouteResult(None, None, None, 0.0)
        
        if len(message) > 1000:  # Prevent DoS
            message = message[:1000]
        
        return router.route(message)
    except Exception as e:
        logger.error(f"Routing failed: {e}")
        return RouteResult(None, None, None, 0.0)
```

### 3. Monitor Performance in Production

```python
# Add timing decorators
from functools import wraps
import time

def timed_operation(name):
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            start = time.time()
            result = func(*args, **kwargs)
            elapsed = time.time() - start
            
            if elapsed > 0.1:  # Log slow operations
                logger.warning(f"{name} took {elapsed:.3f}s")
            
            return result
        return wrapper
    return decorator

# Use on critical paths
@timed_operation("route")
def route(self, message):
    # ... routing logic ...
```

### 4. Test with Real Data

```python
# Load production samples for testing
def load_production_samples():
    with open("test_data/production_messages.json") as f:
        return json.load(f)

def test_production_patterns():
    router = KeywordRouter()
    samples = load_production_samples()
    
    failures = []
    for sample in samples:
        result = router.route(sample["message"])
        if result.entity_type != sample["expected_entity"]:
            failures.append(sample)
    
    assert len(failures) == 0, f"Failed on {len(failures)} samples"
```

## Troubleshooting Guide

### Issue: Low Confidence on Clear Commands

**Symptoms**: Commands like "/newtask" getting <100% confidence

**Solutions**:
1. Check pattern compilation
2. Verify command is in hidden_commands
3. Check for typos in command definition
4. Enable debug logging to see extraction

### Issue: Cache Memory Growth

**Symptoms**: Memory usage increases over time

**Solutions**:
1. Reduce cache_size_limit
2. Decrease cache_ttl
3. Implement cache eviction
4. Use weak references for large objects

### Issue: Slow Pattern Matching

**Symptoms**: Route() taking >100ms

**Solutions**:
1. Pre-compile all patterns
2. Order patterns by frequency
3. Use quick-match patterns for common cases
4. Profile to find bottlenecks

## Conclusion

Smart Rails provides a flexible, extensible framework for intelligent message routing. By following these guidelines, developers can:

- Add new entity types and commands
- Optimize performance for specific use cases
- Debug and monitor the system effectively
- Migrate gradually from legacy systems

Remember to test thoroughly, monitor performance, and iterate based on real-world usage patterns.