import React from 'react';
import { AgentType, availableAgents } from '../../context/ChatContext';
interface TypingIndicatorProps {
  agentType: AgentType;
}
export const TypingIndicator: React.FC<TypingIndicatorProps> = ({
  agentType
}) => {
  const agentInfo = availableAgents.find(agent => agent.id === agentType);
  return <div className="flex items-center gap-2">
      <div className={`w-8 h-8 rounded-full flex items-center justify-center text-white bg-${agentInfo?.color || 'gray'}-500`}>
        {agentInfo?.name.charAt(0)}
      </div>
      <div className="bg-gray-200 dark:bg-gray-700 rounded-lg px-4 py-2 inline-block">
        <div className="flex gap-1">
          <div className="w-2 h-2 rounded-full bg-gray-500 dark:bg-gray-400 animate-bounce" style={{
          animationDelay: '0ms'
        }} />
          <div className="w-2 h-2 rounded-full bg-gray-500 dark:bg-gray-400 animate-bounce" style={{
          animationDelay: '150ms'
        }} />
          <div className="w-2 h-2 rounded-full bg-gray-500 dark:bg-gray-400 animate-bounce" style={{
          animationDelay: '300ms'
        }} />
        </div>
      </div>
    </div>;
};