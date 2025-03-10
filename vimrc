" ============================================
" Basic Settings & vim-plug Initialization
" ============================================
set nocompatible
set encoding=UTF-8

" Install path for vim-plug plugins
" By default, they'll be placed in ~/.vim/plugged/
call plug#begin('~/.vim/plugged')

" Let vim-plug manage itself
Plug 'junegunn/vim-plug'

" Git & File Management
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'

" Color Schemes, Themes & Statusline
" Plug 'chriskempson/base16-vim'
Plug 'mhartington/oceanic-next'
Plug 'glepnir/oceanic-material'
Plug 'ghifarit53/tokyonight-vim'
Plug 'catppuccin/vim'
Plug 'rhysd/vim-color-spring-night'
Plug 'phanviet/vim-monokai-pro'
Plug 'sts10/vim-pink-moon'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Multi-cursor support
Plug 'mg979/vim-visual-multi'

" Icons for files, etc.
Plug 'ryanoasis/vim-devicons'

" Git diff indicators in sign column
Plug 'airblade/vim-gitgutter'

" Parentheses coloring
Plug 'kien/rainbow_parentheses.vim'

" Indentation visualization
Plug 'Yggdroot/indentLine'

" File explorers & Finders
Plug 'preservim/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'

" Commenting
Plug 'tpope/vim-commentary'

" Automatic matching pairs
" Plug 'jiangmiao/auto-pairs'

" Highlight
Plug 'machakann/vim-highlightedyank'
Plug 'junegunn/limelight.vim'

" Start page :)
Plug 'mhinz/vim-startify'

" Programming
Plug 'sheerun/vim-polyglot'

" Database
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-completion'
Plug 'kristijanhusak/vim-dadbod-ui'

" Tables
Plug 'dhruvasagar/vim-table-mode'

" On macOS only, add coc.vim for autocompletion (release branch)
if has("macunix")
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

call plug#end()

" Re-enable filetype detection with plugins and indentation
filetype plugin indent on
syntax on

" ============================================
" General Editor Settings
" ============================================
" Line numbering
set number
set relativenumber

" Smooth Scrolling
set scrolloff=5

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
" set backup
" set backupdir=~/.vim/backups
" set noswapfile

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

" -- Toggle Limelight --
nnoremap <leader>l :Limelight!!<CR>

" -- Reopen last edited position in file --
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" -- Autocompletion settings
if has("macunix")
  " After plugins are loaded, set up omnifunc for coc:
  autocmd BufEnter * setlocal omnifunc=coc#refresh

  " Use Tab for completion navigation (if no mapping conflicts)
  inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
  inoremap <silent><expr> <CR> pumvisible() ? coc#pum#confirm() : "\<CR>"
endif

" -- Table mode
function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
      \ <SID>isAtStartOfLine('\|\|') ?
      \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
      \ <SID>isAtStartOfLine('__') ?
      \ '<c-o>:silent! TableModeDisable<cr>' : '__'

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
  \ '  <leader>l: Toggle Limelight | <leader>tm: Toggle table mode',
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

" ============================================
" Terminal & Appearance Settings
" ============================================
if has("termguicolors")
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Set airline options
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'

" Choose colorscheme

" colorscheme OceanicNext
"   let g:airline_theme='oceanicnext'
"   let g:oceanic_next_terminal_bold = 1
"   let g:oceanic_next_terminal_italic = 1

" set background=dark
" colorscheme oceanic_material
"   let g:airline_theme='oceanicnext'
"   " " let g:oceanic_material_transparent_background = 1
"   let g:oceanic_material_background = 'ocean' " available: ocean, medium, deep, darker
"   let g:oceanic_material_allow_bold = 1
"   let g:oceanic_material_allow_italic = 1
"   let g:oceanic_material_allow_underline = 1
"   let g:oceanic_material_allow_undercurl = 1
"   let g:oceanic_material_allow_reverse = 1

" colorscheme tokyonight
" let g:airline_theme = 'tokyonight'
"   let g:tokyonight_style = 'storm' " available: night, storm
"   let g:tokyonight_enable_italic = 1

" colorscheme catppuccin_frappe " available: frappe, latte, mocha, macchiato
" let g:airline_theme = 'catppuccin_macchiato' " available: frappe, latte, mocha, macchiato

" colorscheme spring-night
" let g:airline_theme = 'spring_night'
"   let g:spring_night_high_contrast = 1
"   let g:spring_night_cterm_italic = 1
"   let g:spring_night_cterm_bold = 1
"   let g:spring_night_highlight_terminal = 0

colorscheme pink-moon
set background=dark
let g:airline_theme = 'base16'
