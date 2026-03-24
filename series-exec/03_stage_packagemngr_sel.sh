#!/bin/bash

# Exit on error
set -e

echo "------------------------------------------------"
echo "📦 Setting up pnpm via Corepack..."
echo "------------------------------------------------"

# 1. Ensure Node.js is available in the current subshell
# This is necessary if the user hasn't restarted their shell after the last script
if ! command -v node &> /dev/null; then
    echo "❌ Error: Node.js not found."
    echo "Please run 'source ~/.bashrc' first, then run this script."
    exit 1
fi

# 2. Enable Corepack
# Corepack is included with Node.js 16.13+ and handles pnpm/yarn versions
echo "Enabling Corepack..."
sudo corepack enable

# 3. Prepare and activate the latest pnpm
echo "Downloading and activating the latest pnpm..."
corepack prepare pnpm@latest --activate

# 4. Configure pnpm shell completion (Optional but highly recommended)
if ! grep -q 'pnpm' ~/.bashrc; then
    echo "Configuring pnpm shell completion..."
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
echo "You can now run: pnpm create next-app@latest"
