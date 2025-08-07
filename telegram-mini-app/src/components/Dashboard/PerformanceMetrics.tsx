import React from 'react';
import { Zap, Clock, BarChart } from 'lucide-react';
interface PerformanceMetricsProps {
  metrics: {
    totalCommands: number;
    tokensSaved: number;
    averageResponseTime: number;
    directExecutionRate: number;
  };
}
export const PerformanceMetrics: React.FC<PerformanceMetricsProps> = ({
  metrics
}) => {
  return <div className="bg-white dark:bg-gray-800 rounded-lg p-4 shadow-sm">
      <h2 className="text-lg font-semibold mb-3">Performance</h2>
      <div className="grid grid-cols-2 gap-4">
        <div className="bg-blue-50 dark:bg-blue-900/30 p-3 rounded-lg">
          <div className="flex items-center gap-2 mb-1">
            <Zap size={16} className="text-blue-600 dark:text-blue-400" />
            <span className="text-sm font-medium text-gray-700 dark:text-gray-300">
              Tokens Saved
            </span>
          </div>
          <div className="flex items-end gap-1">
            <span className="text-2xl font-bold text-blue-600 dark:text-blue-400">
              {metrics.tokensSaved.toLocaleString()}
            </span>
            <span className="text-xs text-gray-500 dark:text-gray-400 mb-1">
              tokens
            </span>
          </div>
        </div>
        <div className="bg-green-50 dark:bg-green-900/30 p-3 rounded-lg">
          <div className="flex items-center gap-2 mb-1">
            <Clock size={16} className="text-green-600 dark:text-green-400" />
            <span className="text-sm font-medium text-gray-700 dark:text-gray-300">
              Avg Response
            </span>
          </div>
          <div className="flex items-end gap-1">
            <span className="text-2xl font-bold text-green-600 dark:text-green-400">
              {metrics.averageResponseTime}
            </span>
            <span className="text-xs text-gray-500 dark:text-gray-400 mb-1">
              ms
            </span>
          </div>
        </div>
      </div>
      <div className="mt-4">
        <div className="flex items-center justify-between mb-2">
          <div className="flex items-center gap-2">
            <BarChart size={16} className="text-purple-600 dark:text-purple-400" />
            <span className="text-sm font-medium text-gray-700 dark:text-gray-300">
              Direct Execution Rate
            </span>
          </div>
          <span className="text-sm font-semibold text-purple-600 dark:text-purple-400">
            {metrics.directExecutionRate}%
          </span>
        </div>
        <div className="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-2.5">
          <div className="bg-purple-600 dark:bg-purple-500 h-2.5 rounded-full" style={{
          width: `${metrics.directExecutionRate}%`
        }}></div>
        </div>
        <div className="mt-4 py-2 px-3 bg-amber-50 dark:bg-amber-900/20 rounded-md border border-amber-100 dark:border-amber-800/30">
          <p className="text-sm text-amber-800 dark:text-amber-300 font-medium text-center">
            70% Token Reduction with Smart Rails
          </p>
        </div>
      </div>
    </div>;
};