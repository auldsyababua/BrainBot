# Testing Guide for Telegram Mini App

This document outlines the comprehensive testing infrastructure for the Telegram Mini App, including unit tests, integration tests, and performance testing strategies.

## Test Stack

- **Test Runner**: Vitest (aligned with Vite)
- **UI Testing**: React Testing Library
- **Environment**: jsdom for browser simulation
- **Mocking**: MSW (Mock Service Worker) for API mocking
- **Coverage**: v8 provider with detailed reporting

## Getting Started

### Install Dependencies

```bash
npm install
```

### Run Tests

```bash
# Run all tests once
npm run test:run

# Run tests in watch mode (development)
npm run test:watch

# Run tests with UI interface
npm run test:ui

# Generate coverage report
npm run test:coverage
```

## Test Structure

```
src/
├── tests/
│   ├── setup.ts                    # Global test setup
│   ├── test-utils.tsx              # Custom render utilities
│   ├── factories.ts                # Test data factories
│   ├── mocks/
│   │   ├── handlers.ts             # MSW API handlers
│   │   └── server.ts               # MSW server setup
│   └── integration/
│       └── task-flow.test.tsx      # Integration tests
├── components/
│   ├── Dashboard/
│   │   └── PerformanceMetrics.test.tsx
│   ├── Tasks/
│   │   └── TaskCreator.test.tsx
│   └── SmartRails/
│       └── CommandExecutor.test.tsx
├── services/
│   └── brainbotApi.test.ts
└── context/
    └── SmartRailsContext.test.tsx
```

## Test Categories

### 1. Unit Tests

Test individual components and functions in isolation:

- **Component Rendering**: Ensure components render correctly
- **User Interactions**: Test click, input, and form submissions
- **State Management**: Verify state changes and side effects
- **Error Handling**: Test error scenarios and edge cases

Example:
```typescript
describe('PerformanceMetrics', () => {
  it('displays tokens saved with proper formatting', () => {
    const metrics = createMockPerformanceMetrics({ tokensSaved: 45123 })
    render(<PerformanceMetrics metrics={metrics} />)
    
    expect(screen.getByText('45,123')).toBeInTheDocument()
  })
})
```

### 2. Integration Tests

Test component interactions and data flow:

- **Task Creation Flow**: End-to-end task creation with API integration
- **Smart Rails Behavior**: Confidence calculation and direct execution
- **Context Coordination**: State sharing between components

### 3. API Service Tests

Test BrainBot API integration:

- **Success Scenarios**: Valid responses and data transformation
- **Error Handling**: Network failures and API errors
- **Performance**: Response timing and retry logic

### 4. Context Tests

Test React Context providers:

- **State Management**: Context value updates
- **Hook Integration**: useSmartRailsContext functionality
- **Performance Tracking**: Token savings and execution metrics

## Coverage Thresholds

The test suite enforces minimum coverage requirements:

- **Global Coverage**: 80% (statements, lines, functions), 70% (branches)
- **Critical Components**: 85-90% coverage for core functionality
- **API Services**: 90% coverage for reliability

### Critical Components Coverage

- `PerformanceMetrics.tsx`: 90%
- `TaskCreator.tsx`: 85%
- `CommandExecutor.tsx`: 85%
- `brainbotApi.ts`: 90%

## Mock Strategy

### API Mocking with MSW

All API calls are mocked using Mock Service Worker:

```typescript
// Mock successful task creation
http.post(`${BASE_URL}/webhook`, async ({ request }) => {
  const body = await request.json()
  if (body.command === 'create_task') {
    return HttpResponse.json(createMockTask({
      description: body.params.description
    }))
  }
})
```

### Telegram Web App API

Telegram-specific APIs are mocked globally:

```typescript
const mockTelegramWebApp = {
  initData: '',
  MainButton: { setText: vi.fn(), show: vi.fn() },
  HapticFeedback: { impactOccurred: vi.fn() }
}
```

## Test Utilities

### Custom Render Function

Wraps components with necessary providers:

