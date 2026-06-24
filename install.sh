#!/bin/bash
# =============================================================================
# Dotfiles Bootstrap Script
# Installs packages, oh-my-zsh, and links dotfiles
# =============================================================================

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Detect OS so package installation and the per-tool install scripts can branch.
OS="$(uname -s)"
export DOTFILES_OS="$OS"

echo "🚀 Setting up your machine ($OS)..."
echo ""

# -----------------------------------------------------------------------------
# Install packages
# -----------------------------------------------------------------------------
install_packages_linux() {
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
    neovim \
    eza \
    zoxide \
    plocate \
    apache2-utils
}

install_packages_macos() {
  # Install Homebrew if it isn't already present.
  if ! command -v brew &>/dev/null; then
    echo "📦 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  # Make brew available on the current shell session (Apple Silicon vs Intel paths).
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi

  echo "📦 Installing brew packages..."
  # Package names differ from apt: fd-find -> fd.
  # plocate (macOS ships `locate`) and apache2-utils (macOS ships `htpasswd`/`ab`)
  # have no brew equivalent and are intentionally omitted.
  brew install \
    zsh \
    git \
    curl \
    wget \
    stow \
    fzf \
    bat \
    fd \
    ripgrep \
    neovim \
    eza \
    zoxide
}

case "$OS" in
  Linux)  install_packages_linux ;;
  Darwin) install_packages_macos ;;
  *)
    echo "❌ Unsupported OS: $OS"
    exit 1
    ;;
esac

# -----------------------------------------------------------------------------
# Install oh-my-zsh
# -----------------------------------------------------------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "📦 Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "✅ oh-my-zsh already installed"
fi

# -----------------------------------------------------------------------------
# Run install scripts
# -----------------------------------------------------------------------------
echo "📦 Running install scripts..."

for script in "$DOTFILES_DIR"/install/*.sh; do
  echo "  Running $(basename "$script")..."
  bash "$script"
done

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

stow -t ~ -R zsh
stow -t ~ -R ghostty
stow -t ~ -R nvim

# -----------------------------------------------------------------------------
# Set zsh as default shell
# -----------------------------------------------------------------------------
ZSH_PATH="$(which zsh)"
if [ "$SHELL" != "$ZSH_PATH" ]; then
  echo "🚀 Setting zsh as default shell..."
  # chsh refuses shells that aren't listed in /etc/shells (common for brew's zsh).
  if ! grep -qx "$ZSH_PATH" /etc/shells 2>/dev/null; then
    echo "$ZSH_PATH" | sudo tee -a /etc/shells >/dev/null
  fi
  chsh -s "$ZSH_PATH"
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
