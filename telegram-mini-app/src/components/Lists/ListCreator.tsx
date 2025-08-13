import React, { useState } from 'react';
import { Zap } from 'lucide-react';
interface ListCreatorProps {
  onListCreate: (name: string) => Promise<void>;
  suggestedNames: string[];
}
export const ListCreator: React.FC<ListCreatorProps> = ({
  onListCreate,
  suggestedNames
}) => {
  const [name, setName] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);
  // Detect if this is a Smart Rails direct command
  const isSmartRailsCommand = false; // Simplified - analytics removed
  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!name.trim() || isSubmitting) return;
    setIsSubmitting(true);
    try {
      await onListCreate(name.trim());
      // Reset form
      setName('');
    } catch (error) {
      console.error('Error creating list:', error);
    } finally {
      setIsSubmitting(false);
    }
  };
  const handleSuggestionClick = (suggestion: string) => {
    setName(suggestion);
  };
  return <div className="bg-white dark:bg-gray-800 rounded-lg p-4 shadow-sm">
      <form onSubmit={handleSubmit}>
        <div className="mb-3">
          <div className="relative">
            <input type="text" value={name} onChange={e => setName(e.target.value)} placeholder="List name" className="w-full px-4 py-3 rounded-lg border border-gray-300 dark:border-gray-700 bg-white dark:bg-gray-900 focus:outline-none focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400" disabled={isSubmitting} />
            {isSmartRailsCommand && <div className="absolute right-3 top-1/2 transform -translate-y-1/2">
                <span className="flex items-center gap-1 text-xs font-medium px-2 py-0.5 rounded-full bg-green-100 dark:bg-green-900/30 text-green-800 dark:text-green-300">
                  <Zap size={10} />0 tokens
                </span>
              </div>}
          </div>
        </div>
        {suggestedNames.length > 0 && <div className="mb-3">
            <p className="text-xs text-gray-500 dark:text-gray-400 mb-2">
              Suggested templates:
            </p>
            <div className="flex flex-wrap gap-2">
              {suggestedNames.map((suggestion, index) => <button key={index} type="button" onClick={() => handleSuggestionClick(suggestion)} className="text-xs px-3 py-1 rounded-full bg-gray-100 hover:bg-gray-200 dark:bg-gray-800 dark:hover:bg-gray-700 text-gray-800 dark:text-gray-200">
                  {suggestion}
                </button>)}
            </div>
          </div>}
        <button type="submit" disabled={!name.trim() || isSubmitting} className="w-full py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-lg disabled:bg-gray-300 dark:disabled:bg-gray-700 disabled:text-gray-500 dark:disabled:text-gray-400 transition-colors">
          {isSubmitting ? 'Creating...' : 'Create List'}
        </button>
      </form>
    </div>;
};