import React, { useState } from 'react';
import { CheckCircle, User, MoreHorizontal, Zap } from 'lucide-react';
import { Task } from '../../context/AppContext';
interface TaskItemProps {
  task: Task;
  isCurrentUser: boolean;
  onComplete: () => Promise<void>;
  onReassign: (newAssignee: string) => Promise<void>;
  isCompleted?: boolean;
}
export const TaskItem: React.FC<TaskItemProps> = ({
  task,
  isCurrentUser,
  onComplete,
  onReassign,
  isCompleted = false
}) => {
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const handleComplete = async (e: React.MouseEvent) => {
    e.stopPropagation();
    if (isCompleted || isLoading) return;
    setIsLoading(true);
    try {
      await onComplete();
    } catch (error) {
      console.error('Error completing task:', error);
    } finally {
      setIsLoading(false);
    }
  };
  const handleReassign = async (newAssignee: string) => {
    if (isCompleted || isLoading) return;
    setIsLoading(true);
    setIsMenuOpen(false);
    try {
      await onReassign(newAssignee);
    } catch (error) {
      console.error('Error reassigning task:', error);
    } finally {
      setIsLoading(false);
    }
  };
  return <li className={`px-4 py-3 ${isCompleted ? 'bg-gray-50 dark:bg-gray-850' : ''}`}>
      <div className="flex items-start justify-between">
        <div className="flex items-start gap-3">
          <button onClick={handleComplete} disabled={isCompleted || isLoading} className={`mt-0.5 flex-shrink-0 rounded-full p-1 ${isCompleted ? 'text-green-500 cursor-default' : 'text-gray-400 hover:text-green-500 hover:bg-green-50 dark:hover:bg-green-900/20'}`}>
            <CheckCircle size={18} />
          </button>
          <div>
            <p className={`${isCompleted ? 'line-through text-gray-500 dark:text-gray-400' : ''}`}>
              {task.description}
            </p>
            <div className="flex items-center gap-2 mt-1">
              <div className="flex items-center gap-1 text-xs text-gray-500 dark:text-gray-400">
                <User size={12} />
                <span>{task.assignee || 'Unassigned'}</span>
              </div>
              {/* Smart Rails indicator - this would be dynamic in a real app */}
              {Math.random() > 0.5 && !isCompleted && <span className="flex items-center gap-1 text-xs font-medium px-1.5 py-0.5 rounded-full bg-green-100 dark:bg-green-900/30 text-green-800 dark:text-green-300">
                  <Zap size={10} />
                  Smart Rails
                </span>}
            </div>
          </div>
        </div>
        {!isCompleted && <div className="relative">
            <button onClick={() => setIsMenuOpen(!isMenuOpen)} className="text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 p-1">
              <MoreHorizontal size={18} />
            </button>
            {isMenuOpen && <div className="absolute right-0 mt-1 w-48 bg-white dark:bg-gray-800 rounded-md shadow-lg z-10 border border-gray-200 dark:border-gray-700">
                <ul className="py-1">
                  <li>
                    <button onClick={() => handleReassign(isCurrentUser ? 'someone_else' : 'me')} className="w-full text-left px-4 py-2 text-sm hover:bg-gray-100 dark:hover:bg-gray-700">
                      {isCurrentUser ? 'Reassign to Someone Else' : 'Assign to Me'}
                    </button>
                  </li>
                  <li>
                    <button onClick={handleComplete} className="w-full text-left px-4 py-2 text-sm hover:bg-gray-100 dark:hover:bg-gray-700">
                      Mark as Completed
                    </button>
                  </li>
                </ul>
              </div>}
          </div>}
      </div>
    </li>;
};