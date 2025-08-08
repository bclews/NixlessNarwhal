#!/bin/bash
set -e

# Load state management functions if not already loaded
if ! command -v command_exists >/dev/null 2>&1; then
    # shellcheck source=../state.sh
    source ~/.local/share/NixlessNarwhal/install/state.sh
fi

# Check if Docker is already installed and configured
if command_exists docker && apt_package_installed docker-ce && user_in_group docker && systemctl is-active docker >/dev/null 2>&1; then
    return 0
fi

# Add the official Docker repo if not present
if [ ! -f /etc/apt/sources.list.d/docker.list ]; then
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo wget -qO /etc/apt/keyrings/docker.asc https://download.docker.com/linux/ubuntu/gpg
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    # shellcheck disable=SC1091
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
    sudo apt-get update >/dev/null
fi

# Install Docker engine and standard plugins if not present
if ! apt_package_installed docker-ce; then
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras >/dev/null
fi

# Give this user privileged Docker access if not already in group
if ! user_in_group docker; then
    sudo usermod -aG docker "${USER}"
fi

# Configure Docker daemon logging if not already configured
if [ ! -f /etc/docker/daemon.json ] || ! grep -q "log-driver" /etc/docker/daemon.json; then
    echo '{"log-driver":"json-file","log-opts":{"max-size":"10m","max-file":"5"}}' | sudo tee /etc/docker/daemon.json >/dev/null
fi

# Start and enable Docker service if not running
if ! systemctl is-active docker >/dev/null 2>&1; then
    sudo systemctl start docker >/dev/null
fi
if ! systemctl is-enabled docker >/dev/null 2>&1; then
    sudo systemctl enable docker >/dev/null
fi
