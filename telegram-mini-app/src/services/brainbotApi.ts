import { Task, List, BotStatus, PerformanceStats } from '../context/AppContext';
import { buildUrl } from '../config/api';

// Base URL for the BrainBot API - uses environment variable or fallback
const BASE_URL = import.meta.env.VITE_API_URL || 'https://brainbot-v76n.onrender.com';
// Health & Status
export async function checkHealth(): Promise<{
  status: 'healthy' | 'degraded' | 'unhealthy';
  message: string;
}> {
  try {
    const response = await fetch(`${BASE_URL}/health`);
    if (!response.ok) throw new Error('Health check failed');
    return await response.json();
  } catch (error) {
    console.error('Health check error:', error);
    return {
      status: 'unhealthy',
      message: 'Unable to connect to BrainBot'
    };
  }
}
export async function getStatus(): Promise<BotStatus> {
  try {
    const response = await fetch(`${BASE_URL}/status`);
    if (!response.ok) throw new Error('Status check failed');
    return await response.json();
  } catch (error) {
    console.error('Status check error:', error);
    return {
      status: 'unhealthy',
      message: 'Unable to fetch status',
      lastUpdated: new Date()
    };
  }
}
export async function getMetrics(): Promise<PerformanceStats> {
  try {
    const response = await fetch(`${BASE_URL}/metrics`);
    if (!response.ok) throw new Error('Metrics fetch failed');
    return await response.json();
  } catch (error) {
    console.error('Metrics fetch error:', error);
    return {
      totalCommands: 0,
      tokensSaved: 0,
      averageResponseTime: 0,
      directExecutionRate: 0
    };
  }
}
// Smart Rails Direct Commands
export async function executeDirectCommand(command: string, params: Record<string, unknown> = {}): Promise<unknown> {
  try {
    const response = await fetch(`${BASE_URL}/webhook`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        command,
        params
      })
    });
    if (!response.ok) throw new Error('Command execution failed');
    return await response.json();
  } catch (error) {
    console.error('Command execution error:', error);
    throw error;
  }
}
// Task Management
export async function createTask(description: string, assignee?: string): Promise<Task> {
  try {
    const response = await fetch(`${BASE_URL}/webhook`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        command: 'create_task',
        params: {
          description,
          assignee
        }
      })
    });
    if (!response.ok) throw new Error('Task creation failed');
    return await response.json();
  } catch (error) {
    console.error('Task creation error:', error);
    throw error;
  }
}
export async function completeTask(taskId: string): Promise<Task> {
  try {
    const response = await fetch(`${BASE_URL}/webhook`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        command: 'complete_task',
        params: {
          taskId
        }
      })
    });
    if (!response.ok) throw new Error('Task completion failed');
    return await response.json();
  } catch (error) {
    console.error('Task completion error:', error);
    throw error;
  }
}
export async function reassignTask(taskId: string, newAssignee: string): Promise<Task> {
  try {
    const response = await fetch(`${BASE_URL}/webhook`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        command: 'reassign_task',
        params: {
          taskId,
          newAssignee
        }
      })
    });
    if (!response.ok) throw new Error('Task reassignment failed');
    return await response.json();
  } catch (error) {
    console.error('Task reassignment error:', error);
    throw error;
  }
}
export async function getTasks(assignee?: string): Promise<Task[]> {
  try {
    const url = assignee ? `${BASE_URL}/webhook?command=get_tasks&assignee=${encodeURIComponent(assignee)}` : `${BASE_URL}/webhook?command=get_tasks`;
    const response = await fetch(url);
    if (!response.ok) throw new Error('Tasks fetch failed');
    return await response.json();
  } catch (error) {
    console.error('Tasks fetch error:', error);
    // Return mock data for development
    return [{
      id: '1',
      description: 'Complete BrainBot integration',
      assignee: 'Test User',
      status: 'active',
      createdAt: new Date()
    }, {
      id: '2',
      description: 'Review Smart Rails performance',
      assignee: 'Test User',
      status: 'completed',
      createdAt: new Date(Date.now() - 86400000),
      completedAt: new Date()
    }];
  }
}
// List Management
export async function createList(name: string): Promise<List> {
  try {
    const response = await fetch(`${BASE_URL}/webhook`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        command: 'create_list',
        params: {
          name
        }
      })
    });
    if (!response.ok) throw new Error('List creation failed');
    return await response.json();
  } catch (error) {
    console.error('List creation error:', error);
    throw error;
  }
}
export async function addToList(listId: string, items: string[]): Promise<List> {
  try {
    const response = await fetch(`${BASE_URL}/webhook`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        command: 'add_to_list',
        params: {
          listId,
          items
        }
      })
    });
    if (!response.ok) throw new Error('Adding to list failed');
    return await response.json();
  } catch (error) {
    console.error('Adding to list error:', error);
    throw error;
  }
}
export async function removeFromList(listId: string, items: string[]): Promise<List> {
  try {
    const response = await fetch(`${BASE_URL}/webhook`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        command: 'remove_from_list',
        params: {
          listId,
          items
        }
      })
    });
    if (!response.ok) throw new Error('Removing from list failed');
    return await response.json();
  } catch (error) {
    console.error('Removing from list error:', error);
    throw error;
  }
}
export async function getList(listId: string): Promise<List> {
  try {
    const response = await fetch(`${BASE_URL}/webhook?command=get_list&listId=${encodeURIComponent(listId)}`);
    if (!response.ok) throw new Error('List fetch failed');
    return await response.json();
  } catch (error) {
    console.error('List fetch error:', error);
    // Return mock data for development
    return {
      id: listId,
      name: 'Shopping List',
      items: ['Milk', 'Bread', 'Eggs'],
      createdAt: new Date(),
      updatedAt: new Date()
    };
  }
}
// Webhook Communication
export async function sendWebhookMessage(message: string): Promise<unknown> {
  try {
    const response = await fetch(`${BASE_URL}/webhook`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        message
      })
    });
    if (!response.ok) throw new Error('Webhook message failed');
    return await response.json();
  } catch (error) {
    console.error('Webhook message error:', error);
    throw error;
  }
}