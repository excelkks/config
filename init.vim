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
"
set nocompatible
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

" 使配色兼容终端
let &t_ut=''

"设置编码
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set nu
set relativenumber
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
set listchars=tab:▸-,trail:-,nbsp:+
set viewoptions=cursor,folds,slash,unix
set nowrap
set linebreak    " do not break within a word when wrap a line
set nofoldenable
set foldmethod=indent    "zo,zO,zc,zC,za,zA,[z,]z,zj,zk
set showcmd
set wildmenu
set incsearch
set ignorecase
set smartcase
set hlsearch
" set visualbell
set noerrorbells
" set paste
set laststatus=2    " enable statu bar
set ruler

" set colorcolumn=80
set updatetime=300

" Cursor shape
let &t_SI = "\<Esc>]50;CursorShape=0\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
if has('persistent_undo')
    set undofile
    set undodir=~/.config/nvim/tmp/undo,.
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
" Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'tweekmonster/braceless.vim'
" Plug 'jaxbot/semantic-highlight.vim'

Plug 'scrooloose/nerdtree'

" bar
Plug 'liuchengxu/eleline.vim'

" snippet
" Plug 'SirVer/ultisnips'
" Plug 'excelkks/vim-snippets'

" auto complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

""""""""""""""
"  coc.vim   "
""""""""""""""
set hidden
" Give more space for displaying messages.
set cmdheight=2
set shortmess+=c
if has("patch-8.1.1564")
    set signcolumn=number
else
    set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Use <CR> to confirm completion, `<C-g>u` means break undo chain at current
" positon. Coc only does snippt and additional edit on confirm.
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

let g:coc_global_extensions = ['coc-html', 'coc-clangd', 'coc-python', 'coc-json', 'coc-highlight']

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostics-prev)
nmap <silent> ]g <Plug>(coc-diagnostics-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap rn <Plug>(coc-rename)



"""""""""""""""
"  basic map  "
"""""""""""""""

map <C-n> :NERDTreeToggle<CR>

noremap ff <Esc>
inoremap ff <Esc>
nnoremap < <<
nnoremap > >>

" split
noremap sl :set splitright<CR>:vsp<space>
noremap sh :set nosplitright<CR>:vsp<space>
noremap sj :set splitbelow<CR>:split<space>
noremap su :set nosplitbelow<CR>:split<space>

" resize
noremap <up> "res +5<CR>
noremap <down> "res -5<CR>
noremap <left> "vertival resize +5<CR>
noremap <right> "vertival resize -5<CR>

" command mode cursor movement
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-w> <S-Right>

noremap <space>h <C-w>h
noremap <space>l <C-w>l
noremap <space>j <C-w>j
noremap <space>k <C-w>k
