" 1. the_silver_searcher (brew, known as ag)
" 2. ripgrep (brew, known as rg)
" 3. neovim-remote (pip3, drop/nvr within internal ternminal)
" 4. set ccls source directory for coc-settings.json;
" 5. download proper DAP adapter extension for vimspector
"    ($HOME/.config/nvim/plugged/vimspector/gadgets/os/)
" 6. yarn

" ===
" === Basic Settings
" ===
" simplified chinese
lan zh_CN.utf-8

" nvim config path
let g:configPath=stdpath('config')

if empty(glob(g:configPath.'/autoload/plug.vim'))
    :exe '!curl -fLo '.g:configPath.'/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" neovim config file
noremap <space>rc :exe 'edit '.g:configPath.'/init.vim'<CR>
" reload config file
noremap <space>rl :exe 'source '.g:configPath.'/init.vim'<CR>


" ===
" === Editor Behavior
" ===
set encoding=utf-8
set jumpoptions=stack
set clipboard+=unnamedplus
set nu
set relativenumber
set cursorline
set colorcolumn=80
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set cindent
set indentexpr=
set scrolloff=4
set notimeout
set viewoptions=cursor,folds,slash,unix
set nowrap
set textwidth=0
set foldmethod=syntax
set foldlevel=99
set splitbelow
set splitright
set hlsearch
set noincsearch
set showcmd
set wildmenu
set ignorecase
set smartcase
set shortmess+=mrwc
" set completeopt=longest.noinsert,menuone,noselect,preview
set formatoptions-=tc
set lazyredraw
set novisualbell
set laststatus=3
exe 'silent !mkdir -p '.g:configPath.'/tmp/backup'
exe 'silent !mkdir -p '.g:configPath.'/tmp/undo'
exe 'set backupdir='.g:configPath.'/tmp/backup,.'
exe 'set directory='.g:configPath.'/tmp/backup,.'
if has('persistent_undo')
    set undofile
    exe 'set undodir='.g:configPath.'/tmp/undo,.'
endif
set virtualedit=block
set mouse=a
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set t_Co=256
set t_ut=
set autochdir


au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" ===
" === Key Mappings
" ===

" map 'jj' as '<ESC>' under insert mode
inoremap jj <ESC>

let mapleader = "\<space>"
noremap sl :set splitright<CR>:vsplit<CR>
noremap sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap sj :set splitbelow<CR>:split<CR>
noremap sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
" change layout
" <C-W> J/K/H/L  move window to below/above/left/right
" rotate
" <C-W> R/r  / <C-W><C-R>  rotate windows
" <C-W> T move window to a new tab page
" gt/gT   change tab
"
" close the window below current window
noremap <LEADER>qj <C-w>j:q<CR>
noremap <LEADER>qk <C-w>k:q<CR>
noremap <LEADER>qh <C-w>h:q<CR>
noremap <LEADER>ql <C-w>l:q<CR>

" window focus
nmap <leader>l <C-w>l
nmap <leader>h <C-w>h
nmap <leader>j <C-w>j
nmap <leader>k <C-w>k

" resize
noremap <up> :res +5<CR>
noremap <down> :res -5<CR>
noremap <left> :vertical resize -5<CR>
noremap <right> :vertical resize +5<CR>

noremap <leader>s :%s//g<left><left>

" terminal
noremap <leader>/ :set splitright<CR>:vsplit<CR>:vertical resize -15<CR>:term<CR>

call plug#begin(g:configPath.'/plugged')

Plug 'theniceboy/nvim-deus'
" Plug 'tomasiser/vim-code-dark'
Plug 'excelkks/vscode.nvim'
Plug 'excelkks/vsdark.nvim'
Plug 'ryanoasis/vim-devicons'

" Plug 'theniceboy/eleline.vim'
Plug 'liuchengxu/eleline.vim'
Plug 'ojroques/vim-scrollstatus'

Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
" Plug 'RRethy/vim-illuminate'  " TODO

Plug 'airblade/vim-rooter'
 
" git
Plug 'airblade/vim-gitgutter'
Plug 'cohama/agit.vim'
Plug 'kdheepak/lazygit.nvim' "TODO
Plug 'tpope/vim-fugitive'

Plug 'kevinoid/vim-jsonc'

" enhance editor
Plug 'jiangmiao/auto-pairs'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-surround' " S for suround. [d/c]s for [delete/change]
Plug 'junegunn/vim-after-object' " da= for delete after =
Plug 'godlygeek/tabular'  " type ga to tabulaize
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim' " TODO
" Plug 'mg979/vim-xtabline' " TODO about tab

Plug 'tpope/vim-speeddating'

Plug 'skywind3000/vim-terminal-help'

" completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" snippets
Plug 'excelkks/vim-snippets'

" highlight 
Plug 'jackguo380/vim-lsp-cxx-highlight'

