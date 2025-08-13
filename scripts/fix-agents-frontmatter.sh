#!/bin/bash
# Script to add YAML frontmatter to agents that are missing it

AGENTS_DIR="/Users/colinaulds/Desktop/projects/flrts/.claude/agents"

echo "Fixing agent frontmatter in $AGENTS_DIR"

# Function to add frontmatter to an agent file
add_frontmatter() {
    local file="$1"
    local basename=$(basename "$file" .md)
    
    # Check if file already has frontmatter
    if head -n 1 "$file" | grep -q "^---$"; then
        echo "✓ $basename already has frontmatter"
        return
    fi
    
    echo "Fixing $basename..."
    
    # Extract description from the file content
    local description=""
    case "$basename" in
        "database-specialist")
            description="Database operations specialist for SQL queries, schema design, and migrations. Use proactively for database-related tasks."
            tools="Read, Write, Edit, Bash, Grep"
            ;;
        "deployment-documentation-specialist")
            description="Deployment and documentation specialist. Use for creating deployment guides, documentation, and infrastructure setup."
            tools="Read, Write, Edit, Glob, Grep"
            ;;
        "devops-engineer")
            description="DevOps and infrastructure specialist. Use for CI/CD, containerization, and deployment automation."
            tools="Read, Write, Edit, Bash, Grep, Glob"
            ;;
        "git-expert")
            description="Git operations specialist. Use for complex git workflows, branch management, and repository operations."
            tools="Bash, Read, Grep, Glob"
            ;;
        "memory-specialist")
            description="Memory and performance optimization specialist. Use for memory management and optimization tasks."
            tools="Read, Edit, Bash, Grep"
            ;;
        "performance-optimizer")
            description="Performance analysis and optimization specialist. Use proactively when code needs performance improvements."
            tools="Read, Edit, Bash, Grep, Glob"
            ;;
        "qa-engineer")
            description="Quality assurance specialist. Use for test planning, test execution, and quality validation."
            tools="Read, Write, Edit, Bash, Grep, Glob"
            ;;
        "smart-rails-enhancer")
            description="Smart Rails system enhancement specialist. Use for Smart Rails feature development and improvements."
            tools="Read, Write, Edit, Bash, Grep"
            ;;
        "telegram-bot-specialist")
            description="Telegram bot development specialist. Use for Telegram bot features, webhooks, and integrations."
            tools="Read, Write, Edit, Bash, Grep"
            ;;
        "test-automation-specialist")
            description="Test automation specialist. Use proactively for creating and maintaining automated tests."
            tools="Read, Write, Edit, Bash, Grep"
            ;;
        "unit-test-writer")
            description="Unit test creation specialist. Use proactively after writing new code to create comprehensive unit tests."
            tools="Read, Write, Edit, Bash"
            ;;
        "unit-test-reviewer")
            description="Unit test review specialist. Use to review and improve existing unit tests."
            tools="Read, Edit, Grep, Glob"
            ;;
        "vector-database-specialist")
            description="Vector database and embedding specialist. Use for vector search, embeddings, and similarity operations."
            tools="Read, Write, Edit, Bash, Grep"
            ;;
        "neo4j-graph-specialist")
            description="Neo4j graph database specialist. Use for graph database operations and queries."
            tools="Read, Write, Edit, Bash"
            ;;
        "pdf-document-processor")
            description="PDF document processing specialist. Use for extracting and processing PDF content."
            tools="Read, Write, Bash, Grep"
            ;;
        "markdown-bot-tester")
            description="Markdown bot testing specialist. Use for testing markdown processing and bot functionality."
            tools="Read, Write, Edit, Bash"
            ;;
        "magic-patterns-researcher")
            description="Magic Patterns UI research specialist. Use for researching and implementing UI patterns."
            tools="Read, Write, WebFetch, Grep"
            ;;
        "llm-ai-agents-and-eng-research")
            description="AI and LLM research specialist. Use for researching AI models, agents, and engineering best practices."
            tools="Read, WebFetch, Write, Grep"
            ;;
        "meta-agent")
            description="Agent creation specialist. Use to create new custom agents from descriptions."
            tools="Write, WebFetch"
            ;;
        "work-completion-summary")
            description="Work summary specialist. Use at the end of sessions to create comprehensive work summaries."
            tools="Read, Grep, Glob, Write"
            ;;
        "ux-ui-designer")
            description="UX/UI design specialist. Use for interface design, user experience improvements, and frontend development."
            tools="Read, Write, Edit, Grep"
            ;;
        "render-deployment-specialist")
            description="Render.com deployment specialist. Use for Render platform deployments and configurations."
            tools="Read, Write, Edit, Bash"
            ;;
        "supabase-database-specialist")
            description="Supabase database specialist. Use for Supabase configurations, queries, and integrations."
            tools="Read, Write, Edit, Bash"
            ;;
        "telegram-integration-specialist")
            description="Telegram integration specialist. Use for Telegram API integrations and bot configurations."
            tools="Read, Write, Edit, Bash"
            ;;
        *)
            description="Specialist agent for $basename tasks. Use when appropriate."
            tools="Read, Write, Edit, Bash, Grep"
            ;;
    esac
    
    # Create temporary file with frontmatter
    temp_file=$(mktemp)
    
    cat > "$temp_file" <<EOF
---
name: $basename
description: $description
tools: $tools
---

EOF
    
    # Append original content
    cat "$file" >> "$temp_file"
    
    # Replace original file
    mv "$temp_file" "$file"
    echo "✓ Fixed $basename"
}

# Process all .md files in agents directory
for agent_file in "$AGENTS_DIR"/*.md; do
    if [ -f "$agent_file" ]; then
        add_frontmatter "$agent_file"
    fi
done

echo ""
echo "All agents have been checked and fixed!"
echo "Agents should now be properly recognized by Claude Code."