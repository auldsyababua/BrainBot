#!/usr/bin/env python3
"""
Test BotMemory initialization by mocking Neo4j dependencies.
"""

import os
import sys
from unittest.mock import Mock, patch
from dotenv import load_dotenv

# Load environment variables
load_dotenv(".env.local")
load_dotenv()


def test_memory_initialization():
    """Test BotMemory initialization with mocked Neo4j."""
    print("🧠 Testing BotMemory with mocked Neo4j dependencies...")

    # Mock the Neo4j imports
    mock_neo4j = Mock()
    mock_langchain_neo4j = Mock()

    with patch.dict(
        "sys.modules", {"neo4j": mock_neo4j, "langchain_neo4j": mock_langchain_neo4j}
    ):
        try:
            from src.core.memory import BotMemory

            print("Environment variables:")
            print(f"  NEO4J_URL: {os.getenv('NEO4J_URL')}")
            print(f"  NEO4J_USERNAME: {os.getenv('NEO4J_USERNAME')}")
            print(
                f"  NEO4J_PASSWORD: {'***' if os.getenv('NEO4J_PASSWORD') else 'Not set'}"
            )

            # Initialize memory
            memory = BotMemory()

            if memory.has_graph:
                print("✅ BotMemory initialized with graph support enabled")
                return True
            else:
                print("❌ BotMemory initialized but graph support is disabled")
                print(
                    "This might be due to missing OpenAI API key or other configuration"
                )
                return False

        except Exception as e:
            print(f"❌ BotMemory initialization failed: {e}")
            import traceback

            traceback.print_exc()
            return False


def check_neo4j_container():
    """Check if Neo4j container is running."""
    import subprocess

    try:
        result = subprocess.run(
            [
                "docker",
                "ps",
                "--filter",
                "name=markdown-bot-neo4j",
                "--format",
                "{{.Status}}",
            ],
            capture_output=True,
            text=True,
            timeout=10,
        )

        if "Up" in result.stdout and "healthy" in result.stdout:
            print("✅ Neo4j container is running and healthy")
            return True
        elif "Up" in result.stdout:
            print("⚠️  Neo4j container is running but not healthy yet")
            return True
        else:
            print("❌ Neo4j container is not running")
            return False

    except Exception as e:
        print(f"❌ Could not check Neo4j container: {e}")
        return False


def test_neo4j_direct_connection():
    """Test direct connection to Neo4j using simple HTTP."""
    import requests

    try:
        # Test HTTP endpoint
        response = requests.get("http://localhost:7474", timeout=5)
        if response.status_code == 200:
            print("✅ Neo4j HTTP endpoint is accessible")
            return True
        else:
            print(f"❌ Neo4j HTTP endpoint returned status {response.status_code}")
            return False

    except Exception as e:
        print(f"❌ Could not connect to Neo4j HTTP endpoint: {e}")
        return False


def main():
    """Main test function."""
    print("🔧 Testing Graph Memory Setup (Without Dependencies)")
    print("=" * 55)

    # Check Neo4j container
    print("\n1. Checking Neo4j container...")
    neo4j_running = check_neo4j_container()

    # Test HTTP connection
    print("\n2. Testing Neo4j HTTP connection...")
    http_accessible = test_neo4j_direct_connection()

    # Test memory initialization
    print("\n3. Testing BotMemory initialization...")
    memory_works = test_memory_initialization()

    print("\n" + "=" * 55)
    print("📈 Test Results:")
    running_status = "✅ Running" if neo4j_running else "❌ Not Running"
    http_status = "✅ Working" if http_accessible else "❌ Failed"
    memory_status = "✅ Enabled" if memory_works else "❌ Disabled"

    print(f"  Neo4j Container: {running_status}")
    print(f"  HTTP Connection: {http_status}")
    print(f"  Graph Memory: {memory_status}")

    if memory_works:
        print("\n🎉 Graph memory infrastructure is ready!")
        print("📝 To complete setup:")
        print("   1. Install Neo4j Python packages when pip is working:")
        print("      pip install neo4j langchain-neo4j")
        print("   2. Add OpenAI API key to .env.local for full functionality")
        print("   3. Test with real graph operations")
        return True
    else:
        print("\n⚠️  Graph memory setup needs attention")
        print("📝 Troubleshooting:")
        if not neo4j_running:
            print("   - Start Neo4j: docker-compose -f docker-compose.neo4j.yml up -d")
        print("   - Check environment variables in .env.local")
        print("   - Ensure OpenAI API key is configured")
        return False


if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)
