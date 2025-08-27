"""Unit tests for refactored LLM methods."""

import json
from unittest.mock import AsyncMock, MagicMock, Mock, patch

import pytest

from brainbot.core.llm import (
    _build_llm_context,
    _execute_llm_chain,
    _extract_session_context,
    _route_message,
    process_message,
)


class TestExtractSessionContext:
    """Test the _extract_session_context method."""

    @pytest.mark.asyncio
    async def test_basic_extraction(self):
        """Test basic session context extraction."""
        user_message = "Test message"
        chat_id = "test_chat_123"

        result = await _extract_session_context(user_message, chat_id)

        assert result["user_message"] == user_message
        assert result["chat_id"] == chat_id
        assert len(result) == 2  # Only user_message and chat_id

    @pytest.mark.asyncio
    async def test_empty_message(self):
        """Test extraction with empty message."""
        result = await _extract_session_context("", "chat_456")

        assert result["user_message"] == ""
        assert result["chat_id"] == "chat_456"

    @pytest.mark.asyncio
    async def test_special_characters(self):
        """Test extraction with special characters in message."""
        message = "Test @mention #tag $special"
        result = await _extract_session_context(message, "chat_789")

        assert result["user_message"] == message
        assert result["chat_id"] == "chat_789"


class TestRouteMessage:
    """Test the _route_message method."""

    @pytest.mark.asyncio
    @patch("brainbot.core.llm.keyword_router")
    @patch("brainbot.core.llm.prompt_generator")
    @patch("brainbot.core.llm._process_rails_command")
    async def test_direct_execution(self, mock_process_rails, mock_prompt_gen, mock_router):
        """Test direct execution path when confidence is high."""
        # Setup mocks
        mock_router.route.return_value = MagicMock(
            entity_type="task",
            operation="create",
            confidence=0.95,
            extracted_data={"content": "New task"},
        )
        mock_router.ensure_aliases_loaded = AsyncMock()

        mock_prompt_gen.determine_execution_strategy.return_value = "direct"
        mock_prompt_gen.generate_performance_metrics.return_value = {"estimated_tokens": 100}

        mock_process_rails.return_value = "Task created successfully"

        # Execute
        result = await _route_message("create task: New task", {"chat_id": "test_123"})

        # Verify
        assert result["response"] == "Task created successfully"
        assert result["execution_strategy"] == "direct"
        mock_process_rails.assert_called_once()

    @pytest.mark.asyncio
    @patch("brainbot.core.llm.keyword_router")
    async def test_low_confidence_routing(self, mock_router):
        """Test routing when confidence is low."""
        mock_router.route.return_value = MagicMock(
            entity_type="unknown",
            confidence=0.3,
            extracted_data=None,
        )
        mock_router.ensure_aliases_loaded = AsyncMock()

        result = await _route_message("vague message", {"chat_id": "test_456"})

        assert result["response"] is None
        assert result["execution_strategy"] is None
        assert result["user_message"] == "vague message"

    @pytest.mark.asyncio
    @patch("brainbot.core.llm.keyword_router", None)
    async def test_no_router_available(self):
        """Test routing when keyword router is not available."""
        result = await _route_message("test message", {"chat_id": "test_789"})

        assert result["response"] is None
        assert result["route_result"] is None
        assert result["user_message"] == "test message"


