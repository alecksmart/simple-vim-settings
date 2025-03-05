# Simple Vim Settings

This repository contains a streamlined Vim configuration with plugins and settings to enhance your Vim experience. It is designed to be easily installed on any system using Vundle as the plugin manager.

## Features

- **Vundle** – Plugin management for Vim.
- **Popular Plugins** such as:
  - [NERDTree](https://github.com/preservim/nerdtree) – File explorer.
  - [CtrlP](https://github.com/ctrlpvim/ctrlp.vim) – Fuzzy file finder.
  - [vim-commentary](https://github.com/tpope/vim-commentary) – Easy commenting.
  - [vim-gitgutter](https://github.com/airblade/vim-gitgutter) – Git diff indicators.
  - [rainbow_parentheses.vim](https://github.com/kien/rainbow_parentheses.vim) – Colorful nested parentheses.
  - [indentLine](https://github.com/Yggdroot/indentLine) – Indentation visualization.
  - [auto-pairs](https://github.com/jiangmiao/auto-pairs) – Automatic matching of brackets, quotes, etc.
- **Enhanced Editor Settings** – Syntax highlighting, smooth scrolling, smart indentation, and more.
- **Custom Mappings** – Predefined shortcuts for navigation, file management, folding, and plugin functions.
- **Custom Help Function** – Displays a summary of available key mappings in a structured three-column layout.

## Installation

You can install the Vim configuration using the provided installation script. The script will:

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

After installation, start Vim and run:

```vim
:PluginInstall
```

to install all the plugins.

## Repository Structure

- **vimrc**: The Vim configuration file. It is downloaded and installed as `~/.vimrc`.
- **install.sh**: The installation script that installs Vundle, backs up any existing vimrc, and downloads the new configuration.

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
  - `<leader>gg`: Toggle GitGutter signs.
  - `<leader>gn`: Go to next hunk.
  - `<leader>gp`: Go to previous hunk.
- **Built-In Folding**:
  - `za`: Toggle fold at cursor.
  - `zR`: Open all folds.
  - `zM`: Close all folds.
- **Window & Tab Navigation**:
  - `<C-w> h/j/k/l`: Move between windows.
  - `gt/gT`: Navigate tabs.
- **Custom Help**:
  - `<leader>h`: Display a help window with a summary of shortcuts.

## Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the [issues page](https://github.com/alecksmart/simple-vim-settings/issues).

## License

This project is licensed under the GPL-2.0 license.

