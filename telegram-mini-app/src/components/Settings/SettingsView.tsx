import React, { useState } from 'react';
import { useAppContext } from '../../context/AppContext';
import { Moon, Sun, Zap, BarChart, HelpCircle, LogOut } from 'lucide-react';
export const SettingsView: React.FC = () => {
  const {
    user,
    botStatus
  } = useAppContext();
  const [darkMode, setDarkMode] = useState(window.matchMedia('(prefers-color-scheme: dark)').matches);
  const toggleDarkMode = () => {
    if (darkMode) {
      document.documentElement.classList.remove('dark');
    } else {
      document.documentElement.classList.add('dark');
    }
    setDarkMode(!darkMode);
  };
  return <div className="flex flex-col gap-4">
      <h1 className="text-xl font-semibold">Settings</h1>
      <div className="bg-white dark:bg-gray-800 rounded-lg shadow-sm overflow-hidden">
        <div className="px-4 py-3 bg-gray-50 dark:bg-gray-850 border-b border-gray-200 dark:border-gray-700">
          <h3 className="font-medium">Account</h3>
        </div>
        <div className="p-4">
          <div className="flex items-center gap-3 mb-4">
            <div className="w-12 h-12 rounded-full bg-blue-100 dark:bg-blue-900/30 flex items-center justify-center">
              <span className="text-lg font-bold text-blue-600 dark:text-blue-400">
                {user?.first_name?.charAt(0) || 'U'}
              </span>
            </div>
            <div>
              <p className="font-medium">
                {user?.first_name} {user?.last_name}
              </p>
              <p className="text-sm text-gray-500 dark:text-gray-400">
                @{user?.username || 'username'}
              </p>
            </div>
          </div>
        </div>
      </div>
      <div className="bg-white dark:bg-gray-800 rounded-lg shadow-sm overflow-hidden">
        <div className="px-4 py-3 bg-gray-50 dark:bg-gray-850 border-b border-gray-200 dark:border-gray-700">
          <h3 className="font-medium">Appearance</h3>
        </div>
        <div className="p-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-2">
              {darkMode ? <Moon size={18} /> : <Sun size={18} />}
              <span>Dark Mode</span>
            </div>
            <label className="relative inline-flex items-center cursor-pointer">
              <input type="checkbox" checked={darkMode} onChange={toggleDarkMode} className="sr-only peer" />
              <div className="w-11 h-6 bg-gray-200 peer-focus:outline-none peer-focus:ring-4 peer-focus:ring-blue-300 dark:peer-focus:ring-blue-800 rounded-full peer dark:bg-gray-700 peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-blue-600"></div>
            </label>
          </div>
        </div>
      </div>
      <div className="bg-white dark:bg-gray-800 rounded-lg shadow-sm overflow-hidden">
        <div className="px-4 py-3 bg-gray-50 dark:bg-gray-850 border-b border-gray-200 dark:border-gray-700">
          <h3 className="font-medium">Smart Rails</h3>
        </div>
        <div className="p-4 space-y-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-2">
              <Zap size={18} className="text-blue-600 dark:text-blue-400" />
              <span>Direct Execution</span>
            </div>
            <label className="relative inline-flex items-center cursor-pointer">
              <input type="checkbox" checked={true} className="sr-only peer" />
              <div className="w-11 h-6 bg-gray-200 peer-focus:outline-none peer-focus:ring-4 peer-focus:ring-blue-300 dark:peer-focus:ring-blue-800 rounded-full peer dark:bg-gray-700 peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-blue-600"></div>
            </label>
          </div>
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-2">
              <BarChart size={18} className="text-purple-600 dark:text-purple-400" />
              <span>Performance Stats</span>
            </div>
            <span className="text-sm font-medium text-green-600 dark:text-green-400">
              Enabled
            </span>
          </div>
        </div>
      </div>
      <div className="bg-white dark:bg-gray-800 rounded-lg shadow-sm overflow-hidden">
        <div className="px-4 py-3 bg-gray-50 dark:bg-gray-850 border-b border-gray-200 dark:border-gray-700">
          <h3 className="font-medium">Support</h3>
        </div>
        <div className="divide-y divide-gray-200 dark:divide-gray-700">
          <button className="w-full flex items-center justify-between p-4 text-left hover:bg-gray-50 dark:hover:bg-gray-750">
            <div className="flex items-center gap-2">
              <HelpCircle size={18} />
              <span>Help & Documentation</span>
            </div>
            <span className="text-gray-400">→</span>
          </button>
          <button className="w-full flex items-center justify-between p-4 text-left text-red-600 dark:text-red-400 hover:bg-red-50 dark:hover:bg-red-900/10">
            <div className="flex items-center gap-2">
              <LogOut size={18} />
              <span>Log Out</span>
            </div>
            <span className="text-gray-400">→</span>
          </button>
        </div>
      </div>
      <p className="text-center text-xs text-gray-500 dark:text-gray-400 mt-4">
        BrainBot v1.0.0 • Smart Rails Enabled
      </p>
    </div>;
};