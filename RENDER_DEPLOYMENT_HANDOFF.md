# Render Deployment Issue - Handoff Document

## Problem Summary
The Render deployment is failing because it's looking for `webhook_server.py` which no longer exists in the codebase.

**Error:**
```
python: can't open file '/opt/render/project/src/webhook_server.py': [Errno 2] No such file or directory
```

## Root Cause
The file `webhook_server.py` was removed in the recent refactoring as shown in the git history:
```
delete mode 100755 webhook_server.py
```

## Solution
Update the Render deployment configuration to use the correct entry point.

### Option 1: Update Start Command in Render Dashboard
1. Go to your Render dashboard
2. Navigate to your service settings
3. Change the Start Command from:
   ```
   python webhook_server.py
   ```
   To:
   ```
   python main.py
   ```

### Option 2: Add render.yaml Configuration
Create a `render.yaml` file in the project root:

```yaml
services:
  - type: web
    name: markdown-brain-bot
    env: python
    buildCommand: "pip install -r requirements.txt"
    startCommand: "python main.py"
    envVars:
      - key: PYTHON_VERSION
        value: 3.13
```

### Option 3: Check for Alternative Entry Points
Look for the new webhook server file:
```bash
find . -name "*.py" | grep -E "(webhook|server|main|bot)" | grep -v __pycache__
```

## Verification Steps
1. Identify the correct entry point file
2. Update Render configuration
3. Trigger a new deployment
4. Monitor logs to ensure successful startup

## Environment Variables to Verify
Ensure these are set in Render:
- `TELEGRAM_BOT_TOKEN`
- `SUPABASE_URL`
- `SUPABASE_KEY`
- `OPENAI_API_KEY`
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `S3_BUCKET_NAME`
- `UPSTASH_VECTOR_URL`
- `UPSTASH_VECTOR_TOKEN`

## Next Steps
1. Find the actual webhook/server file in the current codebase
2. Update Render's start command
3. Ensure all dependencies in requirements.txt are correct
4. Test the deployment

## Files to Check
Based on the codebase structure, look for:
- `src/webhook_handler.py`
- `src/main.py`
- `src/server.py`
- `bot.py`
- Any file with FastAPI/Uvicorn setup