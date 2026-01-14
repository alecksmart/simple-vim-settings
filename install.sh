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

# 4. Check for optional tools early so warnings still appear if later steps fail
echo "Checking for autoformat tools..."
if ! command -v shfmt >/dev/null 2>&1; then
  echo "Warning: 'shfmt' is not installed. bash autoformat will be unavailable."
fi
if ! command -v prettier >/dev/null 2>&1; then
  echo "Warning: 'prettier' is not installed. JS/TS/Markdown autoformat will be unavailable."
fi

# 5. Install/Update plugins synchronously so first run completes fully
echo "Installing/updating vim plugins with vim-plug..."
# Run PlugInstall first, then PlugUpdate in a separate headless pass to ensure updates apply on first run
vim -nEs -u "$VIMRC_FILE" -i NONE +'PlugInstall --sync' +qa < /dev/null 2>/dev/null
vim -nEs -u "$VIMRC_FILE" -i NONE +'PlugUpdate --sync' +qa < /dev/null 2>/dev/null

# 6. On macOS, install Node.js if missing, then build coc.nvim and install extensions
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

# 7. Append colorscheme settings to the end of .vimrc
echo "Ensuring colorscheme lines are present in $VIMRC_FILE..."
if ! grep -q "colorscheme pink-moon" "$VIMRC_FILE"; then
  {
    echo ""
    echo "colorscheme pink-moon"
    echo "set background=dark"
    echo "let g:airline_theme = 'base16'"
  } >> "$VIMRC_FILE"
fi

# 8. Ensure tmux clipboard support is configured once
TMUX_CONF="$HOME/.tmux.conf"
TMUX_CLIPBOARD_SETTING="set -s set-clipboard on"
echo "Ensuring tmux clipboard setting is present in $TMUX_CONF..."
if [ ! -f "$TMUX_CONF" ]; then
  touch "$TMUX_CONF"
fi
if ! grep -Fxq "$TMUX_CLIPBOARD_SETTING" "$TMUX_CONF"; then
  echo "$TMUX_CLIPBOARD_SETTING" >> "$TMUX_CONF"
fi

echo "Checking for 'fortune'..."
if ! command -v fortune >/dev/null 2>&1; then
  echo "Warning: 'fortune' is not installed. Recommended installs: 'brew install fortune' (macOS) or 'sudo apt-get install fortune-mod' (Debian/Ubuntu)."
fi

echo "Installation complete!"
echo "Please open Vim and enjoy your new configuration."
