import React, { useState } from 'react';
import { ChevronDown, Zap, Brain, HardDrive, ClipboardList } from 'lucide-react';
import { AgentType, AgentOption } from '../../context/ChatContext';
interface AgentSelectorProps {
  selectedAgent: AgentType;
  onAgentChange: (agent: AgentType) => void;
  availableAgents: AgentOption[];
}
export const AgentSelector: React.FC<AgentSelectorProps> = ({
  selectedAgent,
  onAgentChange,
  availableAgents
}) => {
  const [isOpen, setIsOpen] = useState(false);
  const selectedAgentInfo = availableAgents.find(agent => agent.id === selectedAgent);
  const getAgentIcon = (iconName: string) => {
    switch (iconName) {
      case 'brain':
        return <Brain size={16} />;
      case 'zap':
        return <Zap size={16} />;
      case 'hard-drive':
        return <HardDrive size={16} />;
      case 'clipboard-list':
        return <ClipboardList size={16} />;
      default:
        return null;
    }
  };
  const getColorClass = (color: string) => {
    switch (color) {
      case 'purple':
        return 'bg-purple-500 text-white';
      case 'blue':
        return 'bg-blue-500 text-white';
      case 'green':
        return 'bg-green-500 text-white';
      case 'orange':
        return 'bg-orange-500 text-white';
      default:
        return 'bg-gray-500 text-white';
    }
  };
  return <div className="relative">
      {/* Quick tabs for frequent agents */}
      <div className="flex p-2 gap-1 overflow-x-auto scrollbar-hide">
        {availableAgents.map(agent => <button key={agent.id} onClick={() => onAgentChange(agent.id)} className={`flex items-center gap-1 px-3 py-1.5 rounded-full text-sm whitespace-nowrap
              ${selectedAgent === agent.id ? getColorClass(agent.color) : 'bg-gray-200 dark:bg-gray-700 text-gray-700 dark:text-gray-300'}
            `}>
            <span className="flex-shrink-0">{getAgentIcon(agent.icon)}</span>
            <span>{agent.name}</span>
          </button>)}
      </div>
      {/* Selected agent with dropdown */}
      <div className="px-4 py-2 border-t border-gray-200 dark:border-gray-700">
        <button onClick={() => setIsOpen(!isOpen)} className="flex items-center justify-between w-full">
          <div className="flex items-center gap-2">
            <div className={`w-8 h-8 rounded-full flex items-center justify-center ${getColorClass(selectedAgentInfo?.color || 'gray')}`}>
              {getAgentIcon(selectedAgentInfo?.icon || '')}
            </div>
            <div className="text-left">
              <div className="font-medium">{selectedAgentInfo?.name}</div>
              <div className="text-xs text-gray-500 dark:text-gray-400">
                {selectedAgentInfo?.description}
              </div>
            </div>
          </div>
          <ChevronDown size={16} className={`transition-transform ${isOpen ? 'rotate-180' : ''}`} />
        </button>
        {isOpen && <div className="absolute left-0 right-0 mt-2 bg-white dark:bg-gray-800 shadow-lg rounded-lg z-20 border border-gray-200 dark:border-gray-700">
            <div className="p-2">
              {availableAgents.map(agent => <button key={agent.id} onClick={() => {
            onAgentChange(agent.id);
            setIsOpen(false);
          }} className={`flex items-center gap-3 w-full p-3 rounded-lg text-left
                    ${selectedAgent === agent.id ? 'bg-gray-100 dark:bg-gray-700' : 'hover:bg-gray-50 dark:hover:bg-gray-700'}
                  `}>
                  <div className={`w-8 h-8 rounded-full flex items-center justify-center ${getColorClass(agent.color)}`}>
                    {getAgentIcon(agent.icon)}
                  </div>
                  <div>
                    <div className="font-medium">{agent.name}</div>
                    <div className="text-xs text-gray-500 dark:text-gray-400">
                      {agent.description}
                    </div>
                  </div>
                </button>)}
            </div>
          </div>}
      </div>
    </div>;
};