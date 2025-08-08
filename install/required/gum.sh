#!/bin/bash
set -e

# Check if gum is already installed
if command_exists gum && apt_package_installed gum; then
    return 0
fi

(
  # Gum is used for the Omakub commands for tailoring Omakub after the initial install
  cd /tmp || exit
  GUM_VERSION="0.14.3" # Use known good version
  wget -qO gum.deb "https://github.com/charmbracelet/gum/releases/download/v${GUM_VERSION}/gum_${GUM_VERSION}_amd64.deb"
  sudo apt-get install -y --allow-downgrades ./gum.deb
  rm gum.deb
  cd - || exit
)
