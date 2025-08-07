import { describe, it, expect } from 'vitest'
import { render, screen } from '../../tests/test-utils'
import { PerformanceMetrics } from './PerformanceMetrics'
import { createMockPerformanceMetrics } from '../../tests/factories'

describe('PerformanceMetrics', () => {
  const defaultMetrics = createMockPerformanceMetrics()

  it('renders performance metrics correctly', () => {
    render(<PerformanceMetrics metrics={defaultMetrics} />)

    expect(screen.getByText('Performance')).toBeInTheDocument()
    expect(screen.getByText('Tokens Saved')).toBeInTheDocument()
    expect(screen.getByText('Avg Response')).toBeInTheDocument()
    expect(screen.getByText('Direct Execution Rate')).toBeInTheDocument()
  })

  it('displays tokens saved with proper formatting', () => {
    const metrics = createMockPerformanceMetrics({ tokensSaved: 45123 })
    render(<PerformanceMetrics metrics={metrics} />)

    expect(screen.getByText('45,123')).toBeInTheDocument()
    expect(screen.getByText('tokens')).toBeInTheDocument()
  })

  it('displays average response time', () => {
    const metrics = createMockPerformanceMetrics({ averageResponseTime: 42 })
    render(<PerformanceMetrics metrics={metrics} />)

    expect(screen.getByText('42')).toBeInTheDocument()
    expect(screen.getByText('ms')).toBeInTheDocument()
  })

  it('displays direct execution rate as percentage', () => {
    const metrics = createMockPerformanceMetrics({ directExecutionRate: 85 })
    render(<PerformanceMetrics metrics={metrics} />)

    expect(screen.getByText('85%')).toBeInTheDocument()
  })

  it('renders progress bar with correct width', () => {
    const metrics = createMockPerformanceMetrics({ directExecutionRate: 75 })
    render(<PerformanceMetrics metrics={metrics} />)

    const progressBar = document.querySelector('.bg-purple-600')
    expect(progressBar).toHaveStyle({ width: '75%' })
  })

  it('displays Smart Rails token reduction message', () => {
    render(<PerformanceMetrics metrics={defaultMetrics} />)

    expect(screen.getByText('70% Token Reduction with Smart Rails')).toBeInTheDocument()
  })

  it('handles zero values gracefully', () => {
    const zeroMetrics = createMockPerformanceMetrics({
      totalCommands: 0,
      tokensSaved: 0,
      averageResponseTime: 0,
      directExecutionRate: 0
    })

    render(<PerformanceMetrics metrics={zeroMetrics} />)

    expect(screen.getByText('0')).toBeInTheDocument()
    expect(screen.getByText('0%')).toBeInTheDocument()
  })

  it('handles large numbers correctly', () => {
    const largeMetrics = createMockPerformanceMetrics({
      tokensSaved: 1234567,
      averageResponseTime: 999
    })

    render(<PerformanceMetrics metrics={largeMetrics} />)

    expect(screen.getByText('1,234,567')).toBeInTheDocument()
    expect(screen.getByText('999')).toBeInTheDocument()
  })

  it('renders with proper CSS classes for styling', () => {
    const { container } = render(<PerformanceMetrics metrics={defaultMetrics} />)

    const mainContainer = container.firstChild
    expect(mainContainer).toHaveClass('bg-white', 'dark:bg-gray-800', 'rounded-lg', 'p-4', 'shadow-sm')
  })

  it('displays icons for each metric section', () => {
    render(<PerformanceMetrics metrics={defaultMetrics} />)

    // Check for Lucide React icons (they render as SVG elements)
    const icons = document.querySelectorAll('svg')
    expect(icons.length).toBeGreaterThan(0)
  })
})