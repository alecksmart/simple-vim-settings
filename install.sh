#!/usr/bin/env bash
set -e

# Variables
VIMRC_FILE="$HOME/.vimrc"
VIM_DIR="$HOME/.vim"
VIMRC_URL="https://raw.githubusercontent.com/alecksmart/simple-vim-settings/refs/heads/main/vimrc"
PLUG_INSTALLER="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
BACKUP_DIR="$HOME/.vimrc_backup"

# 1. Backup existing ~/.vimrc into a dedicated backup directory with a timestamp
if [ -f "$VIMRC_FILE" ]; then
  mkdir -p "$BACKUP_DIR"
  TIMESTAMP=$(date +%Y%m%d-%H%M%S)
  BACKUP_VIMRC="$BACKUP_DIR/vimrc-$TIMESTAMP"
  echo "Found existing $VIMRC_FILE, moving it to $BACKUP_VIMRC..."
  mv "$VIMRC_FILE" "$BACKUP_VIMRC"
fi

# 2. Download new .vimrc from the repo (bypassing cache)
echo "Downloading new vimrc from $VIMRC_URL..."
curl -fsSL "${VIMRC_URL}?$(date +%s)" -o "$VIMRC_FILE"
echo "New vimrc saved to $VIMRC_FILE."

# 3. Install vim-plug (plug.vim) into autoload (in ~/.vim/autoload)
echo "Installing vim-plug..."
curl -fLo "$VIM_DIR/autoload/plug.vim" --create-dirs "$PLUG_INSTALLER"

# 4. Install/Update plugins synchronously so first run completes fully
echo "Installing/updating vim plugins with vim-plug..."
vim -es -u "$VIMRC_FILE" -i NONE -c "PlugInstall --sync" -c "PlugUpdate --sync" -c "qa" < /dev/null 2>/dev/null

# 5. On macOS, install Node.js if missing, then build coc.nvim and install extensions
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
    npm install
    npm ci
    cd - >/dev/null
  fi

  echo "Installing coc.nvim extensions..."
  vim -c "CocInstall -sync coc-html coc-css coc-tsserver coc-json coc-eslint" -c "qall" < /dev/null 2>/dev/null
fi

# 6. Append colorscheme settings to the end of .vimrc
echo "Ensuring colorscheme lines are present in $VIMRC_FILE..."
if ! grep -q "colorscheme pink-moon" "$VIMRC_FILE"; then
  {
    echo ""
    echo "colorscheme pink-moon"
    echo "set background=dark"
    echo "let g:airline_theme = 'base16'"
  } >> "$VIMRC_FILE"
fi

echo "Installation complete!"
echo "Please open Vim and enjoy your new configuration."
