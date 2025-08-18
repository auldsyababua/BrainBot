"""
Storage module initialization.
Provides unified interface for vector storage operations.
"""

import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Determine which vector store to use
USE_CLOUDFLARE = os.getenv("USE_CLOUDFLARE_VECTORIZE", "true").lower() == "true"

if USE_CLOUDFLARE:
    from .cloudflare_vector_store import cloudflare_vector_store as vector_store
else:
    # Fallback to Upstash during migration
    from .vector_store import vector_store

# Export the appropriate vector store
__all__ = ["vector_store"]
