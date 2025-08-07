import { describe, it, expect, vi } from 'vitest'
import { render, screen, waitFor } from '../../tests/test-utils'
import userEvent from '@testing-library/user-event'
import { TaskCreator } from './TaskCreator'
import { createMockUser } from '../../tests/factories'

describe('TaskCreator', () => {
  const mockUsers = [
    createMockUser({ id: 1, username: 'alice', name: 'Alice Smith' }),
    createMockUser({ id: 2, username: 'bob', name: 'Bob Johnson' }),
    createMockUser({ id: 3, username: 'charlie', name: 'Charlie Wilson' })
  ]

  const mockOnTaskCreate = vi.fn()

  const defaultProps = {
    onTaskCreate: mockOnTaskCreate,
    availableUsers: mockUsers,
    isDirectExecution: false
  }

  beforeEach(() => {
    mockOnTaskCreate.mockClear()
  })

  it('renders task creation form', () => {
    render(<TaskCreator {...defaultProps} />)

    expect(screen.getByPlaceholderText('What needs to be done?')).toBeInTheDocument()
    expect(screen.getByText('Assign to')).toBeInTheDocument()
    expect(screen.getByText('Set due date')).toBeInTheDocument()
    expect(screen.getByText('Create Task')).toBeInTheDocument()
  })

  it('allows entering task description', async () => {
    const user = userEvent.setup()
    render(<TaskCreator {...defaultProps} />)

    const input = screen.getByPlaceholderText('What needs to be done?')
    await user.type(input, 'Complete project documentation')

    expect(input).toHaveValue('Complete project documentation')
  })

  it('creates task with description only', async () => {
    const user = userEvent.setup()
    mockOnTaskCreate.mockResolvedValue({})
    
    render(<TaskCreator {...defaultProps} />)

    const input = screen.getByPlaceholderText('What needs to be done?')
    const button = screen.getByText('Create Task')

    await user.type(input, 'Test task')
    await user.click(button)

    await waitFor(() => {
      expect(mockOnTaskCreate).toHaveBeenCalledWith({
        description: 'Test task',
        assignee: undefined,
        dueDate: null
      })
    })
  })

  it('shows assignee dropdown when clicked', async () => {
    const user = userEvent.setup()
    render(<TaskCreator {...defaultProps} />)

    const assignButton = screen.getByText('Assign to')
    await user.click(assignButton)

    expect(screen.getByText('Alice Smith (@alice)')).toBeInTheDocument()
    expect(screen.getByText('Bob Johnson (@bob)')).toBeInTheDocument()
    expect(screen.getByText('Charlie Wilson (@charlie)')).toBeInTheDocument()
  })

  it('selects assignee from dropdown', async () => {
    const user = userEvent.setup()
    mockOnTaskCreate.mockResolvedValue({})
    
    render(<TaskCreator {...defaultProps} />)

    // Open assignee dropdown
    const assignButton = screen.getByText('Assign to')
    await user.click(assignButton)

    // Select Alice
    const aliceOption = screen.getByText('Alice Smith (@alice)')
    await user.click(aliceOption)

    expect(screen.getByText('@alice')).toBeInTheDocument()

    // Create task
    const input = screen.getByPlaceholderText('What needs to be done?')
    const createButton = screen.getByText('Create Task')

    await user.type(input, 'Assigned task')
    await user.click(createButton)

    await waitFor(() => {
      expect(mockOnTaskCreate).toHaveBeenCalledWith({
        description: 'Assigned task',
        assignee: 'alice',
        dueDate: null
      })
    })
  })

  it('auto-assigns user when @mentioned in description', async () => {
    const user = userEvent.setup()
    render(<TaskCreator {...defaultProps} />)

    const input = screen.getByPlaceholderText('What needs to be done?')
    await user.type(input, 'Hey @bob can you handle this?')

    expect(screen.getByText('@bob')).toBeInTheDocument()
  })

  it('shows direct execution indicator when in Smart Rails mode', () => {
    render(<TaskCreator {...defaultProps} isDirectExecution={true} />)

    const input = screen.getByPlaceholderText('What needs to be done?')
    const zeroTokensIndicator = input.parentElement?.querySelector('[class*="bg-green-100"]')
    
    expect(zeroTokensIndicator).toBeInTheDocument()
  })

  it('disables create button when description is empty', () => {
    render(<TaskCreator {...defaultProps} />)

    const button = screen.getByText('Create Task')
    expect(button).toBeDisabled()
  })

  it('enables create button when description is provided', async () => {
    const user = userEvent.setup()
    render(<TaskCreator {...defaultProps} />)

    const input = screen.getByPlaceholderText('What needs to be done?')
    const button = screen.getByText('Create Task')

    await user.type(input, 'Test')
    expect(button).not.toBeDisabled()
  })

  it('shows loading state during task creation', async () => {
    const user = userEvent.setup()
    mockOnTaskCreate.mockImplementation(() => new Promise(resolve => setTimeout(resolve, 100)))
    
    render(<TaskCreator {...defaultProps} />)

    const input = screen.getByPlaceholderText('What needs to be done?')
    const button = screen.getByText('Create Task')

    await user.type(input, 'Test task')
    await user.click(button)

    expect(screen.getByText('Creating...')).toBeInTheDocument()
    expect(button).toBeDisabled()
  })

  it('resets form after successful task creation', async () => {
    const user = userEvent.setup()
    mockOnTaskCreate.mockResolvedValue({})
    
    render(<TaskCreator {...defaultProps} />)

    const input = screen.getByPlaceholderText('What needs to be done?')
    const button = screen.getByText('Create Task')

    await user.type(input, 'Test task')
    await user.click(button)

    await waitFor(() => {
      expect(input).toHaveValue('')
      expect(screen.getByText('Assign to')).toBeInTheDocument() // Should reset to default
    })
  })

  it('handles task creation error gracefully', async () => {
    const user = userEvent.setup()
    const consoleSpy = vi.spyOn(console, 'error').mockImplementation(() => {})
    mockOnTaskCreate.mockRejectedValue(new Error('Creation failed'))
    
    render(<TaskCreator {...defaultProps} />)

    const input = screen.getByPlaceholderText('What needs to be done?')
    const button = screen.getByText('Create Task')

    await user.type(input, 'Test task')
    await user.click(button)

    await waitFor(() => {
      expect(consoleSpy).toHaveBeenCalledWith('Error creating task:', expect.any(Error))
      expect(screen.getByText('Create Task')).toBeInTheDocument() // Should reset from loading state
    })

    consoleSpy.mockRestore()
  })

  it('opens date picker when due date button is clicked', async () => {
    const user = userEvent.setup()
    render(<TaskCreator {...defaultProps} />)

    const dueDateButton = screen.getByText('Set due date')
    await user.click(dueDateButton)

    expect(screen.getByText('January')).toBeInTheDocument() // Calendar should be visible
  })

  it('trims whitespace from task description', async () => {
    const user = userEvent.setup()
    mockOnTaskCreate.mockResolvedValue({})
    
    render(<TaskCreator {...defaultProps} />)

    const input = screen.getByPlaceholderText('What needs to be done?')
    const button = screen.getByText('Create Task')

    await user.type(input, '  Test task  ')
    await user.click(button)

    await waitFor(() => {
      expect(mockOnTaskCreate).toHaveBeenCalledWith({
        description: 'Test task',
        assignee: undefined,
        dueDate: null
      })
    })
  })
})