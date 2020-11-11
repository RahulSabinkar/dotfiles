"*****************************************************************************
"" Vim-Plug core
"*****************************************************************************
call plug#begin('~/.local/share/nvim/plugged')

Plug 'morhetz/gruvbox'
Plug 'crusoexia/vim-monokai'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
"Plug 'preservim/nerdtree'
Plug 'Raimondi/delimitMate'
Plug 'ap/vim-css-color'
Plug 'vim-utils/vim-man'

"" Vim-Session
"Plug 'xolox/vim-misc'
"Plug 'xolox/vim-session'

call plug#end()

"*****************************************************************************
"" Plug Settings
"*****************************************************************************

" Expansion between parenthesis
let delimitMate_expand_cr = 1

" Setting colorscheme to gruvbox
colorscheme gruvbox

" AirlineTheme
let g:airline_theme = 'angr'

" Nerd tree
" map <leader>n :NERDTreeToggle<CR>
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" if has('nvim')
"     let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
" else
"     let NERDTreeBookmarksFile = '~/.vim' . '/NERDTreeBookmarks'
" endif

"*****************************************************************************
"" Basic Settings
"*****************************************************************************

let mapleader =" "

syntax on

set noerrorbells
set ignorecase
set smartcase
set expandtab
set tabstop=4 softtabstop=4
set shiftwidth=4
set smartindent
set scrolloff=6 "cursor doesn't go the borders
set encoding=utf-8
set number relativenumber "relative numbers at the left side
set go=a
set mouse=a
set incsearch "when searching, shows words as you type
set nohlsearch "doesn't highlight searched words
set clipboard+=unnamedplus "uses system clipboard
"set cmdheight=2 " space for messages below
nnoremap c "_c
set nocompatible
filetype plugin indent on

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
set splitbelow splitright

" Enable autocompletion:
set wildmode=longest,list,full

" Disables automatic commenting on newline:
" autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"*****************************************************************************
"" Colors
"*****************************************************************************

" Enable true colors, terminal has to support it
set termguicolors

set background=dark
"set bg=light

set colorcolumn=116
"highlight ColorColumn ctermbg=0 guibg=lightgrey
highlight ColorColumn ctermbg=0 guibg=#005F87

" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
if &diff
   highlight! link DiffText MatchParen
endif

"*****************************************************************************
"" Leader Keybindings
"*****************************************************************************

" Spell-check set to <leader>o, 'o' for 'orthography':
map <leader>o :setlocal spell! spelllang=en_us<CR>

" Shortcutting split navigation, saving a keypress:
map <leader>h <C-w>h
map <leader>j <C-w>j
map <leader>k <C-w>k
map <leader>l <C-w>l
nnoremap <silent> <Leader>= : vertical resize +5<CR>
nnoremap <silent> <Leader>- : vertical resize -5<CR>

" Replace ex mode with gq
"	map Q gq

" Check file in shellcheck:
map <leader>s :!clear && shellcheck %<CR>

"*****************************************************************************
"" Convenience
"*****************************************************************************

" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritepre * %s/\n\+\%$//e

" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
