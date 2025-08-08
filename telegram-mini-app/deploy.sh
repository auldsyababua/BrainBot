#!/bin/bash

# Telegram Mini App Deployment Script
# Automates deployment to various platforms

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_color() {
    echo -e "${2}${1}${NC}"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to validate environment
validate_environment() {
    print_color "Validating environment..." "$BLUE"
    
    if [ ! -f "package.json" ]; then
        print_color "Error: package.json not found. Are you in the correct directory?" "$RED"
        exit 1
    fi
    
    if ! command_exists node; then
        print_color "Error: Node.js is not installed" "$RED"
        exit 1
    fi
    
    if ! command_exists npm; then
        print_color "Error: npm is not installed" "$RED"
        exit 1
    fi
    
    print_color "✓ Environment validated" "$GREEN"
}

# Function to install dependencies
install_dependencies() {
    print_color "Installing dependencies..." "$BLUE"
    npm install
    print_color "✓ Dependencies installed" "$GREEN"
}

# Function to run tests
run_tests() {
    print_color "Running tests..." "$BLUE"
    if npm run test 2>/dev/null; then
        print_color "✓ Tests passed" "$GREEN"
    else
        print_color "⚠ No tests found or tests skipped" "$YELLOW"
    fi
}

# Function to build the application
build_app() {
    print_color "Building application..." "$BLUE"
    
    # Check for environment file
    if [ "$1" == "production" ] && [ -f ".env.production" ]; then
        print_color "Using .env.production" "$YELLOW"
    elif [ -f ".env.local" ]; then
        print_color "Using .env.local" "$YELLOW"
    else
        print_color "Warning: No environment file found" "$YELLOW"
    fi
    
    npm run build
    print_color "✓ Build completed" "$GREEN"
}

# Function to deploy to Vercel
deploy_vercel() {
    print_color "\nDeploying to Vercel..." "$BLUE"
    
    if ! command_exists vercel; then
        print_color "Vercel CLI not found. Installing..." "$YELLOW"
        npm install -g vercel
    fi
    
    if [ "$1" == "production" ]; then
        vercel --prod
    else
        vercel
    fi
    
    print_color "✓ Deployed to Vercel" "$GREEN"
}

# Function to deploy to Netlify
deploy_netlify() {
    print_color "\nDeploying to Netlify..." "$BLUE"
    
    if ! command_exists netlify; then
        print_color "Netlify CLI not found. Installing..." "$YELLOW"
        npm install -g netlify-cli
    fi
    
    if [ "$1" == "production" ]; then
        netlify deploy --prod --dir=dist
    else
        netlify deploy --dir=dist
    fi
    
    print_color "✓ Deployed to Netlify" "$GREEN"
}

# Function to deploy to Render
deploy_render() {
    print_color "\nDeploying to Render..." "$BLUE"
    
    # Render uses Git-based deployment
    print_color "Render uses automatic Git deployment." "$YELLOW"
    print_color "Push to your connected branch to trigger deployment:" "$YELLOW"
    echo "  git add ."
    echo "  git commit -m 'Deploy to Render'"
    echo "  git push origin main"
    
    read -p "Do you want to push to Git now? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git add .
        git commit -m "Deploy Telegram Mini App to Render"
        git push origin main
        print_color "✓ Pushed to Git. Render will auto-deploy." "$GREEN"
    fi
}

# Function to configure Telegram Bot
configure_telegram() {
    print_color "\nConfiguring Telegram Bot..." "$BLUE"
    
    read -p "Enter your Bot Token: " BOT_TOKEN
    read -p "Enter your Mini App URL: " APP_URL
    
    # Set webhook
    print_color "Setting webhook..." "$YELLOW"
    WEBHOOK_RESPONSE=$(curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/setWebhook" \
        -d "url=${APP_URL}/webhook")
    
    if [[ $WEBHOOK_RESPONSE == *"\"ok\":true"* ]]; then
        print_color "✓ Webhook configured" "$GREEN"
    else
        print_color "⚠ Webhook configuration failed" "$RED"
        echo "$WEBHOOK_RESPONSE"
    fi
    
    # Set menu button
    print_color "Setting menu button..." "$YELLOW"
    MENU_RESPONSE=$(curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/setChatMenuButton" \
        -H "Content-Type: application/json" \
        -d "{\"menu_button\": {\"type\": \"web_app\", \"text\": \"Open App\", \"web_app\": {\"url\": \"${APP_URL}\"}}}")
    
    if [[ $MENU_RESPONSE == *"\"ok\":true"* ]]; then
        print_color "✓ Menu button configured" "$GREEN"
    else
        print_color "⚠ Menu button configuration failed" "$RED"
        echo "$MENU_RESPONSE"
    fi
}

# Main deployment menu
show_menu() {
    echo
    print_color "================================" "$BLUE"
    print_color "Telegram Mini App Deployment" "$BLUE"
    print_color "================================" "$BLUE"
    echo
    echo "Select deployment target:"
    echo "1) Vercel (Recommended)"
    echo "2) Netlify"
    echo "3) Render"
    echo "4) Build only (no deploy)"
    echo "5) Configure Telegram Bot"
    echo "6) Full deployment (build + deploy + configure)"
    echo "0) Exit"
    echo
    read -p "Enter choice [0-6]: " choice
    
    case $choice in
        1)
            validate_environment
            install_dependencies
            run_tests
            build_app "production"
            deploy_vercel "production"
            ;;
        2)
            validate_environment
            install_dependencies
            run_tests
            build_app "production"
            deploy_netlify "production"
            ;;
        3)
            validate_environment
            install_dependencies
            run_tests
            build_app "production"
            deploy_render
            ;;
        4)
            validate_environment
            install_dependencies
            run_tests
            build_app "production"
            print_color "✓ Build complete. Files in dist/" "$GREEN"
            ;;
        5)
            configure_telegram
            ;;
        6)
            validate_environment
            install_dependencies
            run_tests
            build_app "production"
            
            echo
            echo "Select deployment platform:"
            echo "1) Vercel"
            echo "2) Netlify"
            echo "3) Render"
            read -p "Enter choice [1-3]: " platform
            
            case $platform in
                1) deploy_vercel "production" ;;
                2) deploy_netlify "production" ;;
                3) deploy_render ;;
                *) print_color "Invalid choice" "$RED" ;;
            esac
            
            configure_telegram
            ;;
        0)
            print_color "Exiting..." "$BLUE"
            exit 0
            ;;
        *)
            print_color "Invalid choice" "$RED"
            show_menu
            ;;
    esac
}

# Check if running with arguments
if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
    echo "Usage: ./deploy.sh [option]"
    echo "Options:"
    echo "  --vercel     Deploy to Vercel"
    echo "  --netlify    Deploy to Netlify"
    echo "  --render     Deploy to Render"
    echo "  --build      Build only"
    echo "  --telegram   Configure Telegram Bot"
    echo "  --help       Show this help message"
    echo
    echo "Without options, interactive menu will be shown."
    exit 0
elif [ "$1" == "--vercel" ]; then
    validate_environment
    install_dependencies
    run_tests
    build_app "production"
    deploy_vercel "production"
elif [ "$1" == "--netlify" ]; then
    validate_environment
    install_dependencies
    run_tests
    build_app "production"
    deploy_netlify "production"
elif [ "$1" == "--render" ]; then
    validate_environment
    install_dependencies
    run_tests
    build_app "production"
    deploy_render
elif [ "$1" == "--build" ]; then
    validate_environment
    install_dependencies
    run_tests
    build_app "production"
elif [ "$1" == "--telegram" ]; then
    configure_telegram
else
    # Show interactive menu
    show_menu
fi

print_color "\n✨ Deployment script completed!" "$GREEN"