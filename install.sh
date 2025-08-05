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
echo "=> NixlessNarwhal is a tool to automate the setup of a new headless Ubuntu installation."
echo -e "\nBegin installation (or abort with ctrl+c)..."

sudo apt-get update >/dev/null

echo "Moving home directory to a new location..."
source install/required/move-home.sh

echo "Installling required libraries..."
source install/required/libraries.sh

echo "Configuring SSH keys, and sets up GitHub for cloning repositories via SSH..."
source install/required/git-ssh.sh

echo "Installing zsh and Oh My Zsh..."
source install/required/zsh.sh

echo "Installation apps..."
for installer in install/apps/*.sh; do source $installer; done
