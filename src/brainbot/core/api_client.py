"""
Resilient OpenAI API client with retry logic and rate limiting.

This module provides a robust wrapper around the OpenAI API client that handles:
- Exponential backoff with jitter for rate limit errors
- Automatic retry for transient failures
- Performance tracking and monitoring
- Token usage tracking
"""

import asyncio
import logging
import random
import time
from collections.abc import Callable
from functools import wraps
from typing import Any, Dict, List, Optional

import openai
from dotenv import load_dotenv
from openai import AsyncOpenAI, OpenAI
from openai.types.chat import ChatCompletion

from brainbot.core.benchmarks import get_performance_monitor

# Load environment variables
load_dotenv()

logger = logging.getLogger(__name__)


class RetryConfig:
    """Configuration for retry behavior."""

    def __init__(
        self,
        max_retries: int = 3,
        base_delay: float = 1.0,
        max_delay: float = 60.0,
        exponential_base: float = 2.0,
        jitter: bool = True,
    ):
        self.max_retries = max_retries
        self.base_delay = base_delay
        self.max_delay = max_delay
        self.exponential_base = exponential_base
        self.jitter = jitter


class ResilientOpenAIClient:
    """OpenAI client with built-in retry logic and performance monitoring."""

    def __init__(self, retry_config: Optional[RetryConfig] = None):
        """Initialize the resilient OpenAI client.

        Args:
            retry_config: Optional retry configuration. Uses defaults if not provided.
        """
        self.client = AsyncOpenAI()
        self.sync_client = OpenAI()
        self.retry_config = retry_config or RetryConfig()
        self.monitor = None

    async def _ensure_monitor(self):
        """Ensure performance monitor is initialized."""
        if self.monitor is None:
            self.monitor = get_performance_monitor()

    def _calculate_delay(self, attempt: int) -> float:
        """Calculate delay for exponential backoff with optional jitter.

        Args:
            attempt: The current retry attempt number (0-based)

        Returns:
            Delay in seconds
        """
        # Exponential backoff
        delay = min(
            self.retry_config.base_delay * (self.retry_config.exponential_base**attempt),
            self.retry_config.max_delay,
        )

        # Add jitter if enabled
        if self.retry_config.jitter:
            delay = delay * (0.5 + random.random() * 0.5)

        return delay

    def _is_retryable_error(self, error: Exception) -> bool:
        """Determine if an error is retryable.

        Args:
            error: The exception that occurred

        Returns:
            True if the error is retryable, False otherwise
        """
        if isinstance(error, openai.RateLimitError):
            return True
        if isinstance(error, openai.APITimeoutError):
            return True
        if isinstance(error, openai.APIConnectionError):
            return True
        if isinstance(error, openai.InternalServerError):
            return True
        if isinstance(error, openai.APIStatusError):
            # Retry on 5xx errors
            if hasattr(error, "status_code") and error.status_code >= 500:
                return True
        return False

    async def call_with_retry(self, api_call_func: Callable, *args, **kwargs) -> Any:
        """Execute an API call with retry logic and monitoring.

        Args:
            api_call_func: The API function to call
            *args: Positional arguments for the API function
            **kwargs: Keyword arguments for the API function

        Returns:
            The API response

        Raises:
            The last exception if all retries are exhausted
        """
        await self._ensure_monitor()

        start_time = time.perf_counter()
        last_error = None

        for attempt in range(self.retry_config.max_retries + 1):
            try:
                # Make the API call
                result = await api_call_func(*args, **kwargs)

                # Track successful call
                duration = time.perf_counter() - start_time

                # Extract token usage if available
                prompt_tokens = 0
                completion_tokens = 0
                if hasattr(result, "usage") and result.usage:
                    prompt_tokens = result.usage.prompt_tokens or 0
                    completion_tokens = result.usage.completion_tokens or 0

                # Track metrics
                if self.monitor:
                    self.monitor.track_llm_call(
                        model=kwargs.get("model", "unknown"),
                        prompt_tokens=prompt_tokens,
                        completion_tokens=completion_tokens,
                        duration=duration,
                        retry_count=attempt,
                    )

                return result

            except Exception as e:
                last_error = e

                # Check if error is retryable
                if not self._is_retryable_error(e) or attempt == self.retry_config.max_retries:
                    # Non-retryable error or last attempt
                    duration = time.perf_counter() - start_time

                    # Track failed call
                    if self.monitor:
                        self.monitor.track_llm_call(
                            model=kwargs.get("model", "unknown"),
                            prompt_tokens=0,
                            completion_tokens=0,
                            duration=duration,
                            retry_count=attempt,
                        )

                    logger.error(f"API call failed after {attempt + 1} attempts: {e}")
                    raise

                # Calculate delay
                delay = self._calculate_delay(attempt)

                # Log retry attempt
                logger.warning(
                    f"API call failed (attempt {attempt + 1}), " f"retrying in {delay:.2f}s: {e}"
                )

                # Wait before retry
                await asyncio.sleep(delay)

        # This should never be reached, but just in case
        raise last_error or Exception("Unexpected error in retry logic")

    async def chat_completion(
        self,
        messages: list[dict[str, str]],
        model: str = "gpt-4o",
        temperature: float = 0.7,
        max_tokens: Optional[int] = None,
        **kwargs,
    ) -> ChatCompletion:
        """Create a chat completion with retry logic.

        Args:
            messages: List of message dictionaries
            model: Model to use
            temperature: Temperature for response generation
            max_tokens: Maximum tokens in response
            **kwargs: Additional parameters for the API

        Returns:
            ChatCompletion response
        """
        return await self.call_with_retry(
            self.client.chat.completions.create,
            messages=messages,
            model=model,
            temperature=temperature,
            max_tokens=max_tokens,
            **kwargs,
        )

    def sync_chat_completion(
        self,
        messages: list[dict[str, str]],
        model: str = "gpt-4o",
        temperature: float = 0.7,
        max_tokens: Optional[int] = None,
        **kwargs,
    ) -> ChatCompletion:
        """Synchronous version of chat completion with retry logic.

        Args:
            messages: List of message dictionaries
            model: Model to use
            temperature: Temperature for response generation
            max_tokens: Maximum tokens in response
            **kwargs: Additional parameters for the API

        Returns:
            ChatCompletion response
        """
        # Run async version in sync context
        loop = asyncio.new_event_loop()
        asyncio.set_event_loop(loop)
        try:
            return loop.run_until_complete(
                self.chat_completion(
                    messages=messages,
                    model=model,
                    temperature=temperature,
                    max_tokens=max_tokens,
                    **kwargs,
                )
            )
        finally:
            loop.close()

    async def embedding_create(
        self, input: str, model: str = "text-embedding-ada-002", **kwargs
    ) -> Any:
        """Create embeddings with retry logic.

        Args:
            input: Text to embed
            model: Embedding model to use
            **kwargs: Additional parameters for the API

        Returns:
            Embedding response
        """
        return await self.call_with_retry(
            self.client.embeddings.create, input=input, model=model, **kwargs
        )

    async def get_token_count(self, messages: list[dict[str, str]], model: str = "gpt-4o") -> int:
        """Estimate token count for messages.

        This is a simple estimation. For accurate counts, use tiktoken.

        Args:
            messages: List of message dictionaries
            model: Model to estimate for

        Returns:
            Estimated token count
        """
        # Simple estimation: ~4 characters per token
        total_chars = sum(len(msg.get("content", "")) for msg in messages)
        return int(total_chars / 4)


