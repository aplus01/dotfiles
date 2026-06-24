#!/bin/bash
# Install ghostty terminal

if command -v ghostty &> /dev/null; then
  echo "ghostty already installed"
  exit 0
fi

echo "Installing ghostty..."
if [ "$(uname -s)" = "Darwin" ]; then
  brew install --cask ghostty
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"
fi
