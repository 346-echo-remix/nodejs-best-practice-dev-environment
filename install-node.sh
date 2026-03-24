install_node_environment() {
    echo "------------------------------------------------"
    echo "🚀 Installing fnm (Fast Node Manager)..."
    echo "------------------------------------------------"

    # 1. Install fnm via the official script
    # -s -- --skip-shell prevents the installer from messy auto-edits
    curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell

    # 2. Set up environment variables for the CURRENT script session
    # This is vital so subsequent functions (like pnpm setup) can find 'node'
    export FNM_DIR="$HOME/.local/share/fnm"
    if [[ ":$PATH:" != *":$FNM_DIR:"* ]]; then
        export PATH="$FNM_DIR:$PATH"
    fi
    eval "`fnm env`"

    # 3. Update .bashrc for FUTURE sessions
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
}
