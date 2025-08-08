/// <reference types="vite/client" />

interface ImportMetaEnv {
  readonly VITE_BRAINBOT_API_URL: string
  readonly VITE_BRAINBOT_WEBHOOK_URL: string
  // more env variables...
}

interface ImportMeta {
  readonly env: ImportMetaEnv
}