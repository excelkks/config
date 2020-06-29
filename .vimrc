" need system application
" 1.ctags (universal ctags)
" 2.pynvim(pip install pynvim)
" 3.the_silver_searcher (for fzf :Ag)


" ===
" === auto load plug
" ===

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
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
set expandtab
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
" set foldenable     " zo for open zc for close,(zo,z0,zc,zC,za,zA,[z,]z,zj,zk
set formatoptions-=tc
set splitright
set splitbelow
"set noshowmode
set hlsearch
set showcmd
set wildmenu
set ignorecase
set smartcase
set shortmess+=c
" set inccommand=split
set completeopt=longest,noinsert,menuone,noselect,preview
set ttyfast
set lazyredraw    " don't redraw implement macro
set novisualbell
set laststatus=2
silent !mkdir -p ~/.vim/tmp/backup
silent !mkdir -p ~/.vim/tmp/undo
set backupdir=~/.vim/tmp/backup,.
set directory=~/.vim/tmp/backup,.
if has('persistent_undo')
    set undofile
    set undodir=~/.vim/tmp/undo,.
endif
"set colorcolumn=100
"set updatetime=1000
set virtualedit=block

set mouse=a

" ctags
set tags=./.tags;,.tags    " don't forget renew ctags, don't use exuberant ctags, ** Univeral ctags ** instead.

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" ===
" === Basic Mappings
" ===
" let mapleader=" "
" noremap ; :

noremap ff <Esc>:w<CR>
inoremap ff <Esc>:w<CR>

" rc
noremap <space>rc :e ~/.vimrc<CR>
" Indentation
nnoremap < <<
nnoremap > >>
" nohl
noremap <space><CR> :nohlsearch<CR>
"split
noremap sl :set splitright<CR>:vsp<space>
noremap sh :set nosplitright<CR>:vsp<space>
noremap sj :set splitbelow<CR>:split<space>
noremap su :set nosplitbelow<CR>:split<space>

" resize
noremap <up> :res +5<CR>
noremap <down> :res -5<CR>
noremap <left> :vertical resize -5<CR>
noremap <right> :vertical resize +5<CR>

" command mode cursor movement
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-w> <S-Right>

" window focus
noremap <space>h <C-w>h
noremap <space>l <C-w>l
noremap <space>j <C-w>j
noremap <space>k <C-w>k

" tab focus
noremap J :tabNext<CR>
noremap K :tabprevious<CR>

" <++> placeholder
noremap <space><space> <Esc>/<++><CR>:nohlsearch<CR>c4l

" Call figlet
noremap tx :r !figlet<space>

noremap <space>s :%s//g<left><left>

" Compile function
noremap <C-F5> :call CompileRunGcc()<CR>
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
Plug 'ludovicchabant/vim-gutentags'  " generate ctags auto 
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

" snippets
Plug 'SirVer/ultisnips'
Plug 'excelkks/vim-snippets'

" Plug 'bling/vim-bufferline'
Plug 'ajmwagar/vim-deus'

" don't get install the_silver_searcher to use :Ag to search string in text
Plug 'junegunn/fzf', { 'do':{ -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" TODO
" check and semantic errors
Plug 'dense-analysis/ale'

" markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" debug TODO
" Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-c --enable-python --enable-go'}

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" TODO
" Go
Plug 'fatih/vim-go', { 'for': ['go', 'vim-plug'], 'tag': '*' }

" python
" Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for' :['python', 'vim-plug']}

" other
Plug 'jiangmiao/auto-pairs'
" Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'gcmt/wildfire.vim'     "type <Enter> to visual i ''
Plug 'junegunn/vim-after-object'  " da= to delete what's after =
Plug 'godlygeek/tabular'  " Tabularize <regex> to align

" writting
Plug 'junegunn/goyo.vim'
" calender
Plug 'itchyny/calendar.vim'

" Plug 'ryanoasis/vim-devicons'

Plug 'jceb/vim-orgmode' 

" Plug 'ianva/vim-youdao-translater'

" latex
" Plug 'lervag/vimtex'
Plug 'xuhdev/vim-latex-live-preview',   {'for': 'tex'}

" wiki
Plug 'vimwiki/vimwiki'

" tarbar
Plug 'majutsushi/tagbar'

" speeddating
Plug 'tpope/vim-speeddating'

call plug#end()

" ===
" === nerdtree
" ===
noremap <c-n> :NERDTreeToggle<CR>
"     
"     
"     
" ===
" === vim-illuminate
" ===
let g:Illuminate_delay = 550
let g:Illuminate_ftblacklist=['nerdtree']
let g:Illuminate_highlightUnderCursor = 0
"hi illuminatedWord cterm=undercurl gui=undercurl

" ===
" === vim-rooter
" ===
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_patterns = ['Rakefile', '.root', '.svn', '.project', '.git/']
autocmd BufEnter * :Rooter


" ===
" === vim-deus
" ===
set t_Co=256

" let &t_8f = "\<Esc>[38;2%lu;%lu;%lum"
" let &t_8b = "\<Esc>[48;2%lu;%lu;%lum"

set background=dark    " setting dark mode
colors deus
"colorscheme desert
let g:deus_termcolors=256


"     " ===
"     " === asynctasks.vim && asyncrun.vim
"     " ===
"     "     let g:asyncrun_open = 6
"     "     let g:asynctasks_term_pos = 'tab'
"     "     " noremap <silent><f5> :AsyncTask file-run<cr>
"     "     noremap <silent><f5> :AsyncTask file-build<cr>
"     "     " project root directory
"     "     let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg']

" ===
" === markdown-preview.nvim
" ===

" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 1

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 1

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
" let g:mkdp_markdown_css = '~/markdown.css'

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = '8222'

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '${name}'

"    " ===
"    " === vimspector
"    " ===
"    let g:vimspector_enable_mappings = 'HUMAN'
"    function! s:read_template_into_buffer(template)
"    	" has to be a function to avoid the extra space fzf#run insers otherwise
"    	execute '0r ~/.config/nvim/sample_vimspector_json/'.a:template
"    endfunction
"    command! -bang -nargs=* LoadVimSpectorJsonTemplate call fzf#run({
"    			\   'source': 'ls -1 ~/.config/nvim/sample_vimspector_json',
"    			\   'down': 20,
"    			\   'sink': function('<sid>read_template_into_buffer')
"    			\ })
"    noremap <space>vs :tabe .vimspector.json<CR>:LoadVimSpectorJsonTemplate<CR>
"    sign define vimspectorBP text=☛ texthl=Normal
"    sign define vimspectorBPDisabled text=☞ texthl=Normal
"    sign define vimspectorPC text=🔶 texthl=SpellBad


" ===
" === vim-after-object
" ===
autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')


" ===
" === tabular
" ===
vmap ga :Tabularize /


"     " ===
"     " === Goyo.vim
"     " ===
"     map <space>gy :Goyo<CR>


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
" === vim-latex-live-preview
" ===
autocmd filetype tex setl updatetime=1000
let g:livepreview_engine = 'xelatex'
let g:livepreview_previewer='open -a Skim'


" ===
" === vimwiki
" ===
let g:vimwiki_list = [{'path': '~/vimwiki/',
            \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_folding = 'expr'
let g:vimwiki_diary_months = {
      \ 1: '一月', 2: '二月', 3: '三月',
      \ 4: '四月', 5: '五月', 6: '六月',
      \ 7: '七月', 8: '八月', 9: '九月',
      \ 10: '十月', 11: '十一月', 12: '十二月'
      \ }



" ===
" === Dress up my vim
" ===
set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
hi NonText ctermfg=gray guifg=gray10
