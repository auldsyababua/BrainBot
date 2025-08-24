# Required Checks for Branch Protection

Require the following checks on pull requests:

- Validate Pull Request (includes ruff/black/isort/mypy/pytest)
- GitGuardian Security Checks
- Semgrep Cloud Platform (semgrep-cloud-platform/scan)
- Run Tests (if defined as a separate job)

Notes:
- CodeQL (optional) should run on a weekly schedule and push to main only (not required per PR).
- Only one Semgrep provider should run per PR; if Semgrep Cloud is enabled, disable/remove local Semgrep OSS per-PR runs.

