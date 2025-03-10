#!/bin/bash
set -e

# Variables
VUNDLE_DIR="$HOME/.vim/bundle/Vundle.vim"
VIMRC_FILE="$HOME/.vimrc"
VIMRC_URL="https://raw.githubusercontent.com/alecksmart/simple-vim-settings/refs/heads/main/vimrc"
COC_DIR="$HOME/.vim/bundle/coc.nvim"

# 1. Install Vundle if not installed
if [ ! -d "$VUNDLE_DIR" ]; then
  echo "Vundle not found. Installing Vundle..."
  git clone https://github.com/VundleVim/Vundle.vim.git "$VUNDLE_DIR"
else
  echo "Vundle is already installed."
fi

# 2. Backup existing .vimrc if it exists
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

# 4. Install plugins, update existing ones, and clean unused plugins.
echo "Installing and updating vim plugins..."
vim +PluginInstall +PluginUpdate +qall
vim +PluginClean! +qall

# 5. If running on macOS, build coc.nvim and install extensions automatically.
if [[ "$(uname)" == "Darwin" ]]; then
  echo "Detected macOS, checking for Node.js..."
  if ! command -v node >/dev/null 2>&1; then
    echo "Error: Node.js is required for building coc.nvim. Please install Node.js and rerun the script."
    exit 1
  fi
  echo "Node.js is installed."

  # Ensure coc.nvim is actually present
  if [ ! -d "$COC_DIR" ]; then
    echo "coc.nvim directory not found. Attempting plugin install again..."
    vim +PluginInstall +qall
  fi

  # If package.json is present, install dependencies & build
  if [ -f "$COC_DIR/package.json" ]; then
    echo "Building coc.nvim..."
    cd "$COC_DIR"
    npm ci
    npm run build
    cd - >/dev/null
  else
    echo "No package.json found in $COC_DIR, skipping npm install."
  fi

  echo "Installing coc.nvim extensions..."
  vim -E -s +CocInstall\ -sync\ coc-html\ coc-css\ coc-tsserver\ coc-json\ coc-eslint +qall
fi

echo "Installation complete. Periodically update plugins with 'vim +PluginUpdate +qall'."

