import React, { useState } from 'react';
import { useSmartRailsContext } from '../../context/SmartRailsContext';
import { Zap, Calendar, User, Clock, ChevronLeft, ChevronRight, X } from 'lucide-react';
interface User {
  id: number;
  username: string;
  name: string;
}
interface CreateTaskRequest {
  description: string;
  assignee?: string;
  dueDate?: Date;
}
interface TaskCreatorProps {
  onTaskCreate: (task: CreateTaskRequest) => Promise<void>;
  availableUsers: User[];
  isDirectExecution: boolean;
}
export const TaskCreator: React.FC<TaskCreatorProps> = ({
  onTaskCreate,
  availableUsers,
  isDirectExecution
}) => {
  const [description, setDescription] = useState('');
  const [assignee, setAssignee] = useState<string>('');
  const [showAssigneeDropdown, setShowAssigneeDropdown] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [showDatePicker, setShowDatePicker] = useState(false);
  const [selectedDate, setSelectedDate] = useState<Date | null>(null);
  const [selectedHours, setSelectedHours] = useState(12);
  const [selectedMinutes, setSelectedMinutes] = useState(0);
  const [selectedAmPm, setSelectedAmPm] = useState<'AM' | 'PM'>('PM');
  const {
    confidence
  } = useSmartRailsContext();
  // Detect if this is a Smart Rails direct command
  const isSmartRailsCommand = confidence === 100;
  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!description.trim() || isSubmitting) return;
    setIsSubmitting(true);
    try {
      await onTaskCreate({
        description: description.trim(),
        assignee: assignee || undefined,
        dueDate: selectedDate
      });
      // Reset form
      setDescription('');
      setAssignee('');
      setSelectedDate(null);
    } catch (error) {
      console.error('Error creating task:', error);
    } finally {
      setIsSubmitting(false);
    }
  };
  const handleDescriptionChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setDescription(e.target.value);
    // Parse for @mentions to auto-assign
    const mentionMatch = e.target.value.match(/@(\w+)/);
    if (mentionMatch && mentionMatch[1]) {
      const mentionedUser = availableUsers.find(user => user.username.toLowerCase() === mentionMatch[1].toLowerCase());
      if (mentionedUser) {
        setAssignee(mentionedUser.username);
      }
    }
  };
  const formatDateDisplay = (date: Date | null): string => {
    if (!date) return 'Set due date';
    const hours = selectedAmPm === 'PM' && selectedHours < 12 ? selectedHours + 12 : selectedAmPm === 'AM' && selectedHours === 12 ? 0 : selectedHours;
    const dateWithTime = new Date(date);
    dateWithTime.setHours(hours, selectedMinutes);
    const formatter = new Intl.DateTimeFormat('en-US', {
      month: 'short',
      day: 'numeric',
      hour: 'numeric',
      minute: '2-digit',
      hour12: true
    });
    return formatter.format(dateWithTime);
  };
  const renderCalendar = () => {
    const today = new Date();
    const currentMonth = selectedDate ? selectedDate.getMonth() : today.getMonth();
    const currentYear = selectedDate ? selectedDate.getFullYear() : today.getFullYear();
    const firstDayOfMonth = new Date(currentYear, currentMonth, 1);
    const lastDayOfMonth = new Date(currentYear, currentMonth + 1, 0);
    const daysInMonth = lastDayOfMonth.getDate();
    const startingDayOfWeek = firstDayOfMonth.getDay();
    const daysArray = [];
    const weekdays = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
    // Add empty cells for days before the first of the month
    for (let i = 0; i < startingDayOfWeek; i++) {
      daysArray.push(<div key={`empty-${i}`} className="h-8 w-8"></div>);
    }
    // Add cells for each day of the month
    for (let day = 1; day <= daysInMonth; day++) {
      const date = new Date(currentYear, currentMonth, day);
      const isToday = today.getDate() === day && today.getMonth() === currentMonth && today.getFullYear() === currentYear;
      const isSelected = selectedDate && selectedDate.getDate() === day && selectedDate.getMonth() === currentMonth && selectedDate.getFullYear() === currentYear;
      daysArray.push(<button key={day} type="button" onClick={() => setSelectedDate(date)} className={`h-8 w-8 rounded-full flex items-center justify-center text-sm
            ${isSelected ? 'bg-blue-600 text-white' : ''}
            ${isToday && !isSelected ? 'border border-blue-600 text-blue-600' : ''}
            ${!isToday && !isSelected ? 'hover:bg-gray-100 dark:hover:bg-gray-700' : ''}
          `}>
          {day}
        </button>);
    }
    const prevMonth = () => {
      const newDate = selectedDate ? new Date(selectedDate) : new Date();
      newDate.setMonth(newDate.getMonth() - 1);
      setSelectedDate(newDate);
    };
    const nextMonth = () => {
      const newDate = selectedDate ? new Date(selectedDate) : new Date();
      newDate.setMonth(newDate.getMonth() + 1);
      setSelectedDate(newDate);
    };
    const monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    return <div className="bg-white dark:bg-gray-800 rounded-lg shadow-lg p-4 absolute right-0 top-full mt-1 z-20 w-72 border border-gray-200 dark:border-gray-700">
        <div className="flex justify-between items-center mb-4">
          <div className="font-medium">
            {monthNames[currentMonth]} {currentYear}
          </div>
          <div className="flex gap-2">
            <button type="button" onClick={prevMonth} className="p-1 rounded-full hover:bg-gray-100 dark:hover:bg-gray-700">
              <ChevronLeft size={16} />
            </button>
            <button type="button" onClick={nextMonth} className="p-1 rounded-full hover:bg-gray-100 dark:hover:bg-gray-700">
              <ChevronRight size={16} />
            </button>
            <button type="button" onClick={() => setShowDatePicker(false)} className="p-1 rounded-full hover:bg-gray-100 dark:hover:bg-gray-700 ml-1">
              <X size={16} />
            </button>
          </div>
        </div>
        <div className="grid grid-cols-7 gap-1 mb-2">
          {weekdays.map(day => <div key={day} className="h-8 w-8 flex items-center justify-center text-xs text-gray-500">
              {day}
            </div>)}
        </div>
        <div className="grid grid-cols-7 gap-1 mb-4">{daysArray}</div>
        <div className="border-t border-gray-200 dark:border-gray-700 pt-3">
          <div className="flex items-center justify-between mb-3">
            <div className="flex items-center">
              <Clock size={16} className="mr-2 text-gray-500" />
              <span className="text-sm">Time</span>
            </div>
          </div>
          <div className="flex items-center justify-center gap-1">
            <select value={selectedHours} onChange={e => setSelectedHours(parseInt(e.target.value))} className="bg-gray-100 dark:bg-gray-700 rounded px-2 py-1 text-sm">
              {[12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11].map(hour => <option key={hour} value={hour}>
                  {hour}
                </option>)}
            </select>
            <span>:</span>
            <select value={selectedMinutes} onChange={e => setSelectedMinutes(parseInt(e.target.value))} className="bg-gray-100 dark:bg-gray-700 rounded px-2 py-1 text-sm">
              {[0, 15, 30, 45].map(minute => <option key={minute} value={minute}>
                  {minute.toString().padStart(2, '0')}
                </option>)}
            </select>
            <select value={selectedAmPm} onChange={e => setSelectedAmPm(e.target.value as 'AM' | 'PM')} className="bg-gray-100 dark:bg-gray-700 rounded px-2 py-1 text-sm">
              <option value="AM">AM</option>
              <option value="PM">PM</option>
            </select>
          </div>
          <div className="mt-3 flex justify-between">
            <button type="button" onClick={() => {
            setSelectedDate(null);
            setShowDatePicker(false);
          }} className="text-sm text-gray-600 dark:text-gray-300 hover:text-red-600 dark:hover:text-red-400">
              Clear
            </button>
            <button type="button" onClick={() => {
            if (!selectedDate) {
              setSelectedDate(new Date());
            }
            setShowDatePicker(false);
          }} className="text-sm bg-blue-600 text-white px-3 py-1 rounded hover:bg-blue-700">
              Apply
            </button>
          </div>
        </div>
      </div>;
  };
  return <div className="bg-white dark:bg-gray-800 rounded-lg p-4 shadow-sm">
      <form onSubmit={handleSubmit}>
        <div className="mb-3">
          <div className="relative">
            <input type="text" value={description} onChange={handleDescriptionChange} placeholder="What needs to be done?" className="w-full px-4 py-3 rounded-lg border border-gray-300 dark:border-gray-700 bg-white dark:bg-gray-900 focus:outline-none focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400" disabled={isSubmitting} />
            {isSmartRailsCommand && isDirectExecution && <div className="absolute right-3 top-1/2 transform -translate-y-1/2">
                <span className="flex items-center gap-1 text-xs font-medium px-2 py-0.5 rounded-full bg-green-100 dark:bg-green-900/30 text-green-800 dark:text-green-300">
                  <Zap size={10} />0 tokens
                </span>
              </div>}
          </div>
        </div>
        <div className="flex items-center justify-between mb-3">
          <div className="relative">
            <button type="button" onClick={() => setShowAssigneeDropdown(!showAssigneeDropdown)} className="flex items-center gap-1 text-sm text-gray-600 dark:text-gray-300 hover:text-blue-600 dark:hover:text-blue-400">
              <User size={16} />
              {assignee ? `@${assignee}` : 'Assign to'}
            </button>
            {showAssigneeDropdown && <div className="absolute top-full left-0 mt-1 w-48 bg-white dark:bg-gray-800 rounded-md shadow-lg z-10 border border-gray-200 dark:border-gray-700">
                <ul className="py-1">
                  {availableUsers.map(user => <li key={user.id}>
                      <button type="button" onClick={() => {
                  setAssignee(user.username);
                  setShowAssigneeDropdown(false);
                }} className="w-full text-left px-4 py-2 text-sm hover:bg-gray-100 dark:hover:bg-gray-700">
                        {user.name} (@{user.username})
                      </button>
                    </li>)}
                </ul>
              </div>}
          </div>
          <div className="relative">
            <button type="button" onClick={() => {
            setShowDatePicker(!showDatePicker);
            if (!selectedDate) setSelectedDate(new Date());
          }} className="flex items-center gap-1 text-sm text-gray-600 dark:text-gray-300 hover:text-blue-600 dark:hover:text-blue-400">
              <Calendar size={16} />
              {selectedDate ? formatDateDisplay(selectedDate) : 'Set due date'}
            </button>
            {showDatePicker && renderCalendar()}
          </div>
        </div>
        <button type="submit" disabled={!description.trim() || isSubmitting} className="w-full py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-lg disabled:bg-gray-300 dark:disabled:bg-gray-700 disabled:text-gray-500 dark:disabled:text-gray-400 transition-colors">
          {isSubmitting ? 'Creating...' : 'Create Task'}
        </button>
      </form>
    </div>;
};