#!/bin/bash

# COLORS
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
CYAN='\033[36m'
BOLD='\033[1m'
RESET='\033[0m'

clear
echo -e "${BOLD}========================${RESET}"
echo -e "${BOLD}| WhatsLinux Installer |${RESET}"
echo -e "${BOLD}========================${RESET}"
echo

# Check if Electron is available
echo -e "${CYAN}[*] Checking for Electron...${RESET}"
if [ -x "./node_modules/.bin/electron" ]; then
  ELECTRON_BIN="./node_modules/.bin/electron"
elif command -v electron >/dev/null 2>&1; then
  ELECTRON_BIN=$(command -v electron)
else
  echo -e "${RED}[!] Error:${RESET} Electron not found. Please run ${BOLD}./install-deps.sh${RESET} first."
  exit 1
fi
echo -e "${GREEN}[✔] Electron found at: ${ELECTRON_BIN}${RESET}"
echo

# Run Electron (optional, comment out if you want install only)
# echo -e "${CYAN}[*] Launching Electron app for test...${RESET}"
# "$ELECTRON_BIN" .

# Install application files
APP_DIR="$HOME/.local/share/applications/WhatsLinux"
ICON_BASE_DIR="$HOME/.local/share/icons/hicolor"
DESKTOP_FILE_SRC="src/whatslinux.desktop"

echo -e "${CYAN}[*] Installing application files...${RESET}"

mkdir -p "$APP_DIR" || { echo -e "${RED}[!] Failed to create app directory.${RESET}"; exit 1; }

cp src/main.js "$APP_DIR/" || { echo -e "${RED}[!] Failed to copy main.js.${RESET}"; exit 1; }
cp src/package.json "$APP_DIR/" || { echo -e "${RED}[!] Failed to copy package.json.${RESET}"; exit 1; }
cp src/WhatsLinux.sh "$APP_DIR/" || { echo -e "${RED}[!] Failed to copy WhatsLinux.sh.${RESET}"; exit 1; }

echo -e "${GREEN}[✔] App files copied.${RESET}"

# Create icons target directories and copy icons
echo -e "${CYAN}[*] Installing icons...${RESET}"
for size in 16 24 32 48 64 128 256; do
  ICON_SRC="src/icons/icon-${size}x${size}.png"
  ICON_DST="$ICON_BASE_DIR/${size}x${size}/apps"
  mkdir -p "$ICON_DST" || { echo -e "${RED}[!] Failed to create icon directory: $ICON_DST${RESET}"; exit 1; }
  cp "$ICON_SRC" "$ICON_DST/whatslinux.png" || { echo -e "${RED}[!] Failed to copy icon size ${size}.${RESET}"; exit 1; }
done
echo -e "${GREEN}[✔] Icons installed.${RESET}"

# Patch .desktop file for Exec and Icon
echo -e "${CYAN}[*] Configuring desktop file...${RESET}"

DESKTOP_TMP="$APP_DIR/whatslinux.desktop"

cp "$DESKTOP_FILE_SRC" "$DESKTOP_TMP" || { echo -e "${RED}[!] Failed to copy desktop file.${RESET}"; exit 1; }

# Calculate absolute paths for Exec and Icon
EXEC_PATH="$APP_DIR/WhatsLinux.sh"
ICON_PATH="$ICON_BASE_DIR/256x256/apps/whatslinux.png"

# Use sed to replace REPLACEME placeholders
sed -i "s|Exec=REPLACEME|Exec=${EXEC_PATH}|g" "$DESKTOP_TMP"
sed -i "s|Icon=REPLACEME|Icon=${ICON_PATH}|g" "$DESKTOP_TMP"

# Move desktop file to user applications directory (one level up from $APP_DIR)
DESKTOP_INSTALL_DIR="$HOME/.local/share/applications"
mkdir -p "$DESKTOP_INSTALL_DIR" || { echo -e "${RED}[!] Failed to create desktop file directory.${RESET}"; exit 1; }
mv "$DESKTOP_TMP" "$DESKTOP_INSTALL_DIR/whatslinux.desktop" || { echo -e "${RED}[!] Failed to move desktop file.${RESET}"; exit 1; }

echo -e "${GREEN}[✔] Desktop entry installed.${RESET}"

# Final message
echo
echo -e "${BOLD}${GREEN}🎉 WhatsLinux installation complete! 🎉${RESET}"
echo -e "${CYAN}You can now find WhatsLinux in your application launcher.${RESET}"
