import { describe, it, expect, vi } from 'vitest'
import { render, screen, waitFor } from '../../tests/test-utils'
import userEvent from '@testing-library/user-event'
import { CommandExecutor } from './CommandExecutor'

// Mock the performance.now function
const mockPerformanceNow = vi.fn()
Object.defineProperty(window, 'performance', {
  value: { now: mockPerformanceNow },
  writable: true
})

describe('CommandExecutor', () => {
  const mockOnCommand = vi.fn()

  const defaultProps = {
    onCommand: mockOnCommand,
    showConfidence: true,
    enableDirectMode: true
  }

  beforeEach(() => {
    mockOnCommand.mockClear()
    mockPerformanceNow.mockClear()
  })

  it('renders command input form', () => {
    render(<CommandExecutor {...defaultProps} />)

    expect(screen.getByPlaceholderText('Type a command...')).toBeInTheDocument()
    expect(screen.getByRole('button', { name: /send/i })).toBeInTheDocument()
  })

  it('allows typing in command input', async () => {
    const user = userEvent.setup()
    render(<CommandExecutor {...defaultProps} />)

    const input = screen.getByPlaceholderText('Type a command...')
    await user.type(input, 'add task complete documentation')

    expect(input).toHaveValue('add task complete documentation')
  })

  it('calculates confidence for direct command patterns', async () => {
    const user = userEvent.setup()
    render(<CommandExecutor {...defaultProps} />)

    const input = screen.getByPlaceholderText('Type a command...')
    await user.type(input, 'add task complete documentation')

    // Should show 100% confidence for direct patterns
    expect(screen.getByText('100%')).toBeInTheDocument()
  })

  it('calculates lower confidence for ambiguous commands', async () => {
    const user = userEvent.setup()
    render(<CommandExecutor {...defaultProps} />)

    const input = screen.getByPlaceholderText('Type a command...')
    await user.type(input, 'hello')

    // Should show lower confidence for short/ambiguous text
    expect(screen.getByText('30%')).toBeInTheDocument()
  })

  it('shows direct execution indicator for high confidence commands', async () => {
    const user = userEvent.setup()
    render(<CommandExecutor {...defaultProps} />)

    const input = screen.getByPlaceholderText('Type a command...')
    await user.type(input, 'create list groceries')

    expect(screen.getByText('Direct Execution')).toBeInTheDocument()
    expect(screen.getByText('0 tokens • <50ms')).toBeInTheDocument()
  })

  it('executes command when form is submitted', async () => {
    const user = userEvent.setup()
    mockOnCommand.mockResolvedValue({})
    mockPerformanceNow.mockReturnValueOnce(100).mockReturnValueOnce(150)
    
    render(<CommandExecutor {...defaultProps} />)

    const input = screen.getByPlaceholderText('Type a command...')
    const button = screen.getByRole('button', { name: /send/i })

    await user.type(input, 'test command')
    await user.click(button)

    await waitFor(() => {
      expect(mockOnCommand).toHaveBeenCalledWith('test command')
    })
  })

  it('measures execution time for performance tracking', async () => {
    const user = userEvent.setup()
    const consoleSpy = vi.spyOn(console, 'log').mockImplementation(() => {})
    mockOnCommand.mockResolvedValue({})
    mockPerformanceNow.mockReturnValueOnce(100).mockReturnValueOnce(150)
    
    render(<CommandExecutor {...defaultProps} />)

    const input = screen.getByPlaceholderText('Type a command...')
    await user.type(input, 'add task test')
    await user.click(screen.getByRole('button', { name: /send/i }))

    await waitFor(() => {
      expect(consoleSpy).toHaveBeenCalledWith('Direct execution: 50ms')
    })

    consoleSpy.mockRestore()
  })

  it('clears input after successful execution', async () => {
    const user = userEvent.setup()
    mockOnCommand.mockResolvedValue({})
    
    render(<CommandExecutor {...defaultProps} />)

    const input = screen.getByPlaceholderText('Type a command...')
    await user.type(input, 'test command')
    await user.click(screen.getByRole('button', { name: /send/i }))

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
    const button = screen.getByRole('button', { name: /send/i })

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

    const button = screen.getByRole('button', { name: /send/i })
    expect(button).toBeDisabled()
  })

  it('disables submit button during execution', async () => {
    const user = userEvent.setup()
    mockOnCommand.mockImplementation(() => new Promise(resolve => setTimeout(resolve, 100)))
    
    render(<CommandExecutor {...defaultProps} />)

    const input = screen.getByPlaceholderText('Type a command...')
    const button = screen.getByRole('button', { name: /send/i })

    await user.type(input, 'test command')
    await user.click(button)

    expect(button).toBeDisabled()
    expect(input).toBeDisabled()
  })

  it('does not show confidence when showConfidence is false', () => {
    render(<CommandExecutor {...defaultProps} showConfidence={false} />)

    const input = screen.getByPlaceholderText('Type a command...')
    
    // Should not show confidence indicators
    expect(screen.queryByText('%')).not.toBeInTheDocument()
  })

  it('does not show direct execution indicator when enableDirectMode is false', async () => {
    const user = userEvent.setup()
    render(<CommandExecutor {...defaultProps} enableDirectMode={false} />)

    const input = screen.getByPlaceholderText('Type a command...')
    await user.type(input, 'add task test')

    expect(screen.queryByText('Direct Execution')).not.toBeInTheDocument()
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

  it('shows token savings display when confidence indicators are shown', async () => {
    const user = userEvent.setup()
    render(<CommandExecutor {...defaultProps} />)

    const input = screen.getByPlaceholderText('Type a command...')
    await user.type(input, 'add task test')

    // TokenSavingsDisplay should be rendered (it contains the "0 tokens" text)
    expect(screen.getByText('0 tokens • <50ms')).toBeInTheDocument()
  })

  it('updates confidence in real-time as user types', async () => {
    const user = userEvent.setup()
    render(<CommandExecutor {...defaultProps} />)

    const input = screen.getByPlaceholderText('Type a command...')
    
    // Start with short text (low confidence)
    await user.type(input, 'hi')
    expect(screen.getByText('30%')).toBeInTheDocument()

    // Add more text (higher confidence)
    await user.type(input, ' there how are you')
    expect(screen.getByText('75%')).toBeInTheDocument()
  })
})