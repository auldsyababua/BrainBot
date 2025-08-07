import React, { useState } from 'react';
import { ItemManager } from './ItemManager';
import { List } from '../../context/AppContext';
import { Zap, Trash } from 'lucide-react';
interface ListViewerProps {
  list: List;
  onAddItems: (items: string[]) => Promise<void>;
  onRemoveItems: (items: string[]) => Promise<void>;
}
export const ListViewer: React.FC<ListViewerProps> = ({
  list,
  onAddItems,
  onRemoveItems
}) => {
  const [selectedItems, setSelectedItems] = useState<string[]>([]);
  const handleItemToggle = (item: string) => {
    setSelectedItems(prev => prev.includes(item) ? prev.filter(i => i !== item) : [...prev, item]);
  };
  const handleRemoveSelected = async () => {
    if (selectedItems.length === 0) return;
    try {
      await onRemoveItems(selectedItems);
      setSelectedItems([]);
    } catch (error) {
      console.error('Error removing items:', error);
    }
  };
  return <div className="bg-white dark:bg-gray-800 rounded-lg shadow-sm overflow-hidden">
      <div className="px-4 py-3 bg-gray-50 dark:bg-gray-850 border-b border-gray-200 dark:border-gray-700 flex justify-between items-center">
        <h3 className="font-medium">{list.name}</h3>
        <span className="text-sm text-gray-500 dark:text-gray-400">
          {list.items.length} items
        </span>
      </div>
      <ItemManager onAddItems={onAddItems} />
      {selectedItems.length > 0 && <div className="px-4 py-2 bg-red-50 dark:bg-red-900/20 flex justify-between items-center">
          <span className="text-sm text-red-600 dark:text-red-400">
            {selectedItems.length} selected
          </span>
          <button onClick={handleRemoveSelected} className="flex items-center gap-1 text-sm text-red-600 dark:text-red-400 hover:text-red-800 dark:hover:text-red-300 px-2 py-1 rounded hover:bg-red-100 dark:hover:bg-red-900/30">
            <Trash size={14} />
            Remove
          </button>
        </div>}
      {list.items.length > 0 ? <ul className="divide-y divide-gray-200 dark:divide-gray-700">
          {list.items.map((item, index) => <li key={index} className="px-4 py-3">
              <div className="flex items-center gap-3">
                <input type="checkbox" checked={selectedItems.includes(item)} onChange={() => handleItemToggle(item)} className="h-4 w-4 rounded border-gray-300 text-blue-600 focus:ring-blue-500 dark:border-gray-600 dark:bg-gray-700" />
                <span>{item}</span>
                {/* Smart Rails indicator - this would be dynamic in a real app */}
                {index % 3 === 0 && <span className="ml-auto flex items-center gap-1 text-xs font-medium px-1.5 py-0.5 rounded-full bg-green-100 dark:bg-green-900/30 text-green-800 dark:text-green-300">
                    <Zap size={10} />
                    Smart Rails
                  </span>}
              </div>
            </li>)}
        </ul> : <div className="px-4 py-6 text-center text-gray-500 dark:text-gray-400">
          This list is empty. Add some items!
        </div>}
    </div>;
};