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

# Run the AI babysitter tests with verbose output
echo "Running tests..."
pytest tests/test_ai_babysitter.py -v -s --tb=short

echo ""
echo "🎯 Test Summary:"
echo "✅ 'Does It Work?' tests check basic functionality"
echo "🧠 'Is It Stupid?' tests catch obvious AI mistakes"
echo "📊 Resource tests check for memory leaks and performance"
echo "🔗 Integration test verifies everything works together"
echo ""
echo "If tests fail, check the specific error messages above."
echo "These tests are designed to catch the most common AI coding mistakes."
