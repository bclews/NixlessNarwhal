#!/bin/bash
set -e

# Load state management functions if not already loaded
if ! command -v command_exists >/dev/null 2>&1; then
    # shellcheck source=../state.sh
    source ~/.local/share/NixlessNarwhal/install/state.sh
fi

# Check if fastfetch is already installed
if command_exists fastfetch && apt_package_installed fastfetch; then
    return 0
fi

# Add PPA and install fastfetch if not present
if ! apt_package_installed fastfetch; then
    # Check if PPA is already added
    if ! grep -q "ppa:zhangsongcui3371/fastfetch" /etc/apt/sources.list /etc/apt/sources.list.d/* 2>/dev/null; then
        sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch >/dev/null
        sudo apt-get update -y >/dev/null
    fi
    sudo apt-get install -y fastfetch >/dev/null
fi
