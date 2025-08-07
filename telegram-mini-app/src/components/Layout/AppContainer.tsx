import React from 'react';
import { useAppContext } from '../../context/AppContext';
import { MobileLayout } from './MobileLayout';
import { DashboardHeader } from '../Dashboard/DashboardHeader';
import { NavigationTabs } from '../Common/NavigationTabs';
import { Dashboard } from '../Dashboard/Dashboard';
import { TasksView } from '../Tasks/TasksView';
import { ListsView } from '../Lists/ListsView';
import { SettingsView } from '../Settings/SettingsView';
import { ChatView } from '../Chat/ChatView';
import { ErrorBoundary } from '../Common/ErrorBoundary';
import { StatusIndicator } from '../Common/StatusIndicator';
import { ChatProvider } from '../../context/ChatContext';
export const AppContainer: React.FC = () => {
  const {
    activeTab,
    isOnline,
    botStatus,
    user,
    refreshData
  } = useAppContext();
  return <ErrorBoundary>
      <ChatProvider>
        <MobileLayout>
          <div className="flex flex-col h-full w-full bg-gray-50 dark:bg-gray-900">
            <DashboardHeader userName={user?.first_name || 'User'} botStatus={botStatus.status} onRefresh={refreshData} />
            {!isOnline && <StatusIndicator type="error" message="You're offline. Some features may be unavailable." />}
            <main className="flex-1 overflow-y-auto">
              {activeTab === 'dashboard' && <Dashboard />}
              {activeTab === 'tasks' && <TasksView />}
              {activeTab === 'lists' && <ListsView />}
              {activeTab === 'chat' && <ChatView />}
              {activeTab === 'settings' && <SettingsView />}
            </main>
            <NavigationTabs activeTab={activeTab} notifications={{
            tasks: 2
          }} />
          </div>
        </MobileLayout>
      </ChatProvider>
    </ErrorBoundary>;
};