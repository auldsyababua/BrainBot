#!/bin/bash

echo "🔧 Fixing Semgrep VSCode Extension..."

# Step 1: Remove old extension data
echo "Step 1: Cleaning up old extension data..."
rm -rf ~/.vscode/extensions/semgrep.semgrep-1.14.0-darwin-arm64

# Step 2: Clear VSCode extension cache
echo "Step 2: Clearing VSCode cache..."
rm -rf ~/Library/Application\ Support/Code/CachedExtensionVSIXs/semgrep*

# Step 3: Verify Semgrep CLI is working
echo "Step 3: Verifying Semgrep CLI..."
semgrep --version

# Step 4: Re-authenticate if needed
echo "Step 4: Checking authentication..."
if ! semgrep whoami 2>/dev/null; then
    echo "Re-authenticating with Semgrep..."
    semgrep logout
    semgrep login
fi

echo ""
echo "✅ Cleanup complete!"
echo ""
echo "Next steps:"
echo "1. Restart VSCode completely (Cmd+Q)"
echo "2. Open VSCode and reinstall the Semgrep extension:"
echo "   - Open Extensions (Cmd+Shift+X)"
echo "   - Search for 'Semgrep'"
echo "   - Click Install on the official Semgrep extension"
echo "3. After installation, the extension should automatically detect your CLI login"
echo ""
echo "If issues persist, try:"
echo "  - Check VSCode Output panel (View > Output > Select 'Semgrep' from dropdown)"
echo "  - Run: semgrep logout && semgrep login"