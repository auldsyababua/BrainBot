import { describe, it, expect, vi } from 'vitest'
import { render, screen, waitFor } from '../../tests/test-utils'
import userEvent from '@testing-library/user-event'
import { CommandExecutor } from './CommandExecutor'

describe('CommandExecutor', () => {
  const mockOnCommand = vi.fn()

  const defaultProps = {
    onCommand: mockOnCommand
  }

  beforeEach(() => {
    mockOnCommand.mockClear()
  })

  it('renders command input form', () => {
    render(<CommandExecutor {...defaultProps} />)

    expect(screen.getByPlaceholderText('Type a command...')).toBeInTheDocument()
    expect(screen.getByRole('button')).toBeInTheDocument()
  })

  it('allows typing in command input', async () => {
    const user = userEvent.setup()
    render(<CommandExecutor {...defaultProps} />)

    const input = screen.getByPlaceholderText('Type a command...')
    await user.type(input, 'add task complete documentation')

    expect(input).toHaveValue('add task complete documentation')
  })

  it('executes command when form is submitted', async () => {
    const user = userEvent.setup()
    mockOnCommand.mockResolvedValue({})
    
    render(<CommandExecutor {...defaultProps} />)

    const input = screen.getByPlaceholderText('Type a command...')
    const button = screen.getByRole('button')

    await user.type(input, 'test command')
    await user.click(button)

    await waitFor(() => {
      expect(mockOnCommand).toHaveBeenCalledWith('test command')
    })
  })

  it('clears input after successful execution', async () => {
    const user = userEvent.setup()
    mockOnCommand.mockResolvedValue({})
    
    render(<CommandExecutor {...defaultProps} />)

    const input = screen.getByPlaceholderText('Type a command...')
    await user.type(input, 'test command')
    await user.click(screen.getByRole('button'))

    await waitFor(() => {
      expect(input).toHaveValue('')
    })
  })

  it('handles command execution error gracefully', async () => {
    const user = userEvent.setup()
    const consoleSpy = vi.spyOn(console, 'error').mockImplementation(() => {})
    mockOnCommand.mockRejectedValue(new Error('Execution failed'))
    
    render(<CommandExecutor {...defaultProps} />)

    const input = screen.getByPlaceholderText('Type a command...')
    const button = screen.getByRole('button')

    await user.type(input, 'failing command')
    await user.click(button)

    await waitFor(() => {
      expect(consoleSpy).toHaveBeenCalledWith('Command execution error:', expect.any(Error))
      expect(button).not.toBeDisabled() // Should not remain disabled
    })

    consoleSpy.mockRestore()
  })

  it('disables submit button when input is empty', () => {
    render(<CommandExecutor {...defaultProps} />)

    const button = screen.getByRole('button')
    expect(button).toBeDisabled()
  })

  it('disables submit button during execution', async () => {
    const user = userEvent.setup()
    mockOnCommand.mockImplementation(() => new Promise(resolve => setTimeout(resolve, 100)))
    
    render(<CommandExecutor {...defaultProps} />)

    const input = screen.getByPlaceholderText('Type a command...')
    const button = screen.getByRole('button')

    await user.type(input, 'test command')
    await user.click(button)

    expect(button).toBeDisabled()
    expect(input).toBeDisabled()
  })

  it('submits on Enter key press', async () => {
    const user = userEvent.setup()
    mockOnCommand.mockResolvedValue({})
    
    render(<CommandExecutor {...defaultProps} />)

    const input = screen.getByPlaceholderText('Type a command...')
    await user.type(input, 'test command{Enter}')

    await waitFor(() => {
      expect(mockOnCommand).toHaveBeenCalledWith('test command')
    })
  })
})