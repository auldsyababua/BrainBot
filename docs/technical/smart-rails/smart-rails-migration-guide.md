# Smart Rails Migration Guide for Nx Monorepo

## Overview

This guide provides instructions for migrating the Smart Rails enhancement to an Nx monorepo structure, ensuring proper separation of concerns and maintainability.

## Current Structure

```
flrts/
├── src/
│   ├── rails/
│   │   ├── router.py           # 988 lines - Main routing engine
│   │   ├── dynamic_prompts.py  # 506 lines - Prompt generation
│   │   └── confidence_scoring.py # 352 lines - Confidence analysis
│   └── core/
│       └── llm.py              # Integration point
```

## Proposed Nx Monorepo Structure

```
nx-workspace/
├── libs/
│   ├── smart-rails/
│   │   ├── core/
│   │   │   ├── src/
│   │   │   │   ├── router.ts
│   │   │   │   ├── types.ts
│   │   │   │   └── index.ts
│   │   │   └── package.json
│   │   ├── preprocessing/
│   │   │   ├── src/
│   │   │   │   ├── extractor.ts
│   │   │   │   ├── patterns.ts
│   │   │   │   └── index.ts
│   │   │   └── package.json
│   │   ├── confidence/
│   │   │   ├── src/
│   │   │   │   ├── scorer.ts
│   │   │   │   ├── factors.ts
│   │   │   │   └── index.ts
│   │   │   └── package.json
│   │   └── prompts/
│   │       ├── src/
│   │       │   ├── generator.ts
│   │       │   ├── strategies.ts
│   │       │   └── index.ts
│   │       └── package.json
│   └── shared/
│       └── types/
│           └── src/
│               └── smart-rails.ts
├── apps/
│   └── telegram-bot/
│       └── src/
│           └── smart-rails-integration.ts
└── nx.json
```

## Migration Steps

### Phase 1: Type Definitions (Week 1)

Create TypeScript interfaces for all data structures:

```typescript
// libs/shared/types/src/smart-rails.ts

export interface RouteResult {
  entityType: EntityType | null;
  operation: Operation | null;
  functionName: string | null;
  confidence: number;
  extractedData: Record<string, any>;
  useDirectExecution: boolean;
  targetUsers: string[];
  entityConfidence?: number;
  operationConfidence?: number;
  assigneeConfidence?: number;
}

export interface ConfidenceFactors {
  patternMatchStrength: number;
  keywordPosition: number;
  keywordSpecificity: number;
  contextClarity: number;
  extractionCompleteness: number;
  syntaxExplicitness: number;
  temporalRelevance: number;
  userMentionClarity: number;
  entityDisambiguation: number;
  operationDisambiguation: number;
}

export interface PromptContext {
  entityType?: EntityType;
  operation?: Operation;
  extractedData?: Record<string, any>;
  confidenceScores?: Record<string, number>;
  cleanedMessage: string;
  originalMessage: string;
  hasMentions: boolean;
  hasCommands: boolean;
  missingFields?: string[];
}

export type EntityType = 'lists' | 'tasks' | 'field_reports';
export type Operation = 'create' | 'read' | 'update' | 'delete' | 
                       'add_items' | 'remove_items' | 'complete' | 
                       'reassign' | 'reschedule';
export type ExecutionStrategy = 'direct' | 'focused_llm' | 'full_llm';
```

### Phase 2: Core Router Library (Week 1-2)

#### 2.1 Create Preprocessing Module

