#!/bin/bash
# Add keyring unlock to xrdp PAM config

# xrdp is Linux-only; nothing to do on macOS.
if [ "$(uname -s)" = "Darwin" ]; then
  echo "Skipping xrdp keyring config on macOS"
  exit 0
fi

if ! grep -q "pam_gnome_keyring" /etc/pam.d/xrdp-sesman; then
    echo "auth optional pam_gnome_keyring.so" | sudo tee -a /etc/pam.d/xrdp-sesman
    echo "session optional pam_gnome_keyring.so auto_start" | sudo tee -a /etc/pam.d/xrdp-sesman
fi
