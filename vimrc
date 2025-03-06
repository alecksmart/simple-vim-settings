" ============================================
" Basic Settings & Vundle Initialization
" ============================================
set nocompatible              " be iMproved, required
set encoding=UTF-8

" Disable filetype detection while loading plugins
filetype off

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
  " Let Vundle manage itself
  Plugin 'VundleVim/Vundle.vim'

  " Git & File Management
  Plugin 'tpope/vim-fugitive'
  Plugin 'mhinz/vim-signify'

  " Color Schemes, Themes & Statusline
  " Plugin 'chriskempson/base16-vim'
  " Plugin 'mhartington/oceanic-next'
  Plugin 'vim-airline/vim-airline'
  " Plugin 'vim-airline/vim-airline-themes'
  " Plugin 'ghifarit53/tokyonight-vim'
  Plugin 'catppuccin/vim'

  " Multi-cursor support
  Plugin 'mg979/vim-visual-multi'
  
  " Icons for files, etc.
  Plugin 'ryanoasis/vim-devicons'

  " Git diff indicators in sign column
  Plugin 'airblade/vim-gitgutter'

  " Parentheses coloring
  Plugin 'kien/rainbow_parentheses.vim'
  
  " Indentation visualization
  Plugin 'Yggdroot/indentLine'

  " File explorers & Finders
  Plugin 'preservim/nerdtree'
  Plugin 'ctrlpvim/ctrlp.vim'

  " Commenting
  Plugin 'tpope/vim-commentary'

  " Automatic matching pairs
  Plugin 'jiangmiao/auto-pairs'

  " Highlight
  Plugin 'machakann/vim-highlightedyank'
  Plugin 'junegunn/limelight.vim'

  " Start page :)
  Plugin 'mhinz/vim-startify'

  " Programming 
  Plugin 'sheerun/vim-polyglot'

  " Database
  Plugin 'tpope/vim-dadbod'
  Plugin 'kristijanhusak/vim-dadbod-completion'
  Plugin 'kristijanhusak/vim-dadbod-ui' 
call vundle#end()            " required

" Re-enable filetype detection with plugins and indentation
filetype plugin indent on

" ============================================
" Terminal & Appearance Settings
" ============================================
if has("termguicolors")
  set termguicolors
endif

" Choose colorscheme
" colorscheme OceanicNext
" colorscheme tokyonight
"   frappe latte mocha macchiato
colorscheme catppuccin_frappe

" Set airline options
let g:airline_powerline_fonts = 1
let g:airline_theme = 'catppuccin_macchiato'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'

" ============================================
" General Editor Settings
" ============================================
" Line numbering
set number
set relativenumber

" Smooth Scrolling
set scrolloff=5

" Syntax highlighting (enabled via filetype plugin indent on)
syntax on

" Smart Indentation & Tabs
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent

" Mouse Support
set mouse=a

" Search Enhancements
set hlsearch
set incsearch
set ignorecase
set smartcase

" Folding settings (using syntax-based folding)
set foldmethod=syntax
set foldlevel=99  " open all folds by default

" Clipboard Integration
" set clipboard=unnamedplus
set clipboard=

" Backup & Swap File Options (optional)
"set backup
"set backupdir=~/.vim/backups
"set noswapfile

" Cursor Line Highlighting
set cursorline

" Cursor style settings for GUI and terminal (if supported)
set guicursor=n-v-c:block,i:ver25
if exists('&t_SI')
  let &t_SI = "\e[6 q"  " Insert mode: vertical bar (if supported)
  let &t_EI = "\e[2 q"  " Normal mode: block cursor
endif

" ============================================
" Plugin Specific Options
" ============================================
" Rainbow Parentheses: set max nesting level
let g:rainbow_active = 5

" IndentLine: customize indentation line character and disable for some filetypes
let g:indentLine_char = '|'
let g:indentLine_fileTypeExclude = ['help', 'nerdtree', 'dashboard']

" vim-highlightedyank Configuration:
let g:highlightedyank_highlight_duration = 400
let g:highlightedyank_highlight_group = 'IncSearch'

" ============================================
" Custom Mappings
" ============================================
" Set the leader key to space
let mapleader = " "

" -- NERDTree Mappings --
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>r :NERDTreeFind<CR>
nnoremap <leader>c :NERDTreeClose<CR>

" -- CtrlP Mappings --
nnoremap <leader>f :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>m :CtrlPMRU<CR>

" -- vim-gitgutter Mappings --
nnoremap <leader>gg :GitGutterToggle<CR>
nnoremap <leader>gn :GitGutterNextHunk<CR>
nnoremap <leader>gp :GitGutterPrevHunk<CR>

" -- Moving Lines Up/Down --
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" -- Toggle limelight --
nnoremap <leader>l :Limelight!!<CR>

" -- Reopen last edited position in file --
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" ============================================
" Custom Leader Shortcut Help (Three Columns + Plugin Headings)
" ============================================
function! ShowCustomShortcuts()
  new
  setlocal buftype=nofile
  setlocal bufhidden=wipe
  setlocal noswapfile
  call setline(1, [
  \ 'Custom Leader Shortcut Help:',
  \ '-------------------------------------------------------------',
  \ '=== NERDTree       | === CtrlP          | === Built-In Folding',
  \ '-------------------------------------------------------------',
  \ ' <leader>n: Toggle | <leader>f: Finder  | za  : Toggle fold',
  \ ' <leader>r: Find   | <leader>b: Buffer  | zR  : Open all folds',
  \ ' <leader>c: Close  | <leader>m: MRU     | zM  : Close all folds',
  \ '-------------------------------------------------------------',
  \ '=== tpope/vim-commentary (Editing Tools)',
  \ '  gc: Toggle comment (normal & visual modes)',
  \ '-------------------------------------------------------------',
  \ '=== vim-gitgutter (Git Integration)',
  \ '  <leader>gg: Toggle signs  | <leader>gn: Next hunk | <leader>gp: Prev hunk',
  \ '-------------------------------------------------------------',
  \ '=== Window & Tab Navigation',
  \ '  <C-w> h/j/k/l: Move between windows',
  \ '  gt/gT: Next/Previous tab',
  \ '-------------------------------------------------------------',
  \ '=== Visuals',
  \ '  <leader>l: Toggle Limelight',
  \ '-------------------------------------------------------------',
  \ 'Press Esc to close this window.'
  \ ])
  setlocal nomodifiable
  nnoremap <buffer> <Esc> :close<CR>
endfunction
nnoremap <leader>h :call ShowCustomShortcuts()<CR>

" Databases
" let g:dbs = {
" \  'project_postgres': 'postgres://postgres@localhost/mydb',
" \  'project_mysql': 'mysql://user:password@localhost/mydb'
" \}

