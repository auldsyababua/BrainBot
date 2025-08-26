import React from 'react';
import { Check, CheckCheck, Clock, Copy, RefreshCw, Zap } from 'lucide-react';
import { ChatMessage, availableAgents } from '../../context/ChatContext';
interface MessageBubbleProps {
  message: ChatMessage;
  isUser: boolean;
  showAvatar: boolean;
  onAction: (action: string) => void;
}
export const MessageBubble: React.FC<MessageBubbleProps> = ({
  message,
  isUser,
  showAvatar,
  onAction
}) => {
  // Helper to render message status icon
  const renderStatusIcon = () => {
    switch (message.status) {
      case 'sending':
        return <Clock size={12} className="text-gray-400" />;
      case 'sent':
        return <Check size={12} className="text-gray-400" />;
      case 'delivered':
        return <CheckCheck size={12} className="text-green-500" />;
      case 'error':
        return <RefreshCw size={12} className="text-red-500" onClick={() => onAction('retry')} />;
      default:
        return null;
    }
  };
  // Get agent info for avatar
  const agentInfo = availableAgents.find(agent => agent.id === message.agentType);
  // Helper to render message content with markdown-like formatting
  const renderMessageContent = () => {
    // Very simple markdown-like rendering
    // In a real app, you'd use a proper markdown renderer
    const formattedContent = message.content.split('\n').map((line) => {
      // Bold text
      line = line.replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>');
      // Italic text
      line = line.replace(/\*(.*?)\*/g, '<em>$1</em>');
      // Code
      line = line.replace(/`(.*?)`/g, '<code>$1</code>');
      // List items
      if (line.match(/^- (.*)/)) {
        return `<li>${line.replace(/^- (.*)/, '$1')}</li>`;
      }
      return line;
    }).join('<br/>');
    return <div dangerouslySetInnerHTML={{
      __html: formattedContent
    }} />;
  };
  return <div className={`flex ${isUser ? 'justify-end' : 'justify-start'} gap-2`}>
      {!isUser && showAvatar && <div className={`w-8 h-8 rounded-full flex items-center justify-center text-white bg-${agentInfo?.color || 'gray'}-500 flex-shrink-0`}>
          {agentInfo?.icon === 'brain' && <span>🧠</span>}
          {agentInfo?.icon === 'zap' && <Zap size={14} />}
          {agentInfo?.icon === 'hard-drive' && <span>💾</span>}
          {agentInfo?.icon === 'clipboard-list' && <span>📋</span>}
        </div>}
      <div className={`max-w-[80%] ${!isUser && !showAvatar ? 'ml-10' : ''}`}>
        <div className={`rounded-lg px-4 py-2 inline-block
            ${isUser ? 'bg-blue-600 text-white rounded-br-none' : 'bg-gray-200 dark:bg-gray-700 text-gray-900 dark:text-gray-100 rounded-bl-none'}
          `}>
          {renderMessageContent()}
        </div>
        <div className={`flex mt-1 text-xs ${isUser ? 'justify-end' : 'justify-start'}`}>
          <div className="flex items-center gap-1 text-gray-500">
            {isUser ? <div className="flex items-center">
                <span className="mr-1">
                  {new Date(message.timestamp).toLocaleTimeString([], {
                hour: '2-digit',
                minute: '2-digit'
              })}
                </span>
                {renderStatusIcon()}
              </div> : <>
                <span>
                  {new Date(message.timestamp).toLocaleTimeString([], {
                hour: '2-digit',
                minute: '2-digit'
              })}
                </span>
                {message.metadata?.smartRailsUsed && <span className="ml-2 flex items-center gap-1 text-green-600 dark:text-green-400">
                    <Zap size={10} />
                    {message.metadata.confidence && `${message.metadata.confidence}%`}
                  </span>}
                {message.metadata?.tokenUsage && <span className="ml-2">
                    {message.metadata.tokenUsage} tokens
                  </span>}
              </>}
            <button onClick={() => onAction('copy')} className="ml-2 p-1 rounded-full hover:bg-gray-200 dark:hover:bg-gray-700">
              <Copy size={12} />
            </button>
          </div>
        </div>
      </div>
    </div>;
};