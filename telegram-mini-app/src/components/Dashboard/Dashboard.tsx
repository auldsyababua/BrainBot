import React from 'react';
import { QuickActions } from './QuickActions';
import { CommandExecutor } from '../SmartRails/CommandExecutor';
export const Dashboard: React.FC = () => {
  return <div className="flex flex-col gap-6">
      <QuickActions />
      <div className="bg-white dark:bg-gray-800 rounded-lg p-4 shadow-sm">
        <h2 className="text-lg font-semibold mb-3">Smart Command</h2>
        <CommandExecutor onCommand={async () => ({
        success: true
      })} showConfidence={true} enableDirectMode={true} />
      </div>
    </div>;
};