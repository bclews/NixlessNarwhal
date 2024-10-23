# Yeah, so uh, not entirely nixless!
# Some random packages require it.

# Install Nix
curl -L https://nixos.org/nix/install | sh

# Source the Nix profile script
. /home/your_user/.nix-profile/etc/profile.d/nix.sh

# Source the bashrc to ensure the environment is updated
source ~/.bashrc

# Verify the installation
nix --version
