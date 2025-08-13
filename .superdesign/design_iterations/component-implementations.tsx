// Clean Telegram Mini App Component Implementations
// No analytics, no marketing, just productivity

import React, { useState, useEffect } from 'react';
import { Send, Plus, Check, X, Calendar, Clock, List, MessageCircle, Settings } from 'lucide-react';

// ============================================
// MAIN APP COMPONENT
// ============================================
export function App() {
  const [currentView, setCurrentView] = useState<'tasks' | 'lists' | 'chat'>('tasks');
  const [tasks, setTasks] = useState<Task[]>([]);
  const [lists, setLists] = useState<List[]>([]);

  return (
    <div className="flex flex-col h-screen bg-white">
      {/* Main Content */}
      <div className="flex-1 overflow-hidden">
        {currentView === 'tasks' && <TasksView tasks={tasks} />}
        {currentView === 'lists' && <ListsView lists={lists} />}
        {currentView === 'chat' && <ChatView />}
      </div>

      {/* Bottom Navigation */}
      <Navigation currentView={currentView} onViewChange={setCurrentView} />
    </div>
  );
}

// ============================================
// NAVIGATION COMPONENT
// ============================================
export function Navigation({ currentView, onViewChange }) {
  return (
    <div className="flex border-t border-gray-200 bg-white">
      <NavTab
        icon={<List size={20} />}
        label="Tasks"
        active={currentView === 'tasks'}
        onClick={() => onViewChange('tasks')}
      />
      <NavTab
        icon={<Calendar size={20} />}
        label="Lists"
        active={currentView === 'lists'}
        onClick={() => onViewChange('lists')}
      />
      <NavTab
        icon={<MessageCircle size={20} />}
        label="Chat"
        active={currentView === 'chat'}
        onClick={() => onViewChange('chat')}
      />
    </div>
  );
}

function NavTab({ icon, label, active, onClick }) {
  return (
    <button
      onClick={onClick}
      className={`flex-1 flex flex-col items-center py-2 px-3 ${
        active ? 'text-blue-500' : 'text-gray-500'
      }`}
    >
      {icon}
      <span className="text-xs mt-1">{label}</span>
    </button>
  );
}

// ============================================
// TASKS VIEW
// ============================================
export function TasksView({ tasks }) {
  const [showNewTask, setShowNewTask] = useState(false);
  
  const todayTasks = tasks.filter(t => isToday(t.dueDate) && !t.completed);
  const upcomingTasks = tasks.filter(t => !isToday(t.dueDate) && !t.completed);
  const completedTasks = tasks.filter(t => t.completed);

  return (
    <div className="flex flex-col h-full">
      {/* Header */}
      <div className="flex items-center justify-between p-4 border-b">
        <h1 className="text-xl font-semibold">Tasks</h1>
        <button
          onClick={() => setShowNewTask(true)}
          className="p-2 bg-blue-500 text-white rounded-full"
        >
          <Plus size={20} />
        </button>
      </div>

      {/* Task List */}
      <div className="flex-1 overflow-y-auto">
        {todayTasks.length > 0 && (
          <TaskSection title={`Today (${todayTasks.length})`} tasks={todayTasks} />
        )}
        
        {upcomingTasks.length > 0 && (
          <TaskSection title={`Upcoming (${upcomingTasks.length})`} tasks={upcomingTasks} />
        )}
        
        {completedTasks.length > 0 && (
          <TaskSection title="Completed" tasks={completedTasks} />
        )}
      </div>

      {/* New Task Modal */}
      {showNewTask && <NewTaskModal onClose={() => setShowNewTask(false)} />}
    </div>
  );
}

function TaskSection({ title, tasks }) {
  return (
    <div className="mb-4">
      <h2 className="px-4 py-2 text-sm font-medium text-gray-600 bg-gray-50">
        {title}
      </h2>
      {tasks.map(task => (
        <TaskItem key={task.id} task={task} />
      ))}
    </div>
  );
}

