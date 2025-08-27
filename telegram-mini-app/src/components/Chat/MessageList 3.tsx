import React, { useMemo } from 'react';
import { MessageBubble } from './MessageBubble';
import { ChatMessage } from '../../context/ChatContext';
interface MessageListProps {
  messages: ChatMessage[];
  onMessageAction: (messageId: string, action: string) => void;
  showTimestamps: boolean;
}
export const MessageList: React.FC<MessageListProps> = ({
  messages,
  onMessageAction,
  showTimestamps
}) => {
  // Group messages by date for timestamp headers
  const groupedMessages = useMemo(() => {
    const groups: {
      date: string;
      messages: ChatMessage[];
    }[] = [];
    messages.forEach(message => {
      const messageDate = new Date(message.timestamp);
      const dateString = messageDate.toLocaleDateString();
      const existingGroup = groups.find(group => group.date === dateString);
      if (existingGroup) {
        existingGroup.messages.push(message);
      } else {
        groups.push({
          date: dateString,
          messages: [message]
        });
      }
    });
    return groups;
  }, [messages]);
  // Helper to format date for timestamp headers
  const formatDateHeader = (dateString: string) => {
    const messageDate = new Date(dateString);
    const today = new Date();
    const yesterday = new Date(today);
    yesterday.setDate(yesterday.getDate() - 1);
    if (messageDate.toDateString() === today.toDateString()) {
      return 'Today';
    } else if (messageDate.toDateString() === yesterday.toDateString()) {
      return 'Yesterday';
    } else {
      return messageDate.toLocaleDateString(undefined, {
        weekday: 'long',
        month: 'short',
        day: 'numeric'
      });
    }
  };
  // Helper to determine if we should show avatar for consecutive messages
  const shouldShowAvatar = (messages: ChatMessage[], index: number) => {
    if (index === 0) return true;
    const currentMessage = messages[index];
    const previousMessage = messages[index - 1];
    // Show avatar if sender changes or if there's a gap of more than 5 minutes
    return currentMessage.sender !== previousMessage.sender || currentMessage.timestamp.getTime() - previousMessage.timestamp.getTime() > 5 * 60 * 1000;
  };
  if (messages.length === 0) {
    return <div className="flex flex-col items-center justify-center h-full text-gray-500 dark:text-gray-400 p-8">
        <div className="text-center">
          <p className="mb-2">No messages yet</p>
          <p className="text-sm">Send a message to start the conversation</p>
        </div>
      </div>;
  }
  return <div className="flex flex-col space-y-4">
      {groupedMessages.map((group) => <div key={group.date} className="space-y-4">
          {showTimestamps && <div className="flex justify-center">
              <div className="bg-gray-200 dark:bg-gray-700 rounded-full px-3 py-1 text-xs text-gray-600 dark:text-gray-300">
                {formatDateHeader(group.date)}
              </div>
            </div>}
          {group.messages.map((message, messageIndex) => <MessageBubble key={message.id} message={message} isUser={message.sender === 'user'} showAvatar={shouldShowAvatar(group.messages, messageIndex)} onAction={action => onMessageAction(message.id, action)} />)}
        </div>)}
    </div>;
};