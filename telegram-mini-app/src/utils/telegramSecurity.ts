/**
 * Telegram Mini App Integration Utilities
 * Provides Telegram WebApp integration without blocking access
 */

export interface TelegramWebApp {
  initData: string;
  initDataUnsafe: {
    user?: {
      id: number;
      first_name: string;
      last_name?: string;
      username?: string;
      language_code?: string;
    };
    auth_date: number;
  };
  version: string;
  platform: string;
  isExpanded: boolean;
  viewportHeight: number;
  viewportStableHeight: number;
  headerColor: string;
  backgroundColor: string;
  isClosingConfirmationEnabled: boolean;
  ready: () => void;
  close: () => void;
  expand: () => void;
}

declare global {
  interface Window {
    Telegram?: {
      WebApp: TelegramWebApp;
    };
  }
}

/**
 * Check if the app is running inside Telegram
 * This is for informational purposes only, not for blocking access
 */
export function isTelegramEnvironment(): boolean {
  // Check for Telegram WebApp object
  return !!(window.Telegram?.WebApp);
}

/**
 * Initialize Telegram WebApp (if available)
 */
export function initTelegramWebApp(): TelegramWebApp | null {
  if (!window.Telegram?.WebApp) {
    return null;
  }

  const webApp = window.Telegram.WebApp;
  
  try {
    // Configure the app
    webApp.ready();
    webApp.expand();
  } catch (error) {
    console.warn('Error initializing Telegram WebApp:', error);
  }
  
  return webApp;
}

/**
 * Get user info from Telegram
 */
export function getTelegramUser() {
  if (!isTelegramEnvironment()) {
    return null;
  }

  return window.Telegram!.WebApp.initDataUnsafe.user;
}

/**
 * Validate Telegram init data (basic client-side check)
 * Note: Real validation should be done server-side
 */
export function validateTelegramData(): boolean {
  if (!isTelegramEnvironment()) {
    return false;
  }

  const webApp = window.Telegram!.WebApp;
  const { auth_date } = webApp.initDataUnsafe;
  
  // Check if data is not too old (24 hours)
  const now = Math.floor(Date.now() / 1000);
  const maxAge = 24 * 60 * 60; // 24 hours
  
  return (now - auth_date) < maxAge;
}