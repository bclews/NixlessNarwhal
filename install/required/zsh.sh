#!/bin/bash
set -e

# Install zsh
sudo apt-get install zsh >/dev/null

# Change default shell to zsh
chsh -s "$(which zsh)" >/dev/null

# Install Oh My Zsh non-interactively
RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" >/dev/null
