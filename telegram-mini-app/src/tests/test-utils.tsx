import React, { ReactElement } from 'react'
import { render, RenderOptions } from '@testing-library/react'
import { SmartRailsProvider } from '../context/SmartRailsContext'
import { AppProvider } from '../context/AppContext'

// Mock providers for testing
const AllTheProviders = ({ children }: { children: React.ReactNode }) => {
  return (
    <AppProvider>
      <SmartRailsProvider>
        {children}
      </SmartRailsProvider>
    </AppProvider>
  )
}

const customRender = (
  ui: ReactElement,
  options?: Omit<RenderOptions, 'wrapper'>
) => render(ui, { wrapper: AllTheProviders, ...options })

export * from '@testing-library/react'
export { customRender as render }