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

# shellcheck source=install/required/libraries.sh
install_with_state "libraries" "Required libraries" "source ~/.local/share/NixlessNarwhal/install/required/libraries.sh"

# echo "Configuring SSH keys, and sets up GitHub for cloning repositories via SSH..."
# source ~/.local/share/NixlessNarwhal/install/required/git-ssh.sh

# shellcheck source=install/required/zsh.sh
install_with_state "zsh" "Zsh and Oh My Zsh" "source ~/.local/share/NixlessNarwhal/install/required/zsh.sh"

echo "Installing apps..."
# shellcheck disable=SC1090
for installer in ~/.local/share/NixlessNarwhal/install/apps/*.sh; do
    app_name=$(basename "$installer" .sh)
    install_with_state "$app_name" "$(echo "$app_name" | tr '[:lower:]' '[:upper:]')" "source $installer"
done

echo ""
echo "Installation Summary:"
show_state
