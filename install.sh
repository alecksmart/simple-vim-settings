#!/usr/bin/env bash
set -e

# Variables
VIMRC_FILE="$HOME/.vimrc"
VIM_DIR="$HOME/.vim"
VIMRC_URL="https://raw.githubusercontent.com/alecksmart/simple-vim-settings/refs/heads/main/vimrc"
PLUG_INSTALLER="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

# 1. Backup existing ~/.vimrc (if it exists)
if [ -f "$VIMRC_FILE" ]; then
  echo "Found existing $VIMRC_FILE, creating backup..."
  BACKUP_NUM=1
  while [ -f "${VIMRC_FILE}.bak.${BACKUP_NUM}" ]; do
    BACKUP_NUM=$((BACKUP_NUM+1))
  done
  mv "$VIMRC_FILE" "${VIMRC_FILE}.bak.${BACKUP_NUM}"
  echo "Backup created: ${VIMRC_FILE}.bak.${BACKUP_NUM}"
fi

# 2. Backup existing ~/.vim directory (if it exists)
if [ -d "$VIM_DIR" ]; then
  echo "Found existing $VIM_DIR, creating backup..."
  BACKUP_NUM=1
  while [ -d "${VIM_DIR}.bak.${BACKUP_NUM}" ]; do
    BACKUP_NUM=$((BACKUP_NUM+1))
  done
  mv "$VIM_DIR" "${VIM_DIR}.bak.${BACKUP_NUM}"
  echo "Backup created: ${VIM_DIR}.bak.${BACKUP_NUM}"
fi

# 3. Create a fresh ~/.vim directory
mkdir -p "$VIM_DIR"
echo "Created a fresh $VIM_DIR"

# 4. Download new .vimrc from the repo (bypassing cache)
echo "Downloading new vimrc from $VIMRC_URL..."
curl -fsSL "${VIMRC_URL}?$(date +%s)" -o "$VIMRC_FILE"
echo "New vimrc saved to $VIMRC_FILE."

# 5. Install vim-plug (plug.vim) into autoload
echo "Installing vim-plug..."
curl -fLo "$VIM_DIR/autoload/plug.vim" --create-dirs "$PLUG_INSTALLER"

# 6. Install plugins using vim-plug
echo "Installing vim plugins with vim-plug..."
vim +PlugInstall +qall

# 7. On macOS, install Node.js if missing, then build coc.nvim + install extensions
if [[ "$(uname)" == "Darwin" ]]; then
  echo "Detected macOS, checking for Node.js..."
  if ! command -v node >/dev/null 2>&1; then
    echo "Node.js not found. Installing Node.js via Homebrew (no confirmation)."
    brew install node
  else
    echo "Node.js is already installed."
  fi

  # Build coc.nvim if it's installed
  COC_DIR="$VIM_DIR/plugged/coc.nvim"
  if [ -d "$COC_DIR" ] && [ -f "$COC_DIR/package.json" ]; then
    echo "Building coc.nvim..."
    cd "$COC_DIR"
    npm ci
    cd - >/dev/null
  fi

  echo "Installing coc.nvim extensions..."
  vim -E -s +CocInstall\ -sync\ coc-html\ coc-css\ coc-tsserver\ coc-json\ coc-eslint +qall
fi

echo "Installation complete!"
echo "Please open Vim and enjoy your new configuration."

