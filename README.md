Below is the updated README that includes information on the autocompletion plugin (coc.nvim) for macOS:

```markdown
# simple-vim-settings

This repository contains a streamlined vim configuration with plugins and settings to enhance your vim experience. It is designed to be easily installed on any system using Vundle as the plugin manager. Many extra features are included as commented-out lines for quick enabling—simply uncomment them if you want to try additional functionalities.

## Features

- **Vundle** – Plugin management for vim.
- **Popular plugins** such as:
  - [NERDTree](https://github.com/preservim/nerdtree) – File explorer.
  - [CtrlP](https://github.com/ctrlpvim/ctrlp.vim) – Fuzzy file finder.
  - [vim-commentary](https://github.com/tpope/vim-commentary) – Easy commenting.
  - [vim-gitgutter](https://github.com/airblade/vim-gitgutter) – Git diff indicators.
  - [rainbow_parentheses.vim](https://github.com/kien/rainbow_parentheses.vim) – Colorful nested parentheses.
  - [indentLine](https://github.com/Yggdroot/indentLine) – Indentation visualization.
  - [auto-pairs](https://github.com/jiangmiao/auto-pairs) – Automatic matching of brackets, quotes, etc.
  - [vim-highlightedyank](https://github.com/machakann/vim-highlightedyank) – Highlights yanked text briefly to help you see what was copied.
  - [vim-startify](https://github.com/mhinz/vim-startify) – Provides a customizable start screen with recent files, sessions, and bookmarks.
  - [vim-polyglot](https://github.com/sheerun/vim-polyglot) – Language pack with improved syntax and folding support.
  - **coc.nvim** – *[macOS only]* Autocompletion and language server protocol integration for a modern coding experience.
  - Additional plugins for databases and themes are also included.

- **Enhanced editor settings** – syntax highlighting, smooth scrolling, smart indentation, and more.
- **Custom mappings** – predefined shortcuts for navigation, file management, folding, and plugin functions.
- **Custom help function** – displays a summary of available key mappings in a structured three-column layout.
- **Leader mapped to Spacebar** – all custom mappings use the spacebar as the leader key.

## Installation

You can install the vim configuration using the provided installation script. The script will:

1. Install Vundle (if not already installed).
2. Backup your existing `~/.vimrc` (creating numbered backups if needed).
3. Download the new vimrc file from this repository and replace your existing `~/.vimrc`.

### Quick Install

Run the following command in your terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/alecksmart/simple-vim-settings/main/install.sh | bash
```

Alternatively, you can use `wget`:

```bash
wget -qO- https://raw.githubusercontent.com/alecksmart/simple-vim-settings/main/install.sh | bash
```

After installation, start vim and run:

```vim
:PluginInstall
```

to install all the plugins.

## Repository Structure

- **vimrc**: the vim configuration file. It is downloaded and installed as `~/.vimrc`.
- **install.sh**: the installation script that installs Vundle, backs up any existing vimrc, and downloads the new configuration.

## Custom Key Mappings

Some of the key mappings include:

- **NERDTree**:
  - `<leader>n`: Toggle NERDTree.
  - `<leader>r`: Find current file in NERDTree.
  - `<leader>c`: Close NERDTree.
- **CtrlP**:
  - `<leader>f`: Open file finder.
  - `<leader>b`: Open buffer finder.
  - `<leader>m`: Open MRU list.
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
- **Window & Tab Navigation**:
  - `<C-w> h/j/k/l`: Move between windows.
  - `gt` / `gT`: Navigate tabs.
- **Additional Enhancements**:
  - **vim-highlightedyank**: Yanked text is highlighted briefly.
  - **vim-startify**: Presents a start screen with recent files and sessions when vim is opened.
- **Autocompletion** (*macOS only*):
  - **coc.nvim** is automatically loaded and configured for autocompletion and language server integration.
- **Custom Help**:
  - `<leader>h`: Display a help window with a summary of shortcuts.

*Note: In all mappings, `<leader>` is mapped to the spacebar.*

## Contributing

Contributions, issues, and feature requests are welcome! Please check the [issues page](https://github.com/alecksmart/simple-vim-settings/issues) for more details.

## License

This project is licensed under the MIT License.
```

This README now includes details on the autocompletion plugin (coc.nvim) that is conditionally loaded on macOS, along with the rest of your configuration features.
