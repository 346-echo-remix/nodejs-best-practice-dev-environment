prepare_system() {
    echo "------------------------------------------------"
    echo "🚀 Starting Debian 12 System Preparation..."
    echo "------------------------------------------------"

    # 1. Update and Upgrade System
    echo "Updating package lists and upgrading existing packages..."
    sudo apt update && sudo apt upgrade -y

    # 2. Install Essential Build Tools
    echo "Installing build-essential, curl, git, and dependencies..."
    sudo apt install -y \
        build-essential \
        curl \
        git \
        wget \
	unzip \
        procps \
        libssl-dev \
        ufw

    # 3. Firewall Configuration
    echo "Configuring UFW (Uncomplicated Firewall)..."

    # Allow SSH first so you don't get locked out of your VM
    sudo ufw allow 22/tcp

    # Allow Next.js default development port
    sudo ufw allow 3000/tcp

    # Enable the firewall
    # 'force' flag skips the interactive [y/n] confirmation
    echo "Enabling firewall..."
    sudo ufw --force enable

    echo "------------------------------------------------"
    echo "✅ System Preparation Complete!"
    echo "SSH (22) and Next.js (3000) ports are open."
    echo "------------------------------------------------"

    # Display firewall status for verification
    sudo ufw status
}
