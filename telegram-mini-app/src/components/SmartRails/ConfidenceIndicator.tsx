import React from 'react';
import { CheckCircle, AlertTriangle } from 'lucide-react';
interface ConfidenceIndicatorProps {
  confidence: number;
}
export const ConfidenceIndicator: React.FC<ConfidenceIndicatorProps> = ({
  confidence
}) => {
  const getColor = () => {
    if (confidence >= 90) return 'text-green-600 dark:text-green-400';
    if (confidence >= 70) return 'text-amber-600 dark:text-amber-400';
    return 'text-gray-500 dark:text-gray-400';
  };
  const getIcon = () => {
    if (confidence === 100) {
      return <CheckCircle size={16} className="text-green-600 dark:text-green-400" />;
    }
    if (confidence >= 70) {
      return <AlertTriangle size={16} className="text-amber-600 dark:text-amber-400" />;
    }
    return null;
  };
  const getLabel = () => {
    if (confidence === 100) return 'Smart Rails Direct';
    if (confidence >= 90) return 'High Confidence';
    if (confidence >= 70) return 'Enhanced LLM';
    return 'Standard Processing';
  };
  return <div className="flex items-center gap-1">
      {getIcon()}
      <span className={`text-xs font-medium ${getColor()}`}>
        {getLabel()} ({confidence}%)
      </span>
    </div>;
};