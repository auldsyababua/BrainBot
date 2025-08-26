import { defineConfig, mergeConfig } from 'vitest/config'
import viteConfig from './vite.config'

export default mergeConfig(
  viteConfig,
  defineConfig({
    test: {
      globals: true,
      environment: 'jsdom',
      setupFiles: ['./src/tests/setup.ts'],
      css: false,
      include: ['src/**/*.{test,spec}.{js,mjs,cjs,ts,mts,cts,jsx,tsx}'],
      coverage: {
        provider: 'v8',
        reporter: ['text', 'json', 'html'],
        exclude: [
          'node_modules/',
          'src/tests/',
          '*.config.ts',
          'src/vite-env.d.ts',
          'src/main.tsx'
        ]
      },
      // CI-specific optimizations
      pool: 'forks',
      poolOptions: {
        forks: {
          singleFork: true
        }
      },
      testTimeout: 20000,
      hookTimeout: 20000,
      teardownTimeout: 5000,
      isolate: true,
      threads: false,
      maxConcurrency: 1,
      bail: 0,
      // Retry failed tests once in CI
      retry: 1,
      // Silence console output in CI
      silent: false,
      logHeapUsage: true,
      // Environment variables for CI
      env: {
        CI: 'true',
        NODE_ENV: 'test',
        VITE_API_URL: 'http://localhost:5000',
        VITE_BOT_USERNAME: 'test_bot',
        VITE_ENVIRONMENT: 'test'
      }
    }
  })
)