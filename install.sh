#!/bin/bash
# =============================================================================
# Dotfiles Bootstrap Script
# Installs packages, oh-my-zsh, and links dotfiles
# =============================================================================

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🚀 Setting up your machine..."
echo ""

# -----------------------------------------------------------------------------
# Install apt packages
# -----------------------------------------------------------------------------
echo "📦 Installing apt packages..."

sudo apt update
sudo apt install -y \
    zsh \
    git \
    curl \
    wget \
    stow \
    fzf \
    bat \
    fd-find \
    ripgrep \
    neovim

# -----------------------------------------------------------------------------
# Run install scripts
# -----------------------------------------------------------------------------
echo "📦 Running install scripts..."

for script in "$DOTFILES_DIR"/install/*.sh; do
    echo "  Running $(basename "$script")..."
    bash "$script"
done

# -----------------------------------------------------------------------------
# Install oh-my-zsh
# -----------------------------------------------------------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "📦 Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "✓ oh-my-zsh already installed"
fi

# -----------------------------------------------------------------------------
# Link dotfiles
# -----------------------------------------------------------------------------
echo "🔗 Linking dotfiles..."

cd "$DOTFILES_DIR"

# Remove existing .zshrc if it's not a symlink (oh-my-zsh creates one)
if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
    echo "  Backing up existing .zshrc to .zshrc.backup"
    mv "$HOME/.zshrc" "$HOME/.zshrc.backup"
fi

stow -R zsh
stow -R ghostty

# -----------------------------------------------------------------------------
# Set zsh as default shell
# -----------------------------------------------------------------------------
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "🐚 Setting zsh as default shell..."
    chsh -s $(which zsh)
fi

# -----------------------------------------------------------------------------
# Done!
# -----------------------------------------------------------------------------
echo ""
echo "=============================================="
echo "✅ Setup complete!"
echo "=============================================="
echo ""
echo "Log out and back in, or run: exec zsh"
echo ""