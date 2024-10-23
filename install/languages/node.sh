# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

# Source the nvm script to add it to the current shell session
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Install the latest LTS version of Node.js
nvm install --lts

# Use the installed LTS version of Node.js
nvm use --lts

# # Check the installed versions of Node.js and npm
# node -v
# npm -v
#
# # Update npm to the latest version globally
# npm install -g npm
#
# # Fix potential permission issues with the .npm directory
# sudo chown -R $(whoami):$(whoami) "$HOME/.npm"
#
# # Re-attempt to update npm globally after fixing permissions
# npm install -g npm
#
# # Confirm the npm update
# npm -v
