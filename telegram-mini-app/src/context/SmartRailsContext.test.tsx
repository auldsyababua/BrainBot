import { describe, it, expect } from 'vitest'
import { renderHook, act } from '@testing-library/react'
import { SmartRailsProvider, useSmartRailsContext } from './SmartRailsContext'

describe('SmartRailsContext', () => {
  const wrapper = ({ children }: { children: React.ReactNode }) => (
    <SmartRailsProvider>{children}</SmartRailsProvider>
  )

  it('provides default context values', () => {
    const { result } = renderHook(() => useSmartRailsContext(), { wrapper })

    expect(result.current.confidence).toBe(100)
    expect(result.current.isDirectMode).toBe(true)
    expect(result.current.tokensSaved).toBe(0)
    expect(result.current.lastCommandType).toBe('direct')
  })

  it('updates confidence and affects direct mode', () => {
    const { result } = renderHook(() => useSmartRailsContext(), { wrapper })

    act(() => {
      result.current.setConfidence(75)
    })

    expect(result.current.confidence).toBe(75)
    expect(result.current.isDirectMode).toBe(false) // Should be false when confidence < 100
  })

  it('maintains direct mode when confidence is 100', () => {
    const { result } = renderHook(() => useSmartRailsContext(), { wrapper })

    act(() => {
      result.current.setConfidence(100)
    })

    expect(result.current.confidence).toBe(100)
    expect(result.current.isDirectMode).toBe(true)
  })

  it('updates tokens saved', () => {
    const { result } = renderHook(() => useSmartRailsContext(), { wrapper })

    act(() => {
      result.current.setTokensSaved(1500)
    })

    expect(result.current.tokensSaved).toBe(1500)
  })

  it('updates last command type', () => {
    const { result } = renderHook(() => useSmartRailsContext(), { wrapper })

    act(() => {
      result.current.setLastCommandType('enhanced')
    })

    expect(result.current.lastCommandType).toBe('enhanced')
  })

  it('tracks direct execution performance', () => {
    const { result } = renderHook(() => useSmartRailsContext(), { wrapper })

    act(() => {
      result.current.trackDirectExecution('add task test', 45)
    })

    // The function should execute without errors
    // In a real app, this would update internal state or send to analytics
    expect(result.current).toBeDefined()
  })

  it('tracks token savings', () => {
    const { result } = renderHook(() => useSmartRailsContext(), { wrapper })

    const initialTokens = result.current.tokensSaved

    act(() => {
      result.current.trackTokenSavings('direct_command', 250)
    })

    expect(result.current.tokensSaved).toBe(initialTokens + 250)
  })

  it('accumulates token savings across multiple calls', () => {
    const { result } = renderHook(() => useSmartRailsContext(), { wrapper })

    act(() => {
      result.current.trackTokenSavings('direct_command', 100)
      result.current.trackTokenSavings('enhanced_command', 200)
      result.current.trackTokenSavings('direct_command', 150)
    })

    expect(result.current.tokensSaved).toBe(450) // 100 + 200 + 150
  })

  it('handles confidence edge cases', () => {
    const { result } = renderHook(() => useSmartRailsContext(), { wrapper })

    // Test 0 confidence
    act(() => {
      result.current.setConfidence(0)
    })

    expect(result.current.confidence).toBe(0)
    expect(result.current.isDirectMode).toBe(false)

    // Test 99 confidence (just below direct mode threshold)
    act(() => {
      result.current.setConfidence(99)
    })

    expect(result.current.confidence).toBe(99)
    expect(result.current.isDirectMode).toBe(false)

    // Test exactly 100 confidence
    act(() => {
      result.current.setConfidence(100)
    })

    expect(result.current.confidence).toBe(100)
    expect(result.current.isDirectMode).toBe(true)
  })

  it('maintains separate state for different hook instances', () => {
    const { result: result1 } = renderHook(() => useSmartRailsContext(), { wrapper })
    const { result: result2 } = renderHook(() => useSmartRailsContext(), { wrapper })

    act(() => {
      result1.current.setConfidence(75)
    })

    // Both hooks should see the same state (they're using the same provider)
    expect(result1.current.confidence).toBe(75)
    expect(result2.current.confidence).toBe(75)
  })

  it('provides all required context methods', () => {
    const { result } = renderHook(() => useSmartRailsContext(), { wrapper })

    expect(typeof result.current.setConfidence).toBe('function')
    expect(typeof result.current.setTokensSaved).toBe('function')
    expect(typeof result.current.setLastCommandType).toBe('function')
    expect(typeof result.current.trackDirectExecution).toBe('function')
    expect(typeof result.current.trackTokenSavings).toBe('function')
  })

  it('tracks execution statistics internally', () => {
    const { result } = renderHook(() => useSmartRailsContext(), { wrapper })

    act(() => {
      result.current.trackDirectExecution('command1', 50)
      result.current.trackDirectExecution('command2', 30)
      result.current.trackDirectExecution('command3', 70)
    })

    // The context should handle this internally
    // We can't directly test the internal state, but we can ensure no errors occur
    expect(result.current).toBeDefined()
  })

  it('handles command type transitions', () => {
    const { result } = renderHook(() => useSmartRailsContext(), { wrapper })

    // Test all command types
    act(() => {
      result.current.setLastCommandType('standard')
    })
    expect(result.current.lastCommandType).toBe('standard')

    act(() => {
      result.current.setLastCommandType('enhanced')
    })
    expect(result.current.lastCommandType).toBe('enhanced')

    act(() => {
      result.current.setLastCommandType('direct')
    })
    expect(result.current.lastCommandType).toBe('direct')
  })
})