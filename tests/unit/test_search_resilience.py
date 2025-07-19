#!/usr/bin/env python3
"""
Test search resilience and case sensitivity.
Focuses on the Eagle Lake scenario and similar edge cases.
"""

import time

from src.core.tools import create_file, search_files, read_file
from src.core.llm import process_message, reset_conversation


def test_case_variations():
    """Test that search finds files regardless of case."""
    print("\n🧪 Testing case variations in search...")

    # Create files with different case patterns
    test_cases = [
        ("Blue Mountain", "blue-mountain-trails.md", "Blue Mountain"),
        ("red river", "red-river-camping.md", "red river"),
        ("GREEN valley", "green-valley-notes.md", "GREEN valley"),
    ]

    for title, expected_filename, folder in test_cases:
        content = f"Test content for {title}"
        file_path = create_file(
            title, content, folder=folder, tags=["test", "case-sensitive"]
        )
        print(f"  ✅ Created: {file_path}")

    # Test various search patterns
    search_tests = [
        ("blue mountain", "Blue Mountain"),
        ("BLUE MOUNTAIN", "Blue Mountain"),
        ("Blue Mountain", "Blue Mountain"),
        ("red RIVER", "red river"),
        ("green", "GREEN valley"),
        ("Valley", "GREEN valley"),
    ]

    for query, expected_folder in search_tests:
        results = search_files(query)
        found = any(expected_folder.lower() in r["path"].lower() for r in results)
        status = "✅" if found else "❌"
        print(f"  {status} Search '{query}' -> Found in '{expected_folder}': {found}")


def test_multi_word_queries():
    """Test searching for multi-word content."""
    print("\n🧪 Testing multi-word query handling...")

    # Create content with multi-word names
    files = [
        ("Pine Ridge Lodge", "Weekend cabin rental info", "travel/lodging"),
        ("Oak Creek Trail", "Hiking trail information", "travel/trails"),
        ("Maple Leaf Inn", "Hotel booking details", "travel/lodging"),
    ]

    for title, content, folder in files:
        create_file(title, content, folder=folder)
        print(f"  ✅ Created: {title}")

    # Test searching with partial and full queries
    searches = [
        ("Pine Ridge", True),
        ("pine", True),
        ("ridge", True),
        ("Oak Creek", True),
        ("creek trail", True),
        ("maple", True),
        ("Maple Leaf Inn", True),
    ]

    for query, should_find in searches:
        results = search_files(query)
        found = len(results) > 0
        status = "✅" if found == should_find else "❌"
        print(
            f"  {status} Search '{query}' -> Found: {found} (expected: {should_find})"
        )


def test_special_characters():
    """Test handling of special characters in names."""
    print("\n🧪 Testing special character handling...")

    # Create files with special characters
    special_files = [
        ("To-Do List #1", "Daily tasks", "lists"),
        ("Meeting @ 3PM", "Team sync notes", "meetings"),
        ("Budget $2024", "Annual budget", "finance"),
        ("Q&A Session", "Questions and answers", "meetings"),
    ]

    for title, content, folder in special_files:
        try:
            file_path = create_file(title, content, folder=folder)
            print(f"  ✅ Created: {title} -> {file_path}")
        except Exception as e:
            print(f"  ❌ Failed to create '{title}': {e}")

    # Search for these files
    search_patterns = [
        ("to-do", "lists"),
        ("todo", "lists"),
        ("Meeting", "meetings"),
        ("3PM", "meetings"),
        ("budget", "finance"),
        ("2024", "finance"),
        ("Q&A", "meetings"),
        ("session", "meetings"),
    ]

    for query, expected_folder in search_patterns:
        results = search_files(query)
        found = any(expected_folder in r["path"] for r in results)
        print(
            f"  {'✅' if found else '⚠️ '} Search '{query}' -> Found in {expected_folder}: {found}"
        )


