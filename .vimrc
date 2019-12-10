" nvim to vim
" :%s/.config\/nvim/.vim/g
" vim to nvim
" :%s/.vim/.config\/nvim/g
" ===
" === Auto load Plug
" ===
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
if empty(glob('~/.vim/colors/solarized.vim'))
    silent !curl -fLo ~/.vim/colors/solarized.vim --create-dirs
                \ https://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim
endif

" ===
" === System setting
" ===
"
set nocompatible
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

" 使配色兼容终端
let &t_ut=''
set autochdir

"设置编码
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set nu
set relativenumber
syntax on
" colorscheme desert
colorscheme solarized
" color snazzy
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
set listchars=tab:▸-,trail:-,nbsp:+
set viewoptions=cursor,folds,slash,unix
set nowrap
set nofoldenable
set foldmethod=indent    "zo,zO,zc,zC,za,zA,[z,]z,zj,zk
set splitright
set splitbelow
set showcmd
set wildmenu
set ignorecase
set smartcase
set hlsearch    "临时取消高亮 :noh
set visualbell
" set paste
set laststatus=2
set ruler

" set colorcolumn=80
set updatetime=1000
set scrolloff=5

" Cursor shape
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

silent !mkdir -p ~/.vim/tmp/backup
silent !mkdir -p ~/.vim/tmp/undo
set backupdir=~/.vim/tmp/backup,.
set directory=~/.vim/tmp/backup,.
if has('persistent_undo')
    set undofile
    set undodir=~/.vim/tmp/undo,.
endif

" 回到上次编辑的位置
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        " set splitbelow
        exec "!g++ -std=c++11 % -Wall -o %<"
        exec "!time ./%<"
        " :sp
        " :res -15
        " :term ./%<
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!time python3 %"
        " set splitbelow
        " :sp
        " :term python3 %
    elseif &filetype == 'html'
        silent! exec "!chromium % &"
    elseif &filetype == 'markdown'
        exec "MarkdownPreview"
    elseif &filetype == 'tex'
        silent! exec "VimtexStop"
        silent! exec "VimtexComplie"
    elseif &filetype == 'go'
        exec "!go buuld %<"
        exec "!time go run %"
        " set splitbelow
        " :sp
        " :term go run %
    endif
endfunc


call plug#begin('~/.vim/plugged')
" python
" Semshi provides semantic highlighting for Python in Neovim
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'tweekmonster/braceless.vim'
" Plug 'jaxbot/semantic-highlight.vim'
Plug 'jiangmiao/auto-pairs'

" File navi
Plug 'scrooloose/nerdtree'

" bar
Plug 'liuchengxu/eleline.vim'

" snippet
Plug 'SirVer/ultisnips'
Plug 'excelkks/vim-snippets'
" Plug 'connorholyday/vim-snazzy'

" autocomplete
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

noremap <C-n> :NERDTreeToggle<CR>
noremap <C-j> 5j
noremap <C-k> 5k
noremap <C-h> 10h
noremap <C-l> 10l

noremap ff <Esc>
noremap!  ff <Esc>

" placeholder
inoremap ph <++>
noremap <space><space> <Esc>/<++><CR>:noh<CR>c4l

" split
noremap sl :vsp<space>
noremap sh :set nosplitright<CR>:vsp<space>
noremap sj :split<space>
noremap sk :set nosplitbelow<CR>:split<space>
" change windows
noremap <space>k <C-w>k
noremap <space>j <C-w>j
noremap <space>h <C-w>h
noremap <space>l <C-w>l

noremap sv <C-w>t<C-w>H
noremap sh <C-w>t<C-w>K

" resize
noremap <up> :res +5<CR>
noremap <down> :res -5<CR>
noremap <left> :vertical resize-5<CR>
noremap <right> :vertical resize+5<CR>
" tab
noremap tn :tabe<space>
noremap th :-tabnext<CR>
noremap tl :+tabnext<CR>

