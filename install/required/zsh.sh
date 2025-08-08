#!/bin/bash
set -e

# Check if zsh is already installed and configured
if apt_package_installed zsh && [ "$SHELL" = "$(which zsh)" ] && [ -d "$HOME/.oh-my-zsh" ]; then
    return 0
fi

# Install zsh if not present
if ! apt_package_installed zsh; then
    sudo apt-get update >/dev/null
    sudo apt-get install -y zsh >/dev/null
fi

# Change default shell to zsh if needed
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s "$(which zsh)" >/dev/null
fi

# Install Oh My Zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" >/dev/null
fi
