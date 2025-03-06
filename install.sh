#!/bin/bash
set -e

# Variables
VUNDLE_DIR="$HOME/.vim/bundle/Vundle.vim"
VIMRC_FILE="$HOME/.vimrc"
VIMRC_URL="https://raw.githubusercontent.com/alecksmart/simple-vim-settings/refs/heads/main/vimrc"

# 1. Install Vundle if not installed
if [ ! -d "$VUNDLE_DIR" ]; then
  echo "Vundle not found. Installing Vundle..."
  git clone https://github.com/VundleVim/Vundle.vim.git "$VUNDLE_DIR"
else
  echo "Vundle is already installed."
fi

# 2. Backup existing .vimrc
if [ -f "$VIMRC_FILE" ]; then
  echo "Found existing $VIMRC_FILE, creating backup..."
  BACKUP_NUM=1
  while [ -f "${VIMRC_FILE}.bak.${BACKUP_NUM}" ]; do
    BACKUP_NUM=$((BACKUP_NUM+1))
  done
  mv "$VIMRC_FILE" "${VIMRC_FILE}.bak.${BACKUP_NUM}"
  echo "Backup created: ${VIMRC_FILE}.bak.${BACKUP_NUM}"
fi

# 3. Download new vimrc from the repo (bypassing cache)
echo "Downloading new vimrc from $VIMRC_URL..."
curl -fsSL "${VIMRC_URL}?$(date +%s)" -o "$VIMRC_FILE"
echo "New vimrc saved to $VIMRC_FILE."

echo "Installing vim plugins..."
vim +PluginClean! +qall
vim +PluginInstall +PluginUpdate +qall

echo "Installation complete. Peridically update plugins with 'vim +PluginUpdate +qall'"

