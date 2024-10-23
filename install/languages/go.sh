# Remove the existing Go installation as it is likely outdated.
sudo apt remove golang-go
sudo apt remove --auto-remove golang-go

# Install the latest version of Go:
cd /tmp
wget https://go.dev/dl/go1.23.2.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.23.2.linux-amd64.tar.gz
rm go1.23.2.linux-amd64.tar.gz
cd -

# Now add the Go binary to .zshrc, if it does not already exist
if ! grep -q "export PATH=$PATH:/usr/local/go/bin" ~/.zshrc; then
  echo "export PATH=$PATH:/usr/local/go/bin" >>~/.zshrc
fi

# Source the .zshrc to apply the changes
source ~/.zshrc

# Verify the installation
go version
