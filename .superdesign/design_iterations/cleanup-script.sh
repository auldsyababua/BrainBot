#!/bin/bash

# Telegram Mini App Cleanup Script
# Removes marketing fluff and analytics, implements clean design

set -e

echo "🧹 Starting Telegram Mini App Cleanup..."
echo "======================================="

# Navigate to mini app directory
cd /Users/colinaulds/Desktop/projects/flrts/telegram-mini-app

# Create backup
echo "📦 Creating backup..."
cp -r . ../telegram-mini-app.backup.$(date +%Y%m%d_%H%M%S)

# Step 1: Remove marketing and analytics components
echo ""
echo "❌ Removing marketing and analytics components..."
echo "------------------------------------------------"

# Remove performance metrics components
if [ -f "src/components/Dashboard/PerformanceMetrics.tsx" ]; then
    rm src/components/Dashboard/PerformanceMetrics.tsx
    echo "  ✓ Removed PerformanceMetrics.tsx"
fi

if [ -f "src/components/SmartRails/TokenSavingsDisplay.tsx" ]; then
    rm src/components/SmartRails/TokenSavingsDisplay.tsx
    echo "  ✓ Removed TokenSavingsDisplay.tsx"
fi

if [ -f "src/components/SmartRails/TokenCalculator.tsx" ]; then
    rm src/components/SmartRails/TokenCalculator.tsx
    echo "  ✓ Removed TokenCalculator.tsx"
fi

if [ -f "src/components/SmartRails/PerformanceIndicator.tsx" ]; then
    rm src/components/SmartRails/PerformanceIndicator.tsx
    echo "  ✓ Removed PerformanceIndicator.tsx"
fi

# Step 2: Clean up imports
echo ""
echo "🔧 Cleaning up imports..."
echo "------------------------"

# Find and remove imports of deleted components
find src -type f \( -name "*.tsx" -o -name "*.ts" \) -exec grep -l "PerformanceMetrics\|TokenSavingsDisplay\|TokenCalculator\|PerformanceIndicator" {} \; | while read file; do
    # Remove import lines
    sed -i '' '/import.*PerformanceMetrics/d' "$file"
    sed -i '' '/import.*TokenSavingsDisplay/d' "$file"
    sed -i '' '/import.*TokenCalculator/d' "$file"
    sed -i '' '/import.*PerformanceIndicator/d' "$file"
    
    # Remove usage of these components
    sed -i '' '/<PerformanceMetrics/d' "$file"
    sed -i '' '/<TokenSavingsDisplay/d' "$file"
    sed -i '' '/<TokenCalculator/d' "$file"
    sed -i '' '/<PerformanceIndicator/d' "$file"
    
    echo "  ✓ Cleaned $file"
done

# Step 3: Simplify ConfidenceIndicator
echo ""
echo "📝 Simplifying ConfidenceIndicator..."
echo "------------------------------------"

if [ -f "src/components/SmartRails/ConfidenceIndicator.tsx" ]; then
    cat > src/components/SmartRails/ConfidenceIndicator.tsx << 'EOF'
import React from 'react';

interface StatusIndicatorProps {
  isProcessing: boolean;
}

export function StatusIndicator({ isProcessing }: StatusIndicatorProps) {
  return (
    <div className="flex items-center space-x-2">
      {isProcessing ? (
        <>
          <div className="w-4 h-4 border-2 border-gray-300 border-t-blue-500 rounded-full animate-spin" />
          <span className="text-sm text-gray-500">Processing...</span>
        </>
      ) : (
        <span className="text-sm text-green-500">Ready</span>
      )}
    </div>
  );
}

// Keep the old name for backward compatibility
export const ConfidenceIndicator = StatusIndicator;
EOF
    echo "  ✓ Simplified ConfidenceIndicator.tsx"
fi

# Step 4: Update Dashboard
echo ""
echo "🏠 Updating Dashboard..."
echo "-----------------------"

if [ -f "src/components/Dashboard/Dashboard.tsx" ]; then
    # Check if file exists and update it
    if grep -q "PerformanceMetrics" src/components/Dashboard/Dashboard.tsx; then
        # Remove PerformanceMetrics import and usage
        sed -i '' '/import.*PerformanceMetrics/d' src/components/Dashboard/Dashboard.tsx
        sed -i '' '/<PerformanceMetrics/d' src/components/Dashboard/Dashboard.tsx
        echo "  ✓ Removed PerformanceMetrics from Dashboard"
    fi
fi

# Step 5: Clean up CommandExecutor
echo ""
echo "⚡ Cleaning CommandExecutor..."
echo "-----------------------------"

if [ -f "src/components/SmartRails/CommandExecutor.tsx" ]; then
    # Remove token display patterns
    sed -i '' 's/.*tokens.*<.*ms.*//g' src/components/SmartRails/CommandExecutor.tsx
    sed -i '' '/Direct Execution/d' src/components/SmartRails/CommandExecutor.tsx
    sed -i '' '/confidence/d' src/components/SmartRails/CommandExecutor.tsx
    echo "  ✓ Cleaned CommandExecutor.tsx"
fi

# Step 6: Update Settings
echo ""
echo "⚙️ Updating Settings..."
echo "----------------------"

if [ -f "src/components/Settings/SettingsView.tsx" ]; then
    # Remove performance statistics section
    sed -i '' '/Performance Statistics/,/^$/d' src/components/Settings/SettingsView.tsx
    sed -i '' '/Token Savings/d' src/components/Settings/SettingsView.tsx
    echo "  ✓ Cleaned SettingsView.tsx"
fi

# Step 7: Check for TypeScript errors
echo ""
echo "🔍 Checking for TypeScript errors..."
echo "-----------------------------------"

# Try to run type check
if command -v tsc &> /dev/null; then
    npx tsc --noEmit || echo "  ⚠️ Some TypeScript errors found - manual fixes may be needed"
else
    echo "  ⚠️ TypeScript not found - skipping type check"
fi

# Step 8: Format code
echo ""
echo "💅 Formatting code..."
echo "--------------------"

if [ -f "package.json" ]; then
    if grep -q "\"prettier\"" package.json; then
        npx prettier --write src/ 2>/dev/null || echo "  ⚠️ Prettier formatting skipped"
    fi
fi

# Step 9: Summary
echo ""
echo "======================================="
echo "✅ Cleanup Complete!"
echo "======================================="
echo ""
echo "Summary of changes:"
echo "  • Removed performance metrics components"
echo "  • Removed token savings displays"
echo "  • Simplified confidence indicators"
echo "  • Cleaned up Dashboard"
echo "  • Removed analytics from Settings"
echo ""
echo "Next steps:"
echo "  1. Review the changes: git diff"
echo "  2. Test the application: npm run dev"
echo "  3. Build for production: npm run build"
echo "  4. Deploy to Cloudflare: npm run deploy"
echo ""
echo "Backup saved to: ../telegram-mini-app.backup.$(date +%Y%m%d_%H%M%S)"
echo ""
echo "To rollback if needed:"
echo "  rm -rf telegram-mini-app"
echo "  mv ../telegram-mini-app.backup.* telegram-mini-app"