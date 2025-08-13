#!/bin/bash

# AI Babysitter Test Runner
# Simple script to run the AI babysitter tests that catch AI coding mistakes

echo "🤖 Running AI Babysitter Tests..."
echo "These tests catch common mistakes AI agents make when writing code."
echo ""

# Change to project root
cd "$(dirname "$0")/.."

# Check if pytest is available
if ! command -v pytest &> /dev/null; then
    echo "❌ pytest not found. Installing..."
    pip install pytest pytest-asyncio
fi

# Create test results directory
mkdir -p tests/test_results

# Run the AI babysitter tests with verbose output and result tracking
echo "Running tests..."
pytest tests/system/test_ai_babysitter.py -v -s --tb=short --json-report --json-report-file=tests/test_results/$(date +%Y%m%d_%H%M%S).json

# Also keep a latest copy
cp tests/test_results/$(date +%Y%m%d_%H%M%S).json tests/test_results/latest.json 2>/dev/null || echo "Note: Could not create latest.json backup"

echo ""
echo "🎯 Test Summary:"
echo "✅ 'Does It Work?' tests check basic functionality"
echo "🧠 'Is It Stupid?' tests catch obvious AI mistakes"
echo "📊 Resource tests check for memory leaks and performance"
echo "🔗 Integration test verifies everything works together"
echo ""
echo "If tests fail, check the specific error messages above."
echo "These tests are designed to catch the most common AI coding mistakes."
