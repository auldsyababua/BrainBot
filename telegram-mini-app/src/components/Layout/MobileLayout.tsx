import React from 'react';
interface MobileLayoutProps {
  children: React.ReactNode;
}
export const MobileLayout: React.FC<MobileLayoutProps> = ({
  children
}) => {
  return <div className="max-w-md mx-auto h-screen overflow-hidden flex flex-col bg-gray-50 dark:bg-gray-900 text-gray-900 dark:text-gray-100">
      {children}
    </div>;
};