def test_llm_search_behavior():
    """Test that the LLM actually searches before claiming not found."""
    print("\n🧪 Testing LLM search behavior...")

    # Create the Eagle Lake scenario
    create_file(
        "Eagle Lake Site To-Do List",
        "- Duct tape\n- Camera\n- Lock\n- Flashlight\n- First aid kit",
        folder="Eagle Lake",
        doc_type="list",
        tags=["todo", "supplies"],
    )
    print("  ✅ Created Eagle Lake todo list")

    # Create similar named files to test discrimination
    create_file(
        "Eagle Mountain Checklist",
        "- Climbing gear\n- Ropes\n- Carabiners",
        folder="Eagle Mountain",
        doc_type="list",
    )
    print("  ✅ Created Eagle Mountain checklist")

    # Test various ways users might ask for the Eagle Lake list
    test_queries = [
        "list the eagle lake todo list",
        "show me the Eagle Lake to-do list",
        "what's in the eagle lake todo?",
        "Eagle Lake list",
        "find eagle lake supplies",
        "search for eagle lake todo",
    ]

    for query in test_queries:
        print(f"\n  🤖 User: '{query}'")
        response = process_message(query)

        # Check if response mentions the expected items
        expected_items = ["duct tape", "camera", "lock"]
        found_items = sum(
            1 for item in expected_items if item.lower() in response.lower()
        )

        if found_items >= 2:  # At least 2 of the 3 items mentioned
            print(f"  ✅ Bot found the list! ({found_items}/3 items mentioned)")
        else:
            print("  ❌ Bot didn't find the list properly")
            print(f"     Response preview: {response[:100]}...")

        # Reset conversation for next test
        reset_conversation("test")
        time.sleep(0.5)  # Small delay between tests


def test_append_operations():
    """Test appending to files with various search patterns."""
    print("\n🧪 Testing append operations...")

    # Create initial files
    create_file("Shopping List", "- Milk\n- Bread", folder="lists", doc_type="list")
    create_file(
        "Project Tasks",
        "- Design mockup\n- Review specs",
        folder="work",
        doc_type="list",
    )

    # Test appending with different references
    append_tests = [
        ("Add eggs to the shopping list", "shopping", "- Eggs"),
        ("Add 'Write tests' to project tasks", "project tasks", "Write tests"),
        ("Append butter to shopping", "shopping", "butter"),
    ]

    for user_msg, search_term, expected_content in append_tests:
        print(f"\n  🤖 User: '{user_msg}'")
        process_message(user_msg)  # Response not needed for this test

        # Verify the content was added
        results = search_files(search_term)
        if results:
            content = read_file(results[0]["path"])
            if expected_content.lower() in content.lower():
                print(
                    f"  ✅ Successfully appended! Content includes '{expected_content}'"
                )
            else:
                print(
                    f"  ❌ Append may have failed. Content doesn't include '{expected_content}'"
                )
        else:
            print("  ❌ Couldn't find file to verify append")

        reset_conversation("test")


def test_similar_names():
    """Test discrimination between similar file names."""
    print("\n🧪 Testing similar name discrimination...")

    # Create files with similar names
    similar_files = [
        ("Development Setup", "Local environment setup", "dev"),
        ("Development Standards", "Coding standards", "dev"),
        ("Deployment Setup", "Production deployment", "dev"),
        ("Testing Setup", "Test environment", "dev"),
        ("Testing Standards", "QA guidelines", "dev"),
    ]

    for title, content, folder in similar_files:
        create_file(title, content, folder=folder)

    # Test specific searches
    specific_searches = [
        ("deployment setup", "Production deployment"),
        ("testing standards", "QA guidelines"),
        ("development setup", "Local environment"),
    ]

    for query, expected_content in specific_searches:
        print(f"\n  🔍 Searching for: '{query}'")
        results = search_files(query)

        if results:
            # Read the first result
            content = read_file(results[0]["path"])
            if expected_content in content:
                print(f"  ✅ Found correct file! Content: '{expected_content}'")
            else:
                print("  ⚠️  Found file but wrong content")
                print(f"     Expected: '{expected_content}'")
                print(f"     Got: '{content[:50]}...'")
        else:
            print("  ❌ No results found")


def run_all_tests():
    """Run all test suites."""
    print("🚀 Starting Markdown Brain Bot Test Suite")
    print("=" * 50)

    test_case_variations()
    test_multi_word_queries()
    test_special_characters()
    test_llm_search_behavior()
    test_append_operations()
    test_similar_names()

    print("\n" + "=" * 50)
    print("✅ Test suite completed!")
    print(
        "\n💡 Note: Some tests may fail if the search improvements haven't been applied."
    )
    print(
        "   The LLM behavior tests are especially important for the Eagle Lake scenario."
    )


if __name__ == "__main__":
    run_all_tests()
