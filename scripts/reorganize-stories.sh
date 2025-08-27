#!/bin/bash

# Story Reorganization Script for FLRTS Epic 2
# This script reorganizes story files according to priority phases

cd /Users/colinaulds/Desktop/projects/flrts/docs/stories

echo "📋 Starting Epic 2 Story Reorganization..."

# Archive older duplicate versions
echo "📦 Archiving duplicate/older versions..."
mv epic-2-story-2.13-redis-to-cloudflare-kv-migration.md archive/ 2>/dev/null

# Phase 1: Cleanup & Documentation (Priority 1)
echo "🧹 Phase 1: Cleanup & Documentation Stories..."
mv epic-2-story-2.1-cleanup-test-artifacts.md epic-2-story-2.1-cleanup-test-artifacts-KEEP.md
mv epic-2-story-2.12-cleanup-test-artifacts.md archive/epic-2-story-2.12-cleanup-test-artifacts-OLD.md
mv epic-2-story-2.1-cleanup-test-artifacts-KEEP.md epic-2-story-2.1-cleanup-test-artifacts.md

# Story 2.2 will be created (update-documentation)
mv epic-2-story-2.16-remove-aws-upstash-references.md epic-2-story-2.3-remove-aws-upstash.md
mv epic-2-story-2.18-remove-render-references.md epic-2-story-2.4-remove-render.md
mv epic-2-story-2.19-nodejs-nvm-configuration.md epic-2-story-2.5-nodejs-nvm-config.md

# Phase 2: Cloudflare Migration (Priority 2)
echo "☁️ Phase 2: Cloudflare Migration Stories..."
mv epic-2-story-2.6-redis-to-cloudflare-kv.md epic-2-story-2.6-redis-to-cloudflare-kv-KEEP.md
mv epic-2-story-2.14-vector-to-cloudflare-vectorize-migration.md epic-2-story-2.7-cloudflare-vectorize.md
mv epic-2-story-2.15-s3-to-cloudflare-r2-migration.md epic-2-story-2.8-cloudflare-r2.md
mv epic-2-story-2.17-render-to-cloudflare-containers-migration.md epic-2-story-2.9-cloudflare-containers.md
mv epic-2-story-2.6-redis-to-cloudflare-kv-KEEP.md epic-2-story-2.6-redis-to-cloudflare-kv.md

# Phase 3: Code Quality (Priority 3)
echo "⚡ Phase 3: Code Quality Stories..."
mv epic-2-story-2.0-remove-agent-contamination.md epic-2-story-2.10-remove-contamination.md
mv epic-2-story-2.1-decompose-process-message.md epic-2-story-2.11-decompose-process.md
mv epic-2-story-2.2-refactor-keyword-router.md epic-2-story-2.12-refactor-router.md
mv epic-2-story-2.3-rename-project.md epic-2-story-2.13-rename-project.md
mv epic-2-story-2.5-remove-manual-memory.md epic-2-story-2.14-remove-manual-memory.md
mv epic-2-story-2.6-externalize-configuration.md epic-2-story-2.15-externalize-config.md

# Phase 4: Final Polish (Priority 4)
echo "✨ Phase 4: Final Polish Stories..."
mv epic-2-story-2.4-test-file-cleanup.md epic-2-story-2.16-test-file-cleanup.md
mv epic-2-story-2.7-complete-todos.md epic-2-story-2.17-complete-todos.md
mv epic-2-story-2.8-standardize-http-codes.md epic-2-story-2.18-standardize-http-codes.md
mv epic-2-story-2.20-verify-github-actions.md epic-2-story-2.19-verify-github-actions.md
mv epic-2-story-2.21-typescript-error-cleanup.md epic-2-story-2.20-typescript-error-cleanup.md

# Archive redundant stories
echo "🗄️ Archiving redundant stories..."
mv epic-2-story-2.9-cloudflare-r2-migration.md archive/ 2>/dev/null
mv epic-2-story-2.11-cloudflare-containers-migration.md archive/ 2>/dev/null

echo "✅ Reorganization complete!"
echo ""
echo "📝 Next steps:"
echo "1. Create epic-2-story-2.2-update-documentation.md"
echo "2. Update all stories with Git/QA sections"
echo "3. Create README.md for story tracking"