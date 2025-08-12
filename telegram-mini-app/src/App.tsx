import React, { useEffect } from 'react';
import { AppProvider } from './context/AppContext';
import { SmartRailsProvider } from './context/SmartRailsContext';
import { AppContainer } from './components/Layout/AppContainer';
import { initTelegramWebApp } from './utils/telegramSecurity';

export function App() {
  useEffect(() => {
    // Initialize Telegram WebApp if available (non-blocking)
    initTelegramWebApp();
  }, []);

  return (
    <AppProvider>
      <SmartRailsProvider>
        <AppContainer />
      </SmartRailsProvider>
    </AppProvider>
  );
}