Plug 'psliwka/vim-smoothie'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }

" file finder
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" LaTex
Plug 'lervag/vimtex'

" markdown
Plug 'plasticboy/vim-markdown'
" folding/insertToc/Toc/tableformat
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

" debug
Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-rust --enable-c --enable-python'}

call plug#end()


" " ===
" " === ajmwagar/vim-deus
" " ===
" colors deus
hi NonText ctermfg=gray guifg=grey10

" ===
" === excelkks/vsdark.nvim
" ===
set termguicolors
let g:vsdark_style = "dark"
colors vsdark

" ===
" === theniceboy/eleline.vim
" ===
let g:airline_powerline_fonts = 0

" ===
" === ojroques/vim-scrollstatus
" ===
let g:scrollstatus_size = 15

" " ===
" " === vim-illuminate
" " ===
" let g:Illuminate_delay = 750
" hi illuminatedWord cterm=undercurl gui=undercurl

" ===
" === vim-rooter
" ===
let g:rooter_patterns = ['__vim_project_root', '.git/', '.vscode/', '.project/']
let g:rooter_silent_chdir = 1

" ===
" ===  airblade/vim-gitgutter
" ===
let g:gitgutter_map_keys = 0

" ===
" === cohama/agit.vim
" ===
" git log
nnoremap <leader>gl :Agit<CR>

" ===
" === tomtom/tcomment_vim
" ===
let g:tcomment_textobject_inlinecomment = ''
nmap <LEADER>cn g>c
vmap <LEADER>cn g>
nmap <LEADER>cu g<c
vmap <LEADER>cu g<

" ===
" === junegunn/vim-after-object
" ===
autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ', '/')

" ===
" === tabular
" ===
vmap ga :Tabularize /

" ===
" === skywind3000/asynctasks.vim
" ===
"

" ===
" === skywind3000/asyncrun.vim
" ===
let g:asyncrun_open = 6

" ===
" === neoclide/coc.nvim
" ===
" cocextensions
let g:coc_global_extensions = [
  \ 'coc-json', 
  \ 'coc-tsserver',
  \ 'coc-css',
  \ 'coc-html',
  \ 'coc-vimlsp',
  \ 'coc-highlight',
  \ 'coc-calc',
  \ 'coc-cmake',
  \ 'coc-pyright',
  \ 'coc-snippets'
  \ ]

set signcolumn=number
" <TAB> to select candidate forward or 
" pump completion candidate
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
" <s-TAB> to selecte candidate backward
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.')-1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" <CR> to comfirm selected candidate
" only when there's selected complete item
if exists('*complete_info')
  inoremap <silent><expr> <cr> complete_info(['selected'])['selected'] != -1 ? "\<C-y>" : "\<C-g>u\<CR>"
endif
" " comfirm the first item as completion when there's no item be seleted
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"     \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if(index(['vim', 'help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

highlight  link CocHighlightText Visual  
autocmd CursorHold * silent call CocActionAsync('highlight')  " TODO
nmap <leader>rn <Plug>(coc-rename)

xmap <leader>f <Plug>(coc-format-selected)
" nmap <leader>f <Plug>(coc-format-selected) " conflict with :leaderf file
command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call CocAction('fold', <f-args>)
" organize import 
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" diagnostic info
nnoremap <silent><nowait> <LEADER>d :CocList diagnostics<cr>
nmap <silent> <LEADER>- <Plug>(coc-diagnostic-prev)
nmap <silent> <LEADER>= <Plug>(coc-diagnostic-next)
nmap <leader>qf <Plug>(coc-fix-current)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" statusline support
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :tab sp<CR><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" coc-calc
nmap <leader>ca <Plug>(coc-calc-result-append)
nmap <leader>cr <Plug>(coc-calc-result-replace)

function! s:generate_complile_commands()
    if empty(glob('CMakeLists.txt'))
        echo "Can't find CMakeLists.txt"
        return
    endif
    if empty(glob('.vscode'))
        execute 'silent !mkdir .vscode'
    endif
    execute '!cmake -DCMAKE_BUILD_TYPE=debug 
        \ -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -S . -B .vscode'
endfunction
command! -nargs=0 Gcmake :call s:generate_complile_commands()


