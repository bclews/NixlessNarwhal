#!/bin/bash
set -e

# Load state management functions if not already loaded
if ! command -v apt_package_installed >/dev/null 2>&1; then
    # shellcheck source=../state.sh
    source ~/.local/share/NixlessNarwhal/install/state.sh
fi

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
