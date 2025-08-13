import React, { useState } from 'react';
import { Send } from 'lucide-react';

interface CommandExecutorProps {
  onCommand: (command: string) => Promise<unknown>;
  showConfidence?: boolean;
  enableDirectMode?: boolean;
}

export const CommandExecutor: React.FC<CommandExecutorProps> = ({
  onCommand,
  showConfidence,
  enableDirectMode
}) => {
  const [command, setCommand] = useState('');
  const [isExecuting, setIsExecuting] = useState(false);

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const newCommand = e.target.value;
    setCommand(newCommand);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!command.trim() || isExecuting) return;
    
    setIsExecuting(true);
    try {
      await onCommand(command);
      setCommand('');
    } catch (error) {
      console.error('Command execution error:', error);
    } finally {
      setIsExecuting(false);
    }
  };

  return (
    <div className="flex flex-col">
      <form onSubmit={handleSubmit} className="relative">
        <input 
          type="text" 
          value={command} 
          onChange={handleInputChange} 
          placeholder="Type a command..." 
          className="w-full px-4 py-3 pr-12 rounded-lg border border-gray-300 dark:border-gray-700 bg-white dark:bg-gray-900 focus:outline-none focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400" 
          disabled={isExecuting} 
        />
        <button 
          type="submit" 
          className="absolute right-2 top-1/2 transform -translate-y-1/2 p-2 text-blue-600 dark:text-blue-400 disabled:text-gray-400 dark:disabled:text-gray-600" 
          disabled={!command.trim() || isExecuting}
        >
          <Send size={20} />
        </button>
      </form>
    </div>
  );
};