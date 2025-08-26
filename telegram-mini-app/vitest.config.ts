/// <reference types="vitest" />
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import path from 'path'
import tsconfigPaths from 'vite-tsconfig-paths'

export default defineConfig({
  plugins: [
    react(),
    tsconfigPaths() // Handles TypeScript path aliases
  ],
  test: {
    globals: true,
    environment: 'jsdom',
    setupFiles: ['./src/tests/setup.ts'],
    css: true,
    // Fix for CI environment differences
    pool: 'forks', // Use forks instead of threads to avoid issues
    testTimeout: 10000,
    hookTimeout: 10000,
    coverage: {
      provider: 'v8',
      reporter: ['text', 'json', 'html'],
      exclude: [
        'node_modules/',
        'src/tests/',
        '**/*.d.ts',
        '**/*.config.*',
        '**/coverage/**',
        'dist/',
        'public/',
        '**/*.test.*',
        '**/*.spec.*',
        'src/main.tsx',
        'src/index.tsx',
        'vite.config.ts',
        'vitest.config.ts'
      ],
      thresholds: {
        global: {
          statements: 80,
          branches: 70,
          functions: 80,
          lines: 80
        },
        './src/components/Dashboard/PerformanceMetrics.tsx': {
          statements: 90,
          branches: 85,
          functions: 90,
          lines: 90
        },
        './src/components/Tasks/TaskCreator.tsx': {
          statements: 85,
          branches: 80,
          functions: 85,
          lines: 85
        },
        './src/components/SmartRails/CommandExecutor.tsx': {
          statements: 85,
          branches: 80,
          functions: 85,
          lines: 85
        },
        './src/services/brainbotApi.ts': {
          statements: 90,
          branches: 85,
          functions: 90,
          lines: 90
        }
      }
    },
    include: ['src/**/*.{test,spec}.{js,mjs,cjs,ts,mts,cts,jsx,tsx}'],
    exclude: [
      'node_modules/',
      'dist/',
      '.idea/',
      '.git/',
      '.cache/',
      'public/'
    ]
  },
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
      '@components': path.resolve(__dirname, './src/components'),
      '@services': path.resolve(__dirname, './src/services'),
      '@context': path.resolve(__dirname, './src/context'),
    },
  },
})