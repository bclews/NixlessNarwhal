#!/bin/bash
set -e

# Check if mise is already installed
if command_exists mise && apt_package_installed mise; then
    return 0
fi

# Install mise for managing multiple versions of languages. See https://mise.jdx.dev/
# Ensure required packages are installed
required_packages=("gpg" "wget" "curl")
for package in "${required_packages[@]}"; do
    if ! apt_package_installed "$package"; then
        sudo apt-get update -y >/dev/null
        sudo apt-get install -y "$package" >/dev/null
    fi
done

# Add mise repository if not present
if [ ! -f /etc/apt/sources.list.d/mise.list ]; then
    sudo install -dm 755 /etc/apt/keyrings
    wget -qO - https://mise.jdx.dev/gpg-key.pub | gpg --dearmor | sudo tee /etc/apt/keyrings/mise-archive-keyring.gpg 1>/dev/null
    echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=$(dpkg --print-architecture)] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list >/dev/null
    sudo apt-get update >/dev/null
fi

# Install mise if not present
if ! apt_package_installed mise; then
    sudo apt-get install -y mise >/dev/null
fi
