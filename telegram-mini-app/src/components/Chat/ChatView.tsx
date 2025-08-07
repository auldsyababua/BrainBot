import React from 'react';
import { ChatContainer } from './ChatContainer';
import { ChatProvider } from '../../context/ChatContext';
export const ChatView: React.FC = () => {
  return <ChatProvider>
      <ChatContainer />
    </ChatProvider>;
};