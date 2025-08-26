import React, { useEffect, useState, useRef } from 'react';
import { Send, Paperclip, Mic, Zap } from 'lucide-react';
interface ChatInputProps {
  onSend: (message: string) => Promise<void>;
  disabled: boolean;
  placeholder: string;
  showSmartRailsPreview: boolean;
}
export const ChatInput: React.FC<ChatInputProps> = ({
  onSend,
  disabled,
  placeholder,
  showSmartRailsPreview
}) => {
  const [message, setMessage] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [confidence, setConfidence] = useState(0);
  const textareaRef = useRef<HTMLTextAreaElement>(null);
  // Auto-resize textarea as content grows
  useEffect(() => {
    if (textareaRef.current) {
      textareaRef.current.style.height = 'auto';
      textareaRef.current.style.height = `${Math.min(textareaRef.current.scrollHeight, 120)}px`;
    }
  }, [message]);
  // Simulate Smart Rails confidence preview
  useEffect(() => {
    if (showSmartRailsPreview && message.trim()) {
      // Simple simulation of confidence based on message length and keywords
      const length = message.trim().length;
      const hasActionWord = /\b(create|add|set|delete|remove|complete|update)\b/i.test(message);
      const hasTaskWord = /\b(task|todo|reminder|list|item)\b/i.test(message);
      let calculatedConfidence = Math.min(length * 2, 60);
      if (hasActionWord) calculatedConfidence += 20;
      if (hasTaskWord) calculatedConfidence += 20;
      setConfidence(Math.min(calculatedConfidence, 100));
    } else {
      setConfidence(0);
    }
  }, [message, showSmartRailsPreview]);
  const handleSubmit = async () => {
    if (!message.trim() || isSubmitting || disabled) return;
    setIsSubmitting(true);
    try {
      await onSend(message);
      setMessage('');
    } catch (error) {
      console.error('Error sending message:', error);
    } finally {
      setIsSubmitting(false);
    }
  };
  const handleKeyDown = (e: React.KeyboardEvent<HTMLTextAreaElement>) => {
    if (e.key === 'Enter' && !e.shiftKey) {
      e.preventDefault();
      handleSubmit();
    }
  };
  return <div className="relative">
      <div className="flex items-end border border-gray-300 dark:border-gray-700 rounded-lg bg-white dark:bg-gray-900 overflow-hidden">
        <button className="p-3 text-gray-500 hover:text-gray-700 dark:hover:text-gray-300" onClick={() => console.log('Attachment')} disabled={disabled}>
          <Paperclip size={20} />
        </button>
        <textarea ref={textareaRef} value={message} onChange={e => setMessage(e.target.value)} onKeyDown={handleKeyDown} placeholder={placeholder} disabled={disabled || isSubmitting} className="flex-1 resize-none py-3 px-2 bg-transparent border-0 focus:ring-0 focus:outline-none max-h-[120px]" rows={1} />
        <button className="p-3 text-gray-500 hover:text-gray-700 dark:hover:text-gray-300" onClick={() => console.log('Voice input')} disabled={disabled}>
          <Mic size={20} />
        </button>
        <button onClick={handleSubmit} disabled={!message.trim() || isSubmitting || disabled} className="p-3 text-white bg-blue-600 hover:bg-blue-700 disabled:bg-gray-300 disabled:text-gray-500 dark:disabled:bg-gray-700 dark:disabled:text-gray-400">
          <Send size={20} />
        </button>
      </div>
      {showSmartRailsPreview && confidence > 0 && <div className="absolute -top-8 right-0 flex items-center gap-1 text-xs bg-green-100 dark:bg-green-900/30 text-green-800 dark:text-green-300 px-2 py-1 rounded-full">
          <Zap size={10} />
          <span>Smart Rails: {confidence}% confidence</span>
        </div>}
    </div>;
};