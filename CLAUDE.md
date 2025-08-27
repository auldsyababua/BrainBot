# BrainBot Project Instructions

## Project Overview

This is the BrainBot project, a comprehensive field operations management system with AI-powered capabilities. This repository represents a clean, production-ready implementation.

## Repository Purpose

This repository contains:
- Core BrainBot functionality for field operations management
- Telegram bot integration for remote field communication
- Vector search and document processing capabilities
- Production-ready deployment configurations

## Development Guidelines

### Code Quality Standards
- Follow existing code patterns and structure
- Maintain comprehensive test coverage
- Use descriptive commit messages
- Ensure all changes are properly documented

### Architecture
- **Backend**: Python Flask application with Supabase integration
- **Frontend**: React-based Telegram Mini App
- **Storage**: Hybrid approach with vector search capabilities
- **Deployment**: Render.com for production hosting

## Getting Started

1. Install dependencies: `pip install -r requirements.txt`
2. Configure environment variables (see `.env.example`)
3. Run tests: `pytest`
4. Start development server: `python main.py`

## Key Features

- **Field Reports**: Structured data collection for field operations
- **Task Management**: Hierarchical task tracking and assignment
- **List Management**: Inventory and resource management
- **Vector Search**: Intelligent document and data retrieval
- **Telegram Integration**: Mobile-first interface for field workers

## Deployment

See `docs/DEPLOYMENT_CHECKLIST.md` for production deployment procedures.

## Contributing

1. Follow the existing code style and patterns
2. Add tests for new functionality
3. Update documentation as needed
4. Submit pull requests for review