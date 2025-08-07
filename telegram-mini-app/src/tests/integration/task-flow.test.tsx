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
      const mockExecuteDirectCommand = vi.mocked(brainbotApi.executeDirectCommand)
      const mockOnCommand = vi.fn()
      const consoleSpy = vi.spyOn(console, 'log').mockImplementation(() => {})

      mockExecuteDirectCommand.mockResolvedValue({ success: true })

      // Mock performance.now for timing
      const mockNow = vi.spyOn(performance, 'now')
      mockNow.mockReturnValueOnce(100).mockReturnValueOnce(150)

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

      // Should show 100% confidence for direct pattern
      expect(screen.getByText('100%')).toBeInTheDocument()
      expect(screen.getByText('Direct Execution')).toBeInTheDocument()

      await user.click(submitButton)

      await waitFor(() => {
        expect(mockOnCommand).toHaveBeenCalledWith('add task complete integration tests')
      })

      // Should log performance metrics
      expect(consoleSpy).toHaveBeenCalledWith('Direct execution: 50ms')

      // Input should clear after execution
      expect(input).toHaveValue('')

      consoleSpy.mockRestore()
      mockNow.mockRestore()
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

      // Test progression of confidence levels
      await user.type(input, 'hi')
      expect(screen.getByText('30%')).toBeInTheDocument()

      await user.clear(input)
      await user.type(input, 'hello there')
      expect(screen.getByText('50%')).toBeInTheDocument()

      await user.clear(input)
      await user.type(input, 'this is a longer message')
      expect(screen.getByText('75%')).toBeInTheDocument()

      await user.clear(input)
      await user.type(input, 'create list shopping items')
      expect(screen.getByText('100%')).toBeInTheDocument()
      expect(screen.getByText('Direct Execution')).toBeInTheDocument()
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

      // Should show direct execution in both components
      expect(screen.getByText('Direct Execution')).toBeInTheDocument()

      // TaskCreator should show the direct execution indicator
      const taskInput = screen.getByPlaceholderText('What needs to be done?')
      const zeroTokensIndicator = taskInput.parentElement?.querySelector('[class*="bg-green-100"]')
      expect(zeroTokensIndicator).toBeInTheDocument()
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
      const commandButton = screen.getByRole('button', { name: /send/i })
      
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