# Claude Project Instructions

## Hooks System Active

This project has Claude Code Hooks installed, providing:
- Security validation and dangerous command blocking
- Comprehensive logging of all actions
- Text-to-speech notifications
- Specialized sub-agents for delegated tasks
- Custom commands in .claude/commands/

## Available Sub-Agents

You can delegate specialized tasks to agents in `.claude/agents/` directory:
- **Agent Location**: `.claude/agents/` 
- Use agents when their description matches your need
- Agents have specialized knowledge and focused tools
- Results are integrated back into our conversation
- Agents are project-agnostic and can be customized for your specific needs

**IMPORTANT**: Agents must have YAML frontmatter to be recognized:
```yaml
---
name: agent-name
description: When to use this agent (be specific for auto-delegation)
tools: Tool1, Tool2, Tool3  # Optional - inherits all if omitted
---

Your agent's system prompt goes here...
```

**Creating New Agents**: 
1. Use the meta-agent: "Create a new agent for [purpose]"
2. Or manually create `.md` files with proper YAML frontmatter in `.claude/agents/`

**Available Custom Agents** (all properly configured with YAML frontmatter):
- `repo-cleaner.md` - Repository cleanup and organization
- `database-specialist.md` - Database operations and queries
- `deployment-documentation-specialist.md` - Deployment guides and documentation
- `devops-engineer.md` - DevOps and infrastructure tasks
- `git-expert.md` - Git operations and workflows
- `memory-specialist.md` - Memory and storage optimization
- `performance-optimizer.md` - Performance analysis and optimization
- `qa-engineer.md` - Quality assurance and testing
- `smart-rails-enhancer.md` - Smart Rails system enhancements
- `telegram-bot-specialist.md` - Telegram bot development
- `test-automation-specialist.md` - Test automation and CI/CD
- `unit-test-writer.md` - Unit test creation and maintenance
- `meta-agent.md` - Creates new agents from descriptions
- And many more...

## Security Notes

- Dangerous commands (rm -rf, etc.) are blocked by default
- .env files are protected from access
- All actions are logged for audit purposes