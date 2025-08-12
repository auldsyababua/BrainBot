#!/usr/bin/env python3
"""
Test script for the /process endpoint
This verifies the HMAC-based authentication between Cloudflare Workers and the bot service
"""

import json
import hmac
import hashlib
import time
import sys
import os
from typing import Dict, Any
import requests
from datetime import datetime

# Configuration
PROCESS_URL = os.getenv("PROCESS_URL", "https://brainbot-v76n.onrender.com/process")
CF_PROXY_SECRET = os.getenv("CF_PROXY_SECRET")
LOCAL_TEST = os.getenv("LOCAL_TEST", "false").lower() == "true"

if LOCAL_TEST:
    PROCESS_URL = "http://localhost:8000/process"

# Color codes for output
RED = "\033[0;31m"
GREEN = "\033[0;32m"
YELLOW = "\033[1;33m"
BLUE = "\033[0;34m"
NC = "\033[0m"  # No Color


def print_colored(message: str, color: str = NC):
    """Print colored message"""
    print(f"{color}{message}{NC}")


def calculate_hmac(timestamp: str, payload: str, secret: str) -> str:
    """Calculate HMAC signature for the request"""
    signature_payload = f"{timestamp}.{payload}"
    signature = hmac.new(
        secret.encode("utf-8"), signature_payload.encode("utf-8"), hashlib.sha256
    ).hexdigest()
    return f"v1={signature}"


def test_valid_request(secret: str) -> Dict[str, Any]:
    """Test with a valid request and correct HMAC"""
    print_colored("\n📝 Test 1: Valid Request with Correct HMAC", BLUE)

    # Create a sample Telegram update
    telegram_update = {
        "update_id": int(time.time()),
        "message": {
            "message_id": 12345,
            "text": "Test message from process endpoint test",
            "chat": {"id": 123456789, "type": "private"},
            "from": {
                "id": 123456789,
                "is_bot": False,
                "first_name": "Test",
                "username": "testuser",
            },
            "date": int(time.time()),
        },
    }

    # Prepare the request body
    body = {
        "body": json.dumps(telegram_update),
        "context": {"test": True, "source": "test_script"},
    }

    timestamp = str(int(time.time()))
    payload = json.dumps(body)

    # Calculate HMAC
    signature = calculate_hmac(timestamp, payload, secret)

    # Make the request
    headers = {
        "Content-Type": "application/json",
        "X-Request-Timestamp": timestamp,
        "X-BrainBot-Signature": signature,
    }

    try:
        response = requests.post(PROCESS_URL, data=payload, headers=headers, timeout=10)

        if response.status_code == 200:
            print_colored("✅ Valid request accepted (200 OK)", GREEN)
            return {"success": True, "status": response.status_code}
        elif response.status_code == 503:
            print_colored(
                "⚠️  Service unavailable (503) - CF_PROXY_SECRET might not be configured",
                YELLOW,
            )
            return {
                "success": False,
                "status": response.status_code,
                "error": "Service unavailable",
            }
        else:
            print_colored(f"❌ Unexpected status: {response.status_code}", RED)
            print(f"Response: {response.text}")
            return {
                "success": False,
                "status": response.status_code,
                "error": response.text,
            }

    except requests.exceptions.RequestException as e:
        print_colored(f"❌ Request failed: {e}", RED)
        return {"success": False, "error": str(e)}


def test_invalid_signature(secret: str) -> Dict[str, Any]:
    """Test with an invalid HMAC signature"""
    print_colored("\n🔒 Test 2: Invalid HMAC Signature", BLUE)

    body = {"body": json.dumps({"update_id": 1}), "context": {}}

    timestamp = str(int(time.time()))
    payload = json.dumps(body)

    # Use wrong signature
    headers = {
        "Content-Type": "application/json",
        "X-Request-Timestamp": timestamp,
        "X-BrainBot-Signature": "v1=invalid_signature",
    }

    try:
        response = requests.post(PROCESS_URL, data=payload, headers=headers, timeout=10)

        if response.status_code == 401:
            print_colored(
                "✅ Invalid signature correctly rejected (401 Unauthorized)", GREEN
            )
            return {"success": True, "status": response.status_code}
        elif response.status_code == 503:
            print_colored(
                "⚠️  Service unavailable - CF_PROXY_SECRET not configured", YELLOW
            )
            return {"success": False, "status": response.status_code}
        else:
            print_colored(f"❌ Expected 401, got {response.status_code}", RED)
            return {"success": False, "status": response.status_code}

    except requests.exceptions.RequestException as e:
        print_colored(f"❌ Request failed: {e}", RED)
        return {"success": False, "error": str(e)}


def test_expired_timestamp(secret: str) -> Dict[str, Any]:
    """Test with an expired timestamp (replay attack protection)"""
    print_colored("\n⏰ Test 3: Expired Timestamp (Replay Protection)", BLUE)

    body = {"body": json.dumps({"update_id": 1}), "context": {}}

    # Use timestamp from 10 minutes ago
    old_timestamp = str(int(time.time()) - 600)
    payload = json.dumps(body)

    signature = calculate_hmac(old_timestamp, payload, secret)

    headers = {
        "Content-Type": "application/json",
        "X-Request-Timestamp": old_timestamp,
        "X-BrainBot-Signature": signature,
    }

    try:
        response = requests.post(PROCESS_URL, data=payload, headers=headers, timeout=10)

        if response.status_code == 401:
            print_colored(
                "✅ Stale request correctly rejected (401 Unauthorized)", GREEN
            )
            return {"success": True, "status": response.status_code}
        elif response.status_code == 503:
            print_colored(
                "⚠️  Service unavailable - CF_PROXY_SECRET not configured", YELLOW
            )
            return {"success": False, "status": response.status_code}
        else:
            print_colored(f"❌ Expected 401, got {response.status_code}", RED)
            return {"success": False, "status": response.status_code}

    except requests.exceptions.RequestException as e:
        print_colored(f"❌ Request failed: {e}", RED)
        return {"success": False, "error": str(e)}


