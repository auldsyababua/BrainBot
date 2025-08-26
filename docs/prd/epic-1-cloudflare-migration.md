# Epic 1: Cloudflare Migration & Smart Rails MVP

## Epic Overview

**Epic Goal**: Complete the migration to a fully Cloudflare-hosted architecture while delivering the core Smart Rails functionality for zero-friction task and list management.

**Business Value**: Consolidate infrastructure onto Cloudflare for easier maintenance, better performance, and simplified LLM agent deployments via Wrangler.

## Epic Scope

### In-Scope
- Complete migration from Upstash to Cloudflare services
- Implement Smart Rails direct execution for tasks and lists
- Deploy Telegram Mini-App on Cloudflare Pages
- Backend migration to Cloudflare Workers
- Task reminders system

### Out-of-Scope (Post-MVP)
- Field reports functionality
- Free-form note creation with RAG
- mem0 integration
- Advanced AI learning features

## User Stories

### Story 1.1: Complete Vector Storage Migration
**As a** system,
**I want** to fully migrate from Upstash Vector to Cloudflare Vectorize,
**so that** all vector operations are consolidated on Cloudflare infrastructure.

**Acceptance Criteria:**
1. All vector storage operations use Cloudflare Vectorize API
2. Vector search functionality maintains current performance levels
3. No remaining Upstash Vector dependencies in codebase
4. Integration tests pass with Vectorize backend

### Story 1.2: Complete Media Storage Migration  
**As a** system,
**I want** to migrate from AWS S3 to Cloudflare R2,
**so that** all file storage is consolidated on Cloudflare infrastructure.

**Acceptance Criteria:**
1. `media_storage.py` uses Cloudflare R2 API instead of boto3
2. All existing media files are migrated to R2
3. File upload/download functionality works correctly
4. No AWS dependencies remain in codebase

### Story 1.3: Complete Cache Migration
**As a** system,  
**I want** to migrate from Upstash Redis to Cloudflare KV,
**so that** all caching is handled by Cloudflare services.

**Acceptance Criteria:**
1. Conversation history stored in Cloudflare KV
2. Router cache uses Cloudflare KV
3. Session data managed via Cloudflare KV
4. Performance maintains current levels

### Story 1.4: Migrate Backend to Cloudflare Workers
**As a** system,
**I want** to migrate the FastAPI backend from Render.com to Cloudflare Workers,
**so that** the entire stack runs on Cloudflare infrastructure.

**Acceptance Criteria:**
1. FastAPI webhook converted to Cloudflare Workers
2. Telegram bot integration works correctly
3. Smart Rails routing functions in Workers environment
4. Database connections optimized for Workers

### Story 1.5: Deploy Mini-App on Cloudflare Pages
**As a** user,
**I want** the Telegram Mini-App hosted on Cloudflare Pages,
**so that** I have a fast, reliable interface for complex operations.

**Acceptance Criteria:**
1. React Mini-App builds and deploys to Cloudflare Pages
2. Mini-App integrates correctly with Telegram WebApp API
3. Backend API calls work from Pages to Workers
4. Authentication via Telegram WebApp data functions

### Story 1.6: Implement Task Reminders
**As a** user,
**I want** to set reminders for my tasks using natural language,
**so that** I don't miss important deadlines.

**Acceptance Criteria:**
1. Smart Rails router parses date/time from natural language
2. Reminders scheduled using Cloudflare Cron Triggers or Durable Objects
3. Reminder notifications sent via Telegram bot
4. Users can snooze or dismiss reminders

### Story 1.7: Optimize Smart Rails Direct Execution
**As a** user,
**I want** high-confidence commands to execute immediately,
**so that** I get sub-500ms responses for common operations.

**Acceptance Criteria:**
1. TaskProcessor and ListProcessor handle direct execution
2. Confidence threshold tuned for optimal accuracy (95%+)
3. Response times consistently under 500ms
4. Graceful fallback to LLM for low-confidence commands

## Technical Requirements

### Performance Targets
- Smart Rails direct execution: <500ms
- Vector search queries: <1s  
- Mini-App initial load: <2s
- File upload to R2: <5s

### Infrastructure Requirements
- All services hosted on Cloudflare
- Wrangler-compatible deployment structure
- Environment variable management via Cloudflare
- Monitoring via Cloudflare Analytics

## Migration Strategy

### Phase 1: Service Migrations
Complete all Upstash → Cloudflare service migrations while maintaining current functionality.

### Phase 2: Backend Migration
Migrate from Render.com to Cloudflare Workers with thorough testing.

### Phase 3: Frontend Deployment
Deploy Mini-App to Cloudflare Pages with full Telegram integration.

### Phase 4: Optimization
Tune Smart Rails performance and implement task reminders.

## Success Metrics

- Zero downtime during migrations
- Performance targets met or exceeded
- All functionality working on Cloudflare infrastructure
- No remaining dependencies on Upstash or AWS
- GitHub tests passing consistently

---

*This epic represents the foundational architecture for the FLRTS MVP, establishing the Cloudflare-first infrastructure that will support all future development.*