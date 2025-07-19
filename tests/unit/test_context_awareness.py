#!/usr/bin/env python3
"""
Test context awareness and organizational hierarchy.
Focuses on proper folder placement based on organizational context.
"""

import time

from src.core.tools import search_files, read_file
from src.core.llm import process_message, reset_conversation


def test_10netzero_context():
    """Test that 10NetZero project sites are properly organized."""
    print("\n🏢 Testing 10NetZero organizational context...")

    # First, let's verify the 10NetZero about page exists
    about_results = search_files("About 10NetZero")
    if about_results:
        print("  ✅ Found 10NetZero about page")
        content = read_file(about_results[0]["path"])
        if "Eagle Lake" in content and "Mathis" in content:
            print("  ✅ About page contains project site information")

    # Test various ways users might create content for 10NetZero sites
    test_scenarios = [
        {
            "query": "Create a maintenance log for the Eagle Lake site. Today we replaced the oil filter and checked the generator.",
            "expected_path": "10NetZero/Eagle Lake",
            "should_contain": ["oil filter", "generator"],
        },
        {
            "query": "Create equipment inventory for Mathis site: 2 generators, 3 miners, 1 transformer",
            "expected_path": "10NetZero/Mathis",
            "should_contain": ["generators", "miners", "transformer"],
        },
        {
            "query": "Add site visit notes for Crockett - Met with Operation Orange LLC team",
            "expected_path": "10NetZero/Crockett",
            "should_contain": ["Operation Orange LLC"],
        },
        {
            "query": "Create a supplies checklist for English site (that's the Eagle Lake location)",
            "expected_path": "10NetZero/Eagle Lake",
            "should_contain": ["checklist", "supplies"],
        },
    ]

    for scenario in test_scenarios:
        print(f"\n  🤖 User: '{scenario['query'][:60]}...'")
        process_message(scenario["query"])  # Response not needed for this test

        # Check if file was created in the correct location
        time.sleep(0.5)

        # Search for the content
        for keyword in scenario["should_contain"]:
            results = search_files(keyword)
            if results:
                correct_path = any(
                    scenario["expected_path"] in r["path"] for r in results
                )
                if correct_path:
                    print(
                        f"  ✅ Content created in correct location: {scenario['expected_path']}"
                    )
                else:
                    # Find where it was actually created
                    actual_path = results[0]["path"] if results else "unknown"
                    print("  ❌ Content created in wrong location")
                    print(f"     Expected: {scenario['expected_path']}")
                    print(f"     Actual: {actual_path}")
                break

        reset_conversation("test")


def test_partner_aliases():
    """Test recognition of partner aliases from the about page."""
    print("\n🤝 Testing partner alias recognition...")

    # Test that the bot recognizes aliases
    alias_tests = [
        (
            "Create inspection report for English site",
            "10NetZero/Eagle Lake",
            "English = Eagle Lake alias",
        ),
        (
            "Add notes for Wharton location",
            "10NetZero/Eagle Lake",
            "Wharton = Eagle Lake alias",
        ),
        (
            "Create checklist for Buetnagel",
            "10NetZero/Mathis",
            "Buetnagel = Mathis alias",
        ),
        (
            "Log maintenance for 1511 Co Road",
            "10NetZero/Crockett",
            "1511 Co Road = Crockett alias",
        ),
    ]

    for query, expected_path, explanation in alias_tests:
        print(f"\n  🤖 Testing: {explanation}")
        print(f"     Query: '{query}'")
        response = process_message(query)

        # Give it a moment to process
        time.sleep(0.5)

        # Search for recently created content
        results = search_files(query.split()[1])  # Search for the action word
        if results:
            correct_path = any(expected_path in r["path"] for r in results)
            if correct_path:
                print(f"  ✅ Correctly recognized alias and used {expected_path}")
            else:
                print("  ❌ Failed to recognize alias")
                print(f"     Response preview: {response[:100]}...")
        else:
            print("  ⚠️  No file created")

        reset_conversation("test")


def test_context_from_conversation():
    """Test maintaining context across conversation."""
    print("\n💬 Testing context maintenance in conversation...")

    # Simulate a conversation about a 10NetZero site
    conversation = [
        ("I'm heading to the Eagle Lake site tomorrow", None),
        ("Create a pre-visit checklist for me", "10NetZero/Eagle Lake"),
        ("Also add a note to bring extra batteries", "10NetZero/Eagle Lake"),
        ("What partner manages this site?", "Flober LLC"),
    ]

    chat_id = "context_test"
    for i, (query, expected) in enumerate(conversation):
        print(f"\n  Turn {i+1}: '{query}'")
        response = process_message(query, chat_id)

        if expected:
            if "10NetZero" in expected:
                # Check file location
                results = search_files("checklist batteries")
                correct = any(expected in r["path"] for r in results)
                print(
                    f"  {'✅' if correct else '❌'} File in correct location: {expected}"
                )
            else:
                # Check response content
                if expected.lower() in response.lower():
                    print(f"  ✅ Response mentions '{expected}'")
                else:
                    print(f"  ❌ Response doesn't mention '{expected}'")
                    print(f"     Response: {response[:100]}...")

        time.sleep(0.5)


def test_implicit_context():
    """Test understanding implicit context from content."""
    print("\n🔍 Testing implicit context understanding...")

    # Create a note that mentions 10NetZero context
    test_cases = [
        {
            "query": "Create a report: Visited Flober LLC's Eagle Lake facility today. Generator running smoothly.",
            "expected_path": "10NetZero/Eagle Lake",
            "reason": "Flober LLC is the Eagle Lake partner",
        },
        {
            "query": "Log issue: WasteWatt Ventures reported high temps at their Mathis location",
            "expected_path": "10NetZero/Mathis",
            "reason": "WasteWatt Ventures is the Mathis partner",
        },
    ]

    for test in test_cases:
        print(f"\n  📝 {test['reason']}")
        print(f"     Query: '{test['query'][:60]}...'")

        process_message(test["query"])  # Response not needed for this test
        time.sleep(0.5)

        # Search for the created content
        results = search_files(
            "generator facility" if "Eagle Lake" in test["query"] else "high temps"
        )
        if results:
            correct_path = any(test["expected_path"] in r["path"] for r in results)
            if correct_path:
                print(
                    f"  ✅ Correctly inferred context and used {test['expected_path']}"
                )
            else:
                actual = results[0]["path"] if results else "unknown"
                print("  ❌ Failed to infer context")
                print(f"     Expected: {test['expected_path']}")
                print(f"     Actual: {actual}")

        reset_conversation("test")


def run_context_tests():
    """Run all context awareness tests."""
    print("🧠 Starting Context Awareness Test Suite")
    print("=" * 50)
    print("\nThese tests verify that the bot understands:")
    print("1. 10NetZero project sites should be organized under 10NetZero/")
    print("2. Site aliases (English = Eagle Lake, etc.)")
    print("3. Partner relationships (Flober LLC = Eagle Lake)")
    print("4. Contextual cues from conversation")

    test_10netzero_context()
    test_partner_aliases()
    test_context_from_conversation()
    test_implicit_context()

    print("\n" + "=" * 50)
    print("✅ Context awareness tests completed!")
    print("\n💡 Key insight: The bot needs to understand organizational")
    print("   relationships to properly structure the knowledge base.")


if __name__ == "__main__":
    run_context_tests()
