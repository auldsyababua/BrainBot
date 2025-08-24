## Linear Issue ID: 10N-XXX
<!-- Replace XXX with actual Linear issue number -->

## Agent Plan
**Who:** <!-- Agent or developer name -->
**What:** <!-- Brief description of changes -->
**Why:** <!-- Business value or problem being solved -->

## Test Plan
- [ ] **Unit tests:** <!-- Describe unit test coverage -->
- [ ] **Integration tests:** <!-- Describe integration test coverage -->
- [ ] **E2E tests:** <!-- If applicable -->
- [ ] **Anti-mesa coverage:** <!-- Note any edge cases or defensive testing -->

## Sensitive Operations
**Contains sensitive operations?** <!-- Y/N -->
- **Workflow name:** <!-- If Y, specify workflow -->
- **Secret refs:** <!-- If Y, list secret references used -->

## Checklist
- [ ] Lint checks pass (`ruff` / `eslint`)
- [ ] Type checks pass (`mypy` / `tsc`)
- [ ] Tests pass with >85% coverage
- [ ] Documentation updated (if applicable)
- [ ] Linear issue linked in PR title (format: `10N-123: description`)
- [ ] Commits reference Linear issue (format: `10N-123`)
- [ ] No hardcoded secrets or credentials
- [ ] Agent-safe (no exposed credentials in logs/outputs)

## Screenshots/Recordings
<!-- If UI changes, add screenshots or recordings -->

## Breaking Changes
<!-- List any breaking changes and migration steps -->

## Dependencies
<!-- List any new dependencies added -->