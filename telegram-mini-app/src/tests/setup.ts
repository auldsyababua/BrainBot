import '@testing-library/jest-dom'
import { expect, afterEach, beforeAll, afterAll, vi } from 'vitest'
import { cleanup } from '@testing-library/react'
import * as matchers from '@testing-library/jest-dom/matchers'
import { server } from './mocks/server'

// Extend Vitest's expect with jest-dom matchers
expect.extend(matchers)

// Establish API mocking before all tests
beforeAll(() => server.listen({ onUnhandledRequest: 'error' }))

// Reset any request handlers that we may add during the tests,
// so they don't affect other tests
afterEach(() => {
  server.resetHandlers()
  cleanup()
})

// Clean up after the tests are finished
afterAll(() => server.close())

// Mock Telegram Web App API
const mockTelegramWebApp = {
  initData: '',
  initDataUnsafe: {
    user: {
      id: 123456789,
      first_name: 'Test',
      last_name: 'User',
      username: 'testuser',
      language_code: 'en'
    },
    chat_type: 'sender',
    auth_date: Date.now()
  },
  version: '6.0',
  platform: 'unknown',
  colorScheme: 'light',
  themeParams: {
    bg_color: '#ffffff',
    text_color: '#000000',
    hint_color: '#999999',
    link_color: '#2481cc',
    button_color: '#2481cc',
    button_text_color: '#ffffff'
  },
  isExpanded: true,
  viewportHeight: 600,
  viewportStableHeight: 600,
  headerColor: '#ffffff',
  backgroundColor: '#ffffff',
  isClosingConfirmationEnabled: false,
  MainButton: {
    text: '',
    color: '#2481cc',
    textColor: '#ffffff',
    isVisible: false,
    isProgressVisible: false,
    isActive: true,
    setText: vi.fn(),
    onClick: vi.fn(),
    show: vi.fn(),
    hide: vi.fn(),
    enable: vi.fn(),
    disable: vi.fn(),
    showProgress: vi.fn(),
    hideProgress: vi.fn(),
    setParams: vi.fn()
  },
  BackButton: {
    isVisible: false,
    onClick: vi.fn(),
    show: vi.fn(),
    hide: vi.fn()
  },
  HapticFeedback: {
    impactOccurred: vi.fn(),
    notificationOccurred: vi.fn(),
    selectionChanged: vi.fn()
  },
  close: vi.fn(),
  expand: vi.fn(),
  ready: vi.fn(),
  sendData: vi.fn(),
  switchInlineQuery: vi.fn(),
  openLink: vi.fn(),
  openTelegramLink: vi.fn(),
  openInvoice: vi.fn(),
  showConfirm: vi.fn(),
  showAlert: vi.fn(),
  showPopup: vi.fn(),
  showScanQrPopup: vi.fn(),
  closeScanQrPopup: vi.fn(),
  readTextFromClipboard: vi.fn(),
  requestWriteAccess: vi.fn(),
  requestContact: vi.fn(),
  onEvent: vi.fn(),
  offEvent: vi.fn(),
  setHeaderColor: vi.fn(),
  setBackgroundColor: vi.fn(),
  setBottomBarColor: vi.fn(),
  enableClosingConfirmation: vi.fn(),
  disableClosingConfirmation: vi.fn(),
  isVersionAtLeast: vi.fn(() => true),
  shareToStory: vi.fn(),
  CloudStorage: {
    setItem: vi.fn((key, value, callback) => {
      if (callback) callback(null, true)
      return Promise.resolve(true)
    }),
    getItem: vi.fn((key, callback) => {
      if (callback) callback(null, '')
      return Promise.resolve('')
    }),
    getItems: vi.fn((keys, callback) => {
      if (callback) callback(null, {})
      return Promise.resolve({})
    }),
    removeItem: vi.fn((key, callback) => {
      if (callback) callback(null, true)
      return Promise.resolve(true)
    }),
    removeItems: vi.fn((keys, callback) => {
      if (callback) callback(null, true)
      return Promise.resolve(true)
    }),
    getKeys: vi.fn((callback) => {
      if (callback) callback(null, [])
      return Promise.resolve([])
    }),
  }
}

// Mock window.Telegram
Object.defineProperty(window, 'Telegram', {
  value: {
    WebApp: mockTelegramWebApp
  },
  writable: true
})

// Mock fetch globally
global.fetch = vi.fn()

// Mock ResizeObserver
global.ResizeObserver = vi.fn().mockImplementation(() => ({
  observe: vi.fn(),
  unobserve: vi.fn(),
  disconnect: vi.fn(),
}))

// Mock IntersectionObserver
global.IntersectionObserver = vi.fn().mockImplementation(() => ({
  observe: vi.fn(),
  unobserve: vi.fn(),
  disconnect: vi.fn(),
}))

// Mock HTMLElement.scrollIntoView
Element.prototype.scrollIntoView = vi.fn()

// Mock performance.now for timing tests
Object.defineProperty(window, 'performance', {
  value: {
    now: vi.fn(() => Date.now())
  },
  writable: true
})

// Mock matchMedia for responsive components
Object.defineProperty(window, 'matchMedia', {
  writable: true,
  value: vi.fn().mockImplementation(query => ({
    matches: false,
    media: query,
    onchange: null,
    addListener: vi.fn(),
    removeListener: vi.fn(),
    addEventListener: vi.fn(),
    removeEventListener: vi.fn(),
    dispatchEvent: vi.fn(),
  })),
})

// Helper to reset all mocks
export const resetAllMocks = () => {
  vi.clearAllMocks()
  
  // Reset fetch mock if it's mocked
  if (vi.isMockFunction(fetch)) {
    vi.mocked(fetch).mockClear()
  }
  
  // Reset Telegram WebApp mocks
  Object.values(mockTelegramWebApp.MainButton).forEach(fn => {
    if (typeof fn === 'function') {
      vi.mocked(fn).mockClear()
    }
  })
  Object.values(mockTelegramWebApp.BackButton).forEach(fn => {
    if (typeof fn === 'function') {
      vi.mocked(fn).mockClear()
    }
  })
  Object.values(mockTelegramWebApp.HapticFeedback).forEach(fn => {
    if (typeof fn === 'function') {
      vi.mocked(fn).mockClear()
    }
  })
}

// Export mock objects for use in tests
export { mockTelegramWebApp }