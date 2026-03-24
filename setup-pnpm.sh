setup_pnpm() {
    echo "------------------------------------------------"
    echo "📦 Setting up pnpm via Corepack..."
    echo "------------------------------------------------"

    # 1. Ensure Node.js is available in the current subshell
    # This checks if the previous install_node_environment function worked
    if ! command -v node &> /dev/null; then
        echo "❌ Error: Node.js not found in the current path."
        echo "Ensure install_node_environment runs before setup_pnpm."
        return 1
    fi

    # 2. Enable Corepack
    # corepack is bundled with Node.js and manages pnpm/yarn
    echo "Enabling Corepack..."
    sudo corepack enable

    # 3. Prepare and activate the latest pnpm
    echo "Downloading and activating the latest pnpm..."
    sudo corepack prepare pnpm@latest --activate

    # 4. Configure pnpm shell completion and PATH for future sessions
    if ! grep -q 'pnpm' ~/.bashrc; then
        echo "Configuring pnpm setup in .bashrc..."
        # pnpm setup adds the pnpm home directory to the PATH
        pnpm setup > /dev/null 2>&1
        echo "✅ pnpm setup added to .bashrc"
    fi

    # 5. Verification
    PNPM_VERSION=$(pnpm -v)
    echo "------------------------------------------------"
    echo "✅ pnpm Environment Ready!"
    echo "pnpm version: $PNPM_VERSION"
    echo "------------------------------------------------"
    echo "Your workspace is now ready for Next.js."
}
