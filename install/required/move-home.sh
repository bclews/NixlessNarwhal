#!/bin/bash

# Load configuration
# shellcheck source=../../config.sh
source ~/.local/share/NixlessNarwhal/config.sh

# Step 1: Create the new home directory if it doesn't exist
if [ ! -d "$NEW_HOME" ]; then
  echo "Creating new home directory at $NEW_HOME"
  sudo mkdir -p "$NEW_HOME"
  sudo chown "${USER}:${USER}" "$NEW_HOME" # Ensure the new directory is owned by the user
fi

# Step 2: Move the contents of the current home directory to the new home
echo "Moving contents of $OLD_HOME to $NEW_HOME"
sudo rsync -a --info=progress2 "$OLD_HOME/" "$NEW_HOME/"
sudo chown -R "${USER}:${USER}" "$NEW_HOME" # Fix ownership of files copied

# Step 3: Update the home directory in /etc/passwd
echo "Updating home directory in /etc/passwd"
sudo sed -i "s|${OLD_HOME}|${NEW_HOME}|g" /etc/passwd

# Step 4: Update environment variables
echo "Updating environment variables"
{
  echo "export HOME=${NEW_HOME}"
  echo "export XDG_CACHE_HOME=${NEW_HOME}/.cache"
  echo "export XDG_CONFIG_HOME=${NEW_HOME}/.config"
  echo "export XDG_DATA_HOME=${NEW_HOME}/.local/share"
} >>"$NEW_HOME/.bashrc"

echo "Setup complete. The new environment will be available after you log out and log back in."

