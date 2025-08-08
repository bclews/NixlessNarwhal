#!/bin/bash
set -e

# Display system information in the terminal
sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch
sudo apt-get update -y
sudo apt-get install -y fastfetch
