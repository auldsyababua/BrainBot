# Story 2.4: Test File Naming Cleanup

**Priority:** HIGH
**Points:** 3
**Status:** Ready for Development

## User Story
As a developer, I need test files to have clean, professional names without temporary suffixes so the test suite appears well-organized and maintainable.

## Problem
8 test files have temporary suffixes (_refactored, _proper, _direct, _standalone) that indicate rushed or incomplete work, making the codebase appear unprofessional.

## Files to Rename
```bash
# Already modified and needs renaming
tests/unit/test_llm_refactored.py → test_llm.py
tests/unit/test_router_refactored.py → test_router.py

# Other temporary suffixes
tests/unit/test_dynamic_prompting_proper.py → test_dynamic_prompting.py
tests/unit/test_smart_rails_proper.py → test_smart_rails.py
tests/integration/test_smart_rails_integration_proper.py → test_smart_rails_integration.py
tests/unit/test_list_processor_direct.py → test_list_processor.py
tests/unit/test_task_processor_direct.py → test_task_processor.py
tests/test_dynamic_prompting_standalone.py → tests/unit/test_dynamic_prompting_standalone.py
```

## Implementation Tasks
1. Rename all test files to remove temporary suffixes
2. Update any imports or references to these test files
3. Move misplaced tests to appropriate directories
4. Verify all tests still run after renaming
5. Update test documentation if needed

## Acceptance Criteria
- [ ] No test files with temporary suffixes remain
- [ ] All tests in appropriate directories (unit/integration)
- [ ] All tests still pass after renaming
- [ ] No broken imports or references
- [ ] Test discovery works correctly

## Developer Notes
- Use git mv to preserve history
- Check for any hardcoded references in configuration files
- Ensure CI/CD pipeline still finds all tests
- Update any test documentation that references old names

### Status
Approved
