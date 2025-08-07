import { vi } from 'vitest'

// Factory for creating test data
export const createMockTask = (overrides = {}) => ({
  id: '1',
  description: 'Test task',
  assignee: 'testuser',
  status: 'active' as const,
  createdAt: new Date('2024-01-01T00:00:00Z'),
  completedAt: undefined,
  dueDate: undefined,
  ...overrides
})

export const createMockList = (overrides = {}) => ({
  id: '1',
  name: 'Test List',
  items: ['Item 1', 'Item 2', 'Item 3'],
  createdAt: new Date('2024-01-01T00:00:00Z'),
  updatedAt: new Date('2024-01-01T00:00:00Z'),
  ...overrides
})

export const createMockPerformanceMetrics = (overrides = {}) => ({
  totalCommands: 150,
  tokensSaved: 45000,
  averageResponseTime: 42,
  directExecutionRate: 85,
  ...overrides
})

export const createMockBotStatus = (overrides = {}) => ({
  status: 'healthy' as const,
  message: 'All systems operational',
  lastUpdated: new Date('2024-01-01T00:00:00Z'),
  ...overrides
})

export const createMockUser = (overrides = {}) => ({
  id: 1,
  username: 'testuser',
  name: 'Test User',
  ...overrides
})

// Mock API responses
export const mockFetch = (response: any, status = 200) => {
  return vi.mocked(fetch).mockResolvedValueOnce({
    ok: status >= 200 && status < 300,
    status,
    json: async () => response,
    text: async () => JSON.stringify(response),
  } as Response)
}

export const mockFetchError = (error: Error) => {
  return vi.mocked(fetch).mockRejectedValueOnce(error)
}

// Mock network delay for testing loading states
export const mockFetchWithDelay = (response: any, delay = 100, status = 200) => {
  return vi.mocked(fetch).mockImplementationOnce(
    () => new Promise(resolve => {
      setTimeout(() => {
        resolve({
          ok: status >= 200 && status < 300,
          status,
          json: async () => response,
          text: async () => JSON.stringify(response),
        } as Response)
      }, delay)
    })
  )
}