class TestBuildLLMContext:
    """Test the _build_llm_context method."""

    @pytest.mark.asyncio
    @patch("brainbot.core.llm.get_performance_monitor")
    @patch("brainbot.core.llm.search_knowledge_base")
    @patch("brainbot.core.llm.bot_memory")
    @patch("brainbot.core.llm.get_conversation_history")
    @patch("brainbot.core.llm.add_to_conversation_history")
    @patch("brainbot.core.llm._get_optimized_functions")
    async def test_context_building(
        self,
        mock_get_functions,
        mock_add_history,
        mock_get_history,
        mock_memory,
        mock_search,
        mock_monitor,
    ):
        """Test building complete LLM context."""
        # Setup mocks
        mock_monitor.return_value = MagicMock(track_conversation_size=MagicMock())
        mock_search.return_value = [
            {
                "content": "Relevant content",
                "metadata": {"title": "Doc1"},
                "document_url": "http://example.com/doc1",
                "score": 0.9,
            }
        ]

        mock_memory.recall_context = AsyncMock(
            return_value=[{"memory": "User prefers detailed responses"}]
        )

        mock_get_history.return_value = [
            {"role": "system", "content": "You are a helpful assistant"},
            {"role": "user", "content": "Previous message"},
        ]

        mock_get_functions.return_value = [{"name": "test_function"}]

        routing_result = {
            "user_message": "Test query",
            "route_result": None,
        }

        context = {"chat_id": "test_chat", "user_message": "Test query"}

        # Execute
        result = await _build_llm_context(routing_result, context)

        # Verify
        assert "messages" in result
        assert "functions_to_send" in result
        assert "source_documents" in result
        assert result["chat_id"] == "test_chat"
        assert len(result["messages"]) > 2  # System + previous + new
        mock_search.assert_called_once_with("Test query", "test_chat")
        mock_memory.recall_context.assert_called_once()

    @pytest.mark.asyncio
    @patch("brainbot.core.llm.get_performance_monitor")
    @patch("brainbot.core.llm.search_knowledge_base")
    @patch("brainbot.core.llm.bot_memory")
    @patch("brainbot.core.llm.get_conversation_history")
    @patch("brainbot.core.llm.add_to_conversation_history")
    @patch("brainbot.core.llm._get_optimized_functions")
    async def test_context_with_route_result(
        self,
        mock_get_functions,
        mock_add_history,
        mock_get_history,
        mock_memory,
        mock_search,
        mock_monitor,
    ):
        """Test context building with routing result."""
        mock_monitor.return_value = MagicMock(track_conversation_size=MagicMock())
        mock_search.return_value = []
        mock_memory.recall_context = AsyncMock(return_value=[])
        mock_get_history.return_value = []
        mock_get_functions.return_value = []

        route_result = MagicMock(
            extracted_data={
                "assignee": "John",
                "site": "Site A",
                "time_references": ["tomorrow", "2pm"],
            }
        )

        routing_result = {
            "user_message": "Assign to John at Site A tomorrow 2pm",
            "route_result": route_result,
            "prompt_context": True,
        }

        result = await _build_llm_context(
            routing_result, {"chat_id": "test", "user_message": "Assign to John"}
        )

        # Check that extracted context was added to message
        user_message = result["messages"][-1]["content"]
        assert "Assignee: John" in user_message
        assert "Site: Site A" in user_message
        assert "Time: tomorrow, 2pm" in user_message


