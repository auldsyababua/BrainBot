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

**Creating New Agents**: Place `.md` files directly in `.claude/agents/` directory.

## Security Notes

- Dangerous commands (rm -rf, etc.) are blocked by default
- .env files are protected from access
- All actions are logged for audit purposes
