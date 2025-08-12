import React, { useEffect, useState } from 'react';
import { isTelegramEnvironment, initTelegramWebApp } from '../../utils/telegramSecurity';

interface TelegramGuardProps {
  children: React.ReactNode;
}

/**
 * Security component that ensures the app only works within Telegram
 */
export function TelegramGuard({ children }: TelegramGuardProps) {
  const [isValid, setIsValid] = useState(false);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    // Give Telegram WebApp a moment to initialize
    const timer = setTimeout(() => {
      const isTelegram = isTelegramEnvironment();
      
      if (isTelegram) {
        initTelegramWebApp();
        setIsValid(true);
      } else {
        setIsValid(false);
      }
      
      setIsLoading(false);
    }, 100);

    return () => clearTimeout(timer);
  }, []);

  if (isLoading) {
    return (
      <div className="flex items-center justify-center min-h-screen bg-gray-900 text-white">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-500 mx-auto mb-4"></div>
          <p>Loading...</p>
        </div>
      </div>
    );
  }

  if (!isValid) {
    return (
      <div className="flex items-center justify-center min-h-screen bg-gray-900 text-white">
        <div className="text-center max-w-md mx-auto p-6">
          <div className="text-6xl mb-4">🔒</div>
          <h1 className="text-2xl font-bold mb-4">Access Restricted</h1>
          <p className="text-gray-300 mb-6">
            This application can only be accessed through Telegram.
          </p>
          <div className="bg-blue-900/30 border border-blue-500/30 rounded-lg p-4">
            <p className="text-sm text-blue-300">
              Please open this app through your Telegram bot's Mini App menu.
            </p>
          </div>
        </div>
      </div>
    );
  }

  return <>{children}</>;
}