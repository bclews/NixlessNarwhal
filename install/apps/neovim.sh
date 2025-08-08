#!/bin/bash
set -e

# Load state management functions if not already loaded
if ! command -v command_exists >/dev/null 2>&1; then
    # shellcheck source=../state.sh
    source ~/.local/share/NixlessNarwhal/install/state.sh
fi

# Check if Neovim is already installed in the expected location
if [ -x /usr/local/bin/nvim ] && command_exists nvim; then
    return 0
fi

(
  cd /tmp || exit
  wget -O nvim.tar.gz "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"
  tar -xf nvim.tar.gz
  sudo install nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
  sudo cp -R nvim-linux-x86_64/lib /usr/local/
  sudo cp -R nvim-linux-x86_64/share /usr/local/
  rm -rf nvim-linux-x86_64 nvim.tar.gz
)
