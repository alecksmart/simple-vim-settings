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
" Plug 'mhinz/vim-signify'

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

" Global clipboard
Plug 'ojroques/vim-oscyank', {'branch': 'main'}

" Change, delete, and add surroundings (quotes, brackets, tags) in pairs
Plug 'tpope/vim-surround'

" Adds more text objects like 'i,' (inside comma) or 'a;' (around semicolon)
Plug 'wellle/targets.vim'

" The fuzzy finder engine (requires 'brew install fzf' on Mac)
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" Vim integration for fzf (files, buffers, history search)
Plug 'junegunn/fzf.vim'

" Distraction-free writing mode (centers text, hides UI)
Plug 'junegunn/goyo.vim'

" Floating terminal window for quick shell commands
Plug 'voldikss/vim-floaterm'

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

" ===========================
"  Set leader key
" ==========================

" Set the leader key to space
let mapleader = " "

" ===========================
"  STARTIFY CONFIGURATION
" ==========================

" 1. Function to build the header with 4-space global padding
function! GetStartifyHeader()
    let l:host    = substitute(system('hostname -s'), '\n', '', '')
    let l:uptime  = substitute(system("uptime | grep -o 'up [^,]*' | sed 's/up //'"), '\n', '', '')
    let l:fortune = substitute(system('fortune -sn 60'), '\n', ' ', 'g')
    
    " We manualy pad with 4 spaces to avoid triggering indent-plugins
    let l:pad = '    '
    let l:divider = l:pad . '━━━✦━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━✦━━━'
    return [
        \ l:divider,
        \ l:pad . 'HOST: ' . l:host,
        \ l:pad . 'VIM:  ' . v:version,
        \ l:pad . 'UP:   ' . l:uptime,
        \ l:divider,
        \ l:pad . 'CWD:  ' . getcwd(),
        \ l:pad . 'HELP: Press <leader>? for shortcuts',
        \ l:divider,
        \ l:pad . '',
        \ l:pad . (empty(l:fortune) ? 'Stay hungry, stay foolish.' : '"' . l:fortune . '"'),
        \ ]
endfunction

let g:startify_custom_header = GetStartifyHeader()

" 2. Smart Lists: Section headers at 4 spaces, Items at 8 spaces
" Startify adds a small indent by default, so 7 spaces in the header 
" usually results in 8 spaces for the actual items.
let g:startify_lists = [
      \ { 'type': 'bookmarks', 'header': ['    🔖 Bookmarks']      },
      \ { 'type': 'files',     'header': ['    🕒 Recent Files']   },
      \ { 'type': 'dir',       'header': ['    📂 Current Project'] },
      \ { 'type': 'sessions',  'header': ['    💾 Sessions']       },
      \ ]

" 3. Bookmarks
let g:startify_bookmarks = [
      \ {'b': '~/.bashrc'},
      \ {'z': '~/.zshrc'},
      \ {'v': '~/.vimrc'},
      \ {'c': '~/.ssh/config'},
      \ {'g': '~/.config/ghostty/config'},
      \ {'p': '~/Projects/'},
      \ ]

" 4. Tweaks
let g:startify_padding_left = 8          " Indent items to 8 spaces
let g:startify_session_persistence = 1
let g:startify_enable_special      = 0
let g:startify_relative_path       = 1
let g:startify_change_to_dir       = 1

" 5. Footer (4-space padding)
let g:startify_custom_footer = [
      \ '    Vim ' . v:version . ' | ' . strftime('%Y-%m-%d %H:%M'),
      \ ]

" 6. Buffer-Specific Fixes (Disable Indent Lines & Colors)
function! s:startify_setup()
    " Disable common indentation guide plugins for this buffer
    if exists(':IndentLinesDisable') | IndentLinesDisable | endif
    let b:indent_blankline_enabled = 0
    
    " Custom Colors
    highlight StartifyHeader  ctermfg=111 guifg=#81a1c1
    highlight StartifyBracket ctermfg=242 guifg=#4c566a
    highlight StartifyFile    ctermfg=214 guifg=#fabd2f
    highlight StartifyPath    ctermfg=245 guifg=#928374
    highlight StartifySection ctermfg=108 guifg=#a3be8c
endfunction

augroup startify_custom
    autocmd!
    " Apply setup when entering Startify
    autocmd FileType startify call s:startify_setup()
augroup END

" ============================================
" Plugin Specific Options
" ============================================
" Rainbow Parentheses: set max nesting level
let g:rainbow_active = 5

" IndentLine: customize indentation line character and disable for some filetypes
let g:indentLine_char = '|'
let g:indentLine_fileTypeExclude = ['help', 'dashboard']

" vim-highlightedyank Configuration:
let g:highlightedyank_highlight_duration = 400
let g:highlightedyank_highlight_group = 'IncSearch'