```typescript
// libs/smart-rails/preprocessing/src/extractor.ts

import { ExtractedData, ConfidenceScores } from '@org/shared/types';

export class MessagePreprocessor {
  private patterns: CompiledPatterns;
  
  constructor(private userAliases: Record<string, string>) {
    this.patterns = this.compilePatterns();
  }
  
  preprocessMessage(message: string): PreprocessingResult {
    const extracted: ExtractedData = {};
    const confidences: ConfidenceScores = {};
    let cleanedMessage = message;
    
    // Extract @mentions
    const mentions = this.extractMentions(message);
    if (mentions.length > 0) {
      extracted.assignee = mentions;
      confidences.assigneeConfidence = 1.0;
      cleanedMessage = this.removeMentions(cleanedMessage);
    }
    
    // Extract /commands
    const command = this.extractCommand(message);
    if (command) {
      const { entityType, operation } = this.parseCommand(command);
      if (entityType) {
        extracted.entityType = entityType;
        confidences.entityConfidence = 1.0;
      }
      if (operation) {
        extracted.operation = operation;
        confidences.operationConfidence = 1.0;
      }
      cleanedMessage = this.removeCommand(cleanedMessage);
    }
    
    // Extract patterns
    const patterns = this.extractPatterns(cleanedMessage);
    Object.assign(extracted, patterns);
    
    return {
      cleanedMessage: this.normalizeWhitespace(cleanedMessage),
      extractedData: extracted,
      confidenceScores: confidences
    };
  }
  
  private compilePatterns(): CompiledPatterns {
    return {
      mention: /@([a-zA-Z][a-zA-Z0-9._]*)/g,
      command: /\/(\w+)/,
      time: /(tomorrow|today|next week|at \d+[ap]m)/gi,
      site: /(eagle lake|crockett|mathis)/gi
    };
  }
}
```

#### 2.2 Create Confidence Scoring Module

```typescript
// libs/smart-rails/confidence/src/scorer.ts

import { ConfidenceFactors, RouteResult } from '@org/shared/types';

export class ConfidenceScorer {
  private keywordSpecificity: Map<string, number>;
  private operationClarity: Map<string, number>;
  
  constructor() {
    this.initializeScores();
  }
  
  calculateConfidence(
    message: string,
    entityType: string | null,
    operation: string | null,
    extractedData: Record<string, any>
  ): [number, ConfidenceFactors] {
    const factors = new ConfidenceFactors();
    
    // Calculate individual factors
    factors.syntaxExplicitness = this.calculateSyntaxScore(message);
    factors.contextClarity = this.calculateContextScore(message, entityType);
    factors.extractionCompleteness = this.calculateCompleteness(extractedData);
    
    // Calculate weighted score
    const confidence = this.calculateWeightedScore(factors);
    
    return [confidence, factors];
  }
  
  private calculateWeightedScore(factors: ConfidenceFactors): number {
    const weights = {
      syntaxExplicitness: 0.20,
      patternMatchStrength: 0.25,
      keywordSpecificity: 0.15,
      contextClarity: 0.10,
      extractionCompleteness: 0.10,
      // ... other weights
    };
    
    let totalScore = 0;
    let totalWeight = 0;
    
    for (const [factor, weight] of Object.entries(weights)) {
      const value = factors[factor as keyof ConfidenceFactors];
      totalScore += value * weight;
      totalWeight += weight;
    }
    
    return totalWeight > 0 ? totalScore / totalWeight : 0;
  }
}
```

#### 2.3 Create Prompt Generation Module

```typescript
// libs/smart-rails/prompts/src/generator.ts

import { PromptContext, ExecutionStrategy } from '@org/shared/types';

export class DynamicPromptGenerator {
  private promptCache: Map<string, string>;
  private entityPrompts: Map<string, EntityPromptConfig>;
  
  constructor() {
    this.promptCache = new Map();
    this.initializeEntityPrompts();
  }
  
  generateSystemPrompt(context: PromptContext): string {
    const cacheKey = this.generateCacheKey(context);
    
    if (this.promptCache.has(cacheKey)) {
      return this.promptCache.get(cacheKey)!;
    }
    
    const strategy = this.determineExecutionStrategy(context);
    let prompt: string;
    
    switch (strategy) {
      case 'direct':
        return ''; // No prompt needed
      case 'focused_llm':
        prompt = this.generateFocusedPrompt(context);
        break;
      case 'full_llm':
        prompt = this.generateFullPrompt(context);
        break;
    }
    
    this.promptCache.set(cacheKey, prompt);
    return prompt;
  }
  
  determineExecutionStrategy(context: PromptContext): ExecutionStrategy {
    const { confidenceScores } = context;
    
    if (!confidenceScores) {
      return 'full_llm';
    }
    
    const entityConf = confidenceScores.entityConfidence ?? 0;
    const opConf = confidenceScores.operationConfidence ?? 0;
    
    if (entityConf >= 0.95 && opConf >= 0.95) {
      if (!context.missingFields || context.missingFields.length === 0) {
        return 'direct';
      }
    }
    
    if (entityConf >= 0.8 || opConf >= 0.8) {
      return 'focused_llm';
    }
    
    return 'full_llm';
  }
}
```

