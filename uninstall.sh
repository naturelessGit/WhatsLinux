#!/bin/bash

# COLORS (add these so variables work!)
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
CYAN='\033[36m'
BOLD='\033[1m'
RESET='\033[0m'

clear
echo -e "${BOLD}==========================${RESET}"
echo -e "${BOLD}| WhatsLinux Uninstaller |${RESET}"
echo -e "${BOLD}==========================${RESET}"
echo

# Remove application files
APP_DIR="$HOME/.local/share/applications/WhatsLinux"
echo -e "${CYAN}[*] Removing application files...${RESET}"
if [ -d "$APP_DIR" ]; then
    rm -rf "$APP_DIR" || { echo -e "${RED}[!] Failed to remove app directory.${RESET}"; exit 1; }
    echo -e "${GREEN}[✔] Application files removed.${RESET}"
else
    echo -e "${YELLOW}[!] No application files found to remove.${RESET}"
fi  

# Remove desktop entry file
DESKTOP_FILE="$HOME/.local/share/applications/whatslinux.desktop"
if [ -f "$DESKTOP_FILE" ]; then
    echo -e "${CYAN}[*] Removing desktop entry...${RESET}"
    rm "$DESKTOP_FILE" || { echo -e "${RED}[!] Failed to remove desktop entry.${RESET}"; exit 1; }
    echo -e "${GREEN}[✔] Desktop entry removed.${RESET}"
else
    echo -e "${YELLOW}[!] No desktop entry found to remove.${RESET}"
fi

# Remove icons
ICON_BASE_DIR="$HOME/.local/share/icons/hicolor"
echo -e "${CYAN}[*] Removing icons...${RESET}"
for size in 16 24 32 48 64 128 256; do
    ICON_DST="$ICON_BASE_DIR/${size}x${size}/apps/whatslinux.png"
    if [ -f "$ICON_DST" ]; then
        rm "$ICON_DST" || { echo -e "${RED}[!] Failed to remove icon size ${size}.${RESET}"; exit 1; }
        echo -e "${GREEN}[✔] Icon size ${size} removed.${RESET}"
    else
        echo -e "${YELLOW}[!] No icon size ${size} found to remove.${RESET}"
    fi
done

echo -e "\n${GREEN}[✔] WhatsLinux has been completely uninstalled.${RESET}"
