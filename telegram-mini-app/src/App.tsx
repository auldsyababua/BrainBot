import React, { useEffect } from 'react';
import { AppProvider } from './context/AppContext';
import { AppContainer } from './components/Layout/AppContainer';
import { initTelegramWebApp } from './utils/telegramSecurity';

export function App() {
  useEffect(() => {
    // Initialize Telegram WebApp if available (non-blocking)
    initTelegramWebApp();
  }, []);

  return (
    <AppProvider>
      <AppContainer />
    </AppProvider>
  );
}