#!/bin/bash

# --- 1. Safety & Environment Settings ---
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ANSI Color Codes for a "Rich CLI" look
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# --- 2. Component Verification ---
COMPONENTS=("prepare-sys.sh" "install-node.sh" "setup-pnpm.sh" "linux-kernel-opt.sh")

verify_and_load() {
    for component in "${COMPONENTS[@]}"; do
        FILE_PATH="$SCRIPT_DIR/$component"
        if [[ -f "$FILE_PATH" ]]; then
            source "$FILE_PATH"
        else
            echo -e "${RED}❌ Error: $component missing in $SCRIPT_DIR${NC}"
            exit 1
        fi
    done
}

# --- 3. Interactive Menu ---
show_menu() {
    clear
    echo -e "${BLUE}==============================================${NC}"
    echo -e "${BLUE}   🚀 NEXT.JS DEBIAN WORKSPACE INSTALLER      ${NC}"
    echo -e "${BLUE}==============================================${NC}"
    echo -e "Please select an option:"
    echo ""

    options=(
        "Full Setup (Standard Recommendation)"
        "System Prep & Firewall Only"
        "Node.js & pnpm Only"
        "Performance Optimizations Only"
        "Quit"
    )

    select opt in "${options[@]}"; do
        case $opt in
            "Full Setup (Standard Recommendation)")
                echo -e "${YELLOW}▶ Starting Full Setup...${NC}"
                prepare_system
                install_node_environment
                setup_pnpm
                optimize_performance
                break
                ;;
            "System Prep & Firewall Only")
                prepare_system
                break
                ;;
            "Node.js & pnpm Only")
                install_node_environment
                setup_pnpm
                break
                ;;
            "Performance Optimizations Only")
                optimize_performance
                break
                ;;
            "Quit")
                echo "Exiting..."
                exit 0
                ;;
            *) 
                echo -e "${RED}Invalid option $REPLY${NC}"
                ;;
        esac
    done
}

# --- 4. Execution ---
verify_and_load
show_menu

echo -e "\n${GREEN}------------------------------------------------${NC}"
echo -e "${GREEN}✅ TASK COMPLETED SUCCESSFULLY${NC}"
echo -e "${GREEN}------------------------------------------------${NC}"
echo -e "1. Run: ${YELLOW}source ~/.bashrc${NC}"
echo -e "2. Start Coding: ${YELLOW}pnpm create next-app@latest${NC}"
