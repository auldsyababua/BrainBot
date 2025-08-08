.PHONY: help install dev build test lint clean deploy docker

# Default target
help:
	@echo "Telegram Mini App - Available Commands"
	@echo "======================================"
	@echo "make install    - Install dependencies"
	@echo "make dev        - Start development server"
	@echo "make build      - Build for production"
	@echo "make test       - Run tests with coverage"
	@echo "make lint       - Run linting and type checks"
	@echo "make clean      - Clean build artifacts and caches"
	@echo "make deploy     - Deploy to configured platform"
	@echo "make docker     - Build and run Docker container"
	@echo "make preflight  - Run all checks before commit"
	@echo "make setup-env  - Setup environment variables"
	@echo "make check-deps - Check for outdated dependencies"

# Install dependencies
install:
	@echo "Installing dependencies..."
	@if [ -f "pnpm-lock.yaml" ]; then \
		pnpm install --frozen-lockfile; \
	elif [ -f "package-lock.json" ]; then \
		npm ci; \
	else \
		npm install; \
	fi

# Development server
dev:
	@echo "Starting development server..."
	npm run dev

# Production build
build:
	@echo "Building for production..."
	npm run build
	@echo "Build complete! Output in ./dist"

# Run tests
test:
	@echo "Running tests..."
	npm run test:coverage

# Linting and type checking
lint:
	@echo "Running linters and type checking..."
	npm run typecheck
	npm run lint

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	rm -rf dist
	rm -rf node_modules/.vite
	rm -rf coverage
	rm -rf .turbo
	rm -rf .next
	@echo "Clean complete!"

# Deploy to platform
deploy:
	@echo "Deploying to production..."
	@if [ -f "vercel.json" ]; then \
		echo "Deploying to Vercel..."; \
		npm run deploy:vercel; \
	elif [ -f "netlify.toml" ]; then \
		echo "Deploying to Netlify..."; \
		npm run deploy:netlify; \
	else \
		echo "No deployment configuration found!"; \
		exit 1; \
	fi

# Docker operations
docker:
	@echo "Building Docker image..."
	docker build -t telegram-mini-app:latest .
	@echo "Starting Docker container..."
	docker run -d -p 8080:8080 --name telegram-mini-app telegram-mini-app:latest
	@echo "App running at http://localhost:8080"

docker-stop:
	@echo "Stopping Docker container..."
	docker stop telegram-mini-app
	docker rm telegram-mini-app

docker-compose-up:
	@echo "Starting with Docker Compose..."
	docker-compose up -d
	@echo "App running at http://localhost:8080"

docker-compose-down:
	@echo "Stopping Docker Compose..."
	docker-compose down

# Pre-commit checks
preflight:
	@echo "Running pre-flight checks..."
	@echo "1. Type checking..."
	@npm run typecheck
	@echo "2. Linting..."
	@npm run lint
	@echo "3. Running tests..."
	@npm run test:coverage
	@echo "4. Building..."
	@npm run build
	@echo "All checks passed! Ready to commit."

# Setup environment
setup-env:
	@echo "Setting up environment variables..."
	@if [ ! -f ".env.local" ]; then \
		cp .env.example .env.local; \
		echo "Created .env.local from template"; \
		echo "Please edit .env.local with your values"; \
	else \
		echo ".env.local already exists"; \
	fi

# Check dependencies
check-deps:
	@echo "Checking for outdated dependencies..."
	npm outdated || true
	@echo ""
	@echo "Run 'npm update' to update dependencies"

# Install development tools globally
install-tools:
	@echo "Installing global development tools..."
	npm i -g vercel netlify-cli @sentry/cli lighthouse

# Security audit
security:
	@echo "Running security audit..."
	npm audit
	@echo ""
	@echo "Run 'npm audit fix' to fix vulnerabilities"

# Bundle size analysis
analyze:
	@echo "Analyzing bundle size..."
	npm run build:analyze

# Format code
format:
	@echo "Formatting code..."
	npm run lint:fix

# Create production environment file
prod-env:
	@echo "Creating production environment template..."
	@echo "# Production Environment Variables" > .env.production
	@echo "VITE_TELEGRAM_BOT_USERNAME=" >> .env.production
	@echo "VITE_TELEGRAM_WEB_APP_URL=" >> .env.production
	@echo "VITE_API_URL=" >> .env.production
	@echo "VITE_ENABLE_ANALYTICS=true" >> .env.production
	@echo "VITE_ENABLE_DEBUG=false" >> .env.production
	@echo "Created .env.production template"

# Quick start for new developers
quickstart: install setup-env
	@echo ""
	@echo "Quick start complete!"
	@echo "1. Edit .env.local with your configuration"
	@echo "2. Run 'make dev' to start development server"
	@echo "3. Run 'make test' to run tests"
	@echo "4. Run 'make build' to build for production"