#!/bin/bash

# Install zsh
sudo apt-get install zsh >/dev/null

# Change default shell to zsh
chsh -s "$(which zsh)"

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
