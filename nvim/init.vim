" ===
" === auto load plug
" ===

if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" ====================
" === Editor Setup ===
" ====================
" ===
" === System
" ===
"set clipboard=unnamedplus
let &t_ut=''
set autochdir


" ===
" === Editor behavior
" ===
set number
set relativenumber
set cursorline
set noexpandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
" set list
" set listchars=tab:\|\ ,trail:▫
set scrolloff=4
set ttimeoutlen=0
set notimeout
set viewoptions=cursor,folds,slash,unix
set wrap
set textwidth=0
set indentexpr=
set foldmethod=indent
set foldlevel=99
set foldenable     " zo for open zc for close,(zo,z0,zc,zC,za,zA,[z,]z,zj,zk
set formatoptions-=tc
set splitright
set splitbelow
"set noshowmode
set showcmd
set wildmenu
set ignorecase
set smartcase
set shortmess+=c
set inccommand=split
set completeopt=longest,noinsert,menuone,noselect,preview
set ttyfast
set lazyredraw    " don't redraw implement macro
set novisualbell
set laststatus=2
silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
if has('persistent_undo')
	set undofile
	set undodir=~/.config/nvim/tmp/undo,.
endif
"set colorcolumn=100
" set updatetime=1000
set virtualedit=block
" color deus
" ctags
set tags=./.tags;,.tags    " don't forget renew ctags, don't use exuberant ctags, ** Univeral ctags ** instead.

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" ===
" === Basic Mappings
let mapleader=" "
" noremap ; :

noremap ff <Esc>
inoremap ff <Esc>

" rc
noremap <LEADER>rc :e ~/.config/nvim/init.vim<CR>
" Indentation
nnoremap < <<
nnoremap > >>
" nohl
noremap <LEADER><CR> :nohlsearch<CR>
"split
noremap sl :set splitright<CR>:vsp<space>
noremap sh :set nosplitright<CR>:vsp<space>
noremap sj :set splitbelow<CR>:split<space>
noremap su :set nosplitbelow<CR>:split<space>

" resize
noremap <up> :res +5<CR>
noremap <down> :res -5<CR>
noremap <left> :vertical resize +5<CR>
noremap <right> :vertical resize -5<CR>

" command mode cursor movement
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-w> <S-Right>

noremap <LEADER>h <C-w>h
noremap <LEADER>l <C-w>l
noremap <LEADER>j <C-w>j
noremap <LEADER>k <C-w>k

" <++> placeholder
noremap <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4l

" Call figlet
noremap tx :r !figlet<space>

"noremap <LEADER>s :%s//g<left><left>

" Compile function
noremap <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
		:sp
		:res -15
		:term ./%<
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "MarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'dart'
		CocCommand flutter.run -d iPhone\ 11\ Pro
		CocCommand flutter.dev.openDevLog
	elseif &filetype == 'javascript'
		set splitbelow
		:sp
		:term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run .
	endif
endfunc




call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'ludovicchabant/vim-gutentags'
" highlight other uses of the current word under the cursor
Plug 'RRethy/vim-illuminate'
" split or joint lines
"Plug 'AndrewRadev/splitjoin.vim'    " gS, gJ
"Plug 'skywind3000/asyncrun.vim'
"Plug 'pechorin/any-jump.vim'
" change to project directory
Plug 'airblade/vim-rooter'
" Plug 'skywind3000/asynctasks.vim'
" Plug 'skywind3000/asyncrun.vim'
Plug 'liuchengxu/eleline.vim'
Plug 'bling/vim-bufferline'
Plug 'ajmwagar/vim-deus'

Plug 'junegunn/fzf', { 'do':{ -> fzf#install() } }    "type <Enter> to visual i ''
Plug 'junegunn/fzf.vim'

" check and semantic errors
Plug 'dense-analysis/ale'


" debug
Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-c --enable-python --enable-go'}
" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Go
Plug 'fatih/vim-go', { 'for': ['go', 'vim-plug'], 'tag': '*' }

" python
" Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for' :['python', 'vim-plug']}

" other
Plug 'jiangmiao/auto-pairs'
" Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'gcmt/wildfire.vim'
Plug 'junegunn/vim-after-object'  " da= to delete what's after =
Plug 'godlygeek/tabular'  " Tabularize <regex> to align
" writting
Plug 'junegunn/goyo.vim'
" calender
Plug 'itchyny/calendar.vim'

" Plug 'ryanoasis/vim-devicons'

call plug#end()

" ===
" === nerdtree
" ===
noremap <c-n> :NERDTreeToggle<CR>



" ===
" === vim-illuminate
" ===
let g:Illuminate_delay = 750
let g:Illuminate_ftblacklist=['nerdtree']
hi illuminatedWord cterm=undercurl gui=undercurl

" ===
" === vim-rooter
" ===
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_patterns = ['Rakefile','.git/']


" ===
" === asynctasks.vim && asyncrun.vim
" ===
"     let g:asyncrun_open = 6
"     let g:asynctasks_term_pos = 'tab'
"     " noremap <silent><f5> :AsyncTask file-run<cr>
"     noremap <silent><f5> :AsyncTask file-build<cr>
"     " project root directory
"     let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg']

" ===
" === vimspector
" ===
let g:vimspector_enable_mapping = 'HUMAN'


" ===
" === vim-after-object
" ===
autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')


" ===
" === tabular
" ===
vmap ga :Tabularize /


" ===
" === Goyo.vim
" ===
map <LEADER>gy :Goyo<CR>


" ===
" === vim-calendar
" ===
noremap \\ :Calendar -view=clock -position=here<CR>



" ===
" === vim-gutentags
" ===
" 自动索引 ctags自动更新

" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif




" ===
" === Dress up my vim
" ===
set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
hi NonText ctermfg=gray guifg=gray10
