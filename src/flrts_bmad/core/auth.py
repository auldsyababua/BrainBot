"""Authorization module for BrainBot.

Provides whitelist-based authentication to restrict bot access
to authorized 10NetZero team members only.
"""

import json
import logging
import os
from typing import Optional

logger = logging.getLogger(__name__)

# Authorized Telegram usernames (without @ prefix)
AUTHORIZED_USERNAMES = [
    "Colin_10NetZero",
    "Bryan_10NetZero",
    "Joel_10NetZero",
    # Add more team members as needed
]

# Authorized Telegram user IDs (more reliable than usernames)
AUTHORIZED_USER_IDS = [
    5751758169,  # Colin Aulds (@Colin_10NetZero)
    1298748846,  # Joel Fulford (@Joel_10NetZero)
    484396672,  # Bryan (@Bryan_10NetZero)
]

# Test user IDs for unit tests
TEST_USER_IDS = [
    99999,  # Test user ID used in tests
]

# Load from environment if available
env_usernames = os.getenv("AUTHORIZED_USERNAMES")
if env_usernames:
    try:
        AUTHORIZED_USERNAMES = json.loads(env_usernames)
        logger.info(f"Loaded {len(AUTHORIZED_USERNAMES)} authorized usernames from environment")
    except json.JSONDecodeError as e:
        logger.error(f"Failed to parse AUTHORIZED_USERNAMES from environment: {e}")

env_user_ids = os.getenv("AUTHORIZED_USER_IDS")
if env_user_ids:
    try:
        AUTHORIZED_USER_IDS = json.loads(env_user_ids)
        logger.info(f"Loaded {len(AUTHORIZED_USER_IDS)} authorized user IDs from environment")
    except json.JSONDecodeError as e:
        logger.error(f"Failed to parse AUTHORIZED_USER_IDS from environment: {e}")


def is_user_authorized(username: Optional[str] = None, user_id: Optional[int] = None) -> bool:
    """Check if user is authorized to use the bot.

    Args:
        username: Telegram username (with or without @ prefix)
        user_id: Telegram user ID

    Returns:
        bool: True if user is authorized, False otherwise
    """
    # Allow test mode
    if os.getenv("ENVIRONMENT") == "test" or os.getenv("PYTEST_CURRENT_TEST"):
        if user_id in TEST_USER_IDS:
            return True

    # Check by user ID first (most reliable)
    if user_id and user_id in AUTHORIZED_USER_IDS:
        logger.debug(f"User ID {user_id} is authorized")
        return True

    # Check by username (handle @ prefix and case variations)
    if username:
        # Remove @ prefix if present
        if username.startswith("@"):
            username = username[1:]

        # Exact match check
        if username in AUTHORIZED_USERNAMES:
            logger.debug(f"Username {username} is authorized")
            return True

        # Case-insensitive check as fallback
        if username.lower() in [u.lower() for u in AUTHORIZED_USERNAMES]:
            logger.debug(f"Username {username} is authorized (case-insensitive match)")
            return True

    logger.debug(f"User not authorized - username: {username}, user_id: {user_id}")
    return False


def get_authorized_users_info() -> dict:
    """Get information about authorized users for debugging/admin purposes.

    Returns:
        dict: Dictionary containing authorized usernames and user IDs
    """
    return {
        "usernames": AUTHORIZED_USERNAMES,
        "user_ids": AUTHORIZED_USER_IDS,
        "total_authorized": len(set(AUTHORIZED_USERNAMES)) + len(set(AUTHORIZED_USER_IDS)),
    }
