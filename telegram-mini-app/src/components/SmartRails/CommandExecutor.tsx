import React, { useState } from 'react';
import { Send } from 'lucide-react';
import { ConfidenceIndicator } from './ConfidenceIndicator';
import { TokenSavingsDisplay } from './TokenSavingsDisplay';
import { useSmartRailsContext } from '../../context/SmartRailsContext';
interface CommandExecutorProps {
  onCommand: (command: string) => Promise<unknown>;
  showConfidence: boolean;
  enableDirectMode: boolean;
}
export const CommandExecutor: React.FC<CommandExecutorProps> = ({
  onCommand,
  showConfidence,
  enableDirectMode
}) => {
  const [command, setCommand] = useState('');
  const [isExecuting, setIsExecuting] = useState(false);
  const {
    confidence,
    setConfidence,
    isDirectMode
  } = useSmartRailsContext();
  // Simulate confidence calculation based on command text
  const calculateConfidence = (text: string) => {
    if (!text.trim()) return 0;
    // Direct command patterns (these would be more sophisticated in a real app)
    const directPatterns = [/^add task.*/i, /^create list.*/i, /^complete task.*/i, /^remind me to.*/i];
    for (const pattern of directPatterns) {
      if (pattern.test(text)) {
        return 100;
      }
    }
    // Simulate varying confidence levels based on command length and complexity
    const length = text.length;
    if (length < 5) return 30;
    if (length < 10) return 50;
    if (length < 20) return 75;
    return 85;
  };
  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const newCommand = e.target.value;
    setCommand(newCommand);
    // Update confidence based on command text
    if (showConfidence) {
      setConfidence(calculateConfidence(newCommand));
    }
  };
  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!command.trim() || isExecuting) return;
    setIsExecuting(true);
    try {
      const startTime = performance.now();
      await onCommand(command);
      const endTime = performance.now();
      // Track performance
      if (isDirectMode) {
        // This would actually track in the SmartRailsContext in a real app
        console.log(`Direct execution: ${endTime - startTime}ms`);
      }
      setCommand('');
    } catch (error) {
      console.error('Command execution error:', error);
    } finally {
      setIsExecuting(false);
    }
  };
  return <div className="flex flex-col">
      {showConfidence && <div className="flex justify-between items-center mb-2">
          <ConfidenceIndicator confidence={confidence} />
          <TokenSavingsDisplay isDirectMode={isDirectMode} />
        </div>}
      <form onSubmit={handleSubmit} className="relative">
        <input type="text" value={command} onChange={handleInputChange} placeholder="Type a command..." className="w-full px-4 py-3 pr-12 rounded-lg border border-gray-300 dark:border-gray-700 bg-white dark:bg-gray-900 focus:outline-none focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400" disabled={isExecuting} />
        <button type="submit" className="absolute right-2 top-1/2 transform -translate-y-1/2 p-2 text-blue-600 dark:text-blue-400 disabled:text-gray-400 dark:disabled:text-gray-600" disabled={!command.trim() || isExecuting}>
          <Send size={20} />
        </button>
      </form>
      {enableDirectMode && isDirectMode && <div className="mt-2 flex items-center">
          <span className="text-xs font-medium px-2 py-0.5 rounded-full bg-green-100 dark:bg-green-900/30 text-green-800 dark:text-green-300">
            Direct Execution
          </span>
          <span className="ml-2 text-xs text-gray-500 dark:text-gray-400">
            0 tokens • &lt;50ms
          </span>
        </div>}
    </div>;
};