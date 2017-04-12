" dphung

" #start plugins -------------------------------------------------------------
call plug#begin('~/.vim/plugged')
Plug 'majutsushi/tagbar'
Plug 'scrooloose/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

" Colour themes
Plug 'joshdick/onedark.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'neilhwatson/vim_cf3', { 'for' : 'cf' }

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Uber fast fuzzy finder
Plug 'junegunn/fzf', { 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'

Plug 'snare/voltron', { 'do' : './install.sh -u' }
" On demand plugins
Plug 'rhysd/vim-clang-format', {'for': 'cpp'}
" Doxygen
Plug 'vim-scripts/DoxygenToolkit.vim', { 'for': 'cpp' }
" cpp highlighting
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
" Golang
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }
" Track the engine.
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

" YouCompleteMe
" if has("python")
function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.py --clang-completer  --gocode-completer --tern-completer
  endif
endfunction

Plug 'Valloric/YouCompleteMe', { 'for': ['sh', 'c', 'cpp', 'cs', 'python'], 'do': function('BuildYCM') }
    " --racer-completer if you want rust
" endif
call plug#end()
" #end plugins ---------------------------------------------------------------

" The goodies
syntax enable
set nofoldenable
" Leader key '-'
let mapleader = ","

" Buffer goodies
" Tab to cycle forward
nnoremap <silent> <Tab> :bnext!<CR>
" Shift Tab to cycle backwards
nnoremap <silent> <S-Tab> :bprevious!<CR>
" Ctrl-w to remove current buffer
nnoremap <silent> <C-w> :bd<CR>

" '\' to Ag
nnoremap \ :Ag<SPACE>

filetype plugin indent on       " Enable file type support
set completeopt-=preview
set colorcolumn=80
set showcmd                     " Show current command
set showmode                    " Show current mode
set autoread                    " Auto reload
set ttyfast                     " Fast terminal
set encoding=utf-8
set pastetoggle=<F10>
nnoremap <F10> :set invpaste paste?<CR>
set ignorecase      " Ignore case when searching
set ruler           " Always show current position
set hlsearch        " Highlight all search results
set smartcase       " Enable smart-case search
set incsearch       " Searches for strings incrementally
set showmatch       " Highlight matching brace
set visualbell      " Use visual bell (no beeping)
set tabstop=4
set shiftwidth=4
set autoindent
set cindent
set softtabstop=4   " Number of spaces per Tab
set expandtab
set backspace=indent,eol,start
set nu              " Line numbers
" Remove Trailing Whitespace
autocmd BufWritePre * :%s/\s\+$//e
" Remember line of file when closing.
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Typos
cnoreabbrev W w
cnoreabbrev Q q
command! Qa :qa!


" Spell checking
set spelllang=en_us             " Default language
set complete+=kspell            " Word completion
map <F7> :setlocal spell!<CR>   " Toggle spell check

" Ctags
set tags=tags

" Doxygen
autocmd Filetype c,cpp set comments^=:///

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

" Signify
let g:signify_vcs_list = [ 'git', 'hg', 'svn' ]

"FZF
nnoremap <silent> <C-p> :Files<CR>

" Tagbar
nnoremap <F8> :TagbarToggle<CR>
let g:tagbar_autofocus=0
"let g:tagbar_left=1
let g:tagbar_right=1
let g:tagbar_width=35

" Vim airline
set laststatus=2
let g:airline_theme='onedark'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemod=':t'

" YouCompleteMe
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_confirm_extra_conf = 0
let g:ycm_extra_conf_globlist=['~/.vim/*']
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_always_populate_location_list = 0
let g:ycm_auto_trigger=1
let g:ycm_enable_diagnostic_highlighting=1
let g:ycm_enable_diagnostic_signs=1
let g:ycm_max_diagnostics_to_display=10000
let g:ycm_min_num_identifier_candidate_chars=0
let g:ycm_min_num_of_chars_for_completion=2
let g:ycm_open_loclist_on_ycm_diags=1
let g:ycm_show_diagnostics_ui=1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_filetype_blacklist={
            \ 'vim' : 1,
            \ 'tagbar' : 1,
            \ 'qf' : 1,
            \ 'notes' : 1,
            \ 'markdown' : 1,
            \ 'md' : 1,
            \ 'unite' : 1,
            \ 'text' : 1,
            \ 'vimwiki' : 1,
            \ 'pandoc' : 1,
            \ 'infolog' : 1,
            \ 'mail' : 1
            \}
"
" YouCompleteMe Omni-Completion
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

" YouCompleteMe key bindings
nnoremap <F11> :YcmForceCompileAndDiagnostics<CR>
nnoremap <F12> :YcmDiags<CR>

" YcmCompleter Subcommands
nnoremap <silent> <Leader>yd :YcmCompleter GetDoc<CR>
nnoremap <silent> <Leader>yf :YcmCompleter FixIt<CR>
nnoremap <silent> <Leader>yg :YcmCompleter GoTo<CR>
nnoremap <silent> <Leader>yi :YcmCompleter GoToInclude<CR>
nnoremap <silent> <Leader>yt :YcmCompleter GetType<CR>

python3 << EOF
import sys, vim, os

ve_dir = vim.eval('$VIRTUAL_ENV')
ve_dir in sys.path or sys.path.insert(0, ve_dir)
activate_this = os.path.join(os.path.join(ve_dir, 'bin'), 'activate_this.py')
EOF

" AutoFormat
let g:formatdef_clangformat='"clang-format -style=file"'

" Doxygen
let g:DoxygenToolkit_commentType = "C++"

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq = 0

" Syntastic Checkers
let g:syntastic_cpp_checkers=['cppcheck']
let g:syntastic_javascript_checkers = ['jshint']
"let g:syntastic_python_checkers=['pylint']
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = '--ignore="E501,E302,E261,E701,E241,E126,E127,E128,W801"'

"snippets
let g:UltiSnipsExpandTrigger="<C-Space>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" disable syntastic errors
silent! nmap <F6> :SyntasticToggleMode<CR>

" Get off my lawn
nnoremap <Left> :echoe "<- Use h"<CR>
nnoremap <Right> :echoe "-> Use l"<CR>
nnoremap <Up> :echoe "^ Use k"<CR>
nnoremap <Down> :echoe "v Use j"<CR>

" Italics
highlight Comment cterm=italic
highlight htmlArg cterm=italic
