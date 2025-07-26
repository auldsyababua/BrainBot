# Development Log - Multi-Repository View

> **Auto-Generated**: This file is programmatically updated from git history.  
> Last updated: 2025-07-25 at 17:24:13 PST

## 🔍 Quick Navigation

<div align="center">

### Filter by Repository

| [**📋 All Repositories**](#all-repositories) | [**🤖 markdown-brain-bot**](#markdown_brain_bot_only) | [**🧠 gpt-parser**](#gpt_parser_only) | [**🎨 bbui**](#bbui_only) |

### Quick Links

| [**📊 Statistics**](#statistics) | [**📈 Repository Breakdown**](#repository-breakdown) | [**🗓️ Recent Activity**](#recent-activity) |

</div>

---


## Project Overview

This development log provides multiple views of your project's commit history:
- **All Repositories**: Complete chronological view across all repos
- **Per-Repository**: Filtered view showing only commits from specific repositories
- **Collapsible Sections**: Click on "Files Modified" to expand/collapse file details

### Repository Structure
- 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)**: Main backend system with Smart Rails routing
- 🧠 **[gpt-parser](https://github.com/auldsyababua/gpt-parser)**: Early backend attempt with GPT parsing
- 🎨 **[bbui](https://github.com/auldsyababua/bbui)**: Frontend interface for FLRTS system

---

<a name="all-repositories"></a>
## 📋 All Repositories

<a name="recent-activity"></a>
### Recent Activity

Showing all commits from all repositories in chronological order.

#### 2025-07-25

### [346fea6] Fix test suite failures and improve code robustness
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-25 17:23:11 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 19 files changed (+1757 -1408)
- **Commit**: [`346fea6`](https://github.com/auldsyababua/markdown-brain-bot/commit/346fea60242f2cb4c3a4e15274376d418cd141c3)

<details>
<summary>Files Modified</summary>

  - `.env.example` (+17 -1)
  - `.githooks/post-commit` (+22)
  - `.gitignore` (+5)
  - *...and 16 more files*

</details>

### [ce66357] Initial commit: BBUI Frontend for FLRTS System
- **Repository**: 🎨 **[bbui](https://github.com/auldsyababua/bbui)** - Frontend interface for FLRTS system
- **Date**: 2025-07-25 15:22:45 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 128 files changed (+27403)
- **Commit**: [`ce66357`](https://github.com/auldsyababua/bbui/commit/ce66357733310e5cbffcf6d48b5bcad4fa493db8)

<details>
<summary>Files Modified</summary>

  - `.env.example` (+11)
  - `.gitignore` (+65)
  - `ADMIN_DASHBOARD.md` (+128)
  - *...and 125 more files*

</details>

### [eadcc30] feat: consolidate user tables and update schema for Phase 2 Smart Rails
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-25 15:08:53 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 1 files changed (+342)
- **Commit**: [`eadcc30`](https://github.com/auldsyababua/markdown-brain-bot/commit/eadcc3005d11bc243121825e006fe1945680ec94)

<details>
<summary>Files Modified</summary>

  - `database_schema_updates.sql` (+342)

</details>

### [4175129] test: enhance integration tests with comprehensive edge case coverage
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-25 13:50:38 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Testing
- **Changes**: 10 files changed (+5054 -72)
- **Commit**: [`4175129`](https://github.com/auldsyababua/markdown-brain-bot/commit/41751296a022f341070a14331424743c2239f3dc)

<details>
<summary>Files Modified</summary>

  - `tests/integration/test_document_storage.py` (+298 -1)
  - `tests/integration/test_media_storage.py` (+302 -1)
  - `tests/integration/test_rails_integration.py` (+1222 -13)
  - *...and 7 more files*

</details>

---

#### 2025-07-24

### [99b8871] feat: implement Smart Rails preprocessing system with deterministic syntax extraction
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-24 19:04:41 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 28 files changed (+4006 -383)
- **Commit**: [`99b8871`](https://github.com/auldsyababua/markdown-brain-bot/commit/99b887189413e2b3266d8e221e24536770935f83)

<details>
<summary>Files Modified</summary>

  - `10nz_kb/about-10netzero 2.md` (+56)
  - `10nz_kb/db_test_docs_do_not_modify/about-10netzero-test 2.md` (+30)
  - `10nz_kb/db_test_docs_do_not_modify/eagle-lake-todo-list 2.md` (+28)
  - *...and 25 more files*

</details>

### [5bd974b] Remove all filesystem operations from production code
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-24 13:31:26 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 42 files changed (+386 -2974)
- **Commit**: [`5bd974b`](https://github.com/auldsyababua/markdown-brain-bot/commit/5bd974b9e980fc0e9541f44da460dd6a4bf80a71)

<details>
<summary>Files Modified</summary>

  - `.env.example` (+6 -1)
  - `10nz_kb/README.md` (-14)
  - `10nz_kb/db_test_docs_do_not_modify/README.md` (-20)
  - *...and 39 more files*

</details>

---

#### 2025-07-22

### [31a42fd] Remove legacy file system operations and reorganize knowledge base
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-22 20:13:11 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 23 files changed (+1157 -202)
- **Commit**: [`31a42fd`](https://github.com/auldsyababua/markdown-brain-bot/commit/31a42fdeca223f73ba8fb71aab7c52009f03d929)

<details>
<summary>Files Modified</summary>

  - `10nz_kb/README.md` (+14)
  - `10nz_kb/about-10netzero.md` (+70)
  - `10nz_kb/db_test_docs_do_not_modify/README.md` (+20)
  - *...and 20 more files*

</details>

---

#### 2025-07-21

### [40c7861] Complete vector store namespace fix - install upstash-vector v0.8.1 from GitHub
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-21 23:16:00 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 1 files changed (+1)
- **Commit**: [`40c7861`](https://github.com/auldsyababua/markdown-brain-bot/commit/40c7861301c967a5ad90a5ec4e3cd9a34ceea621)

<details>
<summary>Files Modified</summary>

  - `src/tests/test_results/latest.json` (+1)

</details>

### [3b27f4d] Fix vector store namespace issue - backup before version fix
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-21 19:27:18 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 43 files changed (+1358 -910)
- **Commit**: [`3b27f4d`](https://github.com/auldsyababua/markdown-brain-bot/commit/3b27f4de442bdd72ab550ac0a06f7f6483373f3c)

<details>
<summary>Files Modified</summary>

  - `.gitignore` (+10 -1)
  - `ARCHITECTURE.md` (+59 -25)
  - `README.md` (+50 -44)
  - *...and 40 more files*

</details>

---

#### 2025-07-20

### [8136edb] Add Locust load testing suite for performance validation
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-20 15:34:18 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 4 files changed (+857)
- **Commit**: [`8136edb`](https://github.com/auldsyababua/markdown-brain-bot/commit/8136edb21abb2c0729a50d1c4e16065e9f668081)

<details>
<summary>Files Modified</summary>

  - `scripts/analyze_load_test.py` (+210)
  - `scripts/run_load_test.sh` (+150)
  - `tests/README_load_testing.md` (+211)
  - *...and 1 more files*

</details>

### [1cf2f99] Enhance AI babysitter tests based on audit feedback
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-20 15:02:37 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 3 files changed (+591 -5)
- **Commit**: [`1cf2f99`](https://github.com/auldsyababua/markdown-brain-bot/commit/1cf2f99b24f1dde0cbfc00b1a8cccc19fb6217f5)

<details>
<summary>Files Modified</summary>

  - `AI_CODING_RULES.md` (+223)
  - `scripts/ai_change_check.sh` (+81)
  - `tests/test_ai_babysitter.py` (+287 -5)

</details>

### [355072e] Add AI babysitter tests to catch common AI coding mistakes
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-20 14:40:59 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 2 files changed (+397)
- **Commit**: [`355072e`](https://github.com/auldsyababua/markdown-brain-bot/commit/355072e32f31994e6d1e9ff266b4f870bbd9fe1e)

<details>
<summary>Files Modified</summary>

  - `scripts/test_ai_babysitter.sh` (+31)
  - `tests/test_ai_babysitter.py` (+366)

</details>

### [b7653eb] Merge branch 'main' into feature/performance-benchmarking
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-20 14:40:06 PST  
- **Author**: Colin Aulds
- **Status**: 🟢 PR merge
- **Changes**: 10 files changed (+652 -42)
- **Commit**: [`b7653eb`](https://github.com/auldsyababua/markdown-brain-bot/commit/b7653eb9e59c257f623b7953c3e231ddab90000a)

<details>
<summary>Files Modified</summary>

  - `docs/FILESYSTEM_CONTENT_ISSUE.md` (+151)
  - `scripts/check_render_logs.sh` (+16)
  - `scripts/debug_joel_query.py` (+98)
  - *...and 7 more files*

</details>

### [33ac636] Fix linting issues after merge
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-20 13:40:19 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 3 files changed (+39 -35)
- **Commit**: [`33ac636`](https://github.com/auldsyababua/markdown-brain-bot/commit/33ac63679dd66a97f7b2cded63847eb2fc240bfb)

<details>
<summary>Files Modified</summary>

  - `scripts/debug_joel_query.py` (+2 -2)
  - `scripts/reset_vector_10net.py` (+16 -14)
  - `src/core/llm.py` (+21 -19)

</details>

### [2d5899e] Add handoff documentation for Issue #7 - Unified Storage Abstraction Layer
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-20 13:27:44 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 2 files changed (+790)
- **Commit**: [`2d5899e`](https://github.com/auldsyababua/markdown-brain-bot/commit/2d5899e7ed0e2fec02240954fe4a3a9181de7968)

<details>
<summary>Files Modified</summary>

  - `docs/HANDOFF_UNIFIED_STORAGE.md` (+654)
  - `docs/STORAGE_MIGRATION_CHECKLIST.md` (+136)

</details>

### [e12d6be] Add comprehensive monitoring and testing documentation
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-20 13:17:32 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 5 files changed (+1341 -1)
- **Commit**: [`e12d6be`](https://github.com/auldsyababua/markdown-brain-bot/commit/e12d6be106f6cbf3d8a352bd1d9fcd7d413b9742)

<details>
<summary>Files Modified</summary>

  - `README.md` (+38 -1)
  - `docs/MONITORING_GUIDE.md` (+512)
  - `docs/MONITORING_QUICK_REFERENCE.md` (+207)
  - *...and 2 more files*

</details>

### [2010cfb] docs: Add complete implementation summary for performance optimization
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-20 12:54:38 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 1 files changed (+108)
- **Commit**: [`2010cfb`](https://github.com/auldsyababua/markdown-brain-bot/commit/2010cfb20a7c23076d825df919d7d5e46d969e60)

<details>
<summary>Files Modified</summary>

  - `docs/PERFORMANCE_IMPLEMENTATION_COMPLETE.md` (+108)

</details>

### [3de22c8] Phase 8: Document performance improvements and metrics
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-20 12:51:33 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 2 files changed (+388)
- **Commit**: [`3de22c8`](https://github.com/auldsyababua/markdown-brain-bot/commit/3de22c878885c0625cac2822aa42cbf0cfa9b42b)

<details>
<summary>Files Modified</summary>

  - `docs/PERFORMANCE_BENCHMARKING_IMPLEMENTATION.md` (+240)
  - `docs/PERFORMANCE_QUICK_REFERENCE.md` (+148)

</details>

### [fec119f] Phase 7: Test all performance features locally
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-20 12:46:37 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 2 files changed (+252)
- **Commit**: [`fec119f`](https://github.com/auldsyababua/markdown-brain-bot/commit/fec119f179a93084f707e47fce4b4037a2898002)

<details>
<summary>Files Modified</summary>

  - `tests/README_performance.md` (+54)
  - `tests/test_performance.py` (+198)

</details>

### [225dd60] Phase 6: Add performance middleware to FastAPI
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-20 12:39:55 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 1 files changed (+37)
- **Commit**: [`225dd60`](https://github.com/auldsyababua/markdown-brain-bot/commit/225dd609f0dc7d3de6a1987b3ad4cdf2fb6131bb)

<details>
<summary>Files Modified</summary>

  - `src/bot/webhook_bot.py` (+37)

</details>

### [7585bd7] Phase 5: Implement conversation history sliding window
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-20 12:32:58 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 3 files changed (+134 -25)
- **Commit**: [`7585bd7`](https://github.com/auldsyababua/markdown-brain-bot/commit/7585bd7a1cd15a3af1d5b38264b89c4d06def3f8)

<details>
<summary>Files Modified</summary>

  - `src/core/config.py` (+4)
  - `src/core/llm.py` (+127 -24)
  - `src/storage/redis_store.py` (+3 -1)

</details>

### [d58fa87] feat: Create resilient OpenAI API client with retry logic
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-20 12:08:24 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 2 files changed (+385 -5)
- **Commit**: [`d58fa87`](https://github.com/auldsyababua/markdown-brain-bot/commit/d58fa87521c026bfdba95bdba281747131a55342)

<details>
<summary>Files Modified</summary>

  - `src/core/api_client.py` (+361)
  - `src/core/llm.py` (+24 -5)

</details>

### [3f9ad43] feat: Add Redis caching layer to vector search
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-20 12:04:32 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 1 files changed (+113 -1)
- **Commit**: [`3f9ad43`](https://github.com/auldsyababua/markdown-brain-bot/commit/3f9ad43cad3656644dc8220edef6fe2a7dcc251e)

<details>
<summary>Files Modified</summary>

  - `src/storage/vector_store.py` (+113 -1)

</details>

### [2b85655] feat: Add core performance benchmarking system
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-20 12:01:16 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 13 files changed (+339 -12)
- **Commit**: [`2b85655`](https://github.com/auldsyababua/markdown-brain-bot/commit/2b856554e03734c93ef0443754058f70a82c4544)

<details>
<summary>Files Modified</summary>

  - `docs/{ => ARCHIVE}/DEPLOYMENT_GUIDE.md` (no changes)
  - `docs/{ => ARCHIVE}/DOC_PROCESSING_PIPELINE.md` (no changes)
  - `docs/{ => ARCHIVE}/LOCAL_VS_PRODUCTION.md` (no changes)
  - *...and 10 more files*

</details>

---

#### 2025-07-19

### [4bc2de4] refactor: Implement webhook-only architecture with local dev simulator
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-19 17:57:32 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Refactor
- **Changes**: 9 files changed (+550 -255)
- **Commit**: [`4bc2de4`](https://github.com/auldsyababua/markdown-brain-bot/commit/4bc2de4090fe57c0c405d26b98912cae356e9b37)

<details>
<summary>Files Modified</summary>

  - `main.py` (+92 -11)
  - `render.yaml` (+1 -1)
  - `run_bot.py` (-20)
  - *...and 6 more files*

</details>

### [49883cd] Merge pull request #4 from auldsyababua/feature/supabase-document-storage
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-19 17:33:39 PST  
- **Author**: Colin Aulds
- **Status**: 🟢 PR merge
- **Changes**: 10 files changed (+652 -43)
- **Commit**: [`49883cd`](https://github.com/auldsyababua/markdown-brain-bot/commit/49883cd5c206204a32c06608533423e9e653fbc4)

<details>
<summary>Files Modified</summary>

  - `docs/FILESYSTEM_CONTENT_ISSUE.md` (+151)
  - `scripts/check_render_logs.sh` (+16)
  - `scripts/debug_joel_query.py` (+98)
  - *...and 7 more files*

</details>

### [b72a30a] feat: Complete Supabase-first document architecture
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-19 17:31:30 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 10 files changed (+555 -26)
- **Commit**: [`b72a30a`](https://github.com/auldsyababua/markdown-brain-bot/commit/b72a30acb3adb4d0d44b7ccfd266585a339fc66a)

<details>
<summary>Files Modified</summary>

  - `docs/FILESYSTEM_CONTENT_ISSUE.md` (+151)
  - `scripts/check_render_logs.sh` (+16)
  - `scripts/debug_joel_query.py` (+98)
  - *...and 7 more files*

</details>

### [0817c4d] refactor: Update vector store to use Supabase instead of filesystem
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-19 17:26:30 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Refactor
- **Changes**: 2 files changed (+114 -34)
- **Commit**: [`0817c4d`](https://github.com/auldsyababua/markdown-brain-bot/commit/0817c4dd9578aa31011181e41047c543be9174e6)

<details>
<summary>Files Modified</summary>

  - `src/storage/storage_service.py` (+45)
  - `src/storage/vector_store.py` (+69 -34)

</details>

### [55a470f] Fix: Add missing await in webhook handler and improve context extraction
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-19 15:51:16 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 3 files changed (+35 -10)
- **Commit**: [`55a470f`](https://github.com/auldsyababua/markdown-brain-bot/commit/55a470f699e13b7249defb8b75a30e8330b2be85)

<details>
<summary>Files Modified</summary>

  - `src/bot/main_webhook.py` (+1 -1)
  - `src/core/llm.py` (+20 -3)
  - `src/storage/vector_store.py` (+14 -6)

</details>

### [5ae06d9] Merge pull request #3 from auldsyababua/cleanup-and-update-prompt
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-19 15:06:36 PST  
- **Author**: Colin Aulds
- **Status**: 🟢 PR merge
- **Changes**: 22 files changed (+2029 -163)
- **Commit**: [`5ae06d9`](https://github.com/auldsyababua/markdown-brain-bot/commit/5ae06d953f8ec6dba132ba8dadc2d2fafec451f5)

<details>
<summary>Files Modified</summary>

  - `ARCHITECTURE.md` (+115)
  - `README.md` (+31 -12)
  - `docs/LOCAL_VS_PRODUCTION.md` (+102)
  - *...and 19 more files*

</details>

### [9a81d15] Major cleanup and documentation update
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-19 15:03:13 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Documentation
- **Changes**: 22 files changed (+2029 -163)
- **Commit**: [`9a81d15`](https://github.com/auldsyababua/markdown-brain-bot/commit/9a81d1586d6edb058dc33ac6703b5ca41b7d4002)

<details>
<summary>Files Modified</summary>

  - `ARCHITECTURE.md` (+115)
  - `README.md` (+31 -12)
  - `docs/LOCAL_VS_PRODUCTION.md` (+102)
  - *...and 19 more files*

</details>

### [ace0abd] Add fastapi and uvicorn to requirements for webhook server deployment
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-19 14:39:03 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 1 files changed (+3 -1)
- **Commit**: [`ace0abd`](https://github.com/auldsyababua/markdown-brain-bot/commit/ace0abd05f6762181b6e5ec36b65ab8b9043f38a)

<details>
<summary>Files Modified</summary>

  - `requirements.txt` (+3 -1)

</details>

### [a3c12f6] Switch from polling to webhook mode for Telegram bot
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-19 12:18:41 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 11 files changed (+384 -10)
- **Commit**: [`a3c12f6`](https://github.com/auldsyababua/markdown-brain-bot/commit/a3c12f660c1a5702aac164b7cd66231e95748c25)

<details>
<summary>Files Modified</summary>

  - `README_WEBHOOK_SETUP.md` (+71)
  - `fix_imports.py` (+48)
  - `pyproject.toml` (+59)
  - *...and 8 more files*

</details>

### [68b72d8] Merge pull request #2 from auldsyababua/feature/storage-implementation-and-cleanup
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-19 11:47:44 PST  
- **Author**: Colin Aulds
- **Status**: 🟢 PR merge
- **Changes**: 43 files changed (+3028 -68)
- **Commit**: [`68b72d8`](https://github.com/auldsyababua/markdown-brain-bot/commit/68b72d895b4e3d1a5c807cdc2ecd0e3e88a1fff9)

<details>
<summary>Files Modified</summary>

  - `.gitignore` (+4 -6)
  - `README.md` (+75 -17)
  - `docs/DEPLOYMENT_GUIDE.md` (+217)
  - *...and 40 more files*

</details>

### [188d450] feat: implement hybrid storage (Supabase + S3) and reorganize project structure
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-19 11:46:39 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 43 files changed (+3028 -68)
- **Commit**: [`188d450`](https://github.com/auldsyababua/markdown-brain-bot/commit/188d450d1dac850fd7020dd13ff5c0d4ecb5a73a)

<details>
<summary>Files Modified</summary>

  - `.gitignore` (+4 -6)
  - `README.md` (+75 -17)
  - `docs/DEPLOYMENT_GUIDE.md` (+217)
  - *...and 40 more files*

</details>

### [0c68c82] feat: Add version tracking and diagnostics to bot
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-19 01:04:21 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 4 files changed (+211 -2)
- **Commit**: [`0c68c82`](https://github.com/auldsyababua/markdown-brain-bot/commit/0c68c82b622ae7a9ea0e0a46a1dcd8f0fd8aa0ab)

<details>
<summary>Files Modified</summary>

  - `config.py` (+2 -1)
  - `diagnose_vector.py` (+163)
  - `main_polling.py` (+26 -1)
  - *...and 1 more files*

</details>

### [65738f9] feat: Implement document chunking for vector store (Phase 2)
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-19 00:55:36 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 2 files changed (+403 -1)
- **Commit**: [`65738f9`](https://github.com/auldsyababua/markdown-brain-bot/commit/65738f93d4a16f27e75ff4c5d441858c779e8403)

<details>
<summary>Files Modified</summary>

  - `chunking.py` (+260)
  - `migrate_to_vector.py` (+143 -1)

</details>

### [3fc2e5d] feat: Implement search_with_full_content method for full document retrieval
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-19 00:40:29 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 2 files changed (+16 -3)
- **Commit**: [`3fc2e5d`](https://github.com/auldsyababua/markdown-brain-bot/commit/3fc2e5d7b44695ecfc1b632627279e1800ba7482)

<details>
<summary>Files Modified</summary>

  - `llm.py` (+5 -3)
  - `scratch/README.md` (+11)

</details>

### [f2f2a4f] WIP: Started implementing search_with_full_content method
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-19 00:34:45 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟡 WIP
- **Changes**: 1 files changed (+113)
- **Commit**: [`f2f2a4f`](https://github.com/auldsyababua/markdown-brain-bot/commit/f2f2a4fe999b596dba99fbcdd48a36bde1502b3d)

<details>
<summary>Files Modified</summary>

  - `vector_store.py` (+113)

</details>

### [37a61d9] Add comprehensive plan for vector store enhancement
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-19 00:29:48 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 1 files changed (+237)
- **Commit**: [`37a61d9`](https://github.com/auldsyababua/markdown-brain-bot/commit/37a61d97140ad9c8478308de39035a5b07cad9ef)

<details>
<summary>Files Modified</summary>

  - `VECTOR_ENHANCEMENT_PLAN.md` (+237)

</details>

### [5ba6c61] Increase content preview from 200 to 1500 characters
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-19 00:15:11 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 1 files changed (+1 -1)
- **Commit**: [`5ba6c61`](https://github.com/auldsyababua/markdown-brain-bot/commit/5ba6c6164286b82cba1deb6049de57d736bc596b)

<details>
<summary>Files Modified</summary>

  - `vector_store.py` (+1 -1)

</details>

### [b09ee80] Fix vector search to return content preview from metadata
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-19 00:13:14 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 1 files changed (+6 -1)
- **Commit**: [`b09ee80`](https://github.com/auldsyababua/markdown-brain-bot/commit/b09ee8050b1a4f5c2335dd7d686ed3873c0a177a)

<details>
<summary>Files Modified</summary>

  - `vector_store.py` (+6 -1)

</details>

---

#### 2025-07-18

### [3b89f9c] Fix OpenAI library compatibility with Python 3.13
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-18 23:27:48 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 6 files changed (+163 -179)
- **Commit**: [`3b89f9c`](https://github.com/auldsyababua/markdown-brain-bot/commit/3b89f9c2e6d816d02f641f8f5d518493c3a544f3)

<details>
<summary>Files Modified</summary>

  - `.gitignore` (+3)
  - `Procfile` (-1)
  - `main.py` (+9 -148)
  - *...and 3 more files*

</details>

### [740ad5a] Sanitize repository - remove all company-specific references
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-18 20:41:20 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 7 files changed (+20 -139)
- **Commit**: [`740ad5a`](https://github.com/auldsyababua/markdown-brain-bot/commit/740ad5ad743cc117134fa91a7dff9543f906b6b9)

<details>
<summary>Files Modified</summary>

  - `.env.example` (+2 -1)
  - `FUTURE_FEATURES.md` (-120)
  - `README.md` (+5 -5)
  - *...and 4 more files*

</details>

### [30963ce] Remove sensitive HANDOFF_DOC.md from repository
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-18 20:27:06 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 2 files changed (+6 -267)
- **Commit**: [`30963ce`](https://github.com/auldsyababua/markdown-brain-bot/commit/30963ce60bd5d1f0e93a7dceb9187d8635cd9f81)

<details>
<summary>Files Modified</summary>

  - `.gitignore` (+6)
  - `HANDOFF_DOC.md` (-267)

</details>

### [31fd0aa] Add Procfile and start script for Render deployment
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-18 20:21:31 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 3 files changed (+13 -1)
- **Commit**: [`31fd0aa`](https://github.com/auldsyababua/markdown-brain-bot/commit/31fd0aaac378af900b0a3da7aa57f70e1963fcae)

<details>
<summary>Files Modified</summary>

  - `Procfile` (+1)
  - `render.yaml` (+1 -1)
  - `start.py` (+11)

</details>

### [7bb46f8] Fix Render deployment configuration
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-18 18:50:21 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 2 files changed (+2 -2)
- **Commit**: [`7bb46f8`](https://github.com/auldsyababua/markdown-brain-bot/commit/7bb46f873222f579450bcf6dde272aef12b91c16)

<details>
<summary>Files Modified</summary>

  - `render.yaml` (+1 -1)
  - `requirements.txt` (+1 -1)

</details>

### [057809e] Configure for Render deployment with Redis/Vector integration
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-18 18:46:35 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 3 files changed (+79 -42)
- **Commit**: [`057809e`](https://github.com/auldsyababua/markdown-brain-bot/commit/057809e94b112b590db814c9bca5eacc24694d57)

<details>
<summary>Files Modified</summary>

  - `.env.example` (+12)
  - `README.md` (+53 -38)
  - `render.yaml` (+14 -4)

</details>

### [688e0f4] Merge pull request #1 from auldsyababua/prompt-optimization
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-18 18:43:45 PST  
- **Author**: Colin Aulds
- **Status**: 🟢 PR merge
- **Changes**: 20 files changed (+2564 -301)
- **Commit**: [`688e0f4`](https://github.com/auldsyababua/markdown-brain-bot/commit/688e0f481424212a1c2bff230f9d669e4e9725ce)

<details>
<summary>Files Modified</summary>

  - `.env.example` (+16 -3)
  - `.gitignore` (+19 -1)
  - `FUTURE_FEATURES.md` (+120)
  - *...and 17 more files*

</details>

### [45ce925] Fix code formatting and linting issues
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-18 18:43:17 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 12 files changed (+1209 -158)
- **Commit**: [`45ce925`](https://github.com/auldsyababua/markdown-brain-bot/commit/45ce92524ad88cc99f6db9e6154305173607a11d)

<details>
<summary>Files Modified</summary>

  - `.gitignore` (+8 -1)
  - `FUTURE_FEATURES.md` (+120)
  - `HANDOFF_DOC.md` (+267)
  - *...and 9 more files*

</details>

### [5bc9564] Add context awareness to system prompt for organizational hierarchy
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-18 17:20:46 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 2 files changed (+520)
- **Commit**: [`5bc9564`](https://github.com/auldsyababua/markdown-brain-bot/commit/5bc956410624fe53b26d334a8cffd704138a6410)

<details>
<summary>Files Modified</summary>

  - `tests/test_context_awareness.py` (+235)
  - `tests/test_search_resilience.py` (+285)

</details>

### [24e587c] Improve prompt and search resilience for file-based queries
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-18 17:10:29 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 15 files changed (+991 -299)
- **Commit**: [`24e587c`](https://github.com/auldsyababua/markdown-brain-bot/commit/24e587cb788d4a410549686890e2d71e0329b062)

<details>
<summary>Files Modified</summary>

  - `.env.example` (+16 -3)
  - `.gitignore` (+12 -1)
  - `README.md` (+15)
  - *...and 12 more files*

</details>

### [bc06a4f] Fix requirements.txt (remove pydantic version constraint) and ensure notes folder is gitignored
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-18 14:48:20 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 1 files changed (+1 -2)
- **Commit**: [`bc06a4f`](https://github.com/auldsyababua/markdown-brain-bot/commit/bc06a4f91a3caf4b665c727276e37178354bf08f)

<details>
<summary>Files Modified</summary>

  - `requirements.txt` (+1 -2)

</details>

### [0eedd40] Exclude notes folder from git (keep only index.md)
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-18 14:46:25 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 1 files changed (+3 -2)
- **Commit**: [`0eedd40`](https://github.com/auldsyababua/markdown-brain-bot/commit/0eedd40ca945986755ca3ac7c3167e1f0620f440)

<details>
<summary>Files Modified</summary>

  - `.gitignore` (+3 -2)

</details>

### [eb3eaf7] Add .env.example and render.yaml for deployment
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-18 14:39:14 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 2 files changed (+22)
- **Commit**: [`eb3eaf7`](https://github.com/auldsyababua/markdown-brain-bot/commit/eb3eaf75bb942f6983ecf26f1cc246c7d0c1643c)

<details>
<summary>Files Modified</summary>

  - `.env.example` (+5)
  - `render.yaml` (+17)

</details>

### [481f3d2] Initial commit: Markdown Brain Bot v1 MVP
- **Repository**: 🤖 **[markdown-brain-bot](https://github.com/auldsyababua/markdown-brain-bot)** - Main backend system with Smart Rails routing
- **Date**: 2025-07-18 14:33:37 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 8 files changed (+946)
- **Commit**: [`481f3d2`](https://github.com/auldsyababua/markdown-brain-bot/commit/481f3d2e59c0dccdcbafd0903a93144c7e4cdd8d)

<details>
<summary>Files Modified</summary>

  - `.gitignore` (+62)
  - `README.md` (+168)
  - `config.py` (+28)
  - *...and 5 more files*

</details>

---

#### 2025-07-16

### [4a6d314] feat: Telegram Mini App Phase 1 - Environment & Dependencies Setup
- **Repository**: 🧠 **[gpt-parser](https://github.com/auldsyababua/gpt-parser)** - Early backend attempt with GPT parsing
- **Date**: 2025-07-16 00:26:44 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 47 files changed (+7966 -52)
- **Commit**: [`4a6d314`](https://github.com/auldsyababua/gpt-parser/commit/4a6d31421914bdee5b04582e97110af82a30789a)

<details>
<summary>Files Modified</summary>

  - `development-phases/telegram-miniapp-integration-prp.md` (+792)
  - `docs/handoff-miniapp-integration.md` (+160)
  - `integrations/telegram/bot.py` (+125 -35)
  - *...and 44 more files*

</details>

---

#### 2025-07-15

### [18e079b] Add detailed logging for Supabase task creation debugging
- **Repository**: 🧠 **[gpt-parser](https://github.com/auldsyababua/gpt-parser)** - Early backend attempt with GPT parsing
- **Date**: 2025-07-15 18:19:54 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 1 files changed (+12 -1)
- **Commit**: [`18e079b`](https://github.com/auldsyababua/gpt-parser/commit/18e079b574615d9407ae351c197d74751d8cfeeb)

<details>
<summary>Files Modified</summary>

  - `integrations/telegram/bot.py` (+12 -1)

</details>

### [ef1e5a6] Improve user lookup to handle real Telegram IDs
- **Repository**: 🧠 **[gpt-parser](https://github.com/auldsyababua/gpt-parser)** - Early backend attempt with GPT parsing
- **Date**: 2025-07-15 18:07:45 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 2 files changed (+38 -7)
- **Commit**: [`ef1e5a6`](https://github.com/auldsyababua/gpt-parser/commit/ef1e5a66366635d0f17dcded3c1431e93c0b3169)

<details>
<summary>Files Modified</summary>

  - `integrations/supabase/user_manager.py` (+1)
  - `integrations/telegram/bot.py` (+37 -7)

</details>

### [2221e01] Fix timezone conversion error with zoneinfo
- **Repository**: 🧠 **[gpt-parser](https://github.com/auldsyababua/gpt-parser)** - Early backend attempt with GPT parsing
- **Date**: 2025-07-15 17:55:17 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 1 files changed (+2 -2)
- **Commit**: [`2221e01`](https://github.com/auldsyababua/gpt-parser/commit/2221e011172f8cbe64da7954e59e10d93e38b4ec)

<details>
<summary>Files Modified</summary>

  - `utils/timezone_converter.py` (+2 -2)

</details>

### [c671b24] Add Supabase integration with dual-system support
- **Repository**: 🧠 **[gpt-parser](https://github.com/auldsyababua/gpt-parser)** - Early backend attempt with GPT parsing
- **Date**: 2025-07-15 17:40:43 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 9 files changed (+1048 -114)
- **Commit**: [`c671b24`](https://github.com/auldsyababua/gpt-parser/commit/c671b242c513461def84019d0aa386cc180deaf3)

<details>
<summary>Files Modified</summary>

  - `.gitignore` (+4)
  - `database/schema.sql` (+160)
  - `database/seed_data.sql` (+24)
  - *...and 6 more files*

</details>

---

#### 2025-07-12

### [c9dc577] Merge pull request #11 from auldsyababua/add-telegram-buttons
- **Repository**: 🧠 **[gpt-parser](https://github.com/auldsyababua/gpt-parser)** - Early backend attempt with GPT parsing
- **Date**: 2025-07-12 15:06:37 PST  
- **Author**: Colin Aulds
- **Status**: 🟢 PR merge
- **Changes**: 55 files changed (+1310 -287)
- **Commit**: [`c9dc577`](https://github.com/auldsyababua/gpt-parser/commit/c9dc5772f09a0d42367dea87307a1481ff57cf5f)

<details>
<summary>Files Modified</summary>

  - `.gitignore` (+1)
  - `cli/__init__.py` (+1 -1)
  - `cli/run_bot.py` (+43 -2)
  - *...and 52 more files*

</details>

### [84f6dd3] fix: timezone parsing and user identification issues
- **Repository**: 🧠 **[gpt-parser](https://github.com/auldsyababua/gpt-parser)** - Early backend attempt with GPT parsing
- **Date**: 2025-07-12 15:02:50 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Bug fix
- **Changes**: 25 files changed (+997 -156)
- **Commit**: [`84f6dd3`](https://github.com/auldsyababua/gpt-parser/commit/84f6dd306a18ec4c6b077cf01102acdb1aa1313e)

<details>
<summary>Files Modified</summary>

  - `.gitignore` (+1)
  - `cli/__init__.py` (+1 -1)
  - `cli/run_bot.py` (+43 -2)
  - *...and 22 more files*

</details>

---


*For older commits, see the per-repository sections below.*

## 📁 Per-Repository Views

Click on any repository section below to see commits filtered by that repository only.

---

<a name="markdown_brain_bot_only"></a>
### 🤖 markdown-brain-bot Repository Only

<details>
<summary>Click to expand 55 commits from markdown-brain-bot</summary>


#### 2025-07-25

### [346fea6] Fix test suite failures and improve code robustness
- **Date**: 2025-07-25 17:23:11 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 19 files changed (+1757 -1408)
- **Commit**: [`346fea6`](https://github.com/auldsyababua/markdown-brain-bot/commit/346fea60242f2cb4c3a4e15274376d418cd141c3)

<details>
<summary>Files Modified</summary>

  - `.env.example` (+17 -1)
  - `.githooks/post-commit` (+22)
  - `.gitignore` (+5)
  - *...and 16 more files*

</details>

### [eadcc30] feat: consolidate user tables and update schema for Phase 2 Smart Rails
- **Date**: 2025-07-25 15:08:53 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 1 files changed (+342)
- **Commit**: [`eadcc30`](https://github.com/auldsyababua/markdown-brain-bot/commit/eadcc3005d11bc243121825e006fe1945680ec94)

<details>
<summary>Files Modified</summary>

  - `database_schema_updates.sql` (+342)

</details>

### [4175129] test: enhance integration tests with comprehensive edge case coverage
- **Date**: 2025-07-25 13:50:38 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Testing
- **Changes**: 10 files changed (+5054 -72)
- **Commit**: [`4175129`](https://github.com/auldsyababua/markdown-brain-bot/commit/41751296a022f341070a14331424743c2239f3dc)

<details>
<summary>Files Modified</summary>

  - `tests/integration/test_document_storage.py` (+298 -1)
  - `tests/integration/test_media_storage.py` (+302 -1)
  - `tests/integration/test_rails_integration.py` (+1222 -13)
  - *...and 7 more files*

</details>


#### 2025-07-24

### [99b8871] feat: implement Smart Rails preprocessing system with deterministic syntax extraction
- **Date**: 2025-07-24 19:04:41 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 28 files changed (+4006 -383)
- **Commit**: [`99b8871`](https://github.com/auldsyababua/markdown-brain-bot/commit/99b887189413e2b3266d8e221e24536770935f83)

<details>
<summary>Files Modified</summary>

  - `10nz_kb/about-10netzero 2.md` (+56)
  - `10nz_kb/db_test_docs_do_not_modify/about-10netzero-test 2.md` (+30)
  - `10nz_kb/db_test_docs_do_not_modify/eagle-lake-todo-list 2.md` (+28)
  - *...and 25 more files*

</details>

### [5bd974b] Remove all filesystem operations from production code
- **Date**: 2025-07-24 13:31:26 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 42 files changed (+386 -2974)
- **Commit**: [`5bd974b`](https://github.com/auldsyababua/markdown-brain-bot/commit/5bd974b9e980fc0e9541f44da460dd6a4bf80a71)

<details>
<summary>Files Modified</summary>

  - `.env.example` (+6 -1)
  - `10nz_kb/README.md` (-14)
  - `10nz_kb/db_test_docs_do_not_modify/README.md` (-20)
  - *...and 39 more files*

</details>


#### 2025-07-22

### [31a42fd] Remove legacy file system operations and reorganize knowledge base
- **Date**: 2025-07-22 20:13:11 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 23 files changed (+1157 -202)
- **Commit**: [`31a42fd`](https://github.com/auldsyababua/markdown-brain-bot/commit/31a42fdeca223f73ba8fb71aab7c52009f03d929)

<details>
<summary>Files Modified</summary>

  - `10nz_kb/README.md` (+14)
  - `10nz_kb/about-10netzero.md` (+70)
  - `10nz_kb/db_test_docs_do_not_modify/README.md` (+20)
  - *...and 20 more files*

</details>


#### 2025-07-21

### [40c7861] Complete vector store namespace fix - install upstash-vector v0.8.1 from GitHub
- **Date**: 2025-07-21 23:16:00 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 1 files changed (+1)
- **Commit**: [`40c7861`](https://github.com/auldsyababua/markdown-brain-bot/commit/40c7861301c967a5ad90a5ec4e3cd9a34ceea621)

<details>
<summary>Files Modified</summary>

  - `src/tests/test_results/latest.json` (+1)

</details>

### [3b27f4d] Fix vector store namespace issue - backup before version fix
- **Date**: 2025-07-21 19:27:18 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 43 files changed (+1358 -910)
- **Commit**: [`3b27f4d`](https://github.com/auldsyababua/markdown-brain-bot/commit/3b27f4de442bdd72ab550ac0a06f7f6483373f3c)

<details>
<summary>Files Modified</summary>

  - `.gitignore` (+10 -1)
  - `ARCHITECTURE.md` (+59 -25)
  - `README.md` (+50 -44)
  - *...and 40 more files*

</details>


#### 2025-07-20

### [8136edb] Add Locust load testing suite for performance validation
- **Date**: 2025-07-20 15:34:18 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 4 files changed (+857)
- **Commit**: [`8136edb`](https://github.com/auldsyababua/markdown-brain-bot/commit/8136edb21abb2c0729a50d1c4e16065e9f668081)

<details>
<summary>Files Modified</summary>

  - `scripts/analyze_load_test.py` (+210)
  - `scripts/run_load_test.sh` (+150)
  - `tests/README_load_testing.md` (+211)
  - *...and 1 more files*

</details>

### [1cf2f99] Enhance AI babysitter tests based on audit feedback
- **Date**: 2025-07-20 15:02:37 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 3 files changed (+591 -5)
- **Commit**: [`1cf2f99`](https://github.com/auldsyababua/markdown-brain-bot/commit/1cf2f99b24f1dde0cbfc00b1a8cccc19fb6217f5)

<details>
<summary>Files Modified</summary>

  - `AI_CODING_RULES.md` (+223)
  - `scripts/ai_change_check.sh` (+81)
  - `tests/test_ai_babysitter.py` (+287 -5)

</details>

### [355072e] Add AI babysitter tests to catch common AI coding mistakes
- **Date**: 2025-07-20 14:40:59 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 2 files changed (+397)
- **Commit**: [`355072e`](https://github.com/auldsyababua/markdown-brain-bot/commit/355072e32f31994e6d1e9ff266b4f870bbd9fe1e)

<details>
<summary>Files Modified</summary>

  - `scripts/test_ai_babysitter.sh` (+31)
  - `tests/test_ai_babysitter.py` (+366)

</details>

### [b7653eb] Merge branch 'main' into feature/performance-benchmarking
- **Date**: 2025-07-20 14:40:06 PST  
- **Author**: Colin Aulds
- **Status**: 🟢 PR merge
- **Changes**: 10 files changed (+652 -42)
- **Commit**: [`b7653eb`](https://github.com/auldsyababua/markdown-brain-bot/commit/b7653eb9e59c257f623b7953c3e231ddab90000a)

<details>
<summary>Files Modified</summary>

  - `docs/FILESYSTEM_CONTENT_ISSUE.md` (+151)
  - `scripts/check_render_logs.sh` (+16)
  - `scripts/debug_joel_query.py` (+98)
  - *...and 7 more files*

</details>

### [33ac636] Fix linting issues after merge
- **Date**: 2025-07-20 13:40:19 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 3 files changed (+39 -35)
- **Commit**: [`33ac636`](https://github.com/auldsyababua/markdown-brain-bot/commit/33ac63679dd66a97f7b2cded63847eb2fc240bfb)

<details>
<summary>Files Modified</summary>

  - `scripts/debug_joel_query.py` (+2 -2)
  - `scripts/reset_vector_10net.py` (+16 -14)
  - `src/core/llm.py` (+21 -19)

</details>

### [2d5899e] Add handoff documentation for Issue #7 - Unified Storage Abstraction Layer
- **Date**: 2025-07-20 13:27:44 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 2 files changed (+790)
- **Commit**: [`2d5899e`](https://github.com/auldsyababua/markdown-brain-bot/commit/2d5899e7ed0e2fec02240954fe4a3a9181de7968)

<details>
<summary>Files Modified</summary>

  - `docs/HANDOFF_UNIFIED_STORAGE.md` (+654)
  - `docs/STORAGE_MIGRATION_CHECKLIST.md` (+136)

</details>

### [e12d6be] Add comprehensive monitoring and testing documentation
- **Date**: 2025-07-20 13:17:32 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 5 files changed (+1341 -1)
- **Commit**: [`e12d6be`](https://github.com/auldsyababua/markdown-brain-bot/commit/e12d6be106f6cbf3d8a352bd1d9fcd7d413b9742)

<details>
<summary>Files Modified</summary>

  - `README.md` (+38 -1)
  - `docs/MONITORING_GUIDE.md` (+512)
  - `docs/MONITORING_QUICK_REFERENCE.md` (+207)
  - *...and 2 more files*

</details>

### [2010cfb] docs: Add complete implementation summary for performance optimization
- **Date**: 2025-07-20 12:54:38 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 1 files changed (+108)
- **Commit**: [`2010cfb`](https://github.com/auldsyababua/markdown-brain-bot/commit/2010cfb20a7c23076d825df919d7d5e46d969e60)

<details>
<summary>Files Modified</summary>

  - `docs/PERFORMANCE_IMPLEMENTATION_COMPLETE.md` (+108)

</details>

### [3de22c8] Phase 8: Document performance improvements and metrics
- **Date**: 2025-07-20 12:51:33 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 2 files changed (+388)
- **Commit**: [`3de22c8`](https://github.com/auldsyababua/markdown-brain-bot/commit/3de22c878885c0625cac2822aa42cbf0cfa9b42b)

<details>
<summary>Files Modified</summary>

  - `docs/PERFORMANCE_BENCHMARKING_IMPLEMENTATION.md` (+240)
  - `docs/PERFORMANCE_QUICK_REFERENCE.md` (+148)

</details>

### [fec119f] Phase 7: Test all performance features locally
- **Date**: 2025-07-20 12:46:37 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 2 files changed (+252)
- **Commit**: [`fec119f`](https://github.com/auldsyababua/markdown-brain-bot/commit/fec119f179a93084f707e47fce4b4037a2898002)

<details>
<summary>Files Modified</summary>

  - `tests/README_performance.md` (+54)
  - `tests/test_performance.py` (+198)

</details>

### [225dd60] Phase 6: Add performance middleware to FastAPI
- **Date**: 2025-07-20 12:39:55 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 1 files changed (+37)
- **Commit**: [`225dd60`](https://github.com/auldsyababua/markdown-brain-bot/commit/225dd609f0dc7d3de6a1987b3ad4cdf2fb6131bb)

<details>
<summary>Files Modified</summary>

  - `src/bot/webhook_bot.py` (+37)

</details>

### [7585bd7] Phase 5: Implement conversation history sliding window
- **Date**: 2025-07-20 12:32:58 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 3 files changed (+134 -25)
- **Commit**: [`7585bd7`](https://github.com/auldsyababua/markdown-brain-bot/commit/7585bd7a1cd15a3af1d5b38264b89c4d06def3f8)

<details>
<summary>Files Modified</summary>

  - `src/core/config.py` (+4)
  - `src/core/llm.py` (+127 -24)
  - `src/storage/redis_store.py` (+3 -1)

</details>

### [d58fa87] feat: Create resilient OpenAI API client with retry logic
- **Date**: 2025-07-20 12:08:24 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 2 files changed (+385 -5)
- **Commit**: [`d58fa87`](https://github.com/auldsyababua/markdown-brain-bot/commit/d58fa87521c026bfdba95bdba281747131a55342)

<details>
<summary>Files Modified</summary>

  - `src/core/api_client.py` (+361)
  - `src/core/llm.py` (+24 -5)

</details>

### [3f9ad43] feat: Add Redis caching layer to vector search
- **Date**: 2025-07-20 12:04:32 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 1 files changed (+113 -1)
- **Commit**: [`3f9ad43`](https://github.com/auldsyababua/markdown-brain-bot/commit/3f9ad43cad3656644dc8220edef6fe2a7dcc251e)

<details>
<summary>Files Modified</summary>

  - `src/storage/vector_store.py` (+113 -1)

</details>

### [2b85655] feat: Add core performance benchmarking system
- **Date**: 2025-07-20 12:01:16 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 13 files changed (+339 -12)
- **Commit**: [`2b85655`](https://github.com/auldsyababua/markdown-brain-bot/commit/2b856554e03734c93ef0443754058f70a82c4544)

<details>
<summary>Files Modified</summary>

  - `docs/{ => ARCHIVE}/DEPLOYMENT_GUIDE.md` (no changes)
  - `docs/{ => ARCHIVE}/DOC_PROCESSING_PIPELINE.md` (no changes)
  - `docs/{ => ARCHIVE}/LOCAL_VS_PRODUCTION.md` (no changes)
  - *...and 10 more files*

</details>


#### 2025-07-19

### [4bc2de4] refactor: Implement webhook-only architecture with local dev simulator
- **Date**: 2025-07-19 17:57:32 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Refactor
- **Changes**: 9 files changed (+550 -255)
- **Commit**: [`4bc2de4`](https://github.com/auldsyababua/markdown-brain-bot/commit/4bc2de4090fe57c0c405d26b98912cae356e9b37)

<details>
<summary>Files Modified</summary>

  - `main.py` (+92 -11)
  - `render.yaml` (+1 -1)
  - `run_bot.py` (-20)
  - *...and 6 more files*

</details>

### [49883cd] Merge pull request #4 from auldsyababua/feature/supabase-document-storage
- **Date**: 2025-07-19 17:33:39 PST  
- **Author**: Colin Aulds
- **Status**: 🟢 PR merge
- **Changes**: 10 files changed (+652 -43)
- **Commit**: [`49883cd`](https://github.com/auldsyababua/markdown-brain-bot/commit/49883cd5c206204a32c06608533423e9e653fbc4)

<details>
<summary>Files Modified</summary>

  - `docs/FILESYSTEM_CONTENT_ISSUE.md` (+151)
  - `scripts/check_render_logs.sh` (+16)
  - `scripts/debug_joel_query.py` (+98)
  - *...and 7 more files*

</details>

### [b72a30a] feat: Complete Supabase-first document architecture
- **Date**: 2025-07-19 17:31:30 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 10 files changed (+555 -26)
- **Commit**: [`b72a30a`](https://github.com/auldsyababua/markdown-brain-bot/commit/b72a30acb3adb4d0d44b7ccfd266585a339fc66a)

<details>
<summary>Files Modified</summary>

  - `docs/FILESYSTEM_CONTENT_ISSUE.md` (+151)
  - `scripts/check_render_logs.sh` (+16)
  - `scripts/debug_joel_query.py` (+98)
  - *...and 7 more files*

</details>

### [0817c4d] refactor: Update vector store to use Supabase instead of filesystem
- **Date**: 2025-07-19 17:26:30 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Refactor
- **Changes**: 2 files changed (+114 -34)
- **Commit**: [`0817c4d`](https://github.com/auldsyababua/markdown-brain-bot/commit/0817c4dd9578aa31011181e41047c543be9174e6)

<details>
<summary>Files Modified</summary>

  - `src/storage/storage_service.py` (+45)
  - `src/storage/vector_store.py` (+69 -34)

</details>

### [55a470f] Fix: Add missing await in webhook handler and improve context extraction
- **Date**: 2025-07-19 15:51:16 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 3 files changed (+35 -10)
- **Commit**: [`55a470f`](https://github.com/auldsyababua/markdown-brain-bot/commit/55a470f699e13b7249defb8b75a30e8330b2be85)

<details>
<summary>Files Modified</summary>

  - `src/bot/main_webhook.py` (+1 -1)
  - `src/core/llm.py` (+20 -3)
  - `src/storage/vector_store.py` (+14 -6)

</details>

### [5ae06d9] Merge pull request #3 from auldsyababua/cleanup-and-update-prompt
- **Date**: 2025-07-19 15:06:36 PST  
- **Author**: Colin Aulds
- **Status**: 🟢 PR merge
- **Changes**: 22 files changed (+2029 -163)
- **Commit**: [`5ae06d9`](https://github.com/auldsyababua/markdown-brain-bot/commit/5ae06d953f8ec6dba132ba8dadc2d2fafec451f5)

<details>
<summary>Files Modified</summary>

  - `ARCHITECTURE.md` (+115)
  - `README.md` (+31 -12)
  - `docs/LOCAL_VS_PRODUCTION.md` (+102)
  - *...and 19 more files*

</details>

### [9a81d15] Major cleanup and documentation update
- **Date**: 2025-07-19 15:03:13 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Documentation
- **Changes**: 22 files changed (+2029 -163)
- **Commit**: [`9a81d15`](https://github.com/auldsyababua/markdown-brain-bot/commit/9a81d1586d6edb058dc33ac6703b5ca41b7d4002)

<details>
<summary>Files Modified</summary>

  - `ARCHITECTURE.md` (+115)
  - `README.md` (+31 -12)
  - `docs/LOCAL_VS_PRODUCTION.md` (+102)
  - *...and 19 more files*

</details>

### [ace0abd] Add fastapi and uvicorn to requirements for webhook server deployment
- **Date**: 2025-07-19 14:39:03 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 1 files changed (+3 -1)
- **Commit**: [`ace0abd`](https://github.com/auldsyababua/markdown-brain-bot/commit/ace0abd05f6762181b6e5ec36b65ab8b9043f38a)

<details>
<summary>Files Modified</summary>

  - `requirements.txt` (+3 -1)

</details>

### [a3c12f6] Switch from polling to webhook mode for Telegram bot
- **Date**: 2025-07-19 12:18:41 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 11 files changed (+384 -10)
- **Commit**: [`a3c12f6`](https://github.com/auldsyababua/markdown-brain-bot/commit/a3c12f660c1a5702aac164b7cd66231e95748c25)

<details>
<summary>Files Modified</summary>

  - `README_WEBHOOK_SETUP.md` (+71)
  - `fix_imports.py` (+48)
  - `pyproject.toml` (+59)
  - *...and 8 more files*

</details>

### [68b72d8] Merge pull request #2 from auldsyababua/feature/storage-implementation-and-cleanup
- **Date**: 2025-07-19 11:47:44 PST  
- **Author**: Colin Aulds
- **Status**: 🟢 PR merge
- **Changes**: 43 files changed (+3028 -68)
- **Commit**: [`68b72d8`](https://github.com/auldsyababua/markdown-brain-bot/commit/68b72d895b4e3d1a5c807cdc2ecd0e3e88a1fff9)

<details>
<summary>Files Modified</summary>

  - `.gitignore` (+4 -6)
  - `README.md` (+75 -17)
  - `docs/DEPLOYMENT_GUIDE.md` (+217)
  - *...and 40 more files*

</details>

### [188d450] feat: implement hybrid storage (Supabase + S3) and reorganize project structure
- **Date**: 2025-07-19 11:46:39 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 43 files changed (+3028 -68)
- **Commit**: [`188d450`](https://github.com/auldsyababua/markdown-brain-bot/commit/188d450d1dac850fd7020dd13ff5c0d4ecb5a73a)

<details>
<summary>Files Modified</summary>

  - `.gitignore` (+4 -6)
  - `README.md` (+75 -17)
  - `docs/DEPLOYMENT_GUIDE.md` (+217)
  - *...and 40 more files*

</details>

### [0c68c82] feat: Add version tracking and diagnostics to bot
- **Date**: 2025-07-19 01:04:21 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 4 files changed (+211 -2)
- **Commit**: [`0c68c82`](https://github.com/auldsyababua/markdown-brain-bot/commit/0c68c82b622ae7a9ea0e0a46a1dcd8f0fd8aa0ab)

<details>
<summary>Files Modified</summary>

  - `config.py` (+2 -1)
  - `diagnose_vector.py` (+163)
  - `main_polling.py` (+26 -1)
  - *...and 1 more files*

</details>

### [65738f9] feat: Implement document chunking for vector store (Phase 2)
- **Date**: 2025-07-19 00:55:36 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 2 files changed (+403 -1)
- **Commit**: [`65738f9`](https://github.com/auldsyababua/markdown-brain-bot/commit/65738f93d4a16f27e75ff4c5d441858c779e8403)

<details>
<summary>Files Modified</summary>

  - `chunking.py` (+260)
  - `migrate_to_vector.py` (+143 -1)

</details>

### [3fc2e5d] feat: Implement search_with_full_content method for full document retrieval
- **Date**: 2025-07-19 00:40:29 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 2 files changed (+16 -3)
- **Commit**: [`3fc2e5d`](https://github.com/auldsyababua/markdown-brain-bot/commit/3fc2e5d7b44695ecfc1b632627279e1800ba7482)

<details>
<summary>Files Modified</summary>

  - `llm.py` (+5 -3)
  - `scratch/README.md` (+11)

</details>

### [f2f2a4f] WIP: Started implementing search_with_full_content method
- **Date**: 2025-07-19 00:34:45 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟡 WIP
- **Changes**: 1 files changed (+113)
- **Commit**: [`f2f2a4f`](https://github.com/auldsyababua/markdown-brain-bot/commit/f2f2a4fe999b596dba99fbcdd48a36bde1502b3d)

<details>
<summary>Files Modified</summary>

  - `vector_store.py` (+113)

</details>

### [37a61d9] Add comprehensive plan for vector store enhancement
- **Date**: 2025-07-19 00:29:48 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 1 files changed (+237)
- **Commit**: [`37a61d9`](https://github.com/auldsyababua/markdown-brain-bot/commit/37a61d97140ad9c8478308de39035a5b07cad9ef)

<details>
<summary>Files Modified</summary>

  - `VECTOR_ENHANCEMENT_PLAN.md` (+237)

</details>

### [5ba6c61] Increase content preview from 200 to 1500 characters
- **Date**: 2025-07-19 00:15:11 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 1 files changed (+1 -1)
- **Commit**: [`5ba6c61`](https://github.com/auldsyababua/markdown-brain-bot/commit/5ba6c6164286b82cba1deb6049de57d736bc596b)

<details>
<summary>Files Modified</summary>

  - `vector_store.py` (+1 -1)

</details>

### [b09ee80] Fix vector search to return content preview from metadata
- **Date**: 2025-07-19 00:13:14 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 1 files changed (+6 -1)
- **Commit**: [`b09ee80`](https://github.com/auldsyababua/markdown-brain-bot/commit/b09ee8050b1a4f5c2335dd7d686ed3873c0a177a)

<details>
<summary>Files Modified</summary>

  - `vector_store.py` (+6 -1)

</details>


#### 2025-07-18

### [3b89f9c] Fix OpenAI library compatibility with Python 3.13
- **Date**: 2025-07-18 23:27:48 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 6 files changed (+163 -179)
- **Commit**: [`3b89f9c`](https://github.com/auldsyababua/markdown-brain-bot/commit/3b89f9c2e6d816d02f641f8f5d518493c3a544f3)

<details>
<summary>Files Modified</summary>

  - `.gitignore` (+3)
  - `Procfile` (-1)
  - `main.py` (+9 -148)
  - *...and 3 more files*

</details>

### [740ad5a] Sanitize repository - remove all company-specific references
- **Date**: 2025-07-18 20:41:20 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 7 files changed (+20 -139)
- **Commit**: [`740ad5a`](https://github.com/auldsyababua/markdown-brain-bot/commit/740ad5ad743cc117134fa91a7dff9543f906b6b9)

<details>
<summary>Files Modified</summary>

  - `.env.example` (+2 -1)
  - `FUTURE_FEATURES.md` (-120)
  - `README.md` (+5 -5)
  - *...and 4 more files*

</details>

### [30963ce] Remove sensitive HANDOFF_DOC.md from repository
- **Date**: 2025-07-18 20:27:06 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 2 files changed (+6 -267)
- **Commit**: [`30963ce`](https://github.com/auldsyababua/markdown-brain-bot/commit/30963ce60bd5d1f0e93a7dceb9187d8635cd9f81)

<details>
<summary>Files Modified</summary>

  - `.gitignore` (+6)
  - `HANDOFF_DOC.md` (-267)

</details>

### [31fd0aa] Add Procfile and start script for Render deployment
- **Date**: 2025-07-18 20:21:31 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 3 files changed (+13 -1)
- **Commit**: [`31fd0aa`](https://github.com/auldsyababua/markdown-brain-bot/commit/31fd0aaac378af900b0a3da7aa57f70e1963fcae)

<details>
<summary>Files Modified</summary>

  - `Procfile` (+1)
  - `render.yaml` (+1 -1)
  - `start.py` (+11)

</details>

### [7bb46f8] Fix Render deployment configuration
- **Date**: 2025-07-18 18:50:21 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 2 files changed (+2 -2)
- **Commit**: [`7bb46f8`](https://github.com/auldsyababua/markdown-brain-bot/commit/7bb46f873222f579450bcf6dde272aef12b91c16)

<details>
<summary>Files Modified</summary>

  - `render.yaml` (+1 -1)
  - `requirements.txt` (+1 -1)

</details>

### [057809e] Configure for Render deployment with Redis/Vector integration
- **Date**: 2025-07-18 18:46:35 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 3 files changed (+79 -42)
- **Commit**: [`057809e`](https://github.com/auldsyababua/markdown-brain-bot/commit/057809e94b112b590db814c9bca5eacc24694d57)

<details>
<summary>Files Modified</summary>

  - `.env.example` (+12)
  - `README.md` (+53 -38)
  - `render.yaml` (+14 -4)

</details>

### [688e0f4] Merge pull request #1 from auldsyababua/prompt-optimization
- **Date**: 2025-07-18 18:43:45 PST  
- **Author**: Colin Aulds
- **Status**: 🟢 PR merge
- **Changes**: 20 files changed (+2564 -301)
- **Commit**: [`688e0f4`](https://github.com/auldsyababua/markdown-brain-bot/commit/688e0f481424212a1c2bff230f9d669e4e9725ce)

<details>
<summary>Files Modified</summary>

  - `.env.example` (+16 -3)
  - `.gitignore` (+19 -1)
  - `FUTURE_FEATURES.md` (+120)
  - *...and 17 more files*

</details>

### [45ce925] Fix code formatting and linting issues
- **Date**: 2025-07-18 18:43:17 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 12 files changed (+1209 -158)
- **Commit**: [`45ce925`](https://github.com/auldsyababua/markdown-brain-bot/commit/45ce92524ad88cc99f6db9e6154305173607a11d)

<details>
<summary>Files Modified</summary>

  - `.gitignore` (+8 -1)
  - `FUTURE_FEATURES.md` (+120)
  - `HANDOFF_DOC.md` (+267)
  - *...and 9 more files*

</details>

### [5bc9564] Add context awareness to system prompt for organizational hierarchy
- **Date**: 2025-07-18 17:20:46 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 2 files changed (+520)
- **Commit**: [`5bc9564`](https://github.com/auldsyababua/markdown-brain-bot/commit/5bc956410624fe53b26d334a8cffd704138a6410)

<details>
<summary>Files Modified</summary>

  - `tests/test_context_awareness.py` (+235)
  - `tests/test_search_resilience.py` (+285)

</details>

### [24e587c] Improve prompt and search resilience for file-based queries
- **Date**: 2025-07-18 17:10:29 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 15 files changed (+991 -299)
- **Commit**: [`24e587c`](https://github.com/auldsyababua/markdown-brain-bot/commit/24e587cb788d4a410549686890e2d71e0329b062)

<details>
<summary>Files Modified</summary>

  - `.env.example` (+16 -3)
  - `.gitignore` (+12 -1)
  - `README.md` (+15)
  - *...and 12 more files*

</details>

### [bc06a4f] Fix requirements.txt (remove pydantic version constraint) and ensure notes folder is gitignored
- **Date**: 2025-07-18 14:48:20 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 1 files changed (+1 -2)
- **Commit**: [`bc06a4f`](https://github.com/auldsyababua/markdown-brain-bot/commit/bc06a4f91a3caf4b665c727276e37178354bf08f)

<details>
<summary>Files Modified</summary>

  - `requirements.txt` (+1 -2)

</details>

### [0eedd40] Exclude notes folder from git (keep only index.md)
- **Date**: 2025-07-18 14:46:25 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 1 files changed (+3 -2)
- **Commit**: [`0eedd40`](https://github.com/auldsyababua/markdown-brain-bot/commit/0eedd40ca945986755ca3ac7c3167e1f0620f440)

<details>
<summary>Files Modified</summary>

  - `.gitignore` (+3 -2)

</details>

### [eb3eaf7] Add .env.example and render.yaml for deployment
- **Date**: 2025-07-18 14:39:14 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 2 files changed (+22)
- **Commit**: [`eb3eaf7`](https://github.com/auldsyababua/markdown-brain-bot/commit/eb3eaf75bb942f6983ecf26f1cc246c7d0c1643c)

<details>
<summary>Files Modified</summary>

  - `.env.example` (+5)
  - `render.yaml` (+17)

</details>

### [481f3d2] Initial commit: Markdown Brain Bot v1 MVP
- **Date**: 2025-07-18 14:33:37 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 8 files changed (+946)
- **Commit**: [`481f3d2`](https://github.com/auldsyababua/markdown-brain-bot/commit/481f3d2e59c0dccdcbafd0903a93144c7e4cdd8d)

<details>
<summary>Files Modified</summary>

  - `.gitignore` (+62)
  - `README.md` (+168)
  - `config.py` (+28)
  - *...and 5 more files*

</details>


</details>

---

<a name="gpt_parser_only"></a>
### 🧠 gpt-parser Repository Only

<details>
<summary>Click to expand 46 commits from gpt-parser</summary>


#### 2025-07-16

### [4a6d314] feat: Telegram Mini App Phase 1 - Environment & Dependencies Setup
- **Date**: 2025-07-16 00:26:44 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 47 files changed (+7966 -52)
- **Commit**: [`4a6d314`](https://github.com/auldsyababua/gpt-parser/commit/4a6d31421914bdee5b04582e97110af82a30789a)

<details>
<summary>Files Modified</summary>

  - `development-phases/telegram-miniapp-integration-prp.md` (+792)
  - `docs/handoff-miniapp-integration.md` (+160)
  - `integrations/telegram/bot.py` (+125 -35)
  - *...and 44 more files*

</details>


#### 2025-07-15

### [18e079b] Add detailed logging for Supabase task creation debugging
- **Date**: 2025-07-15 18:19:54 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 1 files changed (+12 -1)
- **Commit**: [`18e079b`](https://github.com/auldsyababua/gpt-parser/commit/18e079b574615d9407ae351c197d74751d8cfeeb)

<details>
<summary>Files Modified</summary>

  - `integrations/telegram/bot.py` (+12 -1)

</details>

### [ef1e5a6] Improve user lookup to handle real Telegram IDs
- **Date**: 2025-07-15 18:07:45 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 2 files changed (+38 -7)
- **Commit**: [`ef1e5a6`](https://github.com/auldsyababua/gpt-parser/commit/ef1e5a66366635d0f17dcded3c1431e93c0b3169)

<details>
<summary>Files Modified</summary>

  - `integrations/supabase/user_manager.py` (+1)
  - `integrations/telegram/bot.py` (+37 -7)

</details>

### [2221e01] Fix timezone conversion error with zoneinfo
- **Date**: 2025-07-15 17:55:17 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 1 files changed (+2 -2)
- **Commit**: [`2221e01`](https://github.com/auldsyababua/gpt-parser/commit/2221e011172f8cbe64da7954e59e10d93e38b4ec)

<details>
<summary>Files Modified</summary>

  - `utils/timezone_converter.py` (+2 -2)

</details>

### [c671b24] Add Supabase integration with dual-system support
- **Date**: 2025-07-15 17:40:43 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 9 files changed (+1048 -114)
- **Commit**: [`c671b24`](https://github.com/auldsyababua/gpt-parser/commit/c671b242c513461def84019d0aa386cc180deaf3)

<details>
<summary>Files Modified</summary>

  - `.gitignore` (+4)
  - `database/schema.sql` (+160)
  - `database/seed_data.sql` (+24)
  - *...and 6 more files*

</details>


#### 2025-07-12

### [c9dc577] Merge pull request #11 from auldsyababua/add-telegram-buttons
- **Date**: 2025-07-12 15:06:37 PST  
- **Author**: Colin Aulds
- **Status**: 🟢 PR merge
- **Changes**: 55 files changed (+1310 -287)
- **Commit**: [`c9dc577`](https://github.com/auldsyababua/gpt-parser/commit/c9dc5772f09a0d42367dea87307a1481ff57cf5f)

<details>
<summary>Files Modified</summary>

  - `.gitignore` (+1)
  - `cli/__init__.py` (+1 -1)
  - `cli/run_bot.py` (+43 -2)
  - *...and 52 more files*

</details>

### [84f6dd3] fix: timezone parsing and user identification issues
- **Date**: 2025-07-12 15:02:50 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Bug fix
- **Changes**: 25 files changed (+997 -156)
- **Commit**: [`84f6dd3`](https://github.com/auldsyababua/gpt-parser/commit/84f6dd306a18ec4c6b077cf01102acdb1aa1313e)

<details>
<summary>Files Modified</summary>

  - `.gitignore` (+1)
  - `cli/__init__.py` (+1 -1)
  - `cli/run_bot.py` (+43 -2)
  - *...and 22 more files*

</details>


#### 2025-07-11

### [9a2f0eb] feat: add telegram bot buttons with task completion and undo
- **Date**: 2025-07-11 23:40:45 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 1 files changed (+321 -22)
- **Commit**: [`9a2f0eb`](https://github.com/auldsyababua/gpt-parser/commit/9a2f0ebf6b932e221f60c059d6411a94e6802a02)

<details>
<summary>Files Modified</summary>

  - `integrations/telegram/bot.py` (+321 -22)

</details>

### [16287b9] docs: complete temporal expression implementation and reorganize development phases
- **Date**: 2025-07-11 22:48:13 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Documentation
- **Changes**: 33 files changed (+30 -147)
- **Commit**: [`16287b9`](https://github.com/auldsyababua/gpt-parser/commit/16287b9424ed0a80c01fccbe8a8a14bc56dbeee4)

<details>
<summary>Files Modified</summary>

  - `{scratch => development-phases}/1-database-backend/README.md` (no changes)
  - `{scratch => development-phases}/1-database-backend/database.py` (no changes)
  - `{scratch => development-phases}/1-database-backend/generate_test_data.py` (no changes)
  - *...and 30 more files*

</details>

### [438b01a] Merge pull request #10 from auldsyababua/reorganize-for-llm-navigation
- **Date**: 2025-07-11 21:54:57 PST  
- **Author**: Colin Aulds
- **Status**: 🟢 PR merge
- **Changes**: 33 files changed (+205 -20)
- **Commit**: [`438b01a`](https://github.com/auldsyababua/gpt-parser/commit/438b01ade8273b6d891f3c52e25436f252efb054)

<details>
<summary>Files Modified</summary>

  - `.claude/commands/cleanup.md` (+28)
  - `MIGRATION.md` (+90)
  - `cli/__init__.py` (+3)
  - *...and 30 more files*

</details>

### [988fdf8] refactor: reorganize repository structure for better code organization
- **Date**: 2025-07-11 21:35:18 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Refactor
- **Changes**: 33 files changed (+205 -20)
- **Commit**: [`988fdf8`](https://github.com/auldsyababua/gpt-parser/commit/988fdf8749d727a803c021a1a12ea508b5e386e4)

<details>
<summary>Files Modified</summary>

  - `.claude/commands/cleanup.md` (+28)
  - `MIGRATION.md` (+90)
  - `cli/__init__.py` (+3)
  - *...and 30 more files*

</details>

### [d29cf53] Merge pull request #9 from auldsyababua/implement-temporal-preprocessor
- **Date**: 2025-07-11 19:00:14 PST  
- **Author**: Colin Aulds
- **Status**: 🟢 PR merge
- **Changes**: 54 files changed (+12252 -228)
- **Commit**: [`d29cf53`](https://github.com/auldsyababua/gpt-parser/commit/d29cf53bcffb3383bafd0efbe6eccc9ba4897722)

<details>
<summary>Files Modified</summary>

  - `docs/future_features.md` (+43)
  - `github-issues/phase-3-database-backend.md` (+38)
  - `prompts/system_prompt.txt` (+9 -1)
  - *...and 51 more files*

</details>

### [7cdb8a2] refactor: clean up repository structure and organize test files
- **Date**: 2025-07-11 18:58:19 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Refactor
- **Changes**: 51 files changed (+11002 -73)
- **Commit**: [`7cdb8a2`](https://github.com/auldsyababua/gpt-parser/commit/7cdb8a2d18d6b9778140d9c128e1a2050c34b414)

<details>
<summary>Files Modified</summary>

  - `docs/future_features.md` (+43)
  - `scratch/1-database-backend/README.md` (+231)
  - `scratch/1-database-backend/database.py` (+134)
  - *...and 48 more files*

</details>

### [21b206a] fix: resolve telegram bot startup and environment variable caching issues
- **Date**: 2025-07-11 18:54:38 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Bug fix
- **Changes**: 5 files changed (+393 -102)
- **Commit**: [`21b206a`](https://github.com/auldsyababua/gpt-parser/commit/21b206a664dcafd3da3252f8832b76e7c6ac409d)

<details>
<summary>Files Modified</summary>

  - `prompts/system_prompt.txt` (+1 -1)
  - `scratch/timezone_demo.py` (-67)
  - `scripts/assistants_api_runner.py` (+3 -3)
  - *...and 2 more files*

</details>

### [0290afa] feat: switch to gpt-4o-mini model and add BERT parsing to Phase 3
- **Date**: 2025-07-11 12:45:51 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 10 files changed (+631 -482)
- **Commit**: [`0290afa`](https://github.com/auldsyababua/gpt-parser/commit/0290afa247943e0cdc4731bb1470fe1b24213cad)

<details>
<summary>Files Modified</summary>

  - `github-issues/phase-3-database-backend.md` (+38)
  - `scripts/assistants_api_runner.py` (+40 -34)
  - `scripts/telegram_bot.py` (+10 -8)
  - *...and 7 more files*

</details>

### [a194829] feat: implement temporal preprocessing with dateparser
- **Date**: 2025-07-11 09:28:37 PST  
- **Author**: User
- **Status**: 🟢 Feature
- **Changes**: 5 files changed (+662 -7)
- **Commit**: [`a194829`](https://github.com/auldsyababua/gpt-parser/commit/a194829440358f919104dd36c02648be25a50c61)

<details>
<summary>Files Modified</summary>

  - `prompts/system_prompt.txt` (+8)
  - `scripts/assistants_api_runner.py` (+51 -7)
  - `tests/test_temporal_performance.py` (+96)
  - *...and 2 more files*

</details>


#### 2025-07-10

### [5c99687] Merge pull request #8 from auldsyababua/improve-system-prompts
- **Date**: 2025-07-10 18:55:38 PST  
- **Author**: Colin Aulds
- **Status**: 🟢 PR merge
- **Changes**: 21 files changed (+915 -523)
- **Commit**: [`5c99687`](https://github.com/auldsyababua/gpt-parser/commit/5c99687cbcc1eb5b74bb46407e5cec0b812cc87f)

<details>
<summary>Files Modified</summary>

  - `.gitignore` (+3)
  - `github-issues/Better Parsing Options.md` (-255)
  - `github-issues/Normalize Task & Reminder Model (SQL).md` (-45)
  - *...and 18 more files*

</details>

### [d5bd256] fix: telegram bot hanging issue and implement timezone support
- **Date**: 2025-07-10 18:54:07 PST  
- **Author**: User
- **Status**: 🟢 Bug fix
- **Changes**: 14 files changed (+66 -720)
- **Commit**: [`d5bd256`](https://github.com/auldsyababua/gpt-parser/commit/d5bd256bd8d2c6618c4279d03b1ffe4eded6ad1e)

<details>
<summary>Files Modified</summary>

  - `.gitignore` (+3)
  - `github-issues/Better Parsing Options.md` (-255)
  - `github-issues/Gmail Notifications.md` (-51)
  - *...and 11 more files*

</details>

### [4554629] feat: implement comprehensive timezone support for multi-user task assignment
- **Date**: 2025-07-10 17:34:21 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 17 files changed (+814 -581)
- **Commit**: [`4554629`](https://github.com/auldsyababua/gpt-parser/commit/4554629d0c4d2347bf9486d4f115dce575603ef8)

<details>
<summary>Files Modified</summary>

  - `github-issues/Temporal Expression Consistency.md` (+46 -1)
  - `prompts/combined_system_prompt.txt` (-90)
  - `prompts/few_shot_examples.txt` (+29 -4)
  - *...and 14 more files*

</details>

### [8c82af5] Merge remote-tracking branch 'origin/main' into improve-system-prompts
- **Date**: 2025-07-10 15:06:16 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 PR merge
- **Changes**: 10 files changed (+491 -87)
- **Commit**: [`8c82af5`](https://github.com/auldsyababua/gpt-parser/commit/8c82af51bb9e93710ba45122a70da564bb4f7de1)

<details>
<summary>Files Modified</summary>

  - `config/timezone_config.py` (+45)
  - `schema/task_schema.json` (+11 -1)
  - `scratch/README.md` (+11)
  - *...and 7 more files*

</details>

### [58ab3e3] Merge pull request #7 from auldsyababua/timezone-adjustment
- **Date**: 2025-07-10 15:05:46 PST  
- **Author**: Colin Aulds
- **Status**: 🟢 PR merge
- **Changes**: 10 files changed (+491 -87)
- **Commit**: [`58ab3e3`](https://github.com/auldsyababua/gpt-parser/commit/58ab3e346d8bcdf4bee7f8bbee62e9cc1630421a)

<details>
<summary>Files Modified</summary>

  - `config/timezone_config.py` (+45)
  - `schema/task_schema.json` (+11 -1)
  - `scratch/README.md` (+11)
  - *...and 7 more files*

</details>

### [e3d1cc7] feat: create simplified assistant with combined prompt
- **Date**: 2025-07-10 15:02:28 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 3 files changed (+471)
- **Commit**: [`e3d1cc7`](https://github.com/auldsyababua/gpt-parser/commit/e3d1cc7bcd110dddd9f29610b948a209a62c8ef6)

<details>
<summary>Files Modified</summary>

  - `prompts/combined_system_prompt.txt` (+90)
  - `scratch/compare_approaches.md` (+46)
  - `scripts/assistants_api_runner_simple.py` (+335)

</details>

### [908f645] feat: add clarification handling examples and issue
- **Date**: 2025-07-10 14:56:19 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 2 files changed (+113)
- **Commit**: [`908f645`](https://github.com/auldsyababua/gpt-parser/commit/908f64538fcd16e707e5c25567bd95c6cb3be3a5)

<details>
<summary>Files Modified</summary>

  - `github-issues/Improved Clarification Handling.md` (+83)
  - `prompts/few_shot_examples.txt` (+30)

</details>

### [3c80ad4] feat: improve prompts for explicit timezone handling
- **Date**: 2025-07-10 14:50:10 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 7 files changed (+230 -1)
- **Commit**: [`3c80ad4`](https://github.com/auldsyababua/gpt-parser/commit/3c80ad4e97c50011524229d5c79485972950cef1)

<details>
<summary>Files Modified</summary>

  - `github-issues/Gmail Notifications.md` (+51)
  - `github-issues/SMS Notifications.md` (+54)
  - `github-issues/Telegram Notifications.md` (+55)
  - *...and 4 more files*

</details>

### [130aebc] fix: resolve linting issues
- **Date**: 2025-07-10 14:35:17 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Bug fix
- **Changes**: 8 files changed (+208 -165)
- **Commit**: [`130aebc`](https://github.com/auldsyababua/gpt-parser/commit/130aebc81a1f4e594b84531d40e47efc2ea244ad)

<details>
<summary>Files Modified</summary>

  - `config/timezone_config.py` (+10 -8)
  - `scratch/timezone_demo.py` (+26 -19)
  - `scripts/assistants_api_runner.py` (+29 -25)
  - *...and 5 more files*

</details>

### [401a59f] feat: add timezone support for multi-user task assignment
- **Date**: 2025-07-10 14:34:18 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 7 files changed (+368 -7)
- **Commit**: [`401a59f`](https://github.com/auldsyababua/gpt-parser/commit/401a59f1bf9e27d0918c614e11ab1f38d25f5845)

<details>
<summary>Files Modified</summary>

  - `config/timezone_config.py` (+43)
  - `schema/task_schema.json` (+11 -1)
  - `scratch/README.md` (+11)
  - *...and 4 more files*

</details>

### [b27f566] Merge pull request #6 from auldsyababua/feature/user-confirmation
- **Date**: 2025-07-10 01:08:28 PST  
- **Author**: Colin Aulds
- **Status**: 🟢 PR merge
- **Changes**: 8 files changed (+1306)
- **Commit**: [`b27f566`](https://github.com/auldsyababua/gpt-parser/commit/b27f5667293cf4e08f79239a7e9700968abab1cd)

<details>
<summary>Files Modified</summary>

  - `ROADMAP.md` (+289)
  - `USER-STORIES.md` (+94)
  - `VISION.md` (+126)
  - *...and 5 more files*

</details>

### [812327e] docs: add comprehensive project vision and roadmap
- **Date**: 2025-07-10 00:56:09 PST  
- **Author**: User
- **Status**: 🟢 Feature
- **Changes**: 8 files changed (+1306)
- **Commit**: [`812327e`](https://github.com/auldsyababua/gpt-parser/commit/812327e0c8e65c8601962ff591411f7cd109cff8)

<details>
<summary>Files Modified</summary>

  - `ROADMAP.md` (+289)
  - `USER-STORIES.md` (+94)
  - `VISION.md` (+126)
  - *...and 5 more files*

</details>

### [7e72c9f] Merge pull request #5 from auldsyababua/feature/user-confirmation
- **Date**: 2025-07-10 00:15:17 PST  
- **Author**: Colin Aulds
- **Status**: 🟢 PR merge
- **Changes**: 4 files changed (+198 -23)
- **Commit**: [`7e72c9f`](https://github.com/auldsyababua/gpt-parser/commit/7e72c9f57d232001c2a1d61aff050a88b7d6720e)

<details>
<summary>Files Modified</summary>

  - `scripts/assistants_api_runner.py` (+73 -11)
  - `scripts/run_bot_with_monitoring.py` (+13 -1)
  - `scripts/stream_all_logs.sh` (+7)
  - *...and 1 more files*

</details>

### [0456c8b] fix: ensure bot uses virtual environment when running
- **Date**: 2025-07-10 00:13:31 PST  
- **Author**: User
- **Status**: 🟢 Bug fix
- **Changes**: 2 files changed (+20 -1)
- **Commit**: [`0456c8b`](https://github.com/auldsyababua/gpt-parser/commit/0456c8b67548efec134143321a5821ced821203a)

<details>
<summary>Files Modified</summary>

  - `scripts/run_bot_with_monitoring.py` (+13 -1)
  - `scripts/stream_all_logs.sh` (+7)

</details>


#### 2025-07-09

### [bd03f54] feat: add user confirmation flow to task parsing
- **Date**: 2025-07-09 23:31:39 PST  
- **Author**: User
- **Status**: 🟢 Feature
- **Changes**: 2 files changed (+178 -22)
- **Commit**: [`bd03f54`](https://github.com/auldsyababua/gpt-parser/commit/bd03f549dbdbaa0d34b13fefb0374e27bce46115)

<details>
<summary>Files Modified</summary>

  - `scripts/assistants_api_runner.py` (+73 -11)
  - `scripts/telegram_bot.py` (+105 -11)

</details>

### [6ff4729] Merge pull request #4 from auldsyababua/fix-debugging-add-logs-to-tg-bot
- **Date**: 2025-07-09 19:02:02 PST  
- **Author**: Colin Aulds
- **Status**: 🟢 PR merge
- **Changes**: 8 files changed (+647 -4)
- **Commit**: [`6ff4729`](https://github.com/auldsyababua/gpt-parser/commit/6ff47297496a735a936f8e737ee2f0024f785673)

<details>
<summary>Files Modified</summary>

  - `github-issues/Better Parsing Options.md` (+255)
  - `github-issues/Temporal Expression Consistency.md` (+102)
  - `scripts/assistants_api_runner.py` (+4)
  - *...and 5 more files*

</details>

### [6854ba4] docs: add temporal expression parsing and task perspective normalization notes
- **Date**: 2025-07-09 19:00:47 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 2 files changed (+144 -1)
- **Commit**: [`6854ba4`](https://github.com/auldsyababua/gpt-parser/commit/6854ba429f49d822ccef0c0b8c5d8f497132b9ba)

<details>
<summary>Files Modified</summary>

  - `github-issues/Better Parsing Options.md` (+42 -1)
  - `github-issues/Temporal Expression Consistency.md` (+102)

</details>

### [4d6023c] fix: remove unused import and apply black formatting
- **Date**: 2025-07-09 18:55:02 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Bug fix
- **Changes**: 2 files changed (+91 -39)
- **Commit**: [`4d6023c`](https://github.com/auldsyababua/gpt-parser/commit/4d6023c96cc6c2efcec981a27aed3e65efedf7ea)

<details>
<summary>Files Modified</summary>

  - `github-issues/Better Parsing Options.md` (+68 -22)
  - `scripts/run_bot_with_monitoring.py` (+23 -17)

</details>

### [aa65e11] feat: add process monitoring and enhanced logging
- **Date**: 2025-07-09 18:49:39 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Feature
- **Changes**: 4 files changed (+366)
- **Commit**: [`aa65e11`](https://github.com/auldsyababua/gpt-parser/commit/aa65e11aa47daa09af91c3151b5ef8449942c941)

<details>
<summary>Files Modified</summary>

  - `github-issues/Better Parsing Options.md` (+168)
  - `scripts/run_bot_with_monitoring.py` (+82)
  - `scripts/stream_all_logs.sh` (+59)
  - *...and 1 more files*

</details>

### [423093b] fix: resolve linting issues in monitor.py
- **Date**: 2025-07-09 18:16:29 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Bug fix
- **Changes**: 1 files changed (+19 -12)
- **Commit**: [`423093b`](https://github.com/auldsyababua/gpt-parser/commit/423093bf92efe66bece986dff2a6aa38f2870c6f)

<details>
<summary>Files Modified</summary>

  - `scripts/monitor.py` (+19 -12)

</details>

### [71f6d6e] CHECKPOINT: Working bot with debugging - before linting fixes
- **Date**: 2025-07-09 18:10:42 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 3 files changed (+79 -4)
- **Commit**: [`71f6d6e`](https://github.com/auldsyababua/gpt-parser/commit/71f6d6e1969c4e890b250dd22904cd35556b1601)

<details>
<summary>Files Modified</summary>

  - `scripts/assistants_api_runner.py` (+4)
  - `scripts/monitor.py` (+50)
  - `scripts/telegram_bot.py` (+25 -4)

</details>

### [f709a42] Merge pull request #3 from auldsyababua/feature/telegram-bot
- **Date**: 2025-07-09 17:44:55 PST  
- **Author**: Colin Aulds
- **Status**: 🟢 PR merge
- **Changes**: 5 files changed (+253 -53)
- **Commit**: [`f709a42`](https://github.com/auldsyababua/gpt-parser/commit/f709a42d9e7fae18ef53f8f21123634ce0276c40)

<details>
<summary>Files Modified</summary>

  - `.gitignore` (+24)
  - `requirements.txt` (+2 -1)
  - `scripts/assistants_api_runner.py` (+101 -43)
  - *...and 2 more files*

</details>

### [5bd9362] telegram bot receiving messages and responding successfully
- **Date**: 2025-07-09 17:43:33 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 5 files changed (+253 -53)
- **Commit**: [`5bd9362`](https://github.com/auldsyababua/gpt-parser/commit/5bd936265cc865a955a2e10dd94cc145566f12ab)

<details>
<summary>Files Modified</summary>

  - `.gitignore` (+24)
  - `requirements.txt` (+2 -1)
  - `scripts/assistants_api_runner.py` (+101 -43)
  - *...and 2 more files*

</details>

### [0671308] Merge pull request #2 from auldsyababua/feature/assistants-api-runner
- **Date**: 2025-07-09 15:46:05 PST  
- **Author**: Colin Aulds
- **Status**: 🟢 PR merge
- **Changes**: 4 files changed (+270 -18)
- **Commit**: [`0671308`](https://github.com/auldsyababua/gpt-parser/commit/067130864438037104e4c2b4e8a68141c8885684)

<details>
<summary>Files Modified</summary>

  - `.gitignore` (+3)
  - `requirements.txt` (+3)
  - `scripts/assistants_api_runner.py` (+246)
  - *...and 1 more files*

</details>

### [3e11de9] build: ignore log files
- **Date**: 2025-07-09 15:45:00 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 1 files changed (+3)
- **Commit**: [`3e11de9`](https://github.com/auldsyababua/gpt-parser/commit/3e11de94db0461cfe0fe2873d3378ae50ff55f46)

<details>
<summary>Files Modified</summary>

  - `.gitignore` (+3)

</details>

### [65fa3c0] working assistant API - OpenAI
- **Date**: 2025-07-09 15:41:48 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 3 files changed (+267 -18)
- **Commit**: [`65fa3c0`](https://github.com/auldsyababua/gpt-parser/commit/65fa3c07ac18d0e4c3d07dcf31fceadba1e72c31)

<details>
<summary>Files Modified</summary>

  - `requirements.txt` (+3)
  - `scripts/assistants_api_runner.py` (+246)
  - `tests/inputs.txt` (+18 -18)

</details>

### [44343eb] Merge pull request #1 from auldsyababua/customgpt
- **Date**: 2025-07-09 13:56:44 PST  
- **Author**: Colin Aulds
- **Status**: 🟢 PR merge
- **Changes**: 10 files changed (+399 -2)
- **Commit**: [`44343eb`](https://github.com/auldsyababua/gpt-parser/commit/44343eb8a7b0106434467af72f5684746b79aeea)

<details>
<summary>Files Modified</summary>

  - `.DS_Store` (no changes)
  - `.gitignore` (+43)
  - `docs/FLOW.md` (+79)
  - *...and 7 more files*

</details>

### [a77d482] modify code.gs
- **Date**: 2025-07-09 13:55:58 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 2 files changed (+82)
- **Commit**: [`a77d482`](https://github.com/auldsyababua/gpt-parser/commit/a77d4825fd7ccafd85e6f6138dfdce9de2348e59)

<details>
<summary>Files Modified</summary>

  - `.gitignore` (+43)
  - `scripts/code.gs` (+39)

</details>

### [7f723b3] updated prompts
- **Date**: 2025-07-09 12:43:48 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 8 files changed (+317 -2)
- **Commit**: [`7f723b3`](https://github.com/auldsyababua/gpt-parser/commit/7f723b3211730b4d16bc78c37b981e2e622c54a8)

<details>
<summary>Files Modified</summary>

  - `.DS_Store` (no changes)
  - `docs/FLOW.md` (+79)
  - `github-issues/Normalize Task & Reminder Model (SQL).md` (+45)
  - *...and 5 more files*

</details>

### [ac7d4f7] init
- **Date**: 2025-07-09 11:37:59 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 11 files changed (+301)
- **Commit**: [`ac7d4f7`](https://github.com/auldsyababua/gpt-parser/commit/ac7d4f7c746a2a9b1e57e98b0322e7ce44c2555b)

<details>
<summary>Files Modified</summary>

  - `.github/workflows/validate-gpt-output.yml` (no changes)
  - `.gitignore` (no changes)
  - `README.md` (no changes)
  - *...and 8 more files*

</details>


</details>

---

<a name="bbui_only"></a>
### 🎨 bbui Repository Only

<details>
<summary>Click to expand 1 commits from bbui</summary>


#### 2025-07-25

### [ce66357] Initial commit: BBUI Frontend for FLRTS System
- **Date**: 2025-07-25 15:22:45 PST  
- **Author**: MacDaddyScripts
- **Status**: 🟢 Update
- **Changes**: 128 files changed (+27403)
- **Commit**: [`ce66357`](https://github.com/auldsyababua/bbui/commit/ce66357733310e5cbffcf6d48b5bcad4fa493db8)

<details>
<summary>Files Modified</summary>

  - `.env.example` (+11)
  - `.gitignore` (+65)
  - `ADMIN_DASHBOARD.md` (+128)
  - *...and 125 more files*

</details>


</details>

---

<a name="statistics"></a>
## 📊 Statistics

### Overall Summary

| Metric | Value |
|--------|-------|
| **Total Commits** | 102 |
| **Contributors** | 3 |
| **Files Changed** | 1,178 |
| **Lines Added** | +115,560 |
| **Lines Removed** | -12,459 |
| **Net Change** | +103,101 |
| **Development Period** | July 09-25, 2025 |
| **Active Repositories** | 3 |

<a name="repository-breakdown"></a>
### 📈 Repository Breakdown

| Repository | Commits | Contributors | Files Changed | Lines Changed |
|------------|---------|--------------|---------------|--------------|
| 🤖 **markdown-brain-bot** | 55 | 2 | 493 | +40,417 -8,316 |
| 🧠 **gpt-parser** | 46 | 3 | 557 | +47,740 -4,143 |
| 🎨 **bbui** | 1 | 1 | 128 | +27,403 -0 |


---

*This file is automatically generated from git history across all repositories.*  
*Use the navigation links at the top to filter by repository or jump to specific sections.*  
*Last updated: 2025-07-25 17:24:13 PST*
