# 🚀 Next.js Debian 12 Dev-Workspace

A modular, high-performance automation suite for provisioning a professional development environment on **Debian 12 (Bookworm)**. This stack is optimized for **Next.js 15+**, utilizing **fnm**, **pnpm**, and **Turbopack**.

---

## 🏗️ Architecture Overview

This workspace moves away from "monolithic" install scripts. By using a modular architecture, you can update individual components (like Node.js versions or Firewall rules) without re-running the entire suite.

- **OS:** Debian 12 (Stable)
- **Version Manager:** `fnm` (Fast Node Manager) — *Built in Rust for maximum speed.*
- **Package Manager:** `pnpm` — *Utilizes content-addressable storage to save VM disk space.*
- **Performance:** Optimized `inotify` limits to prevent HMR crashes in large projects.
- **Security:** `UFW` pre-configured for SSH (22) and Next.js (3000).

---

## 📋 Prerequisites

- A cloud or local VM running **Debian 12**.
- A user account with `sudo` privileges.
- All `.sh` files from this repository stored in the same directory.

---

## ⚡ Quick Start

### 1. Prepare the files
Clone this set of scripts to your VM and ensure they are executable:

```bash
chmod +x *.sh
```

# 2. Run the Master Installer

Execute the interactive controller to begin the setup:
```
Bash

./setup-workspace.sh
```

Choose Option 1 for the full recommended installation.

## 3. Refresh Environment

Once the script completes, refresh your shell to activate fnm and pnpm:

```
Bash

source ~/.bashrc
```

## 📂 Script Directory

File	Function
- setup-workspace.sh	The Controller. Provides the TUI menu and coordinates execution.
- prepare-sys.sh	Updates OS and configures the UFW firewall.
- install-node.sh	Installs fnm, Node.js LTS, and configures shell profiles.
- setup-pnpm.sh	Enables corepack and activates the pnpm manager.
- linux-kernel-opt.sh	Increases file watcher limits and installs htop.
- check-health.sh	Diagnostic Tool. Verifies all systems are GO after installation.

## 🩺 Post-Installation Health Check

After running the setup, it is a best practice to run the health check to verify the environment's integrity:

```
Bash

./check-health.sh
```

## 💡 Pro-Tips for Developers

Creating a Project

We recommend using the pnpm initializer for the best experience on Linux VMs:

```
Bash

pnpm create next-app@latest
```

### Recommended Setup Selections

** Keep an eye on your VM's RAM and CPU usage during builds using: **

```
Bash

htop
```
#### How to leverage AI to maintain this script.

** Use these concepts to prompt AI. Share the scripts with AI to ensure future best practice. **

Key Concepts to Consider: 
Prompt	        Recommendation	Why?
TypeScript	    Yes	            Essential for 2026 type safety.
ESLint	        Yes	            Keeps code clean and catches errors early.
Tailwind CSS	Yes	            Industry standard for rapid UI development.
App Router	    Yes	            Required for modern React Server Components.
Turbopack	    Yes	            Significantly faster HMR (Hot Module Replacement).
Performance Monitoring

## 🛠️ Maintenance

    - To update Node.js: fnm install latest && fnm use latest

    - To clear pnpm cache: pnpm store prune

    - To check Firewall: sudo ufw status

## ⚖️ Disclaimer

**This repository is provided for educational and transformational purposes only.** The scripts and documentation contained herein are designed to assist **Node.js/Next.js developers** in establishing a secure and optimized development environment using **Linux Debian 12 (Bookworm)**. 

### 🛡️ Use at Your Own Risk
* **No Warranty:** The software is provided "as is", without warranty of any kind, express or implied. The author(s) make no guarantees regarding the stability, security, or suitability of these scripts for your specific hardware or use case.
* **Limitation of Liability:** In no event shall the author(s) or copyright holders be liable for any claim, damages, or other liability, whether in an action of contract, tort, or otherwise, arising from, out of, or in connection with the software or the use or other dealings in the software.
* **Responsibility:** By executing these scripts, you acknowledge that you are responsible for maintaining your own backups and system security. The author(s) are not responsible for any data loss, system downtime, or security vulnerabilities that may occur.

**Always review the code within each `.sh` file before executing it on your system.**
