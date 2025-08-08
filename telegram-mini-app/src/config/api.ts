/**
 * API Configuration for Telegram Mini App
 * Handles connection to the backend service
 */

// Base URL configuration
export const API_CONFIG = {
  // Use environment variable or fallback to local development
  BASE_URL: import.meta.env.VITE_API_BASE_URL || 'http://localhost:8000',
  
  // API version
  VERSION: import.meta.env.VITE_API_VERSION || 'v1',
  
  // Timeout settings
  TIMEOUT: 30000, // 30 seconds
  
  // Retry configuration
  RETRY_ATTEMPTS: 3,
  RETRY_DELAY: 1000, // 1 second
};

// Endpoint definitions
export const ENDPOINTS = {
  // Health check
  HEALTH: '/health',
  METRICS: '/metrics',
  
  // Memory operations
  MEMORIES: {
    LIST: '/api/memories',
    CREATE: '/api/memories',
    GET: (id: string) => `/api/memories/${id}`,
    UPDATE: (id: string) => `/api/memories/${id}`,
    DELETE: (id: string) => `/api/memories/${id}`,
    SEARCH: '/api/memories/search',
  },
  
  // Chat operations
  CHAT: {
    SEND: '/api/chat',
    HISTORY: '/api/chat/history',
  },
  
  // User operations
  USER: {
    PROFILE: '/api/user/profile',
    SETTINGS: '/api/user/settings',
  },
};

// Helper function to build full URL
export function buildUrl(endpoint: string): string {
  const baseUrl = API_CONFIG.BASE_URL.replace(/\/$/, '');
  const path = endpoint.startsWith('/') ? endpoint : `/${endpoint}`;
  return `${baseUrl}${path}`;
}

// Helper function to get auth headers with Telegram init data
export function getAuthHeaders(initData?: string): HeadersInit {
  const headers: HeadersInit = {
    'Content-Type': 'application/json',
  };
  
  if (initData || window.Telegram?.WebApp?.initData) {
    headers['X-Telegram-Init-Data'] = initData || window.Telegram.WebApp.initData;
  }
  
  return headers;
}

// API client with retry logic
export async function apiRequest<T>(
  endpoint: string,
  options: RequestInit = {},
  retries = API_CONFIG.RETRY_ATTEMPTS
): Promise<T> {
  const url = buildUrl(endpoint);
  const controller = new AbortController();
  const timeout = setTimeout(() => controller.abort(), API_CONFIG.TIMEOUT);
  
  try {
    const response = await fetch(url, {
      ...options,
      headers: {
        ...getAuthHeaders(),
        ...options.headers,
      },
      signal: controller.signal,
    });
    
    clearTimeout(timeout);
    
    if (!response.ok) {
      if (response.status === 429 && retries > 0) {
        // Rate limited, retry after delay
        await new Promise(resolve => setTimeout(resolve, API_CONFIG.RETRY_DELAY));
        return apiRequest<T>(endpoint, options, retries - 1);
      }
      
      throw new Error(`API Error: ${response.status} ${response.statusText}`);
    }
    
    return await response.json();
  } catch (error) {
    clearTimeout(timeout);
    
    if (error instanceof Error) {
      if (error.name === 'AbortError') {
        throw new Error('Request timeout');
      }
      
      if (retries > 0 && !error.message.includes('API Error')) {
        // Network error, retry
        await new Promise(resolve => setTimeout(resolve, API_CONFIG.RETRY_DELAY));
        return apiRequest<T>(endpoint, options, retries - 1);
      }
    }
    
    throw error;
  }
}

// Typed API methods
export const api = {
  // Health check
  async checkHealth() {
    return apiRequest<{ status: string; version: string }>(ENDPOINTS.HEALTH);
  },
  
  // Memory operations
  memories: {
    async list(params?: { limit?: number; offset?: number }) {
      const query = new URLSearchParams(params as any).toString();
      return apiRequest<Array<any>>(
        `${ENDPOINTS.MEMORIES.LIST}${query ? `?${query}` : ''}`
      );
    },
    
    async create(data: any) {
      return apiRequest(ENDPOINTS.MEMORIES.CREATE, {
        method: 'POST',
        body: JSON.stringify(data),
      });
    },
    
    async search(query: string) {
      return apiRequest(ENDPOINTS.MEMORIES.SEARCH, {
        method: 'POST',
        body: JSON.stringify({ query }),
      });
    },
  },
  
  // Chat operations
  chat: {
    async send(message: string) {
      return apiRequest(ENDPOINTS.CHAT.SEND, {
        method: 'POST',
        body: JSON.stringify({ message }),
      });
    },
    
    async getHistory(limit = 20) {
      return apiRequest(`${ENDPOINTS.CHAT.HISTORY}?limit=${limit}`);
    },
  },
};

export default api;