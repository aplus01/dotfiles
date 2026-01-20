#!/bin/bash
# Install ghostty terminal

if ! command -v ghostty &> /dev/null; then
  echo "Installing ghostty..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"
else
  echo "ghostty already installed"
fi
