#!/bin/bash
set -e

# Check if eza is already installed
if command_exists eza && apt_package_installed eza; then
    return 0
fi

# Check if GPG is installed, install if needed
if ! apt_package_installed gpg; then
    sudo apt-get update >/dev/null
    sudo apt-get install -y gpg >/dev/null
fi

# Add eza repository if not present
if [ ! -f /etc/apt/sources.list.d/gierens.list ]; then
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list >/dev/null
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt-get update >/dev/null
fi

# Install eza if not present
if ! apt_package_installed eza; then
    sudo apt-get install -y eza >/dev/null
fi
