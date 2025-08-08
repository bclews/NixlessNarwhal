#!/bin/bash
set -e

# Check if Neovim is already installed in the expected location
if [ -x /usr/local/bin/nvim ] && command_exists nvim; then
    return 0
fi

(
  cd /tmp || exit
  wget -O nvim.tar.gz "https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz"
  tar -xf nvim.tar.gz
  sudo install nvim-linux64/bin/nvim /usr/local/bin/nvim
  sudo cp -R nvim-linux64/lib /usr/local/
  sudo cp -R nvim-linux64/share /usr/local/
  rm -rf nvim-linux64 nvim.tar.gz
)
