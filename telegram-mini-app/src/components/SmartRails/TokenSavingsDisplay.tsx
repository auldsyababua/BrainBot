import React from 'react';
import { Zap } from 'lucide-react';
interface TokenSavingsDisplayProps {
  isDirectMode: boolean;
}
export const TokenSavingsDisplay: React.FC<TokenSavingsDisplayProps> = ({
  isDirectMode
}) => {
  return <div className="flex items-center gap-1">
      {isDirectMode && <>
          <Zap size={14} className="text-blue-600 dark:text-blue-400" />
          <span className="text-xs font-medium text-blue-600 dark:text-blue-400">
            100% Token Savings
          </span>
        </>}
    </div>;
};