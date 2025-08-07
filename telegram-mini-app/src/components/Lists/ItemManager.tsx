import React, { useState } from 'react';
import { useSmartRailsContext } from '../../context/SmartRailsContext';
import { Zap, Plus } from 'lucide-react';
interface ItemManagerProps {
  onAddItems: (items: string[]) => Promise<void>;
}
export const ItemManager: React.FC<ItemManagerProps> = ({
  onAddItems
}) => {
  const [itemInput, setItemInput] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);
  const {
    confidence
  } = useSmartRailsContext();
  // Detect if this is a Smart Rails direct command
  const isSmartRailsCommand = confidence === 100;
  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!itemInput.trim() || isSubmitting) return;
    setIsSubmitting(true);
    try {
      // Split by commas for bulk addition
      const items = itemInput.split(',').map(item => item.trim()).filter(item => item.length > 0);
      await onAddItems(items);
      // Reset form
      setItemInput('');
    } catch (error) {
      console.error('Error adding items:', error);
    } finally {
      setIsSubmitting(false);
    }
  };
  return <form onSubmit={handleSubmit} className="p-4 border-b border-gray-200 dark:border-gray-700">
      <div className="flex items-center gap-2">
        <div className="relative flex-1">
          <input type="text" value={itemInput} onChange={e => setItemInput(e.target.value)} placeholder="Add items (separate with commas)" className="w-full px-4 py-2 rounded-lg border border-gray-300 dark:border-gray-700 bg-white dark:bg-gray-900 focus:outline-none focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400" disabled={isSubmitting} />
          {isSmartRailsCommand && <div className="absolute right-3 top-1/2 transform -translate-y-1/2">
              <span className="flex items-center gap-1 text-xs font-medium px-1.5 py-0.5 rounded-full bg-green-100 dark:bg-green-900/30 text-green-800 dark:text-green-300">
                <Zap size={10} />0 tokens
              </span>
            </div>}
        </div>
        <button type="submit" disabled={!itemInput.trim() || isSubmitting} className="p-2 rounded-lg bg-blue-600 text-white disabled:bg-gray-300 dark:disabled:bg-gray-700 disabled:text-gray-500 dark:disabled:text-gray-400">
          <Plus size={20} />
        </button>
      </div>
      <p className="mt-2 text-xs text-gray-500 dark:text-gray-400">
        Tip: Add multiple items at once by separating with commas
      </p>
    </form>;
};