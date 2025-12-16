"*****************************************************************************
"" Vim-Plug core
"*****************************************************************************
call plug#begin('~/.local/share/nvim/plugged')
" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'neoclide/coc-java'
Plug 'morhetz/gruvbox'
" Plug 'crusoexia/vim-monokai'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhartington/oceanic-next'
" Plug 'tanvirtin/monokai.nvim'
Plug 'tpope/vim-commentary'
" Plug 'preservim/nerdtree'
Plug 'Raimondi/delimitMate'
Plug 'ap/vim-css-color'
Plug 'vim-utils/vim-man'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

"" Vim-Session
"Plug 'xolox/vim-misc'
"Plug 'xolox/vim-session'

call plug#end()

"*****************************************************************************
"" Plug Settings
"*****************************************************************************

let g:mkdp_refresh_slow = 0
let g:mkdp_browser = 'firefox'

" Expansion between parenthesis
" imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<Plug>delimitMateCR"
let delimitMate_expand_cr = 1

" Setting colorscheme
colorscheme gruvbox
" colorscheme OceanicNext

" AirlineTheme
let g:airline_theme = 'angr'
" let g:airline_theme='oceanicnext'
" let g:airline_theme=''

" Nerd tree
" map <leader>n :NERDTreeToggle<CR>
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" if has('nvim')
"     let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
" else
"     let NERDTreeBookmarksFile = '~/.vim' . '/NERDTreeBookmarks'
" endif

"*****************************************************************************
"" WSL Clipboard
"*****************************************************************************

let g:clipboard = {
  \   'name': 'win32yank-wsl',
  \   'copy': {
  \      '+': 'win32yank.exe -i --crlf',
  \      '*': 'win32yank.exe -i --crlf',
  \    },
  \   'paste': {
  \      '+': 'win32yank.exe -o --lf',
  \      '*': 'win32yank.exe -o --lf',
  \   },
  \   'cache_enabled': 0,
  \ }

"*****************************************************************************
"" Basic Settings
"*****************************************************************************

let mapleader =" "

syntax on

set noerrorbells
set ignorecase
set smartcase
set expandtab
set tabstop=2 softtabstop=2
set shiftwidth=2
set smartindent
set scrolloff=6 "cursor doesn't go the borders
set encoding=utf-8
set number "numbers at the left side
" set go=a
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

" Replace ex mode with gq
map Q gq

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
"" Regular Mappings
"*****************************************************************************

" Compile document, be it groff/LaTeX/markdown/etc.
map <leader>c :w! \| !compiler "<c-r>%"<CR>

" Open corresponding .pdf/.html or preview
" map <leader>p :!opout <c-r>%<CR><CR>

nmap <leader>p <Plug>MarkdownPreviewToggle

" Spell-check set to <leader>o, 'o' for 'orthography':
map <leader>o :setlocal spell! spelllang=en_us<CR>

" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
nnoremap <silent> <Leader>= : vertical resize +5<CR>
nnoremap <silent> <Leader>- : vertical resize -5<CR>

" save file on Control + s
map <C-s> :w <cr>

" quit without saving on Control + q
map <C-q> :q! <cr>

" Check file in shellcheck:
map <leader>s :!clear && shellcheck %<CR>

" Create tab
map <C-n> :tabnew <cr>

" Changing tabs
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" Go to last active tab
au TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>
vnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>

" *****************************************************************************
"" coc configs
"*****************************************************************************
" coc config
  " \ 'coc-json',
  " \ 'coc-pairs',
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-clangd',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ ]
" from readme
" if hidden is not set, TextEdit might fail.
set hidden " Some servers have issues with backup files, see #649 set nobackup set nowritebackup " Better display for messages set cmdheight=2 " You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" inoremap <silent><expr> <>
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" inoremap <expr><c-k> pumvisible() ? "\<C-p>" : "\<C-h>"

" inoremap <silent><expr> <TAB> pumvisible() ? coc#_select_confirm()
" inoremap <silent><expr> <s-cr> pumvisible() ? coc#_select_confirm()
				\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition) -> needs languageserver
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" nmap <silent> <C-d> <Plug>(coc-range-select)
" xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" source ~/.config/nvim/cp.vim



"*****************************************************************************
"" Convenience
"*****************************************************************************

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	map <leader>v :VimwikiIndex
	let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex

" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritepre * %s/\n\+\%$//e

" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
" Recompile dwmblocks on config edit.
autocmd BufWritePost ~/.config/dwmblocks/config.h !cd ~/.config/dwmblocks/; sudo -A make clean install && { killall -q dwmblocks;setsid dwmblocks & }
" Recompile dwm on config edit.
autocmd BufWritePost ~/.config/dwm/config.h !cd ~/.config/dwm/; sudo -A make clean install && cd && { killall -q dwm;setsid dwm & }
" autocmd BufWritePost ~/dotfiles/dunst/.config/dunst/dunstrc !cd && { killall -q dunst;setsid dunst & }
autocmd BufWritePost ~/dotfiles/dunst/.config/dunst/dunstrc !{ killall -q dunst;setsid dunst & }