def test_missing_headers() -> Dict[str, Any]:
    """Test with missing authentication headers"""
    print_colored("\n🚫 Test 4: Missing Authentication Headers", BLUE)

    body = {"body": json.dumps({"update_id": 1}), "context": {}}

    headers = {"Content-Type": "application/json"}

    try:
        response = requests.post(
            PROCESS_URL, data=json.dumps(body), headers=headers, timeout=10
        )

        if response.status_code == 401:
            print_colored(
                "✅ Request without auth headers correctly rejected (401)", GREEN
            )
            return {"success": True, "status": response.status_code}
        elif response.status_code == 503:
            print_colored(
                "⚠️  Service unavailable - CF_PROXY_SECRET not configured", YELLOW
            )
            return {"success": False, "status": response.status_code}
        else:
            print_colored(f"❌ Expected 401, got {response.status_code}", RED)
            return {"success": False, "status": response.status_code}

    except requests.exceptions.RequestException as e:
        print_colored(f"❌ Request failed: {e}", RED)
        return {"success": False, "error": str(e)}


def test_endpoint_exists() -> Dict[str, Any]:
    """Test if the endpoint exists (should not return 404)"""
    print_colored("\n🌐 Test 0: Endpoint Existence Check", BLUE)

    try:
        # Send a POST request without proper auth (expect 401 or 503, not 404)
        response = requests.post(PROCESS_URL, json={}, timeout=10)

        if response.status_code == 404:
            print_colored(
                "❌ Endpoint not found (404) - /process endpoint is missing!", RED
            )
            return {"success": False, "status": 404, "error": "Endpoint not deployed"}
        elif response.status_code in [401, 503]:
            print_colored(f"✅ Endpoint exists (status: {response.status_code})", GREEN)
            return {"success": True, "status": response.status_code}
        else:
            print_colored(
                f"⚠️  Endpoint exists but returned unexpected status: {response.status_code}",
                YELLOW,
            )
            return {"success": True, "status": response.status_code}

    except requests.exceptions.RequestException as e:
        print_colored(f"❌ Could not reach endpoint: {e}", RED)
        return {"success": False, "error": str(e)}


def main():
    """Run all tests"""
    print_colored("=" * 60, BLUE)
    print_colored("🧪 Testing /process Endpoint", BLUE)
    print_colored("=" * 60, BLUE)
    print(f"URL: {PROCESS_URL}")
    print(f"Time: {datetime.now().isoformat()}")

    if not CF_PROXY_SECRET:
        print_colored("\n⚠️  Warning: CF_PROXY_SECRET not set in environment", YELLOW)
        print("Using test secret: 'test_secret'")
        print("Set CF_PROXY_SECRET environment variable for production testing")
        CF_PROXY_SECRET_VALUE = "test_secret"
    else:
        print_colored("✅ Using CF_PROXY_SECRET from environment", GREEN)
        CF_PROXY_SECRET_VALUE = CF_PROXY_SECRET

    # Run tests
    results = []

    # First check if endpoint exists
    result = test_endpoint_exists()
    results.append(("Endpoint Exists", result))

    if result.get("status") == 404:
        print_colored("\n❌ CRITICAL: /process endpoint not found!", RED)
        print_colored("The endpoint is not deployed to production.", RED)
        print_colored("\nRequired Actions:", YELLOW)
        print("1. Merge feat/cf-migration-phase1 branch to main")
        print("2. Ensure Render deploys from main branch")
        print("3. Set CF_PROXY_SECRET in Render environment variables")
        sys.exit(1)

    # Run authentication tests
    results.append(("Valid Request", test_valid_request(CF_PROXY_SECRET_VALUE)))
    results.append(("Invalid Signature", test_invalid_signature(CF_PROXY_SECRET_VALUE)))
    results.append(("Expired Timestamp", test_expired_timestamp(CF_PROXY_SECRET_VALUE)))
    results.append(("Missing Headers", test_missing_headers()))

    # Print summary
    print_colored("\n" + "=" * 60, BLUE)
    print_colored("📊 Test Summary", BLUE)
    print_colored("=" * 60, BLUE)

    passed = 0
    failed = 0

    for test_name, result in results:
        if result.get("success"):
            print_colored(f"✅ {test_name}: PASSED", GREEN)
            passed += 1
        else:
            error = result.get("error", f"Status {result.get('status', 'unknown')}")
            print_colored(f"❌ {test_name}: FAILED ({error})", RED)
            failed += 1

    print_colored(f"\nTotal: {passed} passed, {failed} failed", BLUE)

    if failed > 0:
        if any("Endpoint not deployed" in str(r.get("error", "")) for _, r in results):
            print_colored("\n🚨 Critical Issue: /process endpoint not deployed!", RED)
            print_colored("Run: ./scripts/deploy_fix.sh", YELLOW)
        elif any(r.get("status") == 503 for _, r in results):
            print_colored("\n⚠️  CF_PROXY_SECRET not configured in production", YELLOW)
            print_colored("Add CF_PROXY_SECRET to Render environment variables", YELLOW)
        sys.exit(1)
    else:
        print_colored("\n✨ All tests passed!", GREEN)


if __name__ == "__main__":
    main()
