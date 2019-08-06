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

" debugger UI toolkit
Plug 'snare/voltron', { 'do' : './install.sh -u' }

" Formatting of cpp
Plug 'rhysd/vim-clang-format', {'for': 'cpp'}

" Doxygen ; :Dox to activate
Plug 'vim-scripts/DoxygenToolkit.vim', { 'for': 'cpp' }
" cpp highlighting
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }

" YouCompleteMe
" if has("python")
function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.py --clang-completer --tern-completer
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
"nnoremap <silent> <C-w> :bd<CR>
"
nnoremap <C-Left> :resize -10<CR>
nnoremap <C-Right> :resize 10<CR>
nnoremap <C-Up> :vertical resize 10<CR>
nnoremap <C-Down> :vertical resize -10<CR>

" '\' to Ag
nnoremap \ :Ag<SPACE>

filetype plugin indent on       " Enable file type support
set completeopt-=preview   " don't show preview window

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

" Ctags
nnoremap <F9> :!ctags -R -f $VIRTUAL_ENV/tags $VIRTUAL_ENV/lib/python3.6/site-packages<CR>
set tags=$VIRTUAL_ENV/tags

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
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" YouCompleteMe key bindings
nnoremap <F11> :YcmForceCompileAndDiagnostics<CR>
nnoremap <F12> :YcmDiags<CR>

" YcmCompleter Subcommands
nnoremap <silent> <Leader>yd :YcmCompleter GetDoc<CR>
nnoremap <silent> <Leader>yf :YcmCompleter FixIt<CR>
nnoremap <silent> <Leader>yg :YcmCompleter GoTo<CR>
nnoremap <silent> <Leader>yi :YcmCompleter GoToInclude<CR>
nnoremap <silent> <Leader>yt :YcmCompleter GetType<CR>

" python3 << EOF
" import sys, vim, os

" ve_dir = vim.eval('$VIRTUAL_ENV')
" ve_dir in sys.path or sys.path.insert(0, ve_dir)
" activate_this = os.path.join(os.path.join(ve_dir, 'bin'), 'activate_this.py')
" EOF

" AutoFormat
let g:formatdef_clangformat='"clang-format -style=file"'

" Get off my lawn
"nnoremap <Left> :echoe "<- Use h"<CR>
"nnoremap <Right> :echoe "-> Use l"<CR>
"nnoremap <Up> :echoe "^ Use k"<CR>
"nnoremap <Down> :echoe "v Use j"<CR>

" Italics
highlight Comment cterm=italic
highlight htmlArg cterm=italic
