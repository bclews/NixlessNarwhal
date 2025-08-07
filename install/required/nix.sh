#!/bin/bash
set -e

# Yeah, so uh, not entirely nixless!
# Some random packages require it.

export TMPDIR=~/nix-install-temp
mkdir -p $TMPDIR

# Install Nix
curl -L https://nixos.org/nix/install | sh

# Source the Nix profile script
# shellcheck disable=SC1091
. ~/.nix-profile/etc/profile.d/nix.sh

# Source the bashrc to ensure the environment is updated
# shellcheck disable=SC1091
source ~/.zshrc

rm -rf ~/nix-install-temp

# Verify the installation
nix --version