### Phase 3: Integration Layer (Week 2)

Create the main Smart Rails service that combines all modules:

```typescript
// libs/smart-rails/core/src/router.ts

import { MessagePreprocessor } from '@org/smart-rails/preprocessing';
import { ConfidenceScorer } from '@org/smart-rails/confidence';
import { DynamicPromptGenerator } from '@org/smart-rails/prompts';
import { RouteResult } from '@org/shared/types';

export class SmartRailsRouter {
  private preprocessor: MessagePreprocessor;
  private scorer: ConfidenceScorer;
  private promptGenerator: DynamicPromptGenerator;
  private routeCache: LRUCache<string, RouteResult>;
  
  constructor(config: SmartRailsConfig) {
    this.preprocessor = new MessagePreprocessor(config.userAliases);
    this.scorer = new ConfidenceScorer();
    this.promptGenerator = new DynamicPromptGenerator();
    this.routeCache = new LRUCache({ max: config.cacheSize ?? 50 });
  }
  
  async route(message: string): Promise<RouteResult> {
    // Check cache
    const cacheKey = this.generateCacheKey(message);
    if (this.routeCache.has(cacheKey)) {
      return this.routeCache.get(cacheKey)!;
    }
    
    // Preprocess message
    const preprocessed = this.preprocessor.preprocessMessage(message);
    
    // Calculate confidence
    const [confidence, factors] = this.scorer.calculateConfidence(
      preprocessed.cleanedMessage,
      preprocessed.extractedData.entityType,
      preprocessed.extractedData.operation,
      preprocessed.extractedData
    );
    
    // Generate prompt if needed
    const context: PromptContext = {
      ...preprocessed,
      confidenceScores: { overall: confidence, ...preprocessed.confidenceScores }
    };
    
    const strategy = this.promptGenerator.determineExecutionStrategy(context);
    
    const result: RouteResult = {
      entityType: preprocessed.extractedData.entityType ?? null,
      operation: preprocessed.extractedData.operation ?? null,
      functionName: this.determineFunctionName(
        preprocessed.extractedData.entityType,
        preprocessed.extractedData.operation
      ),
      confidence,
      extractedData: preprocessed.extractedData,
      useDirectExecution: strategy === 'direct',
      targetUsers: preprocessed.extractedData.assignee ?? [],
      ...preprocessed.confidenceScores
    };
    
    // Cache result
    this.routeCache.set(cacheKey, result);
    
    return result;
  }
}
```

### Phase 4: Testing Strategy (Week 2-3)

#### Unit Tests for Each Module

