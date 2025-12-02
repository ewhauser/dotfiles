#!/bin/bash
# Setup script for completion caches

echo "Setting up zsh completion caches for faster shell startup..."
echo ""

# Create cache directory
mkdir -p ~/.zsh

# Generate kubectl completion cache
if command -v kubectl &> /dev/null; then
    echo "✓ Generating kubectl completion cache..."
    kubectl completion zsh > ~/.zsh/kubectl_completion
else
    echo "⚠ kubectl not found - skipping kubectl completion cache"
fi

# Generate mirrord completion cache
if command -v mirrord &> /dev/null; then
    echo "✓ Generating mirrord completion cache..."
    mirrord completions zsh > ~/.zsh/mirrord_completion
else
    echo "⚠ mirrord not found - skipping mirrord completion cache"
fi

echo ""
echo "✓ Completion cache setup complete!"
echo ""
echo "To regenerate caches in the future:"
echo "  kubectl completion zsh > ~/.zsh/kubectl_completion"
echo "  mirrord completions zsh > ~/.zsh/mirrord_completion"
