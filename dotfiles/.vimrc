" dphung

" #start plugins -------------------------------------------------------------
call plug#begin('~/.vim/plugged')

" Add on top of universal c-tags
Plug 'majutsushi/tagbar'

" Colour themes
Plug 'joshdick/onedark.vim'
Plug 'nanotech/jellybeans.vim'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Uber fast fuzzy finder
Plug 'junegunn/fzf', { 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'

" Formatting of cpp : requires clang-format
Plug 'rhysd/vim-clang-format', {'for': 'cpp'}

" Doxygen ; :Dox to activate
Plug 'vim-scripts/DoxygenToolkit.vim', { 'for': 'cpp' }
Plug 'heavenshell/vim-pydocstring', { 'for' : 'python' }

" cpp highlighting
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }

" Python virtualenv
Plug 'plytophogy/vim-virtualenv'

" 'hybrid' line numbers
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" Code completion
Plug 'ajh17/VimCompletesMe', { 'for': ['sh', 'c', 'cpp', 'bash', 'python'] }

" endif
call plug#end()
" #end plugins ---------------------------------------------------------------

syntax enable

"set nofoldenable

set foldmethod=syntax
" z+o opens a fold at the cursor.
" z+Shift+o opens all folds at the cursor.
" z+c closes a fold at the cursor.
" z+m increases the foldlevel by one.
" z+Shift+m closes all open folds.
" z+r decreases the foldlevel by one.
" z+Shift+r all folds will be open."

" Leader key '-'
let mapleader = ","

" Buffer goodies
" Tab to cycle forward
nnoremap <silent> <Tab> :bnext!<CR>
" Shift Tab to cycle backwards
nnoremap <silent> <S-Tab> :bprevious!<CR>

" '\' to Ag
nnoremap \ :Ag<SPACE>

filetype plugin indent on       " Enable file type support
"set completeopt-=preview        " don't show preview window

set colorcolumn=80
set showcmd                     " Show current command
set showmode                    " Show current mode
set autoread                    " Auto reload
set ttyfast                     " Fast terminal
set encoding=utf-8              " utf-8
set nu                          " Line numbers
set ignorecase                  " Ignore case when searching
set ruler                       " Always show current position
set hlsearch                    " Highlight all search results
set smartcase                   " Enable smart-case search
set incsearch                   " Searches for strings incrementally
set showmatch                   " Highlight matching brace
set visualbell                  " Use visual bell (no beeping)
set tabstop=4                   " number of spaces <tab>
set expandtab
set shiftwidth=4                " << and >> indentation
set softtabstop=4               " Number of spaces per Tab
set autoindent                  " indentation
set backspace=indent,eol,start

set pastetoggle=<F10>
nnoremap <F10> :set invpaste paste?<CR>

" Remove Trailing Whitespace
autocmd BufWritePre * :%s/\s\+$//e
" Remember line of file when closing.
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  " Notify non-ascii characters on current buffer.
  " TODO: Make it pretty; something like this
  " :silent exec '!echo \\n Found following lines containing non-ascii' 
  au BufWriteCmd * write | :silent exec '!grep --color=auto -P -n "[^[:ascii:]]" '.shellescape(@%, 1)
endif

" Typos
cnoreabbrev W w
cnoreabbrev Q q
command! Qa :qa!

" Ctags
set tags=tags

" netrw
nmap <F6> :Lexplore<CR>
let g:netrw_list_hide= '.*\.BIN$,.*\.LIB$,.*\.OBJ$,.*\.IMAGE$'
let g:netrw_hide = 1
let g:netrw_banner=0
let g:netrw_winsize=15
let g:netrw_liststyle=3

syntax on
colorscheme onedark
" use jellybeans theme when using vimdiff
if &diff
    colorscheme jellybeans
endif

" Splits
set splitbelow                  " Horizontal split below / :split
set splitright                  " Vertical split right   / :vsplit

" Quicker window movement..
" Instead of 'ctrl-w' then 'j', it's just 'ctrl-j'
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"FZF
nnoremap <silent> <C-p> :Files<CR>

" Tagbar
nnoremap <F8> :TagbarToggle<CR>
let g:tagbar_autofocus=0
let g:tagbar_right=1
let g:tagbar_width=35

" Vim airline
set laststatus=2
let g:airline_theme='onedark'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemod=':t'


" Italics
highlight Comment cterm=italic
highlight htmlArg cterm=italic

" == Python ==
" Run python on the current buffer
autocmd filetype python nnoremap <buffer> <F5> :w <bar> exec '!python '.shellescape(@%, 1)<CR>

" ctags and virtual env settings
autocmd filetype python nnoremap <F9> :!ctags -R -f $VIRTUAL_ENV/tags $VIRTUAL_ENV/lib/python3.6/site-packages ${PWD} &> /dev/null & disown<CR>
autocmd filetype python nnoremap ,t :set tags=$VIRTUAL_ENV/tags<CR>
autocmd filetype python nnoremap ,l :VirtualEnvList<CR>
autocmd filetype python nnoremap ,m :Pydocstring <CR>

" == C / C++ ==
" AutoFormat
let g:formatdef_clangformat='"clang-format -style=file"'
let g:clang_format#style_options = {
           \ "AccessModifierOffset" : -4,
           \ "AllowShortIfStatementsOnASingleLine" : "true",
           \ "AlwaysBreakTemplateDeclarations" : "true",
           \ "Standard" : "C++11"}
" ',' + 'cf'
autocmd fileType c,cpp nnoremap <buffer> ,cf :<C-u>ClangFormat<CR>
autocmd fileType c,cpp ClangFormatAutoEnable

" handy build hotkey to test something real quick.
autocmd filetype c     nnoremap <F5> :w <bar> exec '!gcc '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
autocmd filetype cpp   nnoremap <F5> :w <bar> exec '!g++ '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
" Doxygen
autocmd filetype c,cpp nnoremap ,m :Dox <CR>
