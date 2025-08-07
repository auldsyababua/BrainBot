import React from 'react';
import { RefreshCw, Wifi, WifiOff } from 'lucide-react';
interface DashboardHeaderProps {
  userName: string;
  botStatus: 'healthy' | 'degraded' | 'unhealthy';
  onRefresh: () => void;
}
export const DashboardHeader: React.FC<DashboardHeaderProps> = ({
  userName,
  botStatus,
  onRefresh
}) => {
  const statusColors = {
    healthy: 'text-green-500',
    degraded: 'text-amber-500',
    unhealthy: 'text-red-500'
  };
  return <header className="sticky top-0 z-10 bg-white dark:bg-gray-950 border-b border-gray-200 dark:border-gray-800 p-4">
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-lg font-semibold">Hi, {userName}</h1>
          <div className="flex items-center mt-1">
            {botStatus === 'healthy' ? <Wifi size={14} className={statusColors[botStatus]} /> : <WifiOff size={14} className={statusColors[botStatus]} />}
            <span className={`ml-1 text-xs ${statusColors[botStatus]}`}>
              BrainBot is {botStatus}
            </span>
          </div>
        </div>
        <button onClick={onRefresh} className="p-2 rounded-full hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors" aria-label="Refresh">
          <RefreshCw size={20} className="text-gray-600 dark:text-gray-300" />
        </button>
      </div>
    </header>;
};