function TaskItem({ task }) {
  const [completed, setCompleted] = useState(task.completed);

  return (
    <div className="flex items-center px-4 py-3 border-b border-gray-100">
      <button
        onClick={() => setCompleted(!completed)}
        className={`w-5 h-5 rounded border-2 mr-3 flex items-center justify-center ${
          completed ? 'bg-green-500 border-green-500' : 'border-gray-300'
        }`}
      >
        {completed && <Check size={14} className="text-white" />}
      </button>
      
      <div className="flex-1">
        <p className={`${completed ? 'line-through text-gray-400' : 'text-gray-800'}`}>
          {task.title}
        </p>
        {task.dueDate && !completed && (
          <p className="text-xs text-gray-500 mt-1">
            Due: {formatDueDate(task.dueDate)}
          </p>
        )}
        {completed && (
          <p className="text-xs text-gray-400 mt-1">Completed</p>
        )}
      </div>
    </div>
  );
}

// ============================================
// LISTS VIEW  
// ============================================
export function ListsView({ lists }) {
  const [showNewList, setShowNewList] = useState(false);

  return (
    <div className="flex flex-col h-full">
      {/* Header */}
      <div className="flex items-center justify-between p-4 border-b">
        <h1 className="text-xl font-semibold">Lists</h1>
        <button
          onClick={() => setShowNewList(true)}
          className="p-2 bg-blue-500 text-white rounded-full"
        >
          <Plus size={20} />
        </button>
      </div>

      {/* Lists */}
      <div className="flex-1 overflow-y-auto p-4">
        {lists.map(list => (
          <ListCard key={list.id} list={list} />
        ))}
      </div>

      {/* New List Modal */}
      {showNewList && <NewListModal onClose={() => setShowNewList(false)} />}
    </div>
  );
}

function ListCard({ list }) {
  return (
    <button className="w-full text-left p-4 mb-3 bg-white border border-gray-200 rounded-lg hover:border-blue-300 transition-colors">
      <div className="flex items-center justify-between">
        <div className="flex items-center">
          <span className="text-2xl mr-3">{list.emoji}</span>
          <div>
            <h3 className="font-medium text-gray-800">{list.name}</h3>
            <p className="text-sm text-gray-500">{list.itemCount} items</p>
          </div>
        </div>
        <ChevronRight size={20} className="text-gray-400" />
      </div>
    </button>
  );
}

// ============================================
// CHAT VIEW (SIMPLIFIED)
// ============================================
export function ChatView() {
  const [messages, setMessages] = useState<Message[]>([
    { id: 1, text: "Hi! How can I help you today?", sender: 'bot' }
  ]);
  const [inputText, setInputText] = useState('');
  const [isProcessing, setIsProcessing] = useState(false);

  const sendMessage = async () => {
    if (!inputText.trim() || isProcessing) return;

    const userMessage = {
      id: messages.length + 1,
      text: inputText,
      sender: 'user'
    };

    setMessages([...messages, userMessage]);
    setInputText('');
    setIsProcessing(true);

    // Simulate bot response
    setTimeout(() => {
      const botResponse = {
        id: messages.length + 2,
        text: "I'll help you with that right away!",
        sender: 'bot'
      };
      setMessages(prev => [...prev, botResponse]);
      setIsProcessing(false);
    }, 1000);
  };

  return (
    <div className="flex flex-col h-full">
      {/* Header */}
      <div className="p-4 border-b bg-white">
        <h1 className="text-xl font-semibold">Chat with BrainBot</h1>
      </div>

      {/* Messages */}
      <div className="flex-1 overflow-y-auto p-4 bg-gray-50">
        {messages.map(message => (
          <MessageBubble key={message.id} message={message} />
        ))}
        {isProcessing && (
          <div className="text-sm text-gray-500 italic">Working...</div>
        )}
      </div>

      {/* Input */}
      <div className="p-4 border-t bg-white">
        <div className="flex space-x-2">
          <input
            type="text"
            value={inputText}
            onChange={(e) => setInputText(e.target.value)}
            onKeyPress={(e) => e.key === 'Enter' && sendMessage()}
            placeholder="Type a message..."
            className="flex-1 px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-500"
          />
          <button
            onClick={sendMessage}
            disabled={!inputText.trim() || isProcessing}
            className="px-4 py-2 bg-blue-500 text-white rounded-lg disabled:opacity-50"
          >
            <Send size={18} />
          </button>
        </div>
      </div>
    </div>
  );
}

