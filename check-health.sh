#!/bin/bash

# ANSI Color Codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}--- Workspace Health Check ---${NC}"

# Function to check command existence and version
check_version() {
    if command -v $1 &> /dev/null; then
        version=$($1 $2 2>&1)
        echo -e "[${GREEN}OK${NC}] $1 is installed ($version)"
        return 0
    else
        echo -e "[${RED}FAIL${NC}] $1 is NOT installed or not in PATH"
        return 1
    fi
}

# 1. Check Core Tools
echo -e "\n${YELLOW}Checking Runtimes & Managers:${NC}"
check_version "node" "-v"
check_version "fnm" "--version"
check_version "pnpm" "-v"
check_version "git" "--version"

# 2. Check Firewall Status
echo -e "\n${YELLOW}Checking Firewall (UFW):${NC}"
if sudo ufw status | grep -q "Status: active"; then
    echo -e "[${GREEN}OK${NC}] Firewall is Active"
    # Check specifically for port 3000
    if sudo ufw status | grep -q "3000/tcp"; then
        echo -e "     - Port 3000 is open for Next.js"
    else
        echo -e "     - ${RED}Warning: Port 3000 is closed${NC}"
    fi
else
    echo -e "[${RED}FAIL${NC}] Firewall is NOT active"
fi

# 3. Check System Optimizations
echo -e "\n${YELLOW}Checking System Limits:${NC}"
max_watches=$(cat /proc/sys/fs/inotify/max_user_watches)
if [ "$max_watches" -ge 524288 ]; then
    echo -e "[${GREEN}OK${NC}] Inotify watches are optimized ($max_watches)"
else
    echo -e "[${RED}FAIL${NC}] Inotify watches are low ($max_watches). HMR might fail."
fi

# 4. Check Aliases
echo -e "\n${YELLOW}Checking Shell Config:${NC}"
if grep -q "alias dev=" ~/.bashrc; then
    echo -e "[${GREEN}OK${NC}] 'dev' alias found in .bashrc"
else
    echo -e "[${YELLOW}INFO${NC}] 'dev' alias not found (Optional)"
fi

echo -e "\n${YELLOW}--- End of Health Check ---${NC}"
