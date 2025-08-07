#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd "$SCRIPT_DIR" || exit 1

if [ -x "./node_modules/.bin/electron" ]; then
  ./node_modules/.bin/electron .
elif command -v electron >/dev/null 2>&1; then
  electron .
else
  echo "Error: Electron not found. Please install it."
  exit 1
fi
