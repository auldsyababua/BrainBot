#!/bin/bash

# Keep Render service alive by pinging it every 10 minutes
# Run this in the background: nohup ./scripts/keep_alive.sh &

echo "🔄 Starting keep-alive service for BrainBot"
echo "This will ping the bot every 10 minutes to prevent sleep"
echo "Press Ctrl+C to stop"

while true; do
    echo -n "$(date '+%Y-%m-%d %H:%M:%S') - Pinging bot... "
    
    # Ping the health endpoint
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://brainbot-v76n.onrender.com/health)
    
    if [ "$STATUS" = "200" ] || [ "$STATUS" = "503" ]; then
        echo "✅ Response: $STATUS"
    else
        echo "⚠️  Unexpected response: $STATUS"
    fi
    
    # Wait 10 minutes
    sleep 600
done