# Self-Hosted GitHub Actions Runner

**Date:** 2025-08-26  
**Status:** ✅ ACTIVE  
**Location:** Mac Mini M4 (Local Machine)

## Overview

We use a self-hosted GitHub Actions runner on the Mac Mini M4 to eliminate queue times and speed up CI/CD. This replaces GitHub's free runners which often have 15+ minute wait times.

## Benefits

- **Zero Queue Time**: Tests start instantly
- **Faster Execution**: M4 chip power vs shared GitHub runners
- **Local Caching**: Dependencies cached on machine
- **Free Forever**: No minutes consumed from GitHub quota

## Installation Location

```bash
~/actions-runner/
```

## Managing the Runner

### Check Status
```bash
# Check if runner is active
ps aux | grep Runner.Listener

# View runner status in GitHub
gh api repos/auldsyababua/BrainBot/actions/runners --jq '.runners[] | {name, status}'
```

### Start Runner
```bash
# Start in background
cd ~/actions-runner && nohup ./run.sh > runner.log 2>&1 &

# Or run interactively (for debugging)
cd ~/actions-runner && ./run.sh
```

### Stop Runner
```bash
# Find and kill the process
pkill -f Runner.Listener

# Or if installed as service
cd ~/actions-runner && ./svc.sh stop
```

### View Logs
```bash
# Real-time logs
cd ~/actions-runner && tail -f runner.log

# Check for errors
cd ~/actions-runner && grep ERROR runner.log
```

## Workflow Configuration

The runner is configured in `.github/workflows/test-self-hosted.yml`:

```yaml
runs-on: [self-hosted, macOS, ARM64, m4]
```

## Environment Variables

Tests require dummy environment variables to run. These are configured in the workflow:

```yaml
env:
  TELEGRAM_BOT_TOKEN: "test-token-not-real"
  SUPABASE_URL: "https://test.supabase.co"
  SUPABASE_KEY: "test-key-not-real"
  OPENAI_API_KEY: "sk-test-not-real"
```

## Troubleshooting

### Runner Not Starting
```bash
# Check if port is in use
lsof -i :8080

# Clear runner cache
cd ~/actions-runner && rm -rf _work/_temp
```

### Tests Failing Due to Missing Dependencies
```bash
# Install Python dependencies globally
pip3 install pytest pytest-asyncio black ruff mypy
```

### Re-registering Runner
If the runner gets disconnected:
```bash
# Generate new token
gh api repos/auldsyababua/BrainBot/actions/runners/registration-token --method POST

# Reconfigure
cd ~/actions-runner
./config.sh --url https://github.com/auldsyababua/BrainBot \
  --token NEW_TOKEN_HERE \
  --name "mac-mini-m4" \
  --labels "self-hosted,macOS,ARM64,m4" \
  --replace
```

## Security Notes

- The runner has access to your local machine
- Only run trusted code (your own repositories)
- Credentials are stored in `~/actions-runner/.credentials`
- Runner token expires after use (one-time registration)

## Performance Metrics

Typical execution times on Mac Mini M4:
- **Checkout**: 2-3 seconds
- **Setup Python**: 5-10 seconds  
- **Install Dependencies**: 20-30 seconds (first run), 5 seconds (cached)
- **Run Unit Tests**: 10-20 seconds
- **Total Workflow**: 45-60 seconds

Compare to GitHub free runners:
- **Queue Wait**: 5-60 minutes
- **Total Time**: 10-65 minutes

## Maintenance

### Weekly Tasks
- Check runner logs for errors
- Clear old workflow runs: `cd ~/actions-runner/_work && rm -rf */*/`
- Update runner if new version available

### Monthly Tasks
- Review and rotate any stored credentials
- Clean pip cache: `pip cache purge`
- Check disk space usage

## Related Documentation

- [Testing Guide](./technical/testing-guide.md)
- [CI/CD Workflows](./.github/workflows/)
- [GitHub Actions Docs](https://docs.github.com/en/actions)