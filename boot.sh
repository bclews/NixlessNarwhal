#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "=> NixlessNarwhal for fresh headless Ubuntu installations only!"
echo -e "\nBegin installation (or abort with ctrl+c)..."

sudo apt-get update >/dev/null
sudo apt-get install -y git >/dev/null

echo "Cloning NixlessNarwhal..."
rm -rf ~/.local/share/NixlessNarwhal
git clone https://github.com/bclews/NixlessNarwhal.git ~/.local/share/NixlessNarwhal >/dev/null

echo "Installation starting..."
# shellcheck source=install.sh
source ~/.local/share/NixlessNarwhal/install.sh
