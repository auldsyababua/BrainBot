import { describe, it, expect, beforeEach } from 'vitest'
import { server } from '../tests/mocks/server'
import { http, HttpResponse } from 'msw'
import {
  checkHealth,
  getStatus,
  executeDirectCommand,
  createTask,
  completeTask,
  reassignTask,
  getTasks,
  createList,
  addToList,
  removeFromList,
  getList,
  sendWebhookMessage
} from './brainbotApi'

const BASE_URL = 'https://brainbot-v76n.onrender.com'

describe('brainbotApi', () => {
  describe('checkHealth', () => {
    it('returns healthy status when API is working', async () => {
      const result = await checkHealth()

      expect(result).toEqual({
        status: 'healthy',
        message: 'All systems operational'
      })
    })

    it('returns unhealthy status when API fails', async () => {
      server.use(
        http.get(`${BASE_URL}/health`, () => {
          return new HttpResponse(null, { status: 500 })
        })
      )

      const result = await checkHealth()

      expect(result).toEqual({
        status: 'unhealthy',
        message: 'Unable to connect to BrainBot'
      })
    })

    it('handles network errors gracefully', async () => {
      server.use(
        http.get(`${BASE_URL}/health`, () => {
          throw new Error('Network error')
        })
      )

      const result = await checkHealth()

      expect(result.status).toBe('unhealthy')
      expect(result.message).toBe('Unable to connect to BrainBot')
    })
  })

  describe('getStatus', () => {
    it('returns bot status successfully', async () => {
      const result = await getStatus()

      expect(result).toHaveProperty('status')
      expect(result).toHaveProperty('message')
      expect(result).toHaveProperty('lastUpdated')
    })

    it('handles API errors gracefully', async () => {
      server.use(
        http.get(`${BASE_URL}/status`, () => {
          return new HttpResponse(null, { status: 500 })
        })
      )

      const result = await getStatus()

      expect(result).toEqual({
        status: 'unhealthy',
        message: 'Unable to fetch status',
        lastUpdated: expect.any(Date)
      })
    })
  })

  describe('getMetrics', () => {
    it('returns performance metrics successfully', async () => {
      const result = await getMetrics()

      expect(result).toHaveProperty('totalCommands')
      expect(result).toHaveProperty('tokensSaved')
      expect(result).toHaveProperty('averageResponseTime')
      expect(result).toHaveProperty('directExecutionRate')
      expect(typeof result.totalCommands).toBe('number')
      expect(typeof result.tokensSaved).toBe('number')
      expect(typeof result.averageResponseTime).toBe('number')
      expect(typeof result.directExecutionRate).toBe('number')
    })

    it('handles API errors with default values', async () => {
      server.use(
        http.get(`${BASE_URL}/metrics`, () => {
          return new HttpResponse(null, { status: 500 })
        })
      )

      const result = await getMetrics()

      expect(result).toEqual({
        totalCommands: 0,
        tokensSaved: 0,
        averageResponseTime: 0,
        directExecutionRate: 0
      })
    })
  })

  describe('executeDirectCommand', () => {
    it('executes command successfully', async () => {
      const result = await executeDirectCommand('test_command', { param1: 'value1' })

      expect(result).toHaveProperty('success', true)
      expect(result).toHaveProperty('message', 'Command executed successfully')
      expect(result.result).toEqual({
        command: 'test_command',
        params: { param1: 'value1' }
      })
    })

    it('handles command execution failures', async () => {
      server.use(
        http.post(`${BASE_URL}/webhook`, () => {
          return new HttpResponse(null, { status: 500 })
        })
      )

      await expect(executeDirectCommand('failing_command')).rejects.toThrow()
    })
  })

  describe('createTask', () => {
    it('creates task successfully', async () => {
      const result = await createTask('Complete project', 'alice')

      expect(result).toHaveProperty('id')
      expect(result).toHaveProperty('description', 'Complete project')
      expect(result).toHaveProperty('assignee', 'alice')
      expect(result).toHaveProperty('status', 'active')
      expect(result).toHaveProperty('createdAt')
    })

    it('creates task without assignee', async () => {
      const result = await createTask('Unassigned task')

      expect(result).toHaveProperty('description', 'Unassigned task')
      expect(result.assignee).toBeDefined()
    })

    it('handles task creation failures', async () => {
      server.use(
        http.post(`${BASE_URL}/webhook`, ({ request }) => {
          return new HttpResponse(null, { status: 500 })
        })
      )

      await expect(createTask('Failing task')).rejects.toThrow('Task creation failed')
    })
  })

  describe('completeTask', () => {
    it('completes task successfully', async () => {
      const result = await completeTask('task-123')

      expect(result).toHaveProperty('id', 'task-123')
      expect(result).toHaveProperty('status', 'completed')
      expect(result).toHaveProperty('completedAt')
    })

    it('handles completion failures', async () => {
      server.use(
        http.post(`${BASE_URL}/webhook`, () => {
          return new HttpResponse(null, { status: 500 })
        })
      )

      await expect(completeTask('task-123')).rejects.toThrow('Task completion failed')
    })
  })

  describe('reassignTask', () => {
    it('reassigns task successfully', async () => {
      const result = await reassignTask('task-123', 'bob')

      expect(result).toHaveProperty('id', 'task-123')
      expect(result).toHaveProperty('assignee', 'bob')
    })

    it('handles reassignment failures', async () => {
      server.use(
        http.post(`${BASE_URL}/webhook`, () => {
          return new HttpResponse(null, { status: 500 })
        })
      )

      await expect(reassignTask('task-123', 'bob')).rejects.toThrow('Task reassignment failed')
    })
  })

  describe('getTasks', () => {
    it('retrieves all tasks when no assignee specified', async () => {
      const result = await getTasks()

      expect(Array.isArray(result)).toBe(true)
      expect(result.length).toBeGreaterThan(0)
      expect(result[0]).toHaveProperty('id')
      expect(result[0]).toHaveProperty('description')
      expect(result[0]).toHaveProperty('status')
    })

    it('retrieves tasks for specific assignee', async () => {
      const result = await getTasks('alice')

      expect(Array.isArray(result)).toBe(true)
      if (result.length > 0) {
        expect(result[0]).toHaveProperty('assignee', 'alice')
      }
    })

    it('returns mock data when API fails', async () => {
      server.use(
        http.get(`${BASE_URL}/webhook`, () => {
          return new HttpResponse(null, { status: 500 })
        })
      )

      const result = await getTasks()

      expect(Array.isArray(result)).toBe(true)
      expect(result.length).toBe(2) // Mock data has 2 tasks
      expect(result[0]).toHaveProperty('description', 'Complete BrainBot integration')
    })
  })

  describe('createList', () => {
    it('creates list successfully', async () => {
      const result = await createList('Shopping List')

      expect(result).toHaveProperty('name', 'Shopping List')
      expect(result).toHaveProperty('id')
      expect(result).toHaveProperty('items')
      expect(result).toHaveProperty('createdAt')
    })

    it('handles list creation failures', async () => {
      server.use(
        http.post(`${BASE_URL}/webhook`, () => {
          return new HttpResponse(null, { status: 500 })
        })
      )

      await expect(createList('Failing list')).rejects.toThrow('List creation failed')
    })
  })

  describe('addToList', () => {
    it('adds items to list successfully', async () => {
      const result = await addToList('list-123', ['Item 1', 'Item 2'])

      expect(result).toHaveProperty('id', 'list-123')
      expect(result).toHaveProperty('items')
      expect(Array.isArray(result.items)).toBe(true)
    })

    it('handles add failures', async () => {
      server.use(
        http.post(`${BASE_URL}/webhook`, () => {
          return new HttpResponse(null, { status: 500 })
        })
      )

      await expect(addToList('list-123', ['Item'])).rejects.toThrow('Adding to list failed')
    })
  })

  describe('removeFromList', () => {
    it('removes items from list successfully', async () => {
      const result = await removeFromList('list-123', ['Item 2'])

      expect(result).toHaveProperty('id', 'list-123')
      expect(result).toHaveProperty('items')
      expect(result.items).toEqual(['Item 1']) // Mock returns remaining items
    })

    it('handles removal failures', async () => {
      server.use(
        http.post(`${BASE_URL}/webhook`, () => {
          return new HttpResponse(null, { status: 500 })
        })
      )

      await expect(removeFromList('list-123', ['Item'])).rejects.toThrow('Removing from list failed')
    })
  })

  describe('getList', () => {
    it('retrieves list successfully', async () => {
      const result = await getList('list-123')

      expect(result).toHaveProperty('id', 'list-123')
      expect(result).toHaveProperty('name')
      expect(result).toHaveProperty('items')
      expect(Array.isArray(result.items)).toBe(true)
    })

    it('returns mock data when API fails', async () => {
      server.use(
        http.get(`${BASE_URL}/webhook`, () => {
          return new HttpResponse(null, { status: 500 })
        })
      )

      const result = await getList('list-123')

      expect(result).toEqual({
        id: 'list-123',
        name: 'Shopping List',
        items: ['Milk', 'Bread', 'Eggs'],
        createdAt: expect.any(Date),
        updatedAt: expect.any(Date)
      })
    })
  })

  describe('sendWebhookMessage', () => {
    it('sends message successfully', async () => {
      const result = await sendWebhookMessage('Hello BrainBot')

      expect(result).toHaveProperty('success', true)
      expect(result.result).toHaveProperty('message', 'Hello BrainBot')
    })

    it('handles message send failures', async () => {
      server.use(
        http.post(`${BASE_URL}/webhook`, () => {
          return new HttpResponse(null, { status: 500 })
        })
      )

      await expect(sendWebhookMessage('Failing message')).rejects.toThrow('Webhook message failed')
    })
  })

  describe('API response timing', () => {
    it('handles responses within reasonable time', async () => {
      const startTime = Date.now()
      await checkHealth()
      const endTime = Date.now()

      // Should complete within 200ms (accounting for mock delay)
      expect(endTime - startTime).toBeLessThan(200)
    })
  })

  describe('Error handling consistency', () => {
    it('all API functions handle network errors gracefully', async () => {
      server.use(
        http.get('*', () => {
          throw new Error('Network error')
        }),
        http.post('*', () => {
          throw new Error('Network error')
        })
      )

      // These should not throw but return default/error values
      const healthResult = await checkHealth()
      expect(healthResult.status).toBe('unhealthy')

      const statusResult = await getStatus()
      expect(statusResult.status).toBe('unhealthy')

      const metricsResult = await getMetrics()
      expect(metricsResult.totalCommands).toBe(0)

      // These should throw as they don't have fallback behavior
      await expect(executeDirectCommand('test')).rejects.toThrow()
      await expect(createTask('test')).rejects.toThrow()
      await expect(completeTask('test')).rejects.toThrow()
      await expect(reassignTask('test', 'user')).rejects.toThrow()
      await expect(createList('test')).rejects.toThrow()
      await expect(addToList('test', [])).rejects.toThrow()
      await expect(removeFromList('test', [])).rejects.toThrow()
      await expect(sendWebhookMessage('test')).rejects.toThrow()
    })
  })
})