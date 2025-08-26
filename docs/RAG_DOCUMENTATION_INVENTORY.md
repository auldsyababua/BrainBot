# FLRTS RAG Agent Documentation Inventory

## Purpose
This document provides a comprehensive list of all technologies, libraries, frameworks, and services used in the FLRTS application, including their versions. This inventory is designed to help AI coding agents find the correct documentation when troubleshooting issues.

---

## Core Programming Languages

### Python
- **Version**: 3.11+ (requires-python = ">=3.11")
- **Documentation**: https://docs.python.org/3.11/

### JavaScript/TypeScript
- **Node.js Version**: 20.19.4 LTS (downgraded from v24.4.1 for stability)
- **npm Version**: >=10.0.0
- **TypeScript Version**: 5.6.0 (frontend), 5.5.4 (workers)
- **Documentation**: 
  - Node.js: https://nodejs.org/docs/latest-v20.x/api/
  - TypeScript: https://www.typescriptlang.org/docs/

---

## Backend Technologies

### Core Web Frameworks

#### FastAPI
- **Version**: >=0.111.0
- **Purpose**: Webhook server for Telegram bot
- **Documentation**: https://fastapi.tiangolo.com/

#### Flask
- **Version**: >=3.0.0
- **Purpose**: Web application framework
- **Documentation**: https://flask.palletsprojects.com/en/3.0.x/

#### Uvicorn
- **Version**: >=0.30.0
- **Purpose**: ASGI server for FastAPI
- **Documentation**: https://www.uvicorn.org/

### Telegram Bot Integration

#### python-telegram-bot
- **Version**: 21.0.1
- **Purpose**: Telegram Bot API wrapper
- **Documentation**: https://docs.python-telegram-bot.org/en/v21.0.1/

### AI/ML Libraries

#### OpenAI
- **Version**: >=1.35.0
- **Purpose**: GPT model integration
- **Documentation**: https://platform.openai.com/docs/libraries/python-library

#### Sentence Transformers
- **Version**: >=2.2.2
- **Purpose**: Text embeddings and similarity
- **Documentation**: https://www.sbert.net/

#### mem0ai
- **Version**: >=0.0.15
- **Purpose**: Memory management for AI applications
- **Documentation**: https://docs.mem0.ai/

### Database & Storage

#### Supabase
- **Version**: >=2.11.0
- **Purpose**: Backend as a Service (PostgreSQL, Auth, Storage)
- **Documentation**: https://supabase.com/docs/reference/python/introduction

#### PostgreSQL
- **Version**: 15 (Docker images)
- **Purpose**: Primary database
- **Documentation**: https://www.postgresql.org/docs/15/

#### Redis (Legacy - Migrated to Cloudflare KV)
- **Version**: >=4.5.5 (python client)
- **Previous Purpose**: Caching and session management
- **Migration Status**: Replaced with Cloudflare KV for edge performance
- **Documentation**: https://redis-py.readthedocs.io/en/stable/
- **Note**: Redis container still available for local testing (port 6380)

#### Boto3 (AWS SDK)
- **Version**: >=1.35.0
- **Purpose**: S3 storage operations
- **Documentation**: https://boto3.amazonaws.com/v1/documentation/api/latest/index.html

### Utilities

#### python-dotenv
- **Version**: 1.0.0
- **Purpose**: Environment variable management
- **Documentation**: https://pypi.org/project/python-dotenv/

#### PyYAML
- **Version**: 6.0.1
- **Purpose**: YAML configuration parsing
- **Documentation**: https://pyyaml.org/wiki/PyYAMLDocumentation

#### requests
- **Version**: >=2.31.0
- **Purpose**: HTTP client library
- **Documentation**: https://requests.readthedocs.io/en/latest/

#### aiohttp
- **Version**: >=3.8.0
- **Purpose**: Async HTTP client/server
- **Documentation**: https://docs.aiohttp.org/en/stable/

#### psutil
- **Version**: >=5.9.0
- **Purpose**: System and process utilities
- **Documentation**: https://psutil.readthedocs.io/en/latest/

---

## Frontend Technologies

### React Ecosystem

#### React
- **Version**: 18.3.1
- **Purpose**: UI framework
- **Documentation**: https://react.dev/

#### React DOM
- **Version**: 18.3.1
- **Purpose**: React rendering for web
- **Documentation**: https://react.dev/reference/react-dom

### Build Tools

