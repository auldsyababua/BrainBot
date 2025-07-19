#!/bin/bash

# Markdown Brain Bot Restart Script
# Similar to flrtslogs - kills processes, clears cache, restarts services

echo "🧠 Markdown Brain Bot Restart Script"
echo "===================================="
echo ""

# Kill any existing bot processes
echo "🔴 Stopping existing bot processes..."
pkill -f "python.*main_polling.py" 2>/dev/null
pkill -f "python.*main.py" 2>/dev/null
pkill -f "python.*test_local.py" 2>/dev/null
sleep 1

# Clear Python cache
echo "🗑️  Clearing Python cache..."
find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null
find . -type f -name "*.pyc" -delete 2>/dev/null
find . -type f -name "*.pyo" -delete 2>/dev/null

# Clear any temporary files
echo "🗑️  Clearing temporary files..."
rm -f /tmp/markdown-brain-bot-* 2>/dev/null

# Check if ngrok is needed (webhook mode)
if [ "$1" == "webhook" ]; then
    echo "🌐 Stopping existing ngrok processes..."
    pkill -f "ngrok" 2>/dev/null
    sleep 1
    
    echo "🌐 Starting ngrok on port 8000..."
    ngrok http 8000 > /tmp/ngrok.log 2>&1 &
    NGROK_PID=$!
    echo "   Ngrok PID: $NGROK_PID"
    sleep 3
    
    # Get ngrok URL
    NGROK_URL=$(curl -s http://localhost:4040/api/tunnels | python3 -c "import sys, json; print(json.load(sys.stdin)['tunnels'][0]['public_url'])" 2>/dev/null)
    if [ -n "$NGROK_URL" ]; then
        echo "   Ngrok URL: $NGROK_URL"
        echo "   Webhook endpoint: $NGROK_URL/webhook"
    else
        echo "   ⚠️  Could not get ngrok URL - check ngrok logs"
    fi
fi

# Activate virtual environment if it exists
if [ -d "venv" ]; then
    echo "🐍 Activating virtual environment..."
    source venv/bin/activate
fi

# Start the bot
if [ "$1" == "webhook" ]; then
    echo "🚀 Starting bot in webhook mode..."
    echo ""
    python main.py &
    BOT_PID=$!
    echo "Bot PID: $BOT_PID"
    echo ""
    echo "📊 Tailing ngrok logs..."
    echo "Press Ctrl+C to stop"
    echo "===================================="
    tail -f /tmp/ngrok.log
else
    echo "🚀 Starting bot in polling mode..."
    echo ""
    echo "📊 Bot output:"
    echo "===================================="
    python main_polling.py
fi