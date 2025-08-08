#!/bin/bash
set -e

# List of required packages
packages=(
    "build-essential"
    "curl" 
    "apache2-utils"
    "bat"
    "btop"
    "fd-find"
    "plocate"
    "ripgrep"
    "stow"
    "tldr"
    "zoxide"
)

# Check if all packages are already installed
all_installed=true
for package in "${packages[@]}"; do
    if ! apt_package_installed "$package"; then
        all_installed=false
        break
    fi
done

# Skip if all packages are installed
if [ "$all_installed" = true ]; then
    return 0
fi

# Install missing packages
sudo apt-get update >/dev/null
sudo apt-get install -y \
  build-essential \
  curl \
  apache2-utils \
  bat \
  btop \
  fd-find \
  plocate \
  ripgrep \
  stow \
  tldr \
  zoxide >/dev/null
