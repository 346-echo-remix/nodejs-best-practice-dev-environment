# Quick Start:

chmod +x *.sh
./setup-workspace.sh

# Function Summary:

1. prepare_system: added a local variable check to ensure the script stops if a critical installation fails.

Pro-Tip for Debian 12

    When running this in a "Main" script, it is often helpful to add export DEBIAN_FRONTEND=noninteractive at the very top of your file. This prevents Debian from showing purple pop-up screens (like kernel update notifications) that can hang a script during the apt upgrade phase.

2. install_node_environment: I have kept the internal export and eval commands. These are critical when running as a function because they allow the rest of your master script to use node and npm immediately without requiring you to manually restart the terminal mid-script.

> Since this function modifies the $PATH of the running script, you should call it before any function that requires Node.js (like your pnpm installer).

A Quick Tip on "fnm env"

Inside the function, I used eval "$(fnm env)". In Bash, eval executes the output of a command. Since fnm env outputs the shell commands needed to set up your paths, eval effectively "plugs" Node.js into your current running script instantly

3. setup_pnpm: I have updated the error handling slightly: instead of exit 1 (which would kill your entire master script), the function will return an error code if Node is missing, allowing your master script to fail gracefully.

Pro-Tip: Sudo and Corepack

In Debian 12, depending on how your user permissions are set, corepack enable might occasionally require sudo to symlink the binaries into /usr/local/bin. I've included sudo in the function above to ensure it doesn't hang on a "Permission Denied" error during your first run.

4. check-health.sh: "final touch" for a professional setup. It acts as a diagnostic tool that you can run any time you feel the VM is acting up, or simply to confirm a successful installation.

This script checks for the existence of binaries, verifies versions, and pings the local ports to ensure the firewall isn't blocking your own dev server.

# How to use the full suite

The complete modular system, here is how you should organize your files on the Debian 12 VM:

File Name	            | Responsibility
setup-workspace.sh	    | The Master Script (The TUI-style menu).
prepare-sys.sh	        | Updates Debian, installs build tools, and sets up UFW.
install-node.sh	        | Installs fnm and sets the Node LTS.
setup-pnpm.sh	        | Enables corepack and activates pnpm.
linux-kernel-opt.sh	    | Fixes file watcher limits and installs htop.
check-health.sh	        | Verifies everything above is still working.

# Final Step: Make everything executable

Run this command once in your folder:
chmod +x *.sh

Then, simply run ./setup-workspace.sh to build the machine, and ./check-health.sh whenever you want to verify it.

----- 
Final Notes:
    >> By default, Debian has a low limit on how many files the kernel can monitor. When you run next dev, the thousands of files in node_modules can exceed this limit, leading to "ENOSPC" errors or broken Hot Module Replacement (HMR).
    >> I have also included htop in this function to ensure you have a professional way to monitor your VM's resources.

    ** Why these performance tweaks matter: **

    Inotify: Without this, next dev might stop reflecting your code changes in the browser after your project grows.

    htop: Next.js (especially when using Turbopack) is fast but can be memory-intensive. htop allows you to see exactly how much RAM your Node process is consuming in real-time.

    The Alias: It’s a small touch, but typing dev instead of pnpm run dev over a 12-hour coding session is a major quality-of-life win.

# Best Practices for Running the Execute Script

    Permissions: Before running, ensure all files (the master and the components) are executable:
    chmod +x *.sh

    User Context: Run this as your standard user, not as root. The script uses sudo internally where necessary. Running the whole thing as root can cause permission issues with your Node.js configuration files in your home directory.

    Run Command:
    ./setup-workspace.sh

# Why this structure is "Safe":

    set -euo pipefail: This is the "Bash Strict Mode." If any part of a piped command fails, the whole script stops immediately, preventing a "cascade" of errors.

    SCRIPT_DIR: This ensures that even if you run the script from a different folder (e.g., bash /home/user/scripts/setup-workspace.sh), it will correctly find the other .sh files in their relative locations.

    Modular Loading: By separating the logic, if you ever need to update just the Node.js version manager or just the firewall rules, you only have to edit one small file.

-----

# Why this is better than a TUI:

    Zero Dependencies: It runs on a vanilla Debian 12 install without needing apt install dialog.

    Keyboard Navigation: You just type 1, 2, or 3 and hit Enter.

    Color Guidance: The use of YELLOW for "In Progress" and GREEN for "Success" provides immediate visual feedback.

    Modular: If you decide to add a 5th script (e.g., docker-setup.sh), you just add it to the COMPONENTS array and the case statement.