```typescript
// libs/smart-rails/preprocessing/src/extractor.spec.ts

describe('MessagePreprocessor', () => {
  let preprocessor: MessagePreprocessor;
  
  beforeEach(() => {
    preprocessor = new MessagePreprocessor({
      'joel': 'joel',
      'bryan': 'bryan'
    });
  });
  
  describe('mention extraction', () => {
    it('should extract single @mention with 100% confidence', () => {
      const result = preprocessor.preprocessMessage('@joel check generator');
      
      expect(result.extractedData.assignee).toEqual(['joel']);
      expect(result.confidenceScores.assigneeConfidence).toBe(1.0);
      expect(result.cleanedMessage).toBe('check generator');
    });
    
    it('should handle multiple @mentions', () => {
      const result = preprocessor.preprocessMessage('@joel and @bryan review');
      
      expect(result.extractedData.assignee).toEqual(['joel', 'bryan']);
      expect(result.cleanedMessage).toBe('and review');
    });
  });
  
  describe('command extraction', () => {
    it('should extract /newtask with 100% confidence', () => {
      const result = preprocessor.preprocessMessage('/newtask Check oil');
      
      expect(result.extractedData.entityType).toBe('tasks');
      expect(result.extractedData.operation).toBe('create');
      expect(result.confidenceScores.entityConfidence).toBe(1.0);
      expect(result.confidenceScores.operationConfidence).toBe(1.0);
    });
  });
});
```

#### Integration Tests

```typescript
// libs/smart-rails/core/src/router.integration.spec.ts

describe('SmartRailsRouter Integration', () => {
  let router: SmartRailsRouter;
  
  beforeEach(() => {
    router = new SmartRailsRouter({
      userAliases: { 'joel': 'joel' },
      cacheSize: 10
    });
  });
  
  it('should handle direct execution path', async () => {
    const result = await router.route('/newtask for @joel: Check generator');
    
    expect(result.useDirectExecution).toBe(true);
    expect(result.confidence).toBe(1.0);
    expect(result.entityType).toBe('tasks');
    expect(result.operation).toBe('create');
    expect(result.targetUsers).toEqual(['joel']);
  });
  
  it('should handle focused LLM path', async () => {
    const result = await router.route('add milk to shopping list');
    
    expect(result.useDirectExecution).toBe(false);
    expect(result.confidence).toBeGreaterThan(0.7);
    expect(result.confidence).toBeLessThan(1.0);
  });
});
```

### Phase 5: Performance Benchmarks (Week 3)

Create performance benchmarks to ensure optimization goals are met:

```typescript
// libs/smart-rails/core/src/router.bench.ts

import { bench, describe } from 'vitest';

describe('SmartRailsRouter Performance', () => {
  const router = new SmartRailsRouter({ userAliases: {} });
  
  bench('direct execution path', () => {
    router.route('/newtask Check generator');
  });
  
  bench('focused LLM path', () => {
    router.route('add milk to shopping list');
  });
  
  bench('full LLM path', () => {
    router.route('maybe update that thing');
  });
  
  bench('batch processing 1000 messages', () => {
    const messages = generateTestMessages(1000);
    messages.forEach(msg => router.route(msg));
  });
});
```

## Configuration Management

### Environment-Specific Configuration

```typescript
// libs/smart-rails/core/src/config.ts

export interface SmartRailsConfig {
  userAliases: Record<string, string>;
  cacheSize?: number;
  cacheTTL?: number;
  confidenceThresholds?: {
    direct: number;
    focused: number;
  };
  enabledFeatures?: {
    preprocessing: boolean;
    directExecution: boolean;
    dynamicPrompts: boolean;
  };
}

export const defaultConfig: SmartRailsConfig = {
  userAliases: {},
  cacheSize: 50,
  cacheTTL: 1800,
  confidenceThresholds: {
    direct: 0.95,
    focused: 0.80
  },
  enabledFeatures: {
    preprocessing: true,
    directExecution: true,
    dynamicPrompts: true
  }
};
```

## Nx Configuration

### Project Configuration

```json
// libs/smart-rails/core/project.json
{
  "name": "smart-rails-core",
  "sourceRoot": "libs/smart-rails/core/src",
  "projectType": "library",
  "targets": {
    "build": {
      "executor": "@nx/js:tsc",
      "outputs": ["{options.outputPath}"],
      "options": {
        "outputPath": "dist/libs/smart-rails/core",
        "main": "libs/smart-rails/core/src/index.ts",
        "tsConfig": "libs/smart-rails/core/tsconfig.lib.json"
      }
    },
    "test": {
      "executor": "@nx/jest:jest",
      "options": {
        "jestConfig": "libs/smart-rails/core/jest.config.ts"
      }
    },
    "lint": {
      "executor": "@nx/linter:eslint",
      "options": {
        "lintFilePatterns": ["libs/smart-rails/core/**/*.ts"]
      }
    }
  }
}
```

