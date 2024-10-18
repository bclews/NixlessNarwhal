# Exit immediately if a command exits with a non-zero status
set -e

# Check the distribution name and version and abort if incompatible
source ~/.local/share/NixlessNarwhal/install/check-version.sh

# Install terminal tools
source ~/.local/share/NixlessNarwhal/install/terminal.sh

