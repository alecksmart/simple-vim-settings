# simple-vim-settings

This repository contains a streamlined vim configuration with plugins and settings to enhance your vim experience. It is designed to be easily installed on any system using **vim-plug** as the plugin manager. Many extra features are included as commented-out lines for quick enabling—simply uncomment them if you want to try additional functionalities.

## Features

- **vim-plug** – Modern, fast plugin management for vim.
- **Popular plugins** such as:
  - [NERDTree](https://github.com/preservim/nerdtree) – File explorer.
  - [CtrlP](https://github.com/ctrlpvim/ctrlp.vim) – Fuzzy file finder.
  - [vim-commentary](https://github.com/tpope/vim-commentary) – Easy commenting.
  - [vim-gitgutter](https://github.com/airblade/vim-gitgutter) – Git diff indicators.
  - [rainbow_parentheses.vim](https://github.com/kien/rainbow_parentheses.vim) – Colorful nested parentheses.
  - [indentLine](https://github.com/Yggdroot/indentLine) – Indentation visualization.
  - [vim-highlightedyank](https://github.com/machakann/vim-highlightedyank) – Highlights yanked text briefly to help you see what was copied.
  - [vim-startify](https://github.com/mhinz/vim-startify) – Provides a customizable start screen with recent files, sessions, and bookmarks.
  - [vim-polyglot](https://github.com/sheerun/vim-polyglot) – Language pack with improved syntax and folding support.
  - [vim-oscyank](https://github.com/ojroques/vim-oscyank) – Copy over SSH/terminal using OSC52 (global clipboard-friendly).
  - **coc.nvim** – *[macOS only]* Autocompletion and language server protocol integration for a modern coding experience.
  - Additional plugins for databases and themes are also included.

- **Enhanced editor settings** – syntax highlighting, smooth scrolling, smart indentation, and more.
- **Custom mappings** – predefined shortcuts for navigation, file management, folding, and plugin functions.
- **Leader mapped to Spacebar** – all custom mappings use the spacebar as the leader key.

## Installation

### Pre-requisites

- On **macOS**:
  - If Node.js is not installed, the script will automatically install it via Homebrew (without prompt).
  - If Homebrew itself is not installed, please install Homebrew first:
    ```bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

- Optional but recommended: install `fortune` so the start screen can show quotes. Example installs:
  - macOS (Homebrew): `brew install fortune`
  - Debian/Ubuntu: `sudo apt-get install fortune-mod`
- Optional but recommended: install `fzf` for the default fuzzy finder keybindings:
  - macOS (Homebrew): `brew install fzf`
  - Debian/Ubuntu: `sudo apt-get install fzf`

### Quick Install

Run the following command in your terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/alecksmart/simple-vim-settings/main/install.sh | bash
```

Alternatively, you can use `wget`:

```bash
wget -qO- https://raw.githubusercontent.com/alecksmart/simple-vim-settings/main/install.sh | bash
```

**What the script does**:

1. Backs up your existing `~/.vimrc` into `~/.vimrc_backup/vimrc-<timestamp>` if present.
2. Downloads the new `vimrc` from this repository and saves it as `~/.vimrc` (cache-busted).
3. Installs [vim-plug](https://github.com/junegunn/vim-plug) into `~/.vim/autoload` (creating the directory if needed).
4. Runs a headless `PlugInstall --sync` followed by `PlugUpdate --sync` so all plugins install on the first run.
5. **macOS only**: If Node.js is missing, installs it automatically via Homebrew. If `coc.nvim` is present, runs `npm install && npm ci`, then installs default coc extensions (HTML, CSS, TS, JSON, ESLint).
6. Ensures the `pink-moon` colorscheme block is present at the end of `~/.vimrc` (idempotent—no duplicates on reruns).

When complete, open Vim to start using the new configuration.

## Autocompletion

Autocompletion is enabled **only for macOS** (intentionally). Make sure Node.js is installed (the script does this automatically if it’s missing). On non-mac platforms, you can remove or modify the coc.nvim plugin lines in `.vimrc` if desired.

## Repository Structure

- **vimrc**: the vim configuration file. It is downloaded and installed as `~/.vimrc`.
- **install.sh**: the installation script that backs up any existing configuration, downloads the new configuration, installs **vim-plug**, and handles coc.nvim setup.

## Custom Key Mappings

Some of the key mappings include:

- **NERDTree**:
  - `<leader>n`: Toggle NERDTree.
  - `<leader>r`: Find current file in NERDTree.
  - `<leader>c`: Close NERDTree.
- **FZF (fuzzy finder)**:
  - `<leader>f`: Open file finder.
  - `<leader>b`: Open buffer finder.
  - `<leader>h`: View history.
  - `<leader>/`: Search within the current buffer.
- **Goyo (distraction-free)**:
  - `<leader>G`: Toggle Goyo mode.
- **Floaterm (floating terminal)**:
  - `<leader>t`: Toggle floating terminal.
- **CtrlP**:
  - `<leader>pf`: Open file finder.
  - `<leader>pb`: Open buffer finder.
  - `<leader>pm`: Open MRU list.
- **vim-commentary**:
  - `gc`: Toggle comment (works in normal and visual modes).
- **vim-gitgutter**:
  - `<leader>gg`: Toggle gitgutter signs.
  - `<leader>gn`: Go to next hunk.
  - `<leader>gp`: Go to previous hunk.
- **Built-In Folding**:
  - `za`: Toggle fold at cursor.
  - `zR`: Open all folds.
  - `zM`: Close all folds.
- **Startify (sessions & start screen)**:
  - `<leader>ss`: Save current session.
  - `<leader>sl`: Load a saved session.
  - `:Startify`: Open the start screen.
  - `:SDelete {name}`: Delete a saved session.
  - `:SClose`: Close the current session.
- **Clipboard (OSC52)**:
  - `<leader>c` (visual): Copy selection to the system clipboard over OSC52.
- **Moving Lines**:
  - `Alt-j` / `Alt-k`: Move the current line or selection down/up (works in normal, insert, and visual modes).
- **Visuals**:
  - `<leader>l`: Toggle Limelight (enabled by default at startup).
  - `<leader>tm`: Toggle table mode.
- **Helper**:
  - `<leader>?`: Show the in-Vim shortcuts window.
- **Window & Tab Navigation**:
  - `<C-w> h/j/k/l`: Move between windows.
  - `gt` / `gT`: Navigate tabs.
- **Additional Enhancements**:
  - **vim-highlightedyank**: Yanked text is briefly highlighted.
  - **vim-startify**: Presents a start screen with recent files and sessions when vim is opened.
- **Autocompletion** (*macOS only*):
  - **coc.nvim** is automatically loaded and configured for autocompletion and language server integration.
- *Note*: `<leader>` is mapped to the spacebar.

## Contributing

Contributions, issues, and feature requests are welcome! Please check the [issues page](https://github.com/alecksmart/simple-vim-settings/issues) for more details.

## License

This project is licensed under the MIT License.
