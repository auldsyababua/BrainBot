import React from 'react';
import { PlusCircle, ListPlus, Zap } from 'lucide-react';
import { useAppContext } from '../../context/AppContext';
export const QuickActions: React.FC = () => {
  const {
    setActiveTab
  } = useAppContext();
  return <div className="grid grid-cols-3 gap-3">
      <button onClick={() => setActiveTab('tasks')} className="flex flex-col items-center justify-center bg-white dark:bg-gray-800 rounded-lg p-4 shadow-sm hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors">
        <div className="w-10 h-10 rounded-full bg-blue-100 dark:bg-blue-900/30 flex items-center justify-center mb-2">
          <PlusCircle size={20} className="text-blue-600 dark:text-blue-400" />
        </div>
        <span className="text-sm font-medium text-gray-700 dark:text-gray-300">
          New Task
        </span>
      </button>
      <button onClick={() => setActiveTab('lists')} className="flex flex-col items-center justify-center bg-white dark:bg-gray-800 rounded-lg p-4 shadow-sm hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors">
        <div className="w-10 h-10 rounded-full bg-green-100 dark:bg-green-900/30 flex items-center justify-center mb-2">
          <ListPlus size={20} className="text-green-600 dark:text-green-400" />
        </div>
        <span className="text-sm font-medium text-gray-700 dark:text-gray-300">
          New List
        </span>
      </button>
      <button className="flex flex-col items-center justify-center bg-white dark:bg-gray-800 rounded-lg p-4 shadow-sm hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors">
        <div className="w-10 h-10 rounded-full bg-purple-100 dark:bg-purple-900/30 flex items-center justify-center mb-2">
          <Zap size={20} className="text-purple-600 dark:text-purple-400" />
        </div>
        <span className="text-sm font-medium text-gray-700 dark:text-gray-300">
          Smart Rails
        </span>
      </button>
    </div>;
};