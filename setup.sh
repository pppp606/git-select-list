#!/bin/bash

SCRIPT_PATH="./scripts/git-select-list.sh"

if [ ! -f "$SCRIPT_PATH" ]; then
  echo "Error: $SCRIPT_PATH not found. Please ensure the script exists."
  exit 1
fi

chmod +x "$SCRIPT_PATH"
echo "Made $SCRIPT_PATH executable."

git config --global alias.ls "!sh $(pwd)/$SCRIPT_PATH"
echo "Git alias 'git ls' has been configured."

echo "Setup complete 🎉🎉🎉🎉🎉🎉"
echo "You can now use 'git ls' to interactively select files to add and stash."
