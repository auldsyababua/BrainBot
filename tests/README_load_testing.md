# 🚀 Load Testing Guide for Markdown Brain Bot

> Simple load testing to ensure your bot can handle your team's usage.

## 🎯 What is Load Testing?

Load testing simulates multiple users using your bot at the same time to see if it:
- Responds quickly enough
- Doesn't crash under pressure  
- Can handle your expected team size

## 🚀 Quick Start

### 1. Run Your First Load Test

```bash
# Basic test with 10 users
./scripts/run_load_test.sh
```

### 2. View Results in Browser

```bash
# Interactive web UI (recommended for beginners)
./scripts/run_load_test.sh --scenario ui
```

Then open http://localhost:8089 in your browser.

### 3. Analyze Results

```bash
# Get recommendations after test completes
./scripts/analyze_load_test.py
```

## 📊 Test Scenarios

### Basic (Development)
- **Users**: 10
- **Good for**: Making sure basic functionality works
- **Run**: `./scripts/run_load_test.sh --scenario basic`

### Normal (Daily Load)
- **Users**: 100
- **Good for**: Testing typical daily usage
- **Run**: `./scripts/run_load_test.sh --scenario normal`

### Peak (Stress Test)
- **Users**: 500
- **Good for**: Finding breaking points
- **Run**: `./scripts/run_load_test.sh --scenario peak`
- **⚠️ Warning**: This puts heavy load on your server!

### Endurance (Memory Leaks)
- **Users**: 50 for 30 minutes
- **Good for**: Finding memory leaks
- **Run**: `./scripts/run_load_test.sh --scenario endurance`

## 📈 Understanding Results

### Key Metrics

1. **Response Time**
   - ✅ < 1 second = Great
   - ⚠️  1-2 seconds = Okay
   - 🔴 > 2 seconds = Too slow

2. **Failure Rate**
   - ✅ < 1% = Normal
   - ⚠️  1-5% = Needs attention
   - 🔴 > 5% = Critical issue

3. **Requests Per Second (RPS)**
   - This shows your bot's capacity
   - Higher is better

### Reading the Web UI

1. **Charts Tab**: Shows performance over time
   - Look for increasing response times (bad)
   - Look for failures (red lines)

2. **Statistics Tab**: Shows detailed numbers
   - Focus on "95%ile" (what most users experience)
   - Check failure counts

3. **Failures Tab**: Shows what went wrong
   - Look for timeout errors
   - Check for 500/502 errors

## 🌐 Testing Different Environments

### Local Development
```bash
./scripts/run_load_test.sh  # Default: http://localhost:8000
```

### Staging/Production
```bash
# Be careful with production!
./scripts/run_load_test.sh --host https://your-bot-url.com --scenario basic
```

## 🔍 What the Test Actually Does

The load test simulates real users:

1. **Saving Notes** (30% of actions)
   - "Save note: Team meeting at 3pm"
   - "Save note: Bug #123 - Login issue"

2. **Searching** (20% of actions)
   - "Search for project deadline"
   - "Find meeting notes"

3. **Asking Questions** (20% of actions)
   - "What's my next deadline?"
   - "Show me todo items"

4. **Other Operations** (30%)
   - Listing notes
   - Updating notes
   - Complex interactions

## 🚫 Common Issues & Solutions

### "Connection refused"
- **Problem**: Bot isn't running
- **Solution**: Start your bot first

### "Too many 500 errors"
- **Problem**: Bot is crashing
- **Solution**: Check bot logs, reduce user count

### "Response times increasing"
- **Problem**: Memory leak or inefficient code
- **Solution**: Run endurance test, check memory usage

### "High failure rate"
- **Problem**: Bot can't handle the load
- **Solutions**:
  1. Check if Redis is running
  2. Verify API rate limits
  3. Run AI babysitter tests
  4. Consider scaling

## 👥 Capacity Planning

### Rough Guidelines

| Team Size | Test Scenario | Expected RPS | Action Needed |
|-----------|--------------|--------------|---------------|
| 1-10      | Basic        | 2-5          | None          |
| 10-25     | Normal       | 5-15         | Optimize code |
| 25-50     | Normal       | 15-30        | Add caching   |
| 50-100    | Peak         | 30-50        | Scale horizontally |

### Memory Requirements

- **10 users**: ~100MB
- **100 users**: ~500MB
- **500 users**: ~2GB

*Note: These are estimates. Run tests to get actual numbers.*

## 📝 Custom Test Scenarios

Edit `tests/locustfile.py` to add custom scenarios:

```python
@task(1)
def my_custom_action(self):
    """Custom user action."""
    message = "My custom bot command"
    self.send_message(message, name="custom_action")
```

## 🎯 Best Practices

1. **Start Small**: Always run basic test first
2. **Test Regularly**: After major changes
3. **Monitor Trends**: Save results over time
4. **Test Early**: Before your team grows
5. **Be Realistic**: Test with actual usage patterns

## 🆘 When Things Go Wrong

1. **Stop the test**: Press Ctrl+C
2. **Check bot logs**: Look for errors
3. **Run AI babysitter tests**: `./scripts/ai_change_check.sh`
4. **Start with fewer users**: Reduce load
5. **Ask for help**: Save the error messages

## 📊 Interpreting Analysis Results

After running a test:

```bash
./scripts/analyze_load_test.py
```

This gives you:
- 🎯 Performance per endpoint
- 💡 Specific recommendations
- 📦 Capacity planning estimates
- 🔧 What to fix first

---

**Remember**: The goal isn't perfect performance, it's *good enough* performance for your team size. Start simple and improve as needed!