" --- FZF (Fuzzy Finder) ---
" Search files with Space+f, buffers with Space+b, and history with Space+h
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>h :History<CR>
" Search current file content (like a super grep)
nnoremap <leader>/ :BLines<CR>

" --- Goyo (Distraction Free) ---
" Toggle clean mode with Space+G
nnoremap <leader>G :Goyo<CR>

" --- Floaterm (Floating Terminal) ---
" Toggle the terminal with Space+t
let g:floaterm_width = 0.8
let g:floaterm_height = 0.8
let g:floaterm_title = ' Terminal '
nnoremap <leader>t :FloatermToggle<CR>
" Terminal-specific: Use Esc to exit terminal mode back to normal mode
tnoremap <Esc> <C-\><C-n>:FloatermToggle<CR>

" ============================================
" Custom Mappings
" ============================================

" -- Startify Sessions --
nnoremap <leader>ss :SSave<CR>
nnoremap <leader>sl :SLoad<CR>

" -- CtrlP Mappings --
" Use separate prefix to avoid clashing with FZF mappings
nnoremap <leader>pf :CtrlP<CR>
nnoremap <leader>pb :CtrlPBuffer<CR>
nnoremap <leader>pm :CtrlPMRU<CR>

" -- vim-gitgutter Mappings --
nnoremap <leader>gg :GitGutterToggle<CR>
nnoremap <leader>gn :GitGutterNextHunk<CR>
nnoremap <leader>gp :GitGutterPrevHunk<CR>

" -- OSCYank Mappings --
" --- Automatically copy every yank to the system clipboard via OSC 52
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankRegister "' | endif
" --- Optional: Map <leader>c to manually copy a visual selection
vnoremap <leader>c :OSCYank<CR>

" -- Moving Lines Up/Down --
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" -- Toggle Limelight --
nnoremap <leader>l :Limelight!!<CR>
" Enable Limelight by default on startup
augroup limelight_auto
  autocmd!
  autocmd VimEnter * Limelight
augroup END

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
let g:table_mode_corner_corner='+'
let g:table_mode_header_fillchar='='

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
  \ '=== FZF (Primary) | === CtrlP (Alt)   | === Built-In Folding',
  \ '-------------------------------------------------------------',
  \ ' <leader>f: Files | <leader>pf: Files | za  : Toggle fold',
  \ ' <leader>b: Buffs | <leader>pb: Buffs | zR  : Open all folds',
  \ ' <leader>h: Hist  | <leader>pm: MRU   | zM  : Close all folds',
  \ ' <leader>/: Lines |                   |',
  \ '-------------------------------------------------------------',
  \ '=== tpope/vim-commentary (Editing Tools)',
  \ '  gc: Toggle comment (normal & visual modes)',
  \ '-------------------------------------------------------------',
  \ '=== vim-gitgutter (Git Integration)',
  \ '  <leader>gg: Toggle signs  | <leader>gn: Next hunk | <leader>gp: Prev hunk',
  \ '-------------------------------------------------------------',
  \ '=== Startify Sessions',
  \ '  <leader>ss: Save session  | <leader>sl: Load session',
  \ '  :SDelete {name}: Delete session | :Startify: Open start screen',
  \ '  :SClose: Close current session',
  \ '-------------------------------------------------------------',
  \ '=== Clipboard (OSCYank)',
  \ '  <leader>c (visual): Copy selection over OSC52',
  \ '-------------------------------------------------------------',
  \ '=== Moving Lines',
  \ '  Alt-j / Alt-k: Move line/selection down/up (normal/insert/visual)',
  \ '-------------------------------------------------------------',
  \ '=== Window & Tab Navigation',
  \ '  <C-w> h/j/k/l: Move between windows',
  \ '  gt/gT: Next/Previous tab',
  \ '-------------------------------------------------------------',
  \ '=== Visuals',
  \ '  <leader>l: Toggle Limelight | <leader>tm: Toggle table mode',
  \ '-------------------------------------------------------------',
  \ '=== Plugin | Key Concept | Mnemonic',
  \ '  Goyo    : Toggle UI        | <leader>G (G for Goyo/Gone)',
  \ '  Surround: Change/Add Pairs | cs (Change Surround), ds (Delete Surround)',
  \ '  Targets : Smart Selecting  | in (Inside Next), il (Inside Last)',
  \ '-------------------------------------------------------------',
  \ '=== Helper',
  \ '  <leader>?: Open this shortcuts window',
  \ '-------------------------------------------------------------',
  \ 'Press Esc to close this window.'
  \ ])
  setlocal nomodifiable
  nnoremap <buffer> <Esc> :close<CR>
endfunction
nnoremap <leader>? :call ShowCustomShortcuts()<CR>

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

" do not underline the current line
highlight CursorLineNr cterm=NONE gui=NONE
