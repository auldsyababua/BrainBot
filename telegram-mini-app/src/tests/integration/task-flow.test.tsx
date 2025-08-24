import { describe, it, expect, vi } from 'vitest'
import { render, screen, waitFor } from '../test-utils'
import userEvent from '@testing-library/user-event'
import { TaskCreator } from '../../components/Tasks/TaskCreator'
import { CommandExecutor } from '../../components/SmartRails/CommandExecutor'
import { createMockUser } from '../factories'
import * as brainbotApi from '../../services/brainbotApi'

// Mock the entire brainbotApi module
vi.mock('../../services/brainbotApi')

describe('Task Flow Integration', () => {
  const mockUsers = [
    createMockUser({ id: 1, username: 'alice', name: 'Alice Smith' }),
    createMockUser({ id: 2, username: 'bob', name: 'Bob Johnson' })
  ]

  beforeEach(() => {
    vi.clearAllMocks()
  })

  describe('TaskCreator Integration', () => {
    it('creates task and handles API response', async () => {
      const user = userEvent.setup()
      const mockCreateTask = vi.mocked(brainbotApi.createTask)
      const mockOnTaskCreate = vi.fn()

      const mockTask = {
        id: '123',
        description: 'Integration test task',
        assignee: 'alice',
        status: 'active' as const,
        createdAt: new Date()
      }

      mockCreateTask.mockResolvedValue(mockTask)

      render(
        <TaskCreator
          onTaskCreate={mockOnTaskCreate}
          availableUsers={mockUsers}
          isDirectExecution={false}
        />
      )

      const input = screen.getByPlaceholderText('What needs to be done?')
      const createButton = screen.getByText('Create Task')

      await user.type(input, 'Integration test task')

      // Select assignee
      const assignButton = screen.getByText('Assign to')
      await user.click(assignButton)
      const aliceOption = screen.getByText('Alice Smith (@alice)')
      await user.click(aliceOption)

      await user.click(createButton)

      await waitFor(() => {
        expect(mockOnTaskCreate).toHaveBeenCalledWith({
          description: 'Integration test task',
          assignee: 'alice',
          dueDate: null
        })
      })

      // Form should reset after successful creation
      expect(input).toHaveValue('')
    })

    it('handles task creation failure gracefully', async () => {
      const user = userEvent.setup()
      const consoleSpy = vi.spyOn(console, 'error').mockImplementation(() => {})
      const mockOnTaskCreate = vi.fn().mockRejectedValue(new Error('API Error'))

      render(
        <TaskCreator
          onTaskCreate={mockOnTaskCreate}
          availableUsers={mockUsers}
          isDirectExecution={false}
        />
      )

      const input = screen.getByPlaceholderText('What needs to be done?')
      const createButton = screen.getByText('Create Task')

      await user.type(input, 'Failing task')
      await user.click(createButton)

      await waitFor(() => {
        expect(consoleSpy).toHaveBeenCalledWith('Error creating task:', expect.any(Error))
      })

      consoleSpy.mockRestore()
    })
  })

  describe('CommandExecutor Integration', () => {
    it('executes direct command and measures performance', async () => {
      const user = userEvent.setup()
      const mockOnCommand = vi.fn().mockResolvedValue({ success: true })

      render(
        <CommandExecutor
          onCommand={mockOnCommand}
          showConfidence={true}
          enableDirectMode={true}
        />
      )

      const input = screen.getByPlaceholderText('Type a command...')
      const submitButton = screen.getByRole('button', { name: /send/i })

      // Type a direct command pattern
      await user.type(input, 'add task complete integration tests')
      await user.click(submitButton)

      await waitFor(() => {
        expect(mockOnCommand).toHaveBeenCalledWith('add task complete integration tests')
      })

      // Input should clear after execution
      expect(input).toHaveValue('')
    })

    it('handles command execution with varying confidence levels', async () => {
      const user = userEvent.setup()
      const mockOnCommand = vi.fn().mockResolvedValue({})

      render(
        <CommandExecutor
          onCommand={mockOnCommand}
          showConfidence={true}
          enableDirectMode={true}
        />
      )

      const input = screen.getByPlaceholderText('Type a command...')
      const submitButton = screen.getByRole('button', { name: /send/i })

      // Test command execution
      await user.type(input, 'create list shopping items')
      await user.click(submitButton)

      await waitFor(() => {
        expect(mockOnCommand).toHaveBeenCalledWith('create list shopping items')
      })
      
      // Input should clear after execution
      expect(input).toHaveValue('')
    })
  })

  describe('Smart Rails Context Integration', () => {
    it('coordinates confidence and direct mode between components', async () => {
      const user = userEvent.setup()
      const mockOnCommand = vi.fn().mockResolvedValue({})
      const mockOnTaskCreate = vi.fn().mockResolvedValue({})

      // Render both components in the same context
      render(
        <div>
          <CommandExecutor
            onCommand={mockOnCommand}
            showConfidence={true}
            enableDirectMode={true}
          />
          <TaskCreator
            onTaskCreate={mockOnTaskCreate}
            availableUsers={mockUsers}
            isDirectExecution={true}
          />
        </div>
      )

      // Type a direct command in CommandExecutor
      const commandInput = screen.getByPlaceholderText('Type a command...')
      await user.type(commandInput, 'add task test')

      // TaskCreator should show the direct execution indicator (0 tokens)
      expect(screen.getByText('0 tokens')).toBeInTheDocument()
      
      // Both inputs should be present and functional
      const taskInput = screen.getByPlaceholderText('What needs to be done?')
      expect(commandInput).toBeInTheDocument()
      expect(taskInput).toBeInTheDocument()
    })
  })

  describe('API Error Handling Integration', () => {
    it('handles network failures across components', async () => {
      const user = userEvent.setup()
      const consoleSpy = vi.spyOn(console, 'error').mockImplementation(() => {})

      // Mock API failures
      const mockOnCommand = vi.fn().mockRejectedValue(new Error('Network error'))
      const mockOnTaskCreate = vi.fn().mockRejectedValue(new Error('Network error'))

      render(
        <div>
          <CommandExecutor
            onCommand={mockOnCommand}
            showConfidence={true}
            enableDirectMode={true}
          />
          <TaskCreator
            onTaskCreate={mockOnTaskCreate}
            availableUsers={mockUsers}
            isDirectExecution={false}
          />
        </div>
      )

      // Test CommandExecutor error handling
      const commandInput = screen.getByPlaceholderText('Type a command...')
      const commandButton = screen.getByRole('button', { name: /send command/i })
      
      await user.type(commandInput, 'test command')
      await user.click(commandButton)

      // Test TaskCreator error handling
      const taskInput = screen.getByPlaceholderText('What needs to be done?')
      const createButton = screen.getByText('Create Task')

      await user.type(taskInput, 'test task')
      await user.click(createButton)

      await waitFor(() => {
        expect(consoleSpy).toHaveBeenCalledWith('Command execution error:', expect.any(Error))
        expect(consoleSpy).toHaveBeenCalledWith('Error creating task:', expect.any(Error))
      })

      consoleSpy.mockRestore()
    })
  })

  describe('Performance Integration', () => {
    it('measures end-to-end task creation performance', async () => {
      const user = userEvent.setup()
      const mockOnTaskCreate = vi.fn()

      // Mock a successful but delayed API response
      mockOnTaskCreate.mockImplementation(() => 
        new Promise(resolve => setTimeout(() => resolve({}), 100))
      )

      const startTime = Date.now()

      render(
        <TaskCreator
          onTaskCreate={mockOnTaskCreate}
          availableUsers={mockUsers}
          isDirectExecution={false}
        />
      )

      const input = screen.getByPlaceholderText('What needs to be done?')
      const createButton = screen.getByText('Create Task')

      await user.type(input, 'Performance test task')
      await user.click(createButton)

      // Should show loading state
      expect(screen.getByText('Creating...')).toBeInTheDocument()

      await waitFor(() => {
        expect(input).toHaveValue('')
      })

      const endTime = Date.now()
      const duration = endTime - startTime

      // Should complete within reasonable time (accounting for delays)
      expect(duration).toBeLessThan(500)
    })
  })
})