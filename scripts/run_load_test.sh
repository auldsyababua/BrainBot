#!/bin/bash

# Load Testing Script for Markdown Brain Bot
# Simple wrapper to run Locust tests with predefined scenarios

echo "🚀 Markdown Brain Bot Load Testing"
echo "================================="

# Change to project root
cd "$(dirname "$0")/.."

# Check if locust is installed
if ! command -v locust &> /dev/null; then
    echo "❌ Locust not found. Installing..."
    pip install locust
fi

# Default values
HOST="http://localhost:8000"
SCENARIO="basic"

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --host)
            HOST="$2"
            shift 2
            ;;
        --scenario)
            SCENARIO="$2"
            shift 2
            ;;
        --help)
            echo "Usage: $0 [--host URL] [--scenario SCENARIO]"
            echo ""
            echo "Scenarios:"
            echo "  basic     - 10 users, good for development testing"
            echo "  normal    - 100 users, typical daily load"
            echo "  peak      - 500 users, stress testing"
            echo "  endurance - 50 users for 30 minutes"
            echo "  ui        - Launch web UI (interactive)"
            echo ""
            echo "Examples:"
            echo "  $0                                    # Basic test on localhost"
            echo "  $0 --scenario normal                  # Normal load on localhost"
            echo "  $0 --host https://mybot.com --scenario peak  # Stress test production"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

echo "🔧 Configuration:"
echo "  Host: $HOST"
echo "  Scenario: $SCENARIO"
echo ""

# Run the appropriate scenario
case $SCENARIO in
    basic)
        echo "📊 Running BASIC load test (10 users)..."
        echo "Good for: Testing basic functionality during development"
        echo ""
        locust -f tests/performance/locustfile.py \
            --host "$HOST" \
            --headless \
            --users 10 \
            --spawn-rate 1 \
            --run-time 2m \
            --html tests/load_test_results_basic.html
        ;;
    
    normal)
        echo "📊 Running NORMAL load test (100 users)..."
        echo "Good for: Testing typical daily load"
        echo ""
        locust -f tests/performance/locustfile.py \
            --host "$HOST" \
            --headless \
            --users 100 \
            --spawn-rate 2 \
            --run-time 5m \
            --html tests/load_test_results_normal.html
        ;;
    
    peak)
        echo "📊 Running PEAK load test (500 users)..."
        echo "Good for: Finding system breaking points"
        echo "⚠️  Warning: This will put significant load on the server!"
        echo ""
        read -p "Are you sure you want to continue? (y/N) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            locust -f tests/performance/locustfile.py \
                --host "$HOST" \
                --headless \
                --users 500 \
                --spawn-rate 5 \
                --run-time 5m \
                --html tests/load_test_results_peak.html
        else
            echo "Peak test cancelled."
            exit 0
        fi
        ;;
    
    endurance)
        echo "📊 Running ENDURANCE test (50 users for 30 minutes)..."
        echo "Good for: Finding memory leaks and degradation over time"
        echo ""
        locust -f tests/performance/locustfile.py \
            --host "$HOST" \
            --headless \
            --users 50 \
            --spawn-rate 1 \
            --run-time 30m \
            --html tests/load_test_results_endurance.html
        ;;
    
    ui)
        echo "🌐 Launching Locust Web UI..."
        echo "Open http://localhost:8089 in your browser"
        echo "Press Ctrl+C to stop"
        echo ""
        locust -f tests/performance/locustfile.py --host "$HOST"
        ;;
    
    *)
        echo "❌ Unknown scenario: $SCENARIO"
        echo "Valid scenarios: basic, normal, peak, endurance, ui"
        exit 1
        ;;
esac

echo ""
echo "✅ Load test complete!"

# Show results location if not UI mode
if [ "$SCENARIO" != "ui" ]; then
    echo "📄 Results saved to: tests/load_test_results_${SCENARIO}.html"
    echo ""
    echo "💡 Quick Analysis Tips:"
    echo "  - Response times > 2s = Users will notice slowness"
    echo "  - Failure rate > 1% = Something is wrong"
    echo "  - 95th percentile time = What most users experience"
    echo "  - RPS (Requests/Second) = Your current capacity"
fi
