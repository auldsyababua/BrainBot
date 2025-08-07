import React from 'react';
import { AlertCircle, CheckCircle, AlertTriangle, Info } from 'lucide-react';
interface StatusIndicatorProps {
  type: 'success' | 'error' | 'warning' | 'info';
  message: string;
  onDismiss?: () => void;
}
export const StatusIndicator: React.FC<StatusIndicatorProps> = ({
  type,
  message,
  onDismiss
}) => {
  const getStatusStyles = () => {
    switch (type) {
      case 'success':
        return 'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-100';
      case 'error':
        return 'bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-100';
      case 'warning':
        return 'bg-amber-100 text-amber-800 dark:bg-amber-900 dark:text-amber-100';
      case 'info':
        return 'bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-100';
    }
  };
  const getStatusIcon = () => {
    switch (type) {
      case 'success':
        return <CheckCircle size={16} className="text-green-500 dark:text-green-400" />;
      case 'error':
        return <AlertCircle size={16} className="text-red-500 dark:text-red-400" />;
      case 'warning':
        return <AlertTriangle size={16} className="text-amber-500 dark:text-amber-400" />;
      case 'info':
        return <Info size={16} className="text-blue-500 dark:text-blue-400" />;
    }
  };
  return <div className={`flex items-center justify-between px-4 py-2 ${getStatusStyles()}`}>
      <div className="flex items-center gap-2">
        {getStatusIcon()}
        <span className="text-sm font-medium">{message}</span>
      </div>
      {onDismiss && <button onClick={onDismiss} className="text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200">
          &times;
        </button>}
    </div>;
};