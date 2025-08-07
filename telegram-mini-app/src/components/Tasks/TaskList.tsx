import React from 'react';
import { TaskItem } from './TaskItem';
import { Task } from '../../context/AppContext';
interface TaskListProps {
  tasks: Task[];
  currentUser: string;
  onTaskComplete: (taskId: string) => Promise<void>;
  onTaskReassign: (taskId: string, newAssignee: string) => Promise<void>;
  filterBy: 'all' | 'mine' | 'assigned';
}
export const TaskList: React.FC<TaskListProps> = ({
  tasks,
  currentUser,
  onTaskComplete,
  onTaskReassign,
  filterBy
}) => {
  // Group tasks by status
  const activeTasks = tasks.filter(task => task.status === 'active');
  const completedTasks = tasks.filter(task => task.status === 'completed');
  if (tasks.length === 0) {
    return <div className="bg-white dark:bg-gray-800 rounded-lg p-6 shadow-sm text-center">
        <p className="text-gray-500 dark:text-gray-400">
          {filterBy === 'all' ? 'No tasks found. Create your first task!' : filterBy === 'mine' ? 'You have no tasks assigned to you.' : 'No tasks assigned to others.'}
        </p>
      </div>;
  }
  return <div className="space-y-4">
      {activeTasks.length > 0 && <div className="bg-white dark:bg-gray-800 rounded-lg shadow-sm overflow-hidden">
          <div className="px-4 py-3 bg-gray-50 dark:bg-gray-850 border-b border-gray-200 dark:border-gray-700">
            <h3 className="font-medium">Active Tasks ({activeTasks.length})</h3>
          </div>
          <ul className="divide-y divide-gray-200 dark:divide-gray-700">
            {activeTasks.map(task => <TaskItem key={task.id} task={task} isCurrentUser={task.assignee === currentUser} onComplete={() => onTaskComplete(task.id)} onReassign={newAssignee => onTaskReassign(task.id, newAssignee)} />)}
          </ul>
        </div>}
      {completedTasks.length > 0 && <div className="bg-white dark:bg-gray-800 rounded-lg shadow-sm overflow-hidden">
          <div className="px-4 py-3 bg-gray-50 dark:bg-gray-850 border-b border-gray-200 dark:border-gray-700">
            <h3 className="font-medium">
              Completed Tasks ({completedTasks.length})
            </h3>
          </div>
          <ul className="divide-y divide-gray-200 dark:divide-gray-700">
            {completedTasks.map(task => <TaskItem key={task.id} task={task} isCurrentUser={task.assignee === currentUser} onComplete={() => {}} onReassign={() => {}} isCompleted />)}
          </ul>
        </div>}
    </div>;
};