#!/bin/bash
set -e

# Load state management functions if not already loaded
if ! command -v command_exists >/dev/null 2>&1; then
    # shellcheck source=../state.sh
    source ~/.local/share/NixlessNarwhal/install/state.sh
fi

# Check if fzf is already installed
if [ -d ~/.local/share/fzf ] && command_exists fzf; then
    return 0
fi

# Clone and install fzf if not present
if [ ! -d ~/.local/share/fzf ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.local/share/fzf >/dev/null
fi

# Run install if fzf command is not available
if ! command_exists fzf; then
    ~/.local/share/fzf/install --bin --key-bindings --completion --no-update-rc >/dev/null 2>&1
fi
