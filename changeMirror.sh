#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Define variables
sources_list="/etc/apt/sources.list"
backup_file="$sources_list.bak"

# Backup /etc/apt/sources.list to the same directory as sources.list.bak
sudo cp "$sources_list" "$backup_file"

# Tsinghua University mirrors for Debian 12 Bookworm
echo "# By default, source mirrors are commented out to improve apt update speed. Uncomment if needed.
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware

deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware

deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware

deb https://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
# deb-src https://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware

deb https://deb.debian.org/debian/ bookworm non-free-firmware contrib main non-free" > "$sources_list"

# Update apt
if sudo apt update && sudo apt upgrade -y; then
    echo "System update and upgrade successful."
else
    echo "Error: System update or upgrade failed."
    exit 1
fi

# Add additional steps and error handling if needed