" ===
" === jackguo380/vim-lsp-cxx-highlight
" ===
let g:lsp_cxx_hl_use_text_props = 1
" check highlight group under cursor by LspCxxHlCursorSym
" customize
" highlight LspCxxHlSymStructMethod
" highlight LspCxxHlSymField ctermfg=GreenBlue guifg=GreenBlue
hi default link LspCxxHlSymFunction cxxFunction
hi default link LspCxxHlSymFunctionParameter cxxParameter
hi default link LspCxxHlSymParameter cxxParameter
hi default link LspCxxHlSymFileVariableStatic cxxFileVariableStatic
hi default link LspCxxHlSymStruct cxxStruct
hi default link LspCxxHlSymStructField cxxStructField
hi default link LspCxxHlSymFileTypeAlias cxxTypeAlias
hi default link LspCxxHlSymClassField cxxStructField
hi default link LspCxxHlSymEnum cxxEnum
hi default link LspCxxHlSymVariableExtern cxxFileVariableStatic
hi default link LspCxxHlSymVariable cxxVariable
hi default link LspCxxHlSymMacro cxxMacro
hi default link LspCxxHlSymEnumMember cxxEnumMember


" ===
" === Shougo/defx.nvim
" ===
" nnoremap <silent> <leader>e :<C-U>:Defx -winwidth=30 -resume -toggle 
"   \ -buffer_name=explorer -split=vertical -direction=topleft 
"   \ -vertical_preview<CR>
call defx#custom#option('_', {
            \ 'winwidth': 30,
            \ 'split': 'vertical',
            \ 'direction': "topleft",
            \ 'show_ignored_files': 0,
            \ 'buffer_name': '',
            \ 'toggle': 1,
            \ 'resume': 1
            \ })
call defx#custom#column('mark', {
      \ 'readonly_icon': '',
      \ 'selected_icon': '',
      \ })
call defx#custom#column('icon', {
      \ 'directory_icon': '▶',
      \ 'opened_icon': '▼',
      \ 'root_icon': ' ',
      \ })
call defx#custom#column('filename', {
      \ 'max_width': -90,
      \ })

nnoremap <silent><leader>e :Defx<CR>
" nnoremap <silent><buffer><expr> <CR>
"   \ defx#is_directory() ?
"   \ defx#do_action('open_tree', 'recursive:10') :
"   \ defx#do_action('preview')
function! s:defx_init()
    setl nonumber
    setl norelativenumber
    setl listchars=
    setl nofoldenable
    setl foldmethod=manual
    nnoremap <silent><buffer><expr> '
      \ defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> V
      \ defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> gx
      \ defx#do_action('execute_system')
    nnoremap <silent><buffer><expr> <2-LeftMouse>
      \ defx#is_directory() ? 
      \     (
      \     defx#is_opened_tree() ?
      \     defx#do_action('close_tree') :
      \     defx#do_action('open_tree')
      \     )
      \ : defx#do_action('drop')
    nnoremap <silent><buffer><expr> o
      \ defx#is_directory() ? 
      \     (
      \     defx#is_opened_tree() ?
      \     defx#do_action('close_tree') :
      \     defx#do_action('open_tree')
      \     )
      \ : defx#do_action('drop')
    nnoremap <silent><buffer><expr> <CR>
      \ defx#is_directory() ?
      \ defx#do_action('open_directory') : defx#do_action('drop')
    nmap <silent><buffer><expr> P
      \ defx#is_directory() ?
      \ defx#do_action('cd',['..']) : defx#do_action('drop')

endfunction
autocmd FileType defx call s:defx_init()


" ===
" === Yggdroot/LeaderF
" ===
let g:Lf_WindowPosition='right'
let g:Lf_PreviewInPopup=1
let g:Lf_CommandMap = {
\   '<C-p>': ['<C-k>'],
\   '<C-k>': ['<C-p>'],
\   '<C-j>': ['<C-n>']
\}
nmap <leader>f :Leaderf file<CR>
nmap <leader>b :Leaderf! buffer<CR>
nmap <leader>F :Leaderf rg<CR>
let g:Lf_DevIconsFont = "DroidSansMono Nerd Font Mono"


" ===
" === lervag/vimtex
" ===
" let g:vimtex_latexmk_options='-pdf -pdflatex="xelatex -synctex=1 \%S \%O" -verbose -file-line-error -interaction=nonstopmode'
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_compiler_latexmk_engines = {'_':'-xelatex'}
let g:vimtex_view_method='skim'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'


" ===
" === iamcco/markdown-preview.nvim
" ===
let g:mkdp_auto_close = 1

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

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
" disable_filename: if disable filename header for preview page, default: 0
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
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = '/Users/perom/.config/nvim/css/markdown.css'

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

" === end iamcco/markdown-preview.nvim ===


" ===
" === puremourning/vimspector
" ===
let g:vimspector_enable_mappings = 'HUMAN'

function! s:generate_vimspector_conf()
  if empty(glob( '.vimspector.json' ))
    if &filetype == 'c' || 'cpp' 
      !cp ~/.config/nvim/vimspector_conf/c.json ./.vimspector.json
    elseif &filetype == 'python'
      !cp ~/.config/nvim/vimspector_conf/python.json ./.vimspector.json
    endif
  endif
  e .vimspector.json
endfunction

command! -nargs=0 Gvimspector :call s:generate_vimspector_conf()
"set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