### Dependencies Graph

```
smart-rails-core
  ├── smart-rails-preprocessing
  ├── smart-rails-confidence
  ├── smart-rails-prompts
  └── shared-types

telegram-bot
  └── smart-rails-core
```

## Deployment Strategy

### Progressive Rollout

1. **Stage 1**: Deploy with preprocessing disabled
2. **Stage 2**: Enable preprocessing, monitor metrics
3. **Stage 3**: Enable direct execution for high-confidence
4. **Stage 4**: Enable dynamic prompts
5. **Stage 5**: Full Smart Rails activation

### Feature Flags

```typescript
// apps/telegram-bot/src/feature-flags.ts

export const smartRailsFlags = {
  preprocessing: process.env.SMART_RAILS_PREPROCESSING === 'true',
  directExecution: process.env.SMART_RAILS_DIRECT === 'true',
  dynamicPrompts: process.env.SMART_RAILS_PROMPTS === 'true',
  cacheEnabled: process.env.SMART_RAILS_CACHE === 'true'
};
```

## Monitoring and Observability

### Metrics Collection

```typescript
// libs/smart-rails/core/src/metrics.ts

export class SmartRailsMetrics {
  private metrics = {
    totalRoutes: 0,
    directExecutions: 0,
    focusedLLM: 0,
    fullLLM: 0,
    cacheHits: 0,
    avgConfidence: 0,
    avgLatency: 0
  };
  
  recordRoute(result: RouteResult, latency: number) {
    this.metrics.totalRoutes++;
    
    if (result.useDirectExecution) {
      this.metrics.directExecutions++;
    } else if (result.confidence >= 0.8) {
      this.metrics.focusedLLM++;
    } else {
      this.metrics.fullLLM++;
    }
    
    // Update running averages
    this.updateAverages(result.confidence, latency);
  }
  
  getMetrics() {
    return {
      ...this.metrics,
      directExecutionRate: this.metrics.directExecutions / this.metrics.totalRoutes,
      tokenSavings: this.calculateTokenSavings()
    };
  }
}
```

## Migration Checklist

### Pre-Migration
- [ ] Document current Python implementation
- [ ] Extract test cases and edge cases
- [ ] Benchmark current performance
- [ ] Define success metrics

### Migration Phase 1 (Types & Core)
- [ ] Create TypeScript type definitions
- [ ] Implement preprocessing module
- [ ] Implement confidence scoring
- [ ] Implement prompt generation
- [ ] Create unit tests

### Migration Phase 2 (Integration)
- [ ] Create main router service
- [ ] Implement caching layer
- [ ] Add integration tests
- [ ] Performance benchmarks

### Migration Phase 3 (Deployment)
- [ ] Set up feature flags
- [ ] Configure monitoring
- [ ] Deploy to staging
- [ ] A/B testing setup
- [ ] Progressive rollout

### Post-Migration
- [ ] Monitor performance metrics
- [ ] Collect user feedback
- [ ] Optimize based on data
- [ ] Document lessons learned

## Conclusion

This migration guide provides a structured approach to moving Smart Rails into an Nx monorepo. The modular architecture ensures:

- **Separation of Concerns**: Each module has a single responsibility
- **Testability**: Each module can be tested independently
- **Reusability**: Modules can be used in multiple applications
- **Performance**: TypeScript compilation and tree-shaking optimize bundle size
- **Maintainability**: Clear boundaries and interfaces between modules

The progressive rollout strategy minimizes risk while allowing for performance monitoring and optimization at each stage.