"""
Unified cache interface that switches between Cloudflare KV and Upstash Redis.
"""

import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Determine which cache backend to use
USE_CLOUDFLARE_CACHE = os.getenv("USE_CLOUDFLARE_CACHE", "true").lower() == "true"

if USE_CLOUDFLARE_CACHE:
    from .cloudflare_cache import cloudflare_cache as cache_client
    from .cloudflare_cache import CloudflareRedis

    # Create Redis-compatible client
    Redis = CloudflareRedis
else:
    # Fallback to Upstash during migration
    from upstash_redis import Redis as UpstashRedis
    from .redis_store import redis_client as cache_client

    Redis = UpstashRedis

# Export the appropriate cache client
__all__ = ["cache_client", "Redis"]
