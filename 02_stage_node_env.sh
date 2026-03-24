#!/bin/bash

# Exit on error
set -e

echo "------------------------------------------------"
echo "🚀 Installing fnm (Fast Node Manager)..."
echo "------------------------------------------------"

# 1. Install fnm via the official script
# We use --skip-shell to manually control the configuration for better reliability
curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell

# 2. Set up environment variables for the current session
# This allows the script to continue using fnm without restarting the terminal
export FNM_DIR="$HOME/.local/share/fnm"
if [[ ":$PATH:" != *":$FNM_DIR:"* ]]; then
  export PATH="$FNM_DIR:$PATH"
fi
eval "`fnm env`"

# 3. Update .bashrc for future sessions
# We check if fnm env is already there to avoid duplicate entries
if ! grep -q 'fnm env' ~/.bashrc; then
    echo 'export PATH="$HOME/.local/share/fnm:$PATH"' >> ~/.bashrc
    echo 'eval "`fnm env --use-on-cd`"' >> ~/.bashrc
    echo "✅ Added fnm to .bashrc"
fi

# 4. Install and use the latest Node.js LTS
echo "Installing Node.js LTS..."
fnm install --lts
fnm use lts-latest

# 5. Verification
NODE_VERSION=$(node -v)
echo "------------------------------------------------"
echo "✅ Node.js Environment Ready!"
echo "Node version: $NODE_VERSION"
echo "fnm version: $(fnm --version)"
echo "------------------------------------------------"
echo "NOTE: Run 'source ~/.bashrc' or restart your terminal to finalize."
