import React from 'react';
import { AppProvider } from './context/AppContext';
import { SmartRailsProvider } from './context/SmartRailsContext';
import { AppContainer } from './components/Layout/AppContainer';
export function App() {
  return <AppProvider>
      <SmartRailsProvider>
        <AppContainer />
      </SmartRailsProvider>
    </AppProvider>;
}