class TestExecuteLLMChain:
    """Test the _execute_llm_chain method."""

    @pytest.mark.asyncio
    @patch("brainbot.core.llm.resilient_client")
    @patch("brainbot.core.llm.add_to_conversation_history")
    @patch("brainbot.core.llm.get_conversation_history")
    @patch("brainbot.core.llm.bot_memory")
    async def test_direct_response(
        self,
        mock_memory,
        mock_get_history,
        mock_add_history,
        mock_client,
    ):
        """Test LLM chain execution with direct response (no function call)."""
        # Setup mocks
        mock_response = MagicMock()
        mock_response.choices = [
            MagicMock(
                message=MagicMock(
                    content="This is the response",
                    function_call=None,
                )
            )
        ]
        mock_client.chat_completion = AsyncMock(return_value=mock_response)
        mock_get_history.return_value = [
            {"role": "user", "content": "test"},
            {"role": "assistant", "content": "response"},
        ]
        mock_memory.remember_from_conversation = AsyncMock()
        mock_add_history.return_value = None

        llm_context = {
            "messages": [{"role": "user", "content": "Test message"}],
            "functions_to_send": [],
            "source_documents": [],
            "chat_id": "test_chat",
        }

        # Execute
        result = await _execute_llm_chain(llm_context)

        # Verify
        assert result["content"] == "This is the response"
        assert result["source_documents"] == []
        mock_add_history.assert_called_once()
        mock_memory.remember_from_conversation.assert_called_once()

    @pytest.mark.asyncio
    @patch("brainbot.core.llm.resilient_client")
    @patch("brainbot.core.llm.execute_function")
    @patch("brainbot.core.llm.add_to_conversation_history")
    @patch("brainbot.core.llm.get_conversation_history")
    @patch("brainbot.core.llm.bot_memory")
    async def test_function_call_response(
        self,
        mock_memory,
        mock_get_history,
        mock_add_history,
        mock_execute,
        mock_client,
    ):
        """Test LLM chain execution with function call."""
        # Setup initial response with function call
        mock_function_call = MagicMock()
        mock_function_call.name = "test_function"
        mock_function_call.arguments = json.dumps({"param": "value"})

        initial_response = MagicMock()
        initial_response.choices = [
            MagicMock(
                message=MagicMock(
                    content=None,
                    function_call=mock_function_call,
                )
            )
        ]

        # Setup final response after function execution
        final_response = MagicMock()
        final_response.choices = [
            MagicMock(
                message=MagicMock(
                    content="Function executed successfully",
                )
            )
        ]

        mock_client.chat_completion = AsyncMock(side_effect=[initial_response, final_response])
        mock_execute.return_value = {"result": "success"}
        mock_get_history.return_value = [{"role": "user", "content": "test"}]

        llm_context = {
            "messages": [{"role": "user", "content": "Execute test function"}],
            "functions_to_send": [{"name": "test_function"}],
            "source_documents": [{"title": "Doc1", "url": "http://example.com", "score": 0.9}],
            "chat_id": "test_chat",
        }

        # Execute
        result = await _execute_llm_chain(llm_context)

        # Verify
        assert "Function executed successfully" in result["content"]
        assert "📚 Sources:" in result["content"]
        assert len(result["source_documents"]) == 1
        mock_execute.assert_called_once_with(
            "test_function", {"param": "value", "chat_id": "test_chat"}
        )
        assert mock_client.chat_completion.call_count == 2


class TestProcessMessage:
    """Test the refactored process_message function."""

    @pytest.mark.asyncio
    @patch("brainbot.core.llm._extract_session_context")
    @patch("brainbot.core.llm._route_message")
    @patch("brainbot.core.llm._build_llm_context")
    @patch("brainbot.core.llm._execute_llm_chain")
    async def test_full_pipeline(
        self,
        mock_execute,
        mock_build,
        mock_route,
        mock_extract,
    ):
        """Test the complete message processing pipeline."""
        # Setup mocks
        mock_extract.return_value = {
            "user_message": "Test message",
            "chat_id": "test_chat",
        }

        mock_route.return_value = {
            "response": None,  # No direct response
            "route_result": None,
            "user_message": "Test message",
        }

        mock_build.return_value = {
            "messages": [{"role": "user", "content": "Test"}],
            "functions_to_send": [],
            "source_documents": [],
        }

        mock_execute.return_value = {
            "content": "This is the final response",
            "source_documents": [],
        }

        # Execute
        result = await process_message("Test message", "test_chat")

        # Verify
        assert result == "This is the final response"
        mock_extract.assert_called_once_with("Test message", "test_chat")
        mock_route.assert_called_once()
        mock_build.assert_called_once()
        mock_execute.assert_called_once()

    @pytest.mark.asyncio
    @patch("brainbot.core.llm._extract_session_context")
    @patch("brainbot.core.llm._route_message")
    async def test_direct_routing_response(self, mock_route, mock_extract):
        """Test when routing returns a direct response."""
        mock_extract.return_value = {
            "user_message": "create task: New task",
            "chat_id": "test_chat",
        }

        mock_route.return_value = {
            "response": "Task created directly",  # Direct response
        }

        # Execute
        result = await process_message("create task: New task", "test_chat")

        # Verify
        assert result == "Task created directly"
        mock_route.assert_called_once()

    @pytest.mark.asyncio
    @patch("brainbot.core.llm._extract_session_context")
    async def test_error_handling(self, mock_extract):
        """Test error handling in process_message."""
        mock_extract.side_effect = Exception("Test error")

        result = await process_message("Test message", "test_chat")

        assert "I encountered an error" in result
        assert "Test error" in result