# Global client instance
_resilient_client: Optional[ResilientOpenAIClient] = None


def get_resilient_client(
    retry_config: Optional[RetryConfig] = None,
) -> ResilientOpenAIClient:
    """Get or create the global resilient OpenAI client.

    Args:
        retry_config: Optional retry configuration for new client

    Returns:
        ResilientOpenAIClient instance
    """
    global _resilient_client
    if _resilient_client is None:
        _resilient_client = ResilientOpenAIClient(retry_config)
    return _resilient_client


def with_retry(retry_config: Optional[RetryConfig] = None):
    """Decorator to add retry logic to any async function.

    Usage:
        @with_retry(RetryConfig(max_retries=5))
        async def my_api_call():
            # Your API call here
            pass
    """

    def decorator(func):
        @wraps(func)
        async def wrapper(*args, **kwargs):
            config = retry_config or RetryConfig()
            last_error = None

            for attempt in range(config.max_retries + 1):
                try:
                    return await func(*args, **kwargs)
                except Exception as e:
                    last_error = e

                    # Check if error is retryable
                    client = ResilientOpenAIClient(config)
                    if not client._is_retryable_error(e) or attempt == config.max_retries:
                        raise

                    # Calculate delay
                    delay = client._calculate_delay(attempt)
                    logger.warning(
                        f"{func.__name__} failed (attempt {attempt + 1}), "
                        f"retrying in {delay:.2f}s: {e}"
                    )

                    # Wait before retry
                    await asyncio.sleep(delay)

            raise last_error or Exception("Unexpected error in retry logic")

        return wrapper

    return decorator
