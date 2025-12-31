#!/bin/bash
PLUGIN_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

if [ -d "$PLUGIN_DIR" ]; then
  echo "zsh-autosuggestions already installed"
else
  git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGIN_DIR"
  echo "zsh-autosuggestions installed"
fi