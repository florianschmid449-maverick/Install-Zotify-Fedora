#!/bin/bash

# ==============================================================================
# Zotify Installer for Fedora Linux (Updated)
# ==============================================================================
# Source: https://github.com/zotify-dev/zotify
# ==============================================================================

# --- Configuration ---
# Updated to the zotify-dev repository
ZOTIFY_REPO="git+https://github.com/zotify-dev/zotify.git"

# Text Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting Zotify Installer (zotify-dev) for Fedora...${NC}"

# --- Step 1: Check for Sudo/Root ---
if [ "$EUID" -ne 0 ]; then 
    echo -e "${YELLOW}Please run this script with sudo to install system dependencies.${NC}"
    echo "Usage: sudo ./install_zotify_fedora.sh"
    exit 1
fi

# --- Step 2: Update DNF Metadata ---
echo -e "${GREEN}[+] Updating package repositories...${NC}"
dnf check-update > /dev/null 2>&1

# --- Step 3: Install System Dependencies ---
echo -e "${GREEN}[+] Installing Python3, Pipx, and Git...${NC}"
dnf install -y python3 python3-pip pipx git

# --- Step 4: Handle FFmpeg ---
echo -e "${GREEN}[+] Checking FFmpeg status...${NC}"

if dnf list installed ffmpeg >/dev/null 2>&1; then
    echo -e "${GREEN}    Full FFmpeg is already installed.${NC}"
elif dnf list installed ffmpeg-free >/dev/null 2>&1; then
    echo -e "${YELLOW}    'ffmpeg-free' is installed. Note: Proprietary codecs might be limited.${NC}"
else
    echo "    Attempting to install FFmpeg..."
    if dnf install -y ffmpeg 2>/dev/null; then
        echo -e "${GREEN}    Successfully installed full FFmpeg.${NC}"
    else
        echo -e "${YELLOW}    Full 'ffmpeg' not found. Installing 'ffmpeg-free' from default repos...${NC}"
        dnf install -y ffmpeg-free
    fi
fi

# --- Step 5: Install Zotify via Pipx ---
REAL_USER=${SUDO_USER:-$USER}
REAL_HOME=$(getent passwd "$REAL_USER" | cut -d: -f6)

echo -e "${GREEN}[+] Installing Zotify for user: $REAL_USER...${NC}"

# Run pipx as the real user
sudo -u "$REAL_USER" bash <<EOF
    pipx ensurepath > /dev/null

    # We use --force to overwrite any existing installation with this specific repo
    echo "    Installing/Updating Zotify from zotify-dev..."
    pipx install --force "$ZOTIFY_REPO"
EOF

# --- Step 6: Completion ---
echo -e "----------------------------------------------------------------"
echo -e "${GREEN}Installation Complete!${NC}"
echo -e "----------------------------------------------------------------"
echo -e "Repo used: zotify-dev/zotify"
echo -e "Run with: ${GREEN}zotify${NC}"
echo -e "----------------------------------------------------------------"
