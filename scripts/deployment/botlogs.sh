#!/bin/bash

# Markdown Brain Bot Logs & Restart Script
# Enhanced version with logging and monitoring

BOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="$BOT_DIR/logs"
LOG_FILE="$LOG_DIR/bot-$(date +%Y%m%d-%H%M%S).log"

# Create logs directory if it doesn't exist
mkdir -p "$LOG_DIR"

# Function to print colored output
print_status() {
    echo -e "\033[1;32m$1\033[0m"
}

print_error() {
    echo -e "\033[1;31m$1\033[0m"
}

print_info() {
    echo -e "\033[1;34m$1\033[0m"
}

echo ""
print_status "🧠 Markdown Brain Bot Manager"
echo "=============================="
echo "Log file: $LOG_FILE"
echo ""

# Kill existing processes
print_info "🔴 Stopping existing bot processes..."
pkill -f "python.*main_polling.py" 2>/dev/null && echo "   Killed polling bot"
pkill -f "python.*main.py" 2>/dev/null && echo "   Killed webhook bot"
pkill -f "ngrok" 2>/dev/null && echo "   Killed ngrok"
sleep 1

# Clear caches
print_info "🗑️  Clearing caches..."
find "$BOT_DIR" -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null
find "$BOT_DIR" -type f -name "*.pyc" -delete 2>/dev/null
echo "   Python cache cleared"

# Rotate old logs (keep last 10)
print_info "📄 Managing logs..."
log_count=$(ls -1 "$LOG_DIR"/bot-*.log 2>/dev/null | wc -l)
if [ $log_count -gt 10 ]; then
    ls -t "$LOG_DIR"/bot-*.log | tail -n +11 | xargs rm -f
    echo "   Old logs cleaned (kept last 10)"
fi

# Check environment
print_info "🔍 Checking environment..."
cd "$BOT_DIR"

if [ ! -f ".env" ]; then
    print_error "   ⚠️  .env file not found!"
    exit 1
fi

if [ -d "venv" ]; then
    source venv/bin/activate
    echo "   Virtual environment activated"
fi

# Verify dependencies
if ! python -c "import telegram" 2>/dev/null; then
    print_error "   ⚠️  python-telegram-bot not installed!"
    echo "   Run: pip install -r requirements.txt"
    exit 1
fi

# Start bot with proper logging
print_status "🚀 Starting bot in polling mode..."
echo ""

# Create a function to handle shutdown
shutdown() {
    echo ""
    print_info "\n🚫 Shutting down..."
    pkill -f "python.*main_polling.py" 2>/dev/null
    print_status "Bot stopped. Log saved to: $LOG_FILE"
    exit 0
}

# Trap Ctrl+C
trap shutdown INT

# Start bot with output to both console and log file
python main_polling.py 2>&1 | tee "$LOG_FILE"

# If bot exits unexpectedly
print_error "\n⚠️  Bot exited unexpectedly!"
echo "Check log file: $LOG_FILE"