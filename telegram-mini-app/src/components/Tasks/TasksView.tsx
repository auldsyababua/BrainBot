import React, { useState } from 'react';
import { TaskCreator } from './TaskCreator';
import { TaskList } from './TaskList';
import { useAppContext } from '../../context/AppContext';
import { createTask, completeTask, reassignTask } from '../../services/brainbotApi';
import { LoadingSpinner } from '../Common/LoadingSpinner';
import { StatusIndicator } from '../Common/StatusIndicator';
export const TasksView: React.FC = () => {
  const {
    tasks,
    user,
    refreshData
  } = useAppContext();
  const [isLoading, setIsLoading] = useState(false);
  const [status, setStatus] = useState<{
    type: 'success' | 'error';
    message: string;
  } | null>(null);
  const [filter, setFilter] = useState<'all' | 'mine' | 'assigned'>('all');
  const handleCreateTask = async (description: string, assignee?: string) => {
    setIsLoading(true);
    setStatus(null);
    try {
      await createTask(description, assignee);
      await refreshData();
      setStatus({
        type: 'success',
        message: 'Task created successfully'
      });
    } catch (error) {
      console.error('Error creating task:', error);
      setStatus({
        type: 'error',
        message: 'Failed to create task'
      });
    } finally {
      setIsLoading(false);
    }
  };
  const handleCompleteTask = async (taskId: string) => {
    setIsLoading(true);
    try {
      await completeTask(taskId);
      await refreshData();
    } catch (error) {
      console.error('Error completing task:', error);
      setStatus({
        type: 'error',
        message: 'Failed to complete task'
      });
    } finally {
      setIsLoading(false);
    }
  };
  const handleReassignTask = async (taskId: string, newAssignee: string) => {
    setIsLoading(true);
    try {
      await reassignTask(taskId, newAssignee);
      await refreshData();
    } catch (error) {
      console.error('Error reassigning task:', error);
      setStatus({
        type: 'error',
        message: 'Failed to reassign task'
      });
    } finally {
      setIsLoading(false);
    }
  };
  const filteredTasks = () => {
    switch (filter) {
      case 'mine':
        return tasks.filter(task => task.assignee === user?.username);
      case 'assigned':
        return tasks.filter(task => task.assignee !== user?.username);
      default:
        return tasks;
    }
  };
  return <div className="flex flex-col gap-4">
      <h1 className="text-xl font-semibold">Tasks</h1>
      {status && <StatusIndicator type={status.type} message={status.message} onDismiss={() => setStatus(null)} />}
      <TaskCreator onTaskCreate={task => handleCreateTask(task.description, task.assignee)} availableUsers={[{
      id: 1,
      username: 'testuser',
      name: 'Test User'
    }]} isDirectExecution={true} />
      <div className="flex gap-2 mb-2">
        <button onClick={() => setFilter('all')} className={`px-3 py-1 text-sm rounded-full ${filter === 'all' ? 'bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-200' : 'bg-gray-100 text-gray-800 dark:bg-gray-800 dark:text-gray-200'}`}>
          All
        </button>
        <button onClick={() => setFilter('mine')} className={`px-3 py-1 text-sm rounded-full ${filter === 'mine' ? 'bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-200' : 'bg-gray-100 text-gray-800 dark:bg-gray-800 dark:text-gray-200'}`}>
          My Tasks
        </button>
        <button onClick={() => setFilter('assigned')} className={`px-3 py-1 text-sm rounded-full ${filter === 'assigned' ? 'bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-200' : 'bg-gray-100 text-gray-800 dark:bg-gray-800 dark:text-gray-200'}`}>
          Assigned
        </button>
      </div>
      {isLoading ? <div className="flex justify-center py-8">
          <LoadingSpinner label="Loading tasks..." />
        </div> : <TaskList tasks={filteredTasks()} currentUser={user?.username || 'testuser'} onTaskComplete={handleCompleteTask} onTaskReassign={handleReassignTask} filterBy={filter} />}
    </div>;
};