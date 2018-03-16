" Hugo Moraes Dzin .vimrc


if has("win32")
    let $PATH .= ';C:\dev\Python27'
    let $PATH .= ';C:\dev\mingw64\bin'
    let $PATH .= ';C:\Users\Hugo\Anaconda3'
    let $PATH .= ';C:\Users\Hugo\Anaconda3\Scripts'

    set langmenu=none
    set guifont=mononoki:h9:cANSI:qDRAFT
    set guioptions-=T

    " Open in fullscreen
    autocmd GUIEnter * simalt ~x
    " Disable chime
    autocmd GUIEnter * set vb t_vb=

    let $MYVIMRC = '~/_vimrc'
    let $VIMDIR  = '~/vimfiles'
    let $PLUGINS = $VIMDIR . '/plugged'
elseif has("win32unix")
    set guioptions-=T

    set rtp+=~/vimfiles
    let $VIMDIR  = '~/vimfiles'
    let $PLUGINS = $VIMDIR . '/cyg_plugged'
else
    let $VIMDIR  = '~/.vim'
    let $PLUGINS = $VIMDIR . '/plugged'
endif



call plug#begin($PLUGINS)

Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/syntastic'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'Vimjas/vim-python-pep8-indent'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'

Plug 'danielepiccone/vim-css-indent'
Plug 'elzr/vim-json'
Plug 'hail2u/vim-css3-syntax'
Plug 'mattn/emmet-vim'
Plug 'ap/vim-css-color'

Plug 'veloce/vim-aldmeris'
Plug 'oblitum/rainbow'

call plug#end()


filetype plugin indent on
syntax enable

colorscheme aldmeris

com! Cel exec getline('.')
com! Cvc edit $MYVIMRC
com! Cvr edit $VIMDIR/vimrc.vim
com! Csv source $MYVIMRC
com! Cbd bn | bd #

set backspace=2 " Windows
set hidden
set mouse=a
set number
set lazyredraw
set wildignore+=*.o,*.d,*.out
set wildmenu

" Show tabs and trailing whitespace
set list
set listchars=tab:\|\ ,trail:\.

set incsearch
set hlsearch

set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent

" Reload modified files
set autoread
set nobackup
set noswapfile

set encoding=utf-8
set fileencoding=utf-8

" Always show status line on bottom
set laststatus=2


fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l,c)
endfun



" Indentation
set sts=4 sw=4 ts=4 et

augroup indentgroup
    autocmd FileType html
    \	setlocal sts=2 sw=2 ts=2 et
augroup END


let rainbow_blacklist = ['vim', 'html', 'css', 'json']
let whitespace_blacklist = []

augroup configgroup
    autocmd FileType *
    \   if index(rainbow_blacklist, &ft) < 0 | call rainbow#toggle()

    autocmd BufWritePre,FileWritePre *
    \   if index(whitespace_blacklist, &ft) < 0 | call <SID>StripTrailingWhitespaces()

    autocmd BufRead,BufNewFile .jshintrc
    \   setlocal ft=json

    " Light up statusbar when in insertion mode
    autocmd InsertEnter *
    \   hi StatusLine ctermfg=7 term=reverse
    autocmd InsertLeave *
    \   hi StatusLine ctermfg=0 term=reverse
augroup END


let g:rainbow_ctermfgs = [
            \ 'brown',
            \ 'blue',
            \ 'red',
            \ 'cyan',
            \ 'magenta',
            \ ]


let mapleader = ','

let NERDTreeQuitOnOpen = 1

let g:ctrlp_follow_symlinks = 2
let g:ctrlp_custom_ignore = 'node_modules\|git'
let g:user_emmet_leader_key = '<C-Z>'
let g:vim_json_syntax_conceal = 0


let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"


let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_c_check_header     = 1
let g:syntastic_c_compiler_options = '-Wall -Wextra'
let g:syntastic_c_include_dirs     = ['.', 'include', 'build']

let g:syntastic_cpp_check_header     = 1
let g:syntastic_cpp_compiler_options = '-Wall -Wextra -std=c++14'
let g:syntastic_cpp_include_dirs     = g:syntastic_c_include_dirs

let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_python_checkers = ['flake8']


" Maps
vn ; :
nn ; :
nn : :C

nn j gj
nn k gk

no <down> gj
no <up> gk

nn <leader><space> :nohlsearch<CR>
nn <space> za
nn Y y$
ino çç <Esc>


" Navigate buffers:
" :ls - show list
" :b PATTERN - open buffer that matches pattern
" :bn next buffer
" :bp previous buffer

" Tabs
nn <C-Up> :tabnew<CR>
nn <C-Down> :tabclose<CR>
nn <C-Left> :tabprevious<CR>
nn <C-Right> :tabnext<CR>

" Create splits
nn <leader>h :vsplit<CR>
nn <leader>j :split<CR><C-W><C-J>
nn <leader>k :split<CR>
nn <leader>l :vsplit<CR><C-W><C-L>

" Navigate splits
nn <C-H> <C-W>h
nn <C-J> <C-W>j
nn <C-K> <C-W>k
nn <C-L> <C-W>l

" Brace matching
ino (<Space> ()<Esc>i
ino [<Space> []<Esc>i
ino {<Space> {}<Esc>i

ino (<CR> (<CR>)<Esc>ko
ino {<CR> {<CR>}<Esc>ko
ino [<CR> [<CR>]<Esc>ko

ino [,<CR> [<CR>],<Esc>ko
ino {,<CR> {<CR>},<Esc>ko

ino [;<CR> [<CR>];<Esc>ko
ino {;<CR> {<CR>};<Esc>ko

ino (} () {<CR>}<ESC>k$F)i
ino {)<CR> {<CR>});<Esc>ko
