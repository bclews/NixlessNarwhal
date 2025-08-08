#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Load configuration
# shellcheck source=config.sh
source ~/.local/share/NixlessNarwhal/config.sh

# Load state management functions
# shellcheck source=install/state.sh
source ~/.local/share/NixlessNarwhal/install/state.sh

# Give people a chance to retry running the installation
trap 'echo "NixlessNarwhal installation failed! You can retry by running: source ~/.local/share/NixlessNarwhal/install.sh"' ERR

# Check the distribution name and version and abort if incompatible
# shellcheck source=install/check-version.sh
source ~/.local/share/NixlessNarwhal/install/check-version.sh

# Ask for app choices
echo "Get ready to make a few choices..."
# shellcheck source=install/required/gum.sh
source ~/.local/share/NixlessNarwhal/install/required/gum.sh >/dev/null
# shellcheck source=install/first-run-choices.sh
source ~/.local/share/NixlessNarwhal/install/first-run-choices.sh

if [ "$HOME" != "$NEW_HOME" ]; then
  echo "Moving home directory to a new location..."
  # shellcheck source=install/required/move-home.sh
  source ~/.local/share/NixlessNarwhal/install/required/move-home.sh
fi

if ! skip_if_installed "libraries" "Required libraries"; then
    echo "Installing Required libraries..."
    # shellcheck source=install/required/libraries.sh
    source ~/.local/share/NixlessNarwhal/install/required/libraries.sh
    mark_installed "libraries"
fi

# echo "Configuring SSH keys, and sets up GitHub for cloning repositories via SSH..."
# source ~/.local/share/NixlessNarwhal/install/required/git-ssh.sh

if ! skip_if_installed "zsh" "Zsh and Oh My Zsh"; then
    echo "Installing Zsh and Oh My Zsh..."
    # shellcheck source=install/required/zsh.sh
    source ~/.local/share/NixlessNarwhal/install/required/zsh.sh
    mark_installed "zsh"
fi

echo "Installing apps..."
# shellcheck disable=SC1090
for installer in ~/.local/share/NixlessNarwhal/install/apps/*.sh; do
    app_name=$(basename "$installer" .sh)
    if ! skip_if_installed "$app_name" "$app_name"; then
        echo "Installing $app_name..."
        source "$installer"
        mark_installed "$app_name"
    fi
done

echo ""
echo "Installation Summary:"
show_state