function MessageBubble({ message }) {
  const isBot = message.sender === 'bot';
  
  return (
    <div className={`mb-3 flex ${isBot ? 'justify-start' : 'justify-end'}`}>
      <div
        className={`max-w-[80%] px-3 py-2 rounded-lg ${
          isBot
            ? 'bg-gray-200 text-gray-800'
            : 'bg-blue-500 text-white'
        }`}
      >
        {isBot && <p className="text-xs font-medium mb-1">Bot</p>}
        <p className="text-sm">{message.text}</p>
      </div>
    </div>
  );
}

// ============================================
// MODALS
// ============================================
export function NewTaskModal({ onClose }) {
  const [title, setTitle] = useState('');
  const [dueDate, setDueDate] = useState('today');
  const [dueTime, setDueTime] = useState('17:00');
  const [list, setList] = useState('personal');
  const [priority, setPriority] = useState('normal');

  const handleCreate = () => {
    // Create task logic here
    console.log('Creating task:', { title, dueDate, dueTime, list, priority });
    onClose();
  };

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-end justify-center">
      <div className="bg-white rounded-t-2xl w-full max-w-lg p-6 animate-slide-up">
        {/* Header */}
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold">New Task</h2>
          <button onClick={onClose} className="p-1">
            <X size={20} />
          </button>
        </div>

        {/* Form */}
        <div className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              What needs to be done?
            </label>
            <input
              type="text"
              value={title}
              onChange={(e) => setTitle(e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-500"
              placeholder="Enter task..."
            />
          </div>

          <div className="grid grid-cols-2 gap-3">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                Due Date
              </label>
              <select
                value={dueDate}
                onChange={(e) => setDueDate(e.target.value)}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg"
              >
                <option value="today">Today</option>
                <option value="tomorrow">Tomorrow</option>
                <option value="nextweek">Next Week</option>
              </select>
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                Time
              </label>
              <input
                type="time"
                value={dueTime}
                onChange={(e) => setDueTime(e.target.value)}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg"
              />
            </div>
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              List
            </label>
            <select
              value={list}
              onChange={(e) => setList(e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg"
            >
              <option value="personal">Personal</option>
              <option value="work">Work</option>
              <option value="shopping">Shopping</option>
            </select>
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Priority
            </label>
            <div className="flex space-x-3">
              {['low', 'normal', 'high'].map((p) => (
                <button
                  key={p}
                  onClick={() => setPriority(p)}
                  className={`flex-1 py-2 px-3 rounded-lg border ${
                    priority === p
                      ? 'bg-blue-50 border-blue-500 text-blue-600'
                      : 'border-gray-300'
                  }`}
                >
                  {p.charAt(0).toUpperCase() + p.slice(1)}
                </button>
              ))}
            </div>
          </div>
        </div>

        {/* Actions */}
        <div className="flex space-x-3 mt-6">
          <button
            onClick={onClose}
            className="flex-1 py-2 px-4 border border-gray-300 rounded-lg"
          >
            Cancel
          </button>
          <button
            onClick={handleCreate}
            disabled={!title.trim()}
            className="flex-1 py-2 px-4 bg-blue-500 text-white rounded-lg disabled:opacity-50"
          >
            Create Task
          </button>
        </div>
      </div>
    </div>
  );
}

// ============================================
// TYPES
// ============================================
interface Task {
  id: string;
  title: string;
  completed: boolean;
  dueDate?: Date;
  list?: string;
  priority?: 'low' | 'normal' | 'high';
}

interface List {
  id: string;
  name: string;
  emoji: string;
  itemCount: number;
}

interface Message {
  id: number;
  text: string;
  sender: 'user' | 'bot';
}

// ============================================
// UTILITIES
// ============================================
function isToday(date: Date): boolean {
  const today = new Date();
  return date?.toDateString() === today.toDateString();
}

function formatDueDate(date: Date): string {
  const today = new Date();
  const tomorrow = new Date(today);
  tomorrow.setDate(tomorrow.getDate() + 1);

  if (date.toDateString() === today.toDateString()) {
    return `Today at ${date.toLocaleTimeString('en-US', { 
      hour: 'numeric', 
      minute: '2-digit' 
    })}`;
  } else if (date.toDateString() === tomorrow.toDateString()) {
    return `Tomorrow at ${date.toLocaleTimeString('en-US', { 
      hour: 'numeric', 
      minute: '2-digit' 
    })}`;
  } else {
    return date.toLocaleDateString('en-US', { 
      month: 'short', 
      day: 'numeric',
      hour: 'numeric',
      minute: '2-digit'
    });
  }
}