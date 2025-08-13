#\!/bin/bash
# Check Render logs for the bot

echo "To view Render logs:"
echo "1. Go to https://dashboard.render.com"
echo "2. Click on your markdown-brain-bot service"
echo "3. Click on 'Logs' tab"
echo ""
echo "Or use Render CLI:"
echo "render logs markdown-brain-bot --tail"
echo ""
echo "Common issues to look for:"
echo "- Vector store connection errors"
echo "- Missing environment variables"
echo "- Python import errors"
echo "- Webhook processing errors"