#### Vite
- **Version**: 6.0.0
- **Purpose**: Frontend build tool
- **Documentation**: https://vite.dev/

#### Vitest
- **Version**: 2.1.8
- **Purpose**: Testing framework
- **Documentation**: https://vitest.dev/

### Styling

#### Tailwind CSS
- **Version**: 3.4.17
- **Purpose**: Utility-first CSS framework
- **Documentation**: https://tailwindcss.com/docs

#### PostCSS
- **Version**: 8.4.47
- **Purpose**: CSS processing
- **Documentation**: https://postcss.org/

#### Autoprefixer
- **Version**: 10.4.20
- **Purpose**: CSS vendor prefixing
- **Documentation**: https://github.com/postcss/autoprefixer

### UI Components

#### lucide-react
- **Version**: 0.441.0
- **Purpose**: Icon library
- **Documentation**: https://lucide.dev/

#### clsx
- **Version**: 2.1.1
- **Purpose**: Conditional className utility
- **Documentation**: https://github.com/lukeed/clsx

#### tailwind-merge
- **Version**: 2.5.4
- **Purpose**: Tailwind class merging utility
- **Documentation**: https://github.com/dcastil/tailwind-merge

### Testing Libraries

#### @testing-library/react
- **Version**: 16.1.0
- **Purpose**: React component testing
- **Documentation**: https://testing-library.com/docs/react-testing-library/intro/

#### @testing-library/jest-dom
- **Version**: 6.6.3
- **Purpose**: Custom jest matchers for DOM
- **Documentation**: https://github.com/testing-library/jest-dom

#### @testing-library/user-event
- **Version**: 14.5.2
- **Purpose**: User interaction simulation
- **Documentation**: https://testing-library.com/docs/user-event/intro

#### MSW (Mock Service Worker)
- **Version**: 2.6.4
- **Purpose**: API mocking
- **Documentation**: https://mswjs.io/

---

## Development Tools

### Python Development

#### pytest
- **Version**: >=7.3.1
- **Purpose**: Testing framework
- **Documentation**: https://docs.pytest.org/en/stable/

#### pytest-asyncio
- **Version**: >=0.21.0
- **Purpose**: Async test support
- **Documentation**: https://pytest-asyncio.readthedocs.io/

#### pytest-cov
- **Version**: >=4.0.0
- **Purpose**: Coverage reporting
- **Documentation**: https://pytest-cov.readthedocs.io/

#### Black
- **Version**: >=24.3.0
- **Purpose**: Code formatter
- **Configuration**: line-length=100, target-version=py311
- **Documentation**: https://black.readthedocs.io/

#### Ruff
- **Version**: >=0.3.0
- **Purpose**: Linter
- **Configuration**: line-length=100, target-version=py311
- **Documentation**: https://docs.astral.sh/ruff/

#### isort
- **Version**: >=5.12.0
- **Purpose**: Import sorting
- **Configuration**: profile=black, line-length=100
- **Documentation**: https://pycqa.github.io/isort/

#### mypy
- **Version**: >=1.0.0
- **Purpose**: Type checking
- **Configuration**: python_version=3.11
- **Documentation**: https://mypy.readthedocs.io/

#### Flake8
- **Version**: >=6.0.0
- **Purpose**: Linting
- **Documentation**: https://flake8.pycqa.org/

### JavaScript/TypeScript Development

#### ESLint
- **Version**: 8.57.0
- **Purpose**: JavaScript linting
- **Documentation**: https://eslint.org/

#### TypeScript ESLint
- **Version**: 7.0.0
- **Purpose**: TypeScript linting
- **Documentation**: https://typescript-eslint.io/

---

## Cloud Services & Infrastructure

### Cloudflare Services

#### Cloudflare Workers
- **Runtime**: Wrangler 4.28.1
- **Purpose**: Edge computing, webhook proxy
- **Documentation**: https://developers.cloudflare.com/workers/

#### Cloudflare Vectorize
- **Index Name**: flrts-vectors
- **Purpose**: Vector search database
- **Documentation**: https://developers.cloudflare.com/vectorize/

#### Cloudflare KV
- **Purpose**: Key-value storage
- **Documentation**: https://developers.cloudflare.com/kv/

#### Cloudflare Durable Objects
- **Purpose**: Stateful edge computing, real-time coordination
- **Documentation**: https://developers.cloudflare.com/durable-objects/

