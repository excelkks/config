" ===
" === Auto load Plug
" ===
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ===
" === System setting
" ===

" 使配色兼容终端
let &t_ut=''
set autochdir

"设置编码
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set nu
set relativenumber
filetype plugin indent on
syntax on
colorscheme desert

"突出当前行
set cursorline
"突出当前列
"set cursorcolumn

set showmatch
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set cindent
" 显示空格、行尾、制表符等
set list
set listchars=tab:>-,trail:-,nbsp:+
set viewoptions=cursor,folds,slash,unix
set wrap
set foldenable
set foldmethod=indent    "zo,zO,zc,zC,za,zA,[z,]z,zj,zk
set splitright
set splitbelow
set showcmd
set wildmenu
set ignorecase
set smartcase
set visualbell
" set paste
set laststatus=2
set ruler

set colorcolumn=80
set updatetime=1000


if has('persistent_undo')
    set undofile
    set undodir=~/.config/nvim/tmp/undo,.
endif



call plug#begin('~/.vim/plugged')

call plug#end()

