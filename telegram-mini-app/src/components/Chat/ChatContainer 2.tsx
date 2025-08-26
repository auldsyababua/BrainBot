import React, { useEffect, useRef } from 'react';
import { MessageList } from './MessageList';
import { ChatInput } from './ChatInput';
import { AgentSelector } from './AgentSelector';
import { TypingIndicator } from './TypingIndicator';
import { useChatContext, AgentType, availableAgents } from '../../context/ChatContext';
export const ChatContainer: React.FC = () => {
  const {
    messages,
    isTyping,
    selectedAgent,
    setSelectedAgent,
    sendMessage,
    connectionStatus,
    markAllAsRead
  } = useChatContext();
  const containerRef = useRef<HTMLDivElement>(null);
  // Mark messages as read when viewing chat
  useEffect(() => {
    markAllAsRead();
  }, [markAllAsRead]);
  // Auto scroll to bottom when new messages arrive
  useEffect(() => {
    if (containerRef.current) {
      containerRef.current.scrollTop = containerRef.current.scrollHeight;
    }
  }, [messages, isTyping]);
  const handleAgentChange = (agent: AgentType) => {
    setSelectedAgent(agent);
  };
  const handleSendMessage = async (message: string) => {
    await sendMessage(message);
  };
  const handleMessageAction = (messageId: string, action: string) => {
    // Handle message actions like copy, delete, etc.
    console.log(`Action ${action} on message ${messageId}`);
  };
  return <div className="flex flex-col h-full bg-gray-50 dark:bg-gray-900">
      <div className="sticky top-0 z-10 bg-white dark:bg-gray-800 shadow-sm">
        <AgentSelector selectedAgent={selectedAgent} onAgentChange={handleAgentChange} availableAgents={availableAgents} />
      </div>
      <div ref={containerRef} className="flex-1 overflow-y-auto p-4 pb-2">
        <MessageList messages={messages} onMessageAction={handleMessageAction} showTimestamps={true} />
        {isTyping && <div className="pl-2 pb-2">
            <TypingIndicator agentType={selectedAgent} />
          </div>}
      </div>
      <div className="p-4 pt-2 bg-white dark:bg-gray-800 border-t border-gray-200 dark:border-gray-700">
        <ChatInput onSend={handleSendMessage} disabled={connectionStatus === 'disconnected'} placeholder={`Message ${availableAgents.find(a => a.id === selectedAgent)?.name || 'Bot'}...`} showSmartRailsPreview={selectedAgent === 'smart-rails'} />
        {connectionStatus === 'disconnected' && <div className="text-xs text-red-500 mt-1 text-center">
            You're offline. Messages will be sent when you reconnect.
          </div>}
      </div>
    </div>;
};