# Augment Configuration for FLRTS Project

This directory contains Augment AI assistant configuration files for the FLRTS BrainBot project. These files help maintain code quality, consistency, and adherence to the Smart Rails architecture.

## Files

### 📋 `rules.yml`
Automated rules that Augment applies during code generation and review:
- **Always Rules**: Applied to every interaction (Smart Rails, security, storage hierarchy)
- **Auto Rules**: Context-specific rules triggered by file patterns
- **Manual Rules**: Explicitly triggered rules for specific tasks
- **Anti-patterns**: Common mistakes to avoid

### 🏗️ `workspace.yml`
Project-specific configuration defining:
- Technology stack and frameworks
- Code conventions and style guides
- Performance targets and metrics
- Security policies
- Documentation requirements
- Development workflow

### 📖 `guidelines.md`
Natural language guidelines for developers:
- Core development principles
- Language-specific best practices
- Smart Rails implementation details
- FLRTS structure organization
- Performance optimization strategies
- Security requirements
- Common pitfalls to avoid

## How Augment Uses These Files

1. **During Code Generation**: Augment references these rules to ensure generated code follows project standards
2. **Code Review**: Automatically checks PRs against defined patterns and anti-patterns
3. **Suggestions**: Provides context-aware suggestions based on file location and task
4. **Documentation**: Generates documentation following project conventions

## Key Features for FLRTS

### Smart Rails Optimization
- Enforces 70% token reduction target
- Maintains confidence scoring integrity
- Preserves deterministic preprocessing

### Storage Layer Separation
- Prevents mixing of storage responsibilities
- Enforces proper use of Supabase, Redis, Vector, and Neo4j
- Maintains data consistency across layers

### Production Standards
- Webhook-based architecture for production
- Async-first development
- Comprehensive error handling and logging

## Updating Configuration

To update these configurations:

1. **Adding Rules**: Edit `rules.yml` and add to appropriate section
2. **Changing Conventions**: Update `workspace.yml` with new standards
3. **Guidelines**: Modify `guidelines.md` for developer instructions

After changes:
- Test with Augment locally
- Verify rules don't conflict
- Update team documentation

## Integration with Development Workflow

```bash
# Augment will automatically use these configs when:
augment generate   # Generating new code
augment review    # Reviewing PRs
augment suggest   # Providing suggestions
augment fix       # Fixing issues
```

## Best Practices

1. **Keep Rules Specific**: Avoid vague statements, be concrete
2. **Document Why**: Explain reasoning behind rules
3. **Update Regularly**: Keep configs in sync with project evolution
4. **Test Changes**: Verify rules work as expected
5. **Team Review**: Get team consensus on major changes

## Support

For questions about these configurations:
- Review main project README.md
- Check docs/smart-rails-architecture.md
- Consult team lead for clarification

---

Last Updated: 2025-01-12
Version: 1.0