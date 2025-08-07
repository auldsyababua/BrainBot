import React, { useState } from 'react';
import { ListCreator } from './ListCreator';
import { ListViewer } from './ListViewer';
import { useAppContext } from '../../context/AppContext';
import { createList, addToList, removeFromList } from '../../services/brainbotApi';
import { LoadingSpinner } from '../Common/LoadingSpinner';
import { StatusIndicator } from '../Common/StatusIndicator';
import { List } from '../../context/AppContext';
export const ListsView: React.FC = () => {
  const {
    lists,
    refreshData
  } = useAppContext();
  const [isLoading, setIsLoading] = useState(false);
  const [status, setStatus] = useState<{
    type: 'success' | 'error';
    message: string;
  } | null>(null);
  const [selectedList, setSelectedList] = useState<List | null>(null);
  const handleCreateList = async (name: string) => {
    setIsLoading(true);
    setStatus(null);
    try {
      await createList(name);
      await refreshData();
      setStatus({
        type: 'success',
        message: 'List created successfully'
      });
    } catch (error) {
      console.error('Error creating list:', error);
      setStatus({
        type: 'error',
        message: 'Failed to create list'
      });
    } finally {
      setIsLoading(false);
    }
  };
  const handleAddItems = async (listId: string, items: string[]) => {
    setIsLoading(true);
    try {
      await addToList(listId, items);
      await refreshData();
    } catch (error) {
      console.error('Error adding items to list:', error);
      setStatus({
        type: 'error',
        message: 'Failed to add items to list'
      });
    } finally {
      setIsLoading(false);
    }
  };
  const handleRemoveItems = async (listId: string, items: string[]) => {
    setIsLoading(true);
    try {
      await removeFromList(listId, items);
      await refreshData();
    } catch (error) {
      console.error('Error removing items from list:', error);
      setStatus({
        type: 'error',
        message: 'Failed to remove items from list'
      });
    } finally {
      setIsLoading(false);
    }
  };
  return <div className="flex flex-col gap-4">
      <h1 className="text-xl font-semibold">Lists</h1>
      {status && <StatusIndicator type={status.type} message={status.message} onDismiss={() => setStatus(null)} />}
      {selectedList ? <>
          <button onClick={() => setSelectedList(null)} className="text-sm text-blue-600 dark:text-blue-400 mb-2">
            ← Back to all lists
          </button>
          <ListViewer list={selectedList} onAddItems={items => handleAddItems(selectedList.id, items)} onRemoveItems={items => handleRemoveItems(selectedList.id, items)} />
        </> : <>
          <ListCreator onListCreate={handleCreateList} suggestedNames={['Shopping List', 'To-Do List', 'Reading List']} />
          {isLoading ? <div className="flex justify-center py-8">
              <LoadingSpinner label="Loading lists..." />
            </div> : lists.length > 0 ? <div className="bg-white dark:bg-gray-800 rounded-lg shadow-sm overflow-hidden">
              <div className="px-4 py-3 bg-gray-50 dark:bg-gray-850 border-b border-gray-200 dark:border-gray-700">
                <h3 className="font-medium">Your Lists ({lists.length})</h3>
              </div>
              <ul className="divide-y divide-gray-200 dark:divide-gray-700">
                {lists.map(list => <li key={list.id} className="px-4 py-3">
                    <button onClick={() => setSelectedList(list)} className="w-full text-left flex justify-between items-center">
                      <span className="font-medium">{list.name}</span>
                      <span className="text-sm text-gray-500 dark:text-gray-400">
                        {list.items.length} items
                      </span>
                    </button>
                  </li>)}
              </ul>
            </div> : <div className="bg-white dark:bg-gray-800 rounded-lg p-6 shadow-sm text-center">
              <p className="text-gray-500 dark:text-gray-400">
                No lists found. Create your first list!
              </p>
            </div>}
        </>}
    </div>;
};