#!/bin/bash
# Cleanup script for build artifacts and temporary files in FLRTS project

echo "🧹 FLRTS Build Artifacts Cleanup Script"
echo "========================================"

# Get the project root (parent of scripts directory)
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT"

echo "📍 Working in: $PROJECT_ROOT"
echo ""

# Function to safely remove with confirmation
safe_remove() {
    local path=$1
    local description=$2
    
    if [ -e "$path" ] || [ -d "$path" ]; then
        echo "Found: $description"
        echo "  Path: $path"
        rm -rf "$path" 2>/dev/null
        echo "  ✅ Removed"
    fi
}

echo "🔍 Searching for artifacts to clean..."
echo ""

# Python cache files
echo "1️⃣ Python Cache Files"
echo "-------------------"
find . -type d -name "__pycache__" 2>/dev/null | while read -r dir; do
    safe_remove "$dir" "Python cache"
done
find . -name "*.pyc" -o -name "*.pyo" 2>/dev/null | while read -r file; do
    safe_remove "$file" "Python compiled file"
done

# Egg info directories
echo ""
echo "2️⃣ Package Build Artifacts"
echo "------------------------"
safe_remove "src/flrts_bmad.egg-info" "Development package info"
safe_remove "src/flrts.egg-info" "Development package info (new name)"
safe_remove "build" "Build directory"
safe_remove "dist" "Distribution directory"
safe_remove "*.egg-info" "Egg info files"

# Test artifacts
echo ""
echo "3️⃣ Test Artifacts"
echo "----------------"
safe_remove ".pytest_cache" "Pytest cache"
safe_remove ".coverage" "Coverage data"
safe_remove "htmlcov" "Coverage HTML report"
safe_remove ".mypy_cache" "MyPy type checking cache"
safe_remove ".ruff_cache" "Ruff linter cache"

# IDE and editor files
echo ""
echo "4️⃣ IDE Temporary Files"
echo "---------------------"
find . -name "*.swp" -o -name "*.swo" -o -name "*~" 2>/dev/null | while read -r file; do
    safe_remove "$file" "Editor temporary file"
done
safe_remove ".DS_Store" "macOS metadata"

# Log files (optional - ask before removing)
echo ""
echo "5️⃣ Log Files"
echo "-----------"
LOG_COUNT=$(find . -name "*.log" 2>/dev/null | wc -l | tr -d ' ')
if [ "$LOG_COUNT" -gt 0 ]; then
    echo "Found $LOG_COUNT log files"
    read -p "Remove log files? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        find . -name "*.log" -exec rm -f {} \;
        echo "  ✅ Log files removed"
    else
        echo "  ⏭️  Skipped log files"
    fi
else
    echo "No log files found"
fi

echo ""
echo "✨ Cleanup complete!"
echo ""

# Check if .gitignore needs updating
echo "📝 Checking .gitignore..."
MISSING_PATTERNS=""

check_gitignore() {
    local pattern=$1
    if ! grep -q "^$pattern" .gitignore 2>/dev/null; then
        MISSING_PATTERNS="$MISSING_PATTERNS\n$pattern"
    fi
}

check_gitignore "*.egg-info/"
check_gitignore "__pycache__/"
check_gitignore "*.pyc"
check_gitignore "*.pyo"
check_gitignore ".mypy_cache/"
check_gitignore ".ruff_cache/"
check_gitignore ".pytest_cache/"
check_gitignore ".coverage"
check_gitignore "htmlcov/"
check_gitignore "*.swp"
check_gitignore "*.swo"
check_gitignore "*~"
check_gitignore ".DS_Store"

if [ -n "$MISSING_PATTERNS" ]; then
    echo ""
    echo "⚠️  Recommended additions to .gitignore:"
    echo -e "$MISSING_PATTERNS"
else
    echo "✅ .gitignore appears complete"
fi

echo ""
echo "Done! Your project is clean. 🎉"