import React, { useEffect, useState, createContext, useContext } from 'react';
import { checkHealth, getTasks, getList } from '../services/brainbotApi';
export interface TelegramUser {
  id: number;
  first_name: string;
  last_name?: string;
  username?: string;
  language_code?: string;
}
export interface BotStatus {
  status: 'healthy' | 'degraded' | 'unhealthy';
  message: string;
  lastUpdated: Date;
}
export interface PerformanceStats {
  totalCommands: number;
  tokensSaved: number;
  averageResponseTime: number;
  directExecutionRate: number;
}
export interface Task {
  id: string;
  description: string;
  assignee: string;
  status: 'active' | 'completed';
  createdAt: Date;
  completedAt?: Date;
}
export interface List {
  id: string;
  name: string;
  items: string[];
  createdAt: Date;
  updatedAt: Date;
}
interface AppContextValue {
  user: TelegramUser | null;
  botStatus: BotStatus;
  performance: PerformanceStats;
  tasks: Task[];
  lists: List[];
  isOnline: boolean;
  activeTab: 'dashboard' | 'tasks' | 'lists' | 'settings';
  setActiveTab: (tab: 'dashboard' | 'tasks' | 'lists' | 'settings') => void;
  refreshData: () => Promise<void>;
}
const defaultPerformanceStats: PerformanceStats = {
  totalCommands: 150,
  tokensSaved: 45000,
  averageResponseTime: 42,
  directExecutionRate: 85
};
const defaultBotStatus: BotStatus = {
  status: 'healthy',
  message: 'System operational',
  lastUpdated: new Date()
};
const AppContext = createContext<AppContextValue>({
  user: null,
  botStatus: defaultBotStatus,
  performance: defaultPerformanceStats,
  tasks: [],
  lists: [],
  isOnline: true,
  activeTab: 'dashboard',
  setActiveTab: () => {},
  refreshData: async () => {}
});
export const useAppContext = () => useContext(AppContext);
export const AppProvider: React.FC<{
  children: React.ReactNode;
}> = ({
  children
}) => {
  const [user, setUser] = useState<TelegramUser | null>(null);
  const [botStatus, setBotStatus] = useState<BotStatus>(defaultBotStatus);
  const [performance, setPerformance] = useState<PerformanceStats>(defaultPerformanceStats);
  const [tasks, setTasks] = useState<Task[]>([]);
  const [lists, setLists] = useState<List[]>([]);
  const [isOnline, setIsOnline] = useState(true);
  const [activeTab, setActiveTab] = useState<'dashboard' | 'tasks' | 'lists' | 'settings'>('dashboard');
  // Initialize Telegram Web App
  useEffect(() => {
    const initTelegramApp = () => {
      if (window.Telegram?.WebApp) {
        const telegramApp = window.Telegram.WebApp;
        telegramApp.ready();
        // Extract user data
        if (telegramApp.initDataUnsafe?.user) {
          setUser(telegramApp.initDataUnsafe.user);
        } else {
          // Mock user for development
          setUser({
            id: 12345,
            first_name: 'Test',
            last_name: 'User',
            username: 'testuser'
          });
        }
      } else {
        // Mock user for development
        setUser({
          id: 12345,
          first_name: 'Test',
          last_name: 'User',
          username: 'testuser'
        });
        console.warn('Telegram WebApp not available. Running in development mode.');
      }
    };
    initTelegramApp();
  }, []);
  // Initial data fetch
  useEffect(() => {
    refreshData();
    // Set up polling for real-time updates
    const intervalId = setInterval(refreshData, 30000); // Poll every 30 seconds
    return () => clearInterval(intervalId);
  }, []);
  // Check online status
  useEffect(() => {
    const handleOnlineStatus = () => {
      setIsOnline(navigator.onLine);
    };
    window.addEventListener('online', handleOnlineStatus);
    window.addEventListener('offline', handleOnlineStatus);
    return () => {
      window.removeEventListener('online', handleOnlineStatus);
      window.removeEventListener('offline', handleOnlineStatus);
    };
  }, []);
  const refreshData = async () => {
    try {
      // Fetch bot health status
      const healthResponse = await checkHealth();
      setBotStatus({
        status: healthResponse.status,
        message: healthResponse.message,
        lastUpdated: new Date()
      });
      // Use static performance data (no API call)
      setPerformance(defaultPerformanceStats);
      // Fetch tasks
      const tasksResponse = await getTasks();
      setTasks(tasksResponse);
      // For simplicity, just fetch one list for now
      // In a real app, you'd fetch all lists or implement pagination
      try {
        const listResponse = await getList('default');
        if (listResponse) {
          setLists([listResponse]);
        }
      } catch (error) {
        console.error('Error fetching lists:', error);
      }
    } catch (error) {
      console.error('Error refreshing data:', error);
      setIsOnline(false);
    }
  };
  const value: AppContextValue = {
    user,
    botStatus,
    performance,
    tasks,
    lists,
    isOnline,
    activeTab,
    setActiveTab,
    refreshData
  };
  return <AppContext.Provider value={value}>{children}</AppContext.Provider>;
};
// Add Telegram WebApp type definitions
declare global {
  interface Window {
    Telegram?: {
      WebApp: {
        ready: () => void;
        expand: () => void;
        close: () => void;
        initDataUnsafe: {
          user?: TelegramUser;
        };
        MainButton: {
          text: string;
          show: () => void;
          hide: () => void;
          onClick: (callback: () => void) => void;
        };
      };
    };
  }
}