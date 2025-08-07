#!/bin/bash

# Colors
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
CYAN='\033[36m'
BOLD='\033[1m'
RESET='\033[0m'

clear
echo -e "${BOLD}=== Install Dependencies ===${RESET}"
echo -e "${CYAN}[i] What are dependencies? These are tools that WhatsLinux relies on for installation.${RESET}"
read -rp "${YELLOW}[?] Hit enter to start installing. > ${RESET}" varidk

clear
echo -e "${BOLD}${CYAN}[*] Installing Electron globally...${RESET}"
sudo npm install -g electron
if [ $? -ne 0 ]; then
  echo -e "${RED}[!] Failed to install Electron. Do you have a internet connection or npm installed?${RESET}"
  exit 1
fi

echo -e "${BOLD}${CYAN}[*] Fixing permissions for chrome-sandbox...${RESET}"
sudo chown root:root /usr/local/lib/node_modules/electron/dist/chrome-sandbox
if [ $? -ne 0 ]; then
  echo -e "${RED}[!] Failed to change ownership of chrome-sandbox. Are you running this script with sudo?${RESET}"
  exit 1
fi

sudo chmod 4755 /usr/local/lib/node_modules/electron/dist/chrome-sandbox
if [ $? -ne 0 ]; then
  echo -e "${RED}[!] Failed to set permissions on chrome-sandbox.${RESET}"
  exit 1
fi

clear
echo -e "${GREEN}[✔] Dependencies have been installed.${RESET}"
echo -e "${CYAN}You can now run ${BOLD}install.sh${RESET}${CYAN} to continue.${RESET}"

