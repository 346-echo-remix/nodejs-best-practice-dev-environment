optimize_performance() {
    echo "------------------------------------------------"
    echo "🛠️  Optimizing VM Performance for Next.js..."
    echo "------------------------------------------------"

    # 1. Increase Inotify Watcher Limits
    # This prevents 'Every step you take' errors in large Node projects
    echo "Increasing system file watcher limits..."
    
    # Check if the setting already exists to avoid duplicates
    if ! grep -q "fs.inotify.max_user_watches" /etc/sysctl.conf; then
        echo "fs.inotify.max_user_watches=524288" | sudo tee -a /etc/sysctl.conf
        sudo sysctl -p
        echo "✅ Inotify limits updated."
    else
        echo "ℹ️  Inotify limits already configured."
    fi

    # 2. Install htop for resource monitoring
    echo "Installing htop for process management..."
    sudo apt install -y htop

    # 3. Create a helpful alias for the developer
    if ! grep -q "alias dev" ~/.bashrc; then
        echo "alias dev='pnpm dev'" >> ~/.bashrc
        echo "✅ Added 'dev' alias to .bashrc"
    fi

    echo "------------------------------------------------"
    echo "🚀 Performance Optimization Complete!"
    echo "------------------------------------------------"
}
