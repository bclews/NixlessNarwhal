# Exit immediately if a command exits with a non-zero status
set -e

ascii_art='
▄▀▀▄ ▀▄  ▄▀▀█▀▄   ▄▀▀▄  ▄▀▄  ▄▀▀▀▀▄     ▄▀▀█▄▄▄▄  ▄▀▀▀▀▄  ▄▀▀▀▀▄
█  █ █ █ █   █  █ █    █   █ █    █     ▐  ▄▀   ▐ █ █   ▐ █ █   ▐
▐  █  ▀█ ▐   █  ▐ ▐     ▀▄▀  ▐    █       █▄▄▄▄▄     ▀▄      ▀▄
  █   █      █         ▄▀ █      █        █    ▌  ▀▄   █  ▀▄   █
▄▀   █    ▄▀▀▀▀▀▄     █  ▄▀    ▄▀▄▄▄▄▄▄▀ ▄▀▄▄▄▄    █▀▀▀    █▀▀▀
█    ▐   █       █  ▄▀  ▄▀     █         █    ▐    ▐       ▐
▐        ▐       ▐ █    ▐      ▐         ▐
 ▄▀▀▄ ▀▄  ▄▀▀█▄   ▄▀▀▄▀▀▀▄  ▄▀▀▄    ▄▀▀▄  ▄▀▀▄ ▄▄   ▄▀▀█▄   ▄▀▀▀▀▄
█  █ █ █ ▐ ▄▀ ▀▄ █   █   █ █   █    ▐  █ █  █   ▄▀ ▐ ▄▀ ▀▄ █    █
▐  █  ▀█   █▄▄▄█ ▐  █▀▀█▀  ▐  █        █ ▐  █▄▄▄█    █▄▄▄█ ▐    █
  █   █   ▄▀   █  ▄▀    █    █   ▄    █     █   █   ▄▀   █     █
▄▀   █   █   ▄▀  █     █      ▀▄▀ ▀▄ ▄▀    ▄▀  ▄▀  █   ▄▀    ▄▀▄▄▄▄▄▄▀
█    ▐   ▐   ▐   ▐     ▐            ▀     █   █    ▐   ▐     █
▐                                         ▐   ▐              ▐
'

echo -e "$ascii_art"
echo "=> NixlessNarwhal is for fresh Ubuntu 22.04 installations only!"
echo -e "\nBegin installation (or abort with ctrl+c)..."

# Update package list
sudo apt-get update >/dev/null

echo "Installling required libraries..."
source install/required/libraries.sh

echo "Configuring SSH keys, and sets up GitHub for cloning repositories via SSH..."
source install/required/git-ssh.sh

echo "Installing zsh and Oh My Zsh..."
source install/required/zsh.sh

echo "Installation starting..."
# Check the distribution name and version and abort if incompatible
source ~/.local/share/NixlessNarwhal/install/check-version.sh

# Install terminal tools
source ~/.local/share/NixlessNarwhal/install/terminal.sh
