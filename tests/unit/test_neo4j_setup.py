#!/usr/bin/env python3
"""
Test script to verify Neo4j setup and install missing dependencies.
"""

import os
import subprocess
import sys


def install_package(package):
    """Install a package using pip."""
    try:
        subprocess.check_call(
            [
                sys.executable,
                "-m",
                "pip",
                "install",
                package,
                "--quiet",
                "--no-warn-script-location",
            ]
        )
        print(f"✅ Successfully installed {package}")
        return True
    except subprocess.CalledProcessError as e:
        print(f"❌ Failed to install {package}: {e}")
        return False


def test_neo4j_connection():
    """Test connection to Neo4j database."""
    try:
        from neo4j import GraphDatabase

        uri = "bolt://localhost:7687"
        username = "neo4j"
        password = "markdown-bot-password"

        driver = GraphDatabase.driver(uri, auth=(username, password))

        with driver.session() as session:
            result = session.run("RETURN 1 AS test")
            test_value = result.single()["test"]

        driver.close()

        if test_value == 1:
            print("✅ Neo4j connection successful")
            return True
        else:
            print("❌ Neo4j returned unexpected value")
            return False

    except Exception as e:
        print(f"❌ Neo4j connection failed: {e}")
        return False


def test_memory_initialization():
    """Test BotMemory initialization with graph support."""
    try:
        # Set environment variables for the test
        os.environ["NEO4J_URL"] = "bolt://localhost:7687"
        os.environ["NEO4J_USERNAME"] = "neo4j"
        os.environ["NEO4J_PASSWORD"] = "markdown-bot-password"

        from src.core.memory import BotMemory

        # Initialize memory instance
        memory = BotMemory()

        if memory.has_graph:
            print("✅ BotMemory initialized with graph support")
            return True
        else:
            print("❌ BotMemory initialized but graph support is disabled")
            return False

    except Exception as e:
        print(f"❌ BotMemory initialization failed: {e}")
        return False


def main():
    """Main test function."""
    print("🔧 Testing Neo4j setup for markdown-brain-bot")
    print("=" * 50)

    # Step 1: Install required packages
    print("\n1. Installing required packages...")
    packages = ["neo4j>=5.0.0", "langchain-neo4j>=0.0.5"]

    all_installed = True
    for package in packages:
        if not install_package(package):
            all_installed = False

    if not all_installed:
        print("❌ Some packages failed to install. Please run manually:")
        print("   pip install neo4j langchain-neo4j")
        return False

    # Step 2: Test Neo4j connection
    print("\n2. Testing Neo4j connection...")
    if not test_neo4j_connection():
        print("❌ Neo4j connection test failed")
        print("   Make sure Neo4j is running: docker-compose -f docker-compose.neo4j.yml up -d")
        return False

    # Step 3: Test memory initialization
    print("\n3. Testing BotMemory initialization...")
    if not test_memory_initialization():
        print("❌ BotMemory initialization failed")
        return False

    print("\n🎉 All tests passed! Graph memory is ready to use.")
    print("\n📝 Next steps:")
    print("   - Update your .env file with Neo4j credentials")
    print("   - Test graph memory operations")
    print("   - Mark T3.1.2 as complete")

    return True


if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)