#### Cloudflare Workers KV (Redis Alternative)
- **Purpose**: Key-value storage with Redis-like operations (migrated from Upstash Redis)
- **Migration**: Moved from Upstash Redis to Cloudflare's native KV
- **Documentation**: https://developers.cloudflare.com/kv/

#### Cloudflare Pages
- **Purpose**: Static site hosting (Frontend deployment)
- **Documentation**: https://developers.cloudflare.com/pages/

#### Cloudflare Workers for Platforms
- **Purpose**: Container hosting (migrating from Render)
- **Documentation**: https://developers.cloudflare.com/cloudflare-for-platforms/

### Render.com (Legacy - Migrating to Cloudflare)
- **Purpose**: Previous application hosting
- **Migration Status**: Moving to Cloudflare Workers/Pages
- **Documentation**: https://docs.render.com/

### Neo4j (Optional)
- **Purpose**: Graph database for memory
- **Documentation**: https://neo4j.com/docs/

### Docker
- **PostgreSQL Image**: postgres:15
- **Supabase Image**: supabase/postgres:15.1.0.147
- **Purpose**: Local development and testing
- **Documentation**: https://docs.docker.com/

---

## Telegram Mini App Specific

### Telegram Web App
- **Purpose**: Mini app integration
- **Documentation**: https://core.telegram.org/bots/webapps

---

## API Documentation URLs

### Primary APIs
1. **OpenAI API**: https://platform.openai.com/docs/api-reference
2. **Telegram Bot API**: https://core.telegram.org/bots/api
3. **Supabase REST API**: https://supabase.com/docs/reference/javascript/introduction
4. **Cloudflare API**: https://developers.cloudflare.com/api/

### Secondary APIs
1. **AWS S3 API**: https://docs.aws.amazon.com/AmazonS3/latest/API/
2. **Neo4j REST API**: https://neo4j.com/docs/http-api/current/

---

## Configuration & Environment

### Environment Variables
- Managed with python-dotenv
- Required variables listed in render.yaml
- Development configuration in .env files

### Port Configuration
- FastAPI/Uvicorn: Default 8000
- PostgreSQL: 5432 (prod), 5433 (test), 5434 (supabase test)
- Frontend dev server: Vite default (5173)

---

## Version Management

### Python
- Managed via pyproject.toml and requirements.txt
- Virtual environment recommended

### Node.js
- Managed via package.json
- Engine requirement: Node 20.19.4 LTS (specifically v20.0.0 - v21.0.0)
- npm requirement: >=10.0.0
- **IMPORTANT**: Do NOT use Node v24.x - causes TypeScript/Vite toolchain issues

---

## Testing Strategies

### Backend Testing
- pytest with asyncio support
- Coverage reporting with pytest-cov
- Integration test markers

### Frontend Testing  
- Vitest for unit tests
- React Testing Library for component tests
- MSW for API mocking

---

## Deployment Checklist Reference
See: `docs/DEPLOYMENT_CHECKLIST.md`

---

## Notes for RAG Agent

1. **Version Compatibility**: Always check version-specific documentation
2. **Node.js Critical**: MUST use Node 20.19.4 LTS - Node v24.x breaks TypeScript/Vite
3. **Configuration Files**: Check pyproject.toml, package.json, and render.yaml for settings
4. **Environment Variables**: Critical for service integration
5. **Testing**: Both backend (pytest) and frontend (vitest) have extensive test suites
6. **Cloud Migration**: Moving from Render.com to Cloudflare (Pages for frontend, Workers for backend)
7. **Cloud Services**: Heavy reliance on Cloudflare ecosystem:
   - Workers (edge computing)
   - Vectorize (vector search)
   - KV (key-value storage, replaced Upstash Redis)
   - Durable Objects (stateful coordination)
   - Pages (static hosting)
8. **Database**: 
   - Primary: Supabase (PostgreSQL)
   - Cache/Session: Cloudflare KV (migrated from Upstash Redis)
   - Edge: Cloudflare services for distributed operations
9. **Mini App Context**: This is a Telegram Mini App, requiring special consideration for Telegram Web App APIs

## Implemented Recommendations Status

### ✅ Completed from Resolution Docs:
- Package.json engines field configured for Node 20.0.0 - 21.0.0
- CI/CD updated for Node 20.x only

### ⚠️ Pending Actions:
- `.nvmrc` file NOT created yet (should contain `20.19.4`)
- TypeScript errors cleanup (38 errors exist but don't block build)
- GitHub Actions workflow verification needed

---

Last Updated: August 26, 2024