```typescript
const customRender = (ui: ReactElement) => 
  render(ui, { wrapper: AllTheProviders })
```

### Test Data Factories

Generate consistent test data:

```typescript
export const createMockTask = (overrides = {}) => ({
  id: '1',
  description: 'Test task',
  status: 'active',
  ...overrides
})
```

## Performance Testing

### Response Time Testing

Test Smart Rails sub-50ms response claims:

```typescript
it('measures execution time for performance tracking', async () => {
  mockPerformanceNow.mockReturnValueOnce(100).mockReturnValueOnce(150)
  
  // Execute command
  await user.click(submitButton)
  
  expect(consoleSpy).toHaveBeenCalledWith('Direct execution: 50ms')
})
```

### Load State Testing

Verify loading states and user feedback:

```typescript
it('shows loading state during task creation', async () => {
  mockOnTaskCreate.mockImplementation(() => 
    new Promise(resolve => setTimeout(resolve, 100))
  )
  
  await user.click(createButton)
  expect(screen.getByText('Creating...')).toBeInTheDocument()
})
```

## CI/CD Integration

### GitHub Actions Workflow

Automated testing runs on:
- Push to main/develop branches
- Pull request creation
- Multiple Node.js versions (18.x, 20.x)

### Coverage Reporting

- Coverage reports uploaded to Codecov
- Build artifacts preserved for analysis
- Performance benchmarks tracked

## Best Practices

### 1. Test Naming

Use descriptive test names that explain behavior:

```typescript
it('auto-assigns user when @mentioned in description', async () => {
  // Test implementation
})
```

### 2. Arrange-Act-Assert Pattern

Structure tests clearly:

```typescript
it('creates task with assignee', async () => {
  // Arrange
  const user = userEvent.setup()
  render(<TaskCreator {...props} />)
  
  // Act
  await user.type(input, 'Test task')
  await user.click(button)
  
  // Assert
  expect(mockOnTaskCreate).toHaveBeenCalled()
})
```

### 3. Error Testing

Always test error scenarios:

```typescript
it('handles API errors gracefully', async () => {
  const consoleSpy = vi.spyOn(console, 'error').mockImplementation(() => {})
  mockOnTaskCreate.mockRejectedValue(new Error('API Error'))
  
  // Test error handling
  
  consoleSpy.mockRestore()
})
```

### 4. Cleanup

Ensure tests don't affect each other:

```typescript
beforeEach(() => {
  mockOnTaskCreate.mockClear()
  vi.clearAllMocks()
})
```

## Debugging Tests

### Run Specific Tests

```bash
# Run specific test file
npm run test TaskCreator.test.tsx

# Run tests matching pattern
npm run test -- --grep "direct execution"

# Run with verbose output
npm run test -- --reporter=verbose
```

### Debug Mode

```bash
# Run with debugger support
npm run test -- --inspect-brk

# Run single test for debugging
npm run test -- --run --reporter=verbose src/components/Tasks/TaskCreator.test.tsx
```

## Troubleshooting

### Common Issues

1. **MSW Handler Not Found**: Ensure API endpoint matches handler URL
2. **React Context Error**: Verify components are wrapped with providers
3. **Async Test Timeouts**: Use `waitFor` for asynchronous operations
4. **Mock Reset Issues**: Clear mocks in `beforeEach` hooks

### Performance Issues

- Use `vi.clearAllMocks()` to prevent memory leaks
- Avoid rendering large component trees unnecessarily
- Mock expensive operations like animations

## Contributing

When adding new features:

1. Write tests before implementation (TDD approach)
2. Maintain coverage thresholds
3. Add integration tests for new user flows
4. Update this documentation for new testing patterns

## Maintenance

### Regular Tasks

- Review and update mock data to match API changes
- Verify test performance and execution times
- Update dependencies and compatibility
- Monitor coverage trends and improve low-coverage areas

### Performance Monitoring

- Track test execution time trends
- Monitor coverage percentage changes
- Review and optimize slow tests
- Ensure CI/CD pipeline efficiency