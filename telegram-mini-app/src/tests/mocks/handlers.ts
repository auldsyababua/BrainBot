import { http, HttpResponse } from 'msw'
import { createMockTask, createMockList, createMockBotStatus } from '../factories'

const BASE_URL = 'https://brainbot-v76n.onrender.com'

export const handlers = [
  // Health check
  http.get(`${BASE_URL}/health`, () => {
    return HttpResponse.json({
      status: 'healthy',
      message: 'All systems operational'
    })
  }),

  // Status endpoint
  http.get(`${BASE_URL}/status`, () => {
    return HttpResponse.json(createMockBotStatus())
  }),

  // Webhook endpoint for commands
  http.post(`${BASE_URL}/webhook`, async ({ request }) => {
    const body = await request.json() as any
    const { command, params } = body

    // Simulate response delay for realistic testing
    await new Promise(resolve => setTimeout(resolve, 50))

    switch (command) {
      case 'create_task':
        return HttpResponse.json(createMockTask({
          description: params.description,
          assignee: params.assignee
        }))

      case 'complete_task':
        return HttpResponse.json(createMockTask({
          id: params.taskId,
          status: 'completed',
          completedAt: new Date()
        }))

      case 'reassign_task':
        return HttpResponse.json(createMockTask({
          id: params.taskId,
          assignee: params.newAssignee
        }))

      case 'create_list':
        return HttpResponse.json(createMockList({
          name: params.name
        }))

      case 'add_to_list':
        return HttpResponse.json(createMockList({
          id: params.listId,
          items: params.items
        }))

      case 'remove_from_list':
        return HttpResponse.json(createMockList({
          id: params.listId,
          items: ['Item 1'] // Mock remaining items
        }))

      default:
        return HttpResponse.json({ 
          success: true, 
          message: 'Command executed successfully',
          result: { command, params }
        })
    }
  }),

  // Get tasks endpoint
  http.get(`${BASE_URL}/webhook`, ({ request }) => {
    const url = new URL(request.url)
    const command = url.searchParams.get('command')
    const assignee = url.searchParams.get('assignee')

    if (command === 'get_tasks') {
      const tasks = assignee 
        ? [createMockTask({ assignee })]
        : [
            createMockTask(),
            createMockTask({ 
              id: '2', 
              description: 'Another task',
              status: 'completed',
              completedAt: new Date()
            })
          ]
      return HttpResponse.json(tasks)
    }

    if (command === 'get_list') {
      const listId = url.searchParams.get('listId')
      return HttpResponse.json(createMockList({ id: listId }))
    }

    return HttpResponse.json({ error: 'Unknown command' }, { status: 400 })
  }),

  // Error simulation handlers
  http.post(`${BASE_URL}/webhook-error`, () => {
    return HttpResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    )
  }),

  http.get(`${BASE_URL}/health-error`, () => {
    return HttpResponse.json(
      { error: 'Service unavailable' },
      { status: 503 }
    )
  })
]