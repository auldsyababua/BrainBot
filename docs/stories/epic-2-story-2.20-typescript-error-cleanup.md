# User Story: TypeScript Error Cleanup

**Story ID:** FLRTS-2024-001  
**Priority:** Medium  
**Points:** 3  
**Sprint:** Next Available

## Story
**As a** development team  
**I want** all TypeScript errors resolved in the telegram-mini-app  
**So that** we have type-safe code and can enable strict type checking in CI/CD

## Background
Following the Node.js v20 downgrade resolution, the frontend builds successfully but has 38 TypeScript errors that need cleanup. These don't block deployment but impact code quality and developer experience.

## Acceptance Criteria
- [ ] All 38 TypeScript errors are resolved
- [ ] `npm run typecheck` passes with zero errors
- [ ] No use of `@ts-ignore` or `any` type unless absolutely necessary
- [ ] All test files maintain proper typing
- [ ] CI/CD pipeline updated to fail on TypeScript errors

## Technical Details

### Current Error Categories
1. **Unused imports** (2 errors) - React imports not used
2. **Type mismatches** (15 errors) - Incorrect type assignments
3. **Telegram API typing** (8 errors) - Missing or incorrect Telegram WebApp types
4. **Test mocks** (13 errors) - Handler parameter types missing

### Files Requiring Updates
```
src/App.tsx
src/components/Common/NavigationTabs.tsx
src/components/Layout/AppContainer.tsx
src/components/Tasks/TaskCreator.tsx
src/components/Tasks/TaskList.tsx
src/config/api.ts
src/context/AppContext.tsx
src/index.tsx
src/services/brainbotApi.test.ts
src/tests/infrastructure.test.ts
src/tests/mocks/handlers.ts
src/tests/setup.ts
```

## Implementation Notes

### Priority Order
1. Fix Telegram WebApp type definitions (blocks multiple files)
2. Resolve test mock parameter types
3. Clean up unused imports
4. Fix remaining type mismatches

### Type Definition Updates Needed
```typescript
// Telegram WebApp types need proper definition
interface TelegramWebApp {
  ready: () => void;
  expand: () => void;
  close: () => void;
  initDataUnsafe: {
    user?: TelegramUser;
  };
  MainButton: {
    text: string;
    show: () => void;
    hide: () => void;
    onClick: (callback: () => void) => void;
  };
}
```

## Definition of Done
- [ ] All TypeScript errors resolved
- [ ] Code review completed
- [ ] Tests still passing (npm run test:run)
- [ ] Build succeeds (npm run build)
- [ ] TypeScript strict mode enabled in tsconfig.json
- [ ] Documentation updated if new types added

## Dependencies
- Node.js v20 LTS environment (completed)
- Current test suite passing (completed)

## Notes
- This is technical debt cleanup from the initial implementation
- Consider adding pre-commit hooks for TypeScript checking
- May discover additional type safety improvements during cleanup