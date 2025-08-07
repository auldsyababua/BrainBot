import React from 'react';
import { LayoutDashboard, CheckSquare, List, Settings, MessageCircle } from 'lucide-react';
import { useAppContext } from '../../context/AppContext';
import { useChatContext } from '../../context/ChatContext';
interface NavigationTabsProps {
  activeTab: 'dashboard' | 'tasks' | 'lists' | 'chat' | 'settings';
  notifications?: Record<string, number>;
}
export const NavigationTabs: React.FC<NavigationTabsProps> = ({
  activeTab,
  notifications = {}
}) => {
  const {
    setActiveTab
  } = useAppContext();
  const {
    unreadCount,
    isTyping
  } = useChatContext();
  return <nav className="flex justify-around items-center h-16 border-t border-gray-200 dark:border-gray-800 bg-white dark:bg-gray-950">
      <button onClick={() => setActiveTab('dashboard')} className={`flex flex-col items-center justify-center w-full h-full ${activeTab === 'dashboard' ? 'text-blue-600 dark:text-blue-400' : 'text-gray-500 dark:text-gray-400'}`}>
        <LayoutDashboard size={20} />
        <span className="text-xs mt-1">Dashboard</span>
      </button>
      <button onClick={() => setActiveTab('tasks')} className={`flex flex-col items-center justify-center w-full h-full relative ${activeTab === 'tasks' ? 'text-blue-600 dark:text-blue-400' : 'text-gray-500 dark:text-gray-400'}`}>
        <CheckSquare size={20} />
        <span className="text-xs mt-1">Tasks</span>
        {notifications.tasks && notifications.tasks > 0 && <span className="absolute top-1 right-1/4 bg-red-500 text-white text-xs rounded-full h-5 w-5 flex items-center justify-center">
            {notifications.tasks}
          </span>}
      </button>
      <button onClick={() => setActiveTab('lists')} className={`flex flex-col items-center justify-center w-full h-full relative ${activeTab === 'lists' ? 'text-blue-600 dark:text-blue-400' : 'text-gray-500 dark:text-gray-400'}`}>
        <List size={20} />
        <span className="text-xs mt-1">Lists</span>
        {notifications.lists && notifications.lists > 0 && <span className="absolute top-1 right-1/4 bg-red-500 text-white text-xs rounded-full h-5 w-5 flex items-center justify-center">
            {notifications.lists}
          </span>}
      </button>
      <button onClick={() => setActiveTab('chat')} className={`flex flex-col items-center justify-center w-full h-full relative ${activeTab === 'chat' ? 'text-blue-600 dark:text-blue-400' : 'text-gray-500 dark:text-gray-400'}`}>
        <MessageCircle size={20} />
        <span className="text-xs mt-1">Chat</span>
        {unreadCount > 0 && <span className="absolute top-1 right-1/4 bg-red-500 text-white text-xs rounded-full h-5 w-5 flex items-center justify-center">
            {unreadCount}
          </span>}
        {isTyping && activeTab !== 'chat' && <span className="absolute top-1 right-1/4 bg-green-500 text-white text-xs rounded-full h-5 w-5 flex items-center justify-center animate-pulse">
            •••
          </span>}
      </button>
      <button onClick={() => setActiveTab('settings')} className={`flex flex-col items-center justify-center w-full h-full ${activeTab === 'settings' ? 'text-blue-600 dark:text-blue-400' : 'text-gray-500 dark:text-gray-400'}`}>
        <Settings size={20} />
        <span className="text-xs mt-1">Settings</span>
      </button>
    </nav>;
};