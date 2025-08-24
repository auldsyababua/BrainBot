import { http, HttpResponse } from 'msw'
import { createMockTask, createMockList, createMockBotStatus } from '../factories'

// Support both production and test URLs dynamically
const URLS = [
  'https://brainbot-v76n.onrender.com',
  'http://localhost:5000',
  'http://localhost:3000'
].filter(Boolean)

const createHandlersForUrl = (url: string) => [
  // Health check
  http.get(`${url}/health`, () => {
    return HttpResponse.json({
      status: 'healthy',
      message: 'All systems operational'
    })
  }),

  // Metrics endpoint
  http.get(`${url}/metrics`, () => {
    return HttpResponse.json({
      taskCount: 42,
      listCount: 7,
      activeUsers: 15,
      completionRate: 0.85,
      averageTaskTime: 3600,
      tokensSaved: 1500,
      timestamp: Date.now()
    })
  }),

  // Status endpoint
  http.get(`${url}/status`, () => {
    return HttpResponse.json(createMockBotStatus())
  }),

  // Combined GET webhook endpoint for tasks and lists
  http.get(`${url}/webhook`, ({ request }) => {
    const requestUrl = new URL(request.url)
    const command = requestUrl.searchParams.get('command')
    const assignee = requestUrl.searchParams.get('assignee')
    const listId = requestUrl.searchParams.get('listId')
    
    // Handle get_tasks command
    if (command === 'get_tasks') {
      const tasks = [
        createMockTask(),
        createMockTask({ id: '2', description: 'Second task', status: 'completed' }),
        createMockTask({ id: '3', description: 'Third task', assignee: assignee || 'testuser' })
      ]
      
      let filteredTasks = tasks
      if (assignee) {
        filteredTasks = filteredTasks.filter(t => t.assignee === assignee)
      }
      
      return HttpResponse.json(filteredTasks)
    }
    
    // Handle get_list command
    if (command === 'get_list' && listId) {
      return HttpResponse.json(createMockList({ id: listId }))
    }
    
    return HttpResponse.json([])
  }),

  // POST webhook endpoint for commands
  http.post(`${url}/webhook`, async ({ request }) => {
    const body = await request.json() as any
    
    // Handle task creation via webhook
    if (body.command === 'create_task') {
      return HttpResponse.json({
        id: `task-${Date.now()}`,
        description: body.params?.description || 'New task',
        assignee: body.params?.assignee || 'unassigned',
        status: 'active',
        createdAt: new Date().toISOString()
      })
    }
    
    // Handle task completion
    if (body.command === 'complete_task') {
      return HttpResponse.json({
        id: body.params?.taskId,
        description: 'Completed task',
        assignee: 'Test User',
        status: 'completed',
        createdAt: new Date().toISOString(),
        completedAt: new Date().toISOString()
      })
    }
    
    // Handle task reassignment
    if (body.command === 'reassign_task') {
      return HttpResponse.json({
        id: body.params?.taskId,
        description: 'Reassigned task',
        assignee: body.params?.newAssignee,
        status: 'active',
        createdAt: new Date().toISOString()
      })
    }
    
    // Handle list creation
    if (body.command === 'create_list') {
      return HttpResponse.json({
        id: `list-${Date.now()}`,
        name: body.params?.name || 'New list',
        items: [],
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString()
      })
    }
    
    // Handle adding items to list
    if (body.command === 'add_to_list') {
      return HttpResponse.json({
        id: body.params?.listId,
        name: 'Updated list',
        items: [body.params?.item],
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString()
      })
    }
    
    // Handle removing items from list
    if (body.command === 'remove_from_list') {
      return HttpResponse.json({
        id: body.params?.listId,
        name: 'Updated list',
        items: ['Item 1'], // Return remaining items after removal
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString()
      })
    }
    
    // Handle send_message command
    if (body.command === 'send_message') {
      return HttpResponse.json({
        success: true,
        messageId: Date.now(),
        text: body.params?.text || 'Message sent'
      })
    }
    
    // Handle message field directly (for sendWebhookMessage)
    if (body.message && typeof body.message === 'string') {
      return HttpResponse.json({
        success: true,
        result: {
          message: body.message
        }
      })
    }
    
    // Handle direct command execution
    if (body.command) {
      return HttpResponse.json({
        success: true,
        message: 'Command executed successfully',
        result: {
          command: body.command,
          params: body.params
        }
      })
    }
    
    // Handle Telegram bot messages
    if (body.message?.text?.startsWith('/task')) {
      return HttpResponse.json({
        ok: true,
        result: {
          message_id: Date.now(),
          text: 'Task created successfully',
          chat: { id: body.message.chat.id }
        }
      })
    }
    
    if (body.message?.text?.startsWith('/list')) {
      return HttpResponse.json({
        ok: true,
        result: {
          message_id: Date.now(),
          text: 'List operation successful',
          chat: { id: body.message.chat.id }
        }
      })
    }
    
    if (body.text) {
      return HttpResponse.json({
        success: true,
        messageId: Date.now(),
        text: body.text
      })
    }
    
    return HttpResponse.json({
      ok: true,
      result: {
        message_id: Date.now(),
        text: 'Command processed',
        chat: { id: body.message?.chat?.id || 1 }
      }
    })
  }),
  
  // Tasks REST endpoints
  http.get(`${url}/tasks`, ({ request }) => {
    const requestUrl = new URL(request.url)
    const assigned_to = requestUrl.searchParams.get('assigned_to')
    const status = requestUrl.searchParams.get('status')
    
    const tasks = [
      createMockTask(),
      createMockTask({ status: 'completed' }),
      createMockTask({ assignee: assigned_to || 'testuser' })
    ]
    
    let filteredTasks = tasks
    if (assigned_to) {
      filteredTasks = filteredTasks.filter(t => t.assignee === assigned_to)
    }
    if (status) {
      filteredTasks = filteredTasks.filter(t => t.status === status)
    }
    
    return HttpResponse.json({
      tasks: filteredTasks,
      total: filteredTasks.length
    })
  }),

  http.post(`${url}/tasks`, async ({ request }) => {
    const body = await request.json() as any
    const newTask = createMockTask({
      ...body,
      id: `task-${Date.now()}`,
      created_at: new Date().toISOString()
    })
    
    return HttpResponse.json({
      success: true,
      task: newTask
    }, { status: 201 })
  }),

  http.patch(`${url}/tasks/:taskId/complete`, ({ params }) => {
    const { taskId } = params
    return HttpResponse.json({
      success: true,
      task: createMockTask({
        id: taskId as string,
        status: 'completed',
        completed_at: new Date().toISOString()
      })
    })
  }),

  http.patch(`${url}/tasks/:taskId/reassign`, async ({ params, request }) => {
    const { taskId } = params
    const body = await request.json() as any
    
    return HttpResponse.json({
      success: true,
      task: createMockTask({
        id: taskId as string,
        assignee: body.assigned_to || body.assignee
      })
    })
  }),

  // Lists REST endpoints
  http.get(`${url}/lists/:listId`, ({ params }) => {
    const { listId } = params
    return HttpResponse.json({
      list: createMockList({
        id: listId as string
      })
    })
  }),

  http.post(`${url}/lists`, async ({ request }) => {
    const body = await request.json() as any
    const newList = createMockList({
      ...body,
      id: `list-${Date.now()}`,
      created_at: new Date().toISOString()
    })
    
    return HttpResponse.json({
      success: true,
      list: newList
    }, { status: 201 })
  }),

  http.post(`${url}/lists/:listId/items`, async ({ params, request }) => {
    const { listId } = params
    const body = await request.json() as any
    
    return HttpResponse.json({
      success: true,
      list: createMockList({
        id: listId as string,
        items: [body.item]
      })
    })
  }),

  http.delete(`${url}/lists/:listId/items/:itemId`, ({ params }) => {
    const { listId } = params
    
    return HttpResponse.json({
      success: true,
      list: createMockList({
        id: listId as string,
        items: []
      })
    })
  }),

  // Direct command execution
  http.post(`${url}/execute`, async ({ request }) => {
    const body = await request.json() as any
    
    return HttpResponse.json({
      success: true,
      result: `Executed: ${body.command}`,
      timestamp: Date.now()
    })
  }),
  
  // Error simulation endpoints
  http.post(`${url}/webhook-error`, () => {
    return new HttpResponse(null, { status: 500 })
  }),
  
  http.get(`${url}/health-error`, () => {
    return new HttpResponse(null, { status: 503 })
  })
]

// Generate handlers for all URLs
export const handlers = URLS.flatMap(url => createHandlersForUrl(url))

// Export error handlers for testing error scenarios
export const errorHandlers = {
  healthError: (url: string = URLS[0]) => 
    http.get(`${url}/health`, () => {
      return new HttpResponse(null, { status: 500 })
    }),
  
  taskCreateError: (url: string = URLS[0]) =>
    http.post(`${url}/tasks`, () => {
      return HttpResponse.json(
        { error: 'Failed to create task' },
        { status: 400 }
      )
    }),
    
  networkError: (url: string = URLS[0]) =>
    http.get(`${url}/health`, () => {
      throw new Error('Network error')
    })
}