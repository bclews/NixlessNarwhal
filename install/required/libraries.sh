#!/bin/bash
set -e

sudo apt-get install -y \
  build-essential \
  curl \
  apache2-utils \
  bat \
  btop \
  fd-find \
  plocate \
  ripgrep \
  stow \
  tldr \
  zoxide >/dev/null
