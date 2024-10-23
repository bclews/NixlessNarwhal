# To use this script, you will need to generate a GitHub Personal Access Token (PAT)
#   1. Go to GitHub Token Settings via https://github.com/settings/tokens
#   2. Click "Generate new token" and give it a descriptive name (e.g., "SSH Key Script").
#   3. Under "Select scopes," check the box for admin:public_key.
#   4. Generate the token and save it somewhere secure (you'll use it in the script).

# Exit script immediately if a command fails
set -e

# Function to install git
install_git() {
  echo "Installing git..."
  sudo apt-get update >/dev/null
  sudo apt-get install -y git curl >/dev/null
}

# Function to generate SSH keys
generate_ssh_key() {
  echo "Checking if SSH keys exist..."
  if [ -f "$HOME/.ssh/id_rsa.pub" ]; then
    echo "SSH key already exists."
  else
    echo "Generating a new SSH key..."
    ssh-keygen -t rsa -b 4096 -C "$1"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa
  fi
}

# Function to display SSH public key
show_ssh_key() {
  echo "Your SSH public key is:"
  cat ~/.ssh/id_rsa.pub
}

# Function to upload the SSH key to GitHub via API
upload_ssh_key_to_github() {
  read -p "Enter your GitHub username: " username
  read -sp "Enter your GitHub Personal Access Token: " token
  echo ""

  public_key=$(cat ~/.ssh/id_rsa.pub)
  title="SSH key for $(hostname)"

  echo "Uploading SSH key to GitHub..."

  response=$(curl -s -o /dev/null -w "%{http_code}" \
    -H "Authorization: token $token" \
    -d "{\"title\":\"$title\", \"key\":\"$public_key\"}" \
    https://api.github.com/user/keys)

  if [ "$response" == "201" ]; then
    echo "SSH key successfully added to GitHub!"
  else
    echo "Failed to add SSH key to GitHub. Response code: $response"
  fi
}

# Function to test SSH connection to GitHub
test_github_connection() {
  echo "Testing connection to GitHub..."
  ssh -T git@github.com
  if [ $? -eq 1 ]; then
    echo "SSH connection to GitHub successful!"
  else
    echo "SSH connection failed. Make sure the SSH key is added to GitHub."
  fi
}

# Function to clone a GitHub repository
clone_repository() {
  read -p "Enter the GitHub repository SSH URL to clone: " repo_url
  git clone "$repo_url"
}

# Main script
main() {
  echo "Git Installation and SSH Configuration Script"
  read -p "Enter your GitHub email for SSH key generation: " email

  install_git
  generate_ssh_key "$email"
  show_ssh_key

  upload_ssh_key_to_github

  test_github_connection

  read -p "Do you want to clone a GitHub repository now? (y/n): " clone_choice
  if [[ "$clone_choice" == "y" || "$clone_choice" == "Y" ]]; then
    clone_repository
  else
    echo "Script finished. You can now clone repositories via SSH."
  fi
}

main
