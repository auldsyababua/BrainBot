import React, { useEffect, useState, createContext, useContext, memo } from 'react';
export type AgentType = 'brainbot-rag' | 'smart-rails' | 'memory-assistant' | 'field-reports';
export interface AgentOption {
  id: AgentType;
  name: string;
  description: string;
  icon: string;
  color: string;
}
export interface ChatMessage {
  id: string;
  content: string;
  sender: 'user' | 'bot';
  timestamp: Date;
  agentType: AgentType;
  metadata?: {
    tokenUsage?: number;
    responseTime?: number;
    confidence?: number;
    smartRailsUsed?: boolean;
  };
  status: 'sending' | 'sent' | 'delivered' | 'error';
}
interface ChatContextValue {
  messages: ChatMessage[];
  selectedAgent: AgentType;
  isTyping: boolean;
  connectionStatus: 'connected' | 'connecting' | 'disconnected';
  unreadCount: number;
  lastActivity: Date;
  setSelectedAgent: (agent: AgentType) => void;
  sendMessage: (content: string) => Promise<void>;
  markAllAsRead: () => void;
}
const defaultAgents: AgentOption[] = [{
  id: 'brainbot-rag',
  name: 'BrainBot RAG',
  description: 'General knowledge and document search',
  icon: 'brain',
  color: 'purple'
}, {
  id: 'smart-rails',
  name: 'Smart Rails',
  description: 'Task and list management (direct execution)',
  icon: 'zap',
  color: 'blue'
}, {
  id: 'memory-assistant',
  name: 'Memory Assistant',
  description: 'Personal memory and preferences',
  icon: 'hard-drive',
  color: 'green'
}, {
  id: 'field-reports',
  name: 'Field Reports',
  description: 'Site-specific operations and reports',
  icon: 'clipboard-list',
  color: 'orange'
}];
const ChatContext = createContext<ChatContextValue>({
  messages: [],
  selectedAgent: 'brainbot-rag',
  isTyping: false,
  connectionStatus: 'connected',
  unreadCount: 0,
  lastActivity: new Date(),
  setSelectedAgent: () => {},
  sendMessage: async () => {},
  markAllAsRead: () => {}
});
export const useChatContext = () => useContext(ChatContext);
export const ChatProvider: React.FC<{
  children: React.ReactNode;
}> = ({
  children
}) => {
  const [messages, setMessages] = useState<ChatMessage[]>([]);
  const [selectedAgent, setSelectedAgent] = useState<AgentType>('brainbot-rag');
  const [isTyping, setIsTyping] = useState(false);
  const [connectionStatus, setConnectionStatus] = useState<'connected' | 'connecting' | 'disconnected'>('connected');
  const [unreadCount, setUnreadCount] = useState(0);
  const [lastActivity, setLastActivity] = useState(new Date());
  // Mock function to simulate sending a message and getting a response
  const sendMessage = async (content: string): Promise<void> => {
    if (!content.trim()) return;
    // Update last activity
    setLastActivity(new Date());
    // Create user message
    const userMessage: ChatMessage = {
      id: Date.now().toString(),
      content: content.trim(),
      sender: 'user',
      timestamp: new Date(),
      agentType: selectedAgent,
      status: 'sending'
    };
    // Add user message to chat
    setMessages(prev => [...prev, userMessage]);
    // Update user message status to sent
    setTimeout(() => {
      setMessages(prev => prev.map(msg => msg.id === userMessage.id ? {
        ...msg,
        status: 'sent'
      } : msg));
    }, 500);
    // Simulate typing indicator
    setIsTyping(true);
    try {
      // Simulate API delay
      await new Promise(resolve => setTimeout(resolve, 1500));
      // Create bot response
      const botMessage: ChatMessage = {
        id: (Date.now() + 1).toString(),
        content: generateBotResponse(content, selectedAgent),
        sender: 'bot',
        timestamp: new Date(),
        agentType: selectedAgent,
        metadata: {
          tokenUsage: Math.floor(Math.random() * 100) + 50,
          responseTime: Math.floor(Math.random() * 1000) + 500,
          confidence: selectedAgent === 'smart-rails' ? Math.floor(Math.random() * 50) + 50 : undefined,
          smartRailsUsed: selectedAgent === 'smart-rails'
        },
        status: 'delivered'
      };
      // Add bot message to chat
      setMessages(prev => [...prev, botMessage]);
      // Increment unread count if user isn't viewing the chat
      setUnreadCount(prev => prev + 1);
    } catch (error) {
      console.error('Error sending message:', error);
      // Update user message status to error
      setMessages(prev => prev.map(msg => msg.id === userMessage.id ? {
        ...msg,
        status: 'error'
      } : msg));
    } finally {
      setIsTyping(false);
    }
  };
  const markAllAsRead = () => {
    setUnreadCount(0);
  };
  // Helper function to generate mock responses based on agent type
  const generateBotResponse = (userMessage: string, agentType: AgentType): string => {
    switch (agentType) {
      case 'brainbot-rag':
        return `Here's what I found about "${userMessage}":\n\n- The information is stored in our knowledge base\n- You can learn more by asking specific questions\n- I can provide more details if needed`;
      case 'smart-rails':
        if (userMessage.toLowerCase().includes('task') || userMessage.toLowerCase().includes('todo')) {
          return `✅ Task created: "${userMessage}"\n\nAssigned to: You\nDue date: Tomorrow`;
        }
        if (userMessage.toLowerCase().includes('list')) {
          return `📋 List created with items:\n\n- Item 1\n- Item 2\n- Item 3`;
        }
        return `I've processed your request: "${userMessage}". Is there anything else you'd like me to do?`;
      case 'memory-assistant':
        return `I remember you mentioned "${userMessage}" before. Would you like me to recall related information from your personal memory?`;
      case 'field-reports':
        return `Field report logged: "${userMessage}"\n\nLocation: Current\nTimestamp: ${new Date().toLocaleString()}\nStatus: Pending review`;
      default:
        return `I received your message: "${userMessage}". How can I assist you further?`;
    }
  };
  // Monitor connection status
  useEffect(() => {
    const handleOnline = () => setConnectionStatus('connected');
    const handleOffline = () => setConnectionStatus('disconnected');
    window.addEventListener('online', handleOnline);
    window.addEventListener('offline', handleOffline);
    return () => {
      window.removeEventListener('online', handleOnline);
      window.removeEventListener('offline', handleOffline);
    };
  }, []);
  const value: ChatContextValue = {
    messages,
    selectedAgent,
    isTyping,
    connectionStatus,
    unreadCount,
    lastActivity,
    setSelectedAgent,
    sendMessage,
    markAllAsRead
  };
  return <ChatContext.Provider value={value}>{children}</ChatContext.Provider>;
};
export const availableAgents: AgentOption[] = defaultAgents;