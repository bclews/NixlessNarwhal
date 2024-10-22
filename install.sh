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

sudo apt-get update >/dev/null
sudo apt-get install -y git >/dev/null

echo "Cloning NixlessNarwhal..."
rm -rf ~/.local/share/NixlessNarwhal
# git clone https://github.com/bclews/NixlessNarwhal.git ~/.local/share/NixlessNarwhal >/dev/null
git clone git@github.com:bclews/NixlessNarwhal.git ~/.local/share/NixlessNarwhal >/dev/null

echo "Installation starting..."
# Check the distribution name and version and abort if incompatible
source ~/.local/share/NixlessNarwhal/install/check-version.sh

# Install terminal tools
source ~/.local/share/NixlessNarwhal/install/terminal.sh
