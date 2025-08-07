import React, { useState, createContext, useContext } from 'react';
interface SmartRailsContextValue {
  isDirectMode: boolean;
  confidence: number;
  tokensSaved: number;
  lastCommandType: 'direct' | 'enhanced' | 'standard';
  setConfidence: (value: number) => void;
  setTokensSaved: (value: number) => void;
  setLastCommandType: (type: 'direct' | 'enhanced' | 'standard') => void;
  trackDirectExecution: (command: string, duration: number) => void;
  trackTokenSavings: (commandType: string, tokensSaved: number) => void;
}
const SmartRailsContext = createContext<SmartRailsContextValue>({
  isDirectMode: true,
  confidence: 100,
  tokensSaved: 0,
  lastCommandType: 'direct',
  setConfidence: () => {},
  setTokensSaved: () => {},
  setLastCommandType: () => {},
  trackDirectExecution: () => {},
  trackTokenSavings: () => {}
});
export const useSmartRailsContext = () => useContext(SmartRailsContext);
export const SmartRailsProvider: React.FC<{
  children: React.ReactNode;
}> = ({
  children
}) => {
  const [confidence, setConfidence] = useState(100);
  const [tokensSaved, setTokensSaved] = useState(0);
  const [lastCommandType, setLastCommandType] = useState<'direct' | 'enhanced' | 'standard'>('direct');
  const [executionStats, setExecutionStats] = useState<{
    command: string;
    duration: number;
  }[]>([]);
  const isDirectMode = confidence === 100;
  const trackDirectExecution = (command: string, duration: number) => {
    setExecutionStats(prev => [...prev, {
      command,
      duration
    }]);
    // In a real app, you might want to send this data to the server
  };
  const trackTokenSavings = (commandType: string, tokensCount: number) => {
    setTokensSaved(prev => prev + tokensCount);
    // In a real app, you might want to send this data to the server
  };
  const value: SmartRailsContextValue = {
    isDirectMode,
    confidence,
    tokensSaved,
    lastCommandType,
    setConfidence,
    setTokensSaved,
    setLastCommandType,
    trackDirectExecution,
    trackTokenSavings
  };
  return <SmartRailsContext.Provider value={value}>
      {children}
    </SmartRailsContext.Provider>;
};