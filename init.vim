:set number
:set relativenumber
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a


"重新设置neovim的前导键
let mapleader = ","

"安装vim-plug
"curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
"Plug使用说明, docs: https://github.com/junegunn/vim-plug
"1. 安装插件
":PlugInstall
"
"2. 更新插件
":PlugUpdate
"
"3. 删除插件
" 先在init.vim里删掉插件，然后运行:PlugClean
"
"4. 升级vim-plug本身
":PlugUpgrade

call plug#begin()
"tag导航插件
Plug 'majutsushi/tagbar'

"安装buffer 浏览器
"\<Leader\>be normal open
"\<Leader\>bt toggle open / close
"\<Leader\>bs force horizontal split open
"\<Leader\>bv force vertical split open
"Plug 'jlanzarotta/bufexplorer'
Plug 'jeetsukumaran/vim-buffergator'

"Plug 'dikiaap/minimalist' "colorscheme minimalist
Plug 'vim-airline/vim-airline' "Status bar
Plug 'vim-airline/vim-airline-themes' "Status bar themes

"XXX for compatible with vim (parsing ~/.NERDTreeBookmarks)
"Plug 'scrooloose/nerdtree'
Plug 'preservim/nerdtree' "NerdTree

Plug 'tpope/vim-surround' "Surrounding ysw
Plug 'tpope/vim-fugitive' "git
"Plug 'gabrielelana/vim-markdown' "markdown

"高亮光标所在的单词
Plug 'lfv89/vim-interestingwords'

"为了让coc可以支持CPP，需要执行 :CocInstall coc-clangd
"如果没有安装clangd，可以继续执行: CocCommand clangd.install
Plug 'neoclide/coc.nvim', {'branch': 'release'}  "code completion
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } "for golang

"为了可以支持C语言，需要安装ccls, :CocInstall coc-ccls
"然后配置coc-settings.json文件,
"目前系统已经安装了ccls，但是coc-ccls安装失败，故作罢；

"为了让coc支持Rust，需要提前执行 :CocInstall coc-rust-analyzer,
"该插件会自动安装rust-analyzer可执行文件
Plug 'rust-lang/rust.vim'  "安装rust 语法vim插件
Plug 'simrat39/rust-tools.nvim'

"fzf#install() makes sure that you have the latest binary, but it's optional, so you can omit it if you use a plugin manager that doesn't support hooks.
":Files :Tags :Ag :Rg
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'jiangmiao/auto-pairs' "自动配对{ ‘ “ [
Plug 'ray-x/starry.nvim' "colorschemes
Plug 'morhetz/gruvbox'  "colorshceme  

"mm mi ma mc mn mp
Plug 'MattesGroeger/vim-bookmarks'

"copilot插件安装，安装好之后，执行 :Copilot setup 设置copilot授权码
Plug 'github/copilot.vim'

call plug#end()

"Tab键可以选择coc.nvim 下拉内容
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

"coc.vim 按回车键确认我们所选择的候选词
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"coc-setting: GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"buffergator是用来管理各个buffer的， setting and usage at:https://github.com/jeetsukumaran/vim-buffergator/blob/master/doc/buffergator.txt
let g:buffergator_viewport_split_policy = "B"
let g:buffergator_autoupdate = 1

"bookmarks setting
let g:bookmark_highlight_lines = 1
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1
let g:bookmark_display_annotation = 1


colorscheme gruvbox
"colorscheme desert 
"colorscheme moonlight
"colorscheme monokai
"colorscheme emerald

let g:airline_theme='gruvbox' " 设置主题
let g:airline_powerline_fonts = 1 "开启powerline字体显示，例如状态栏上的小三角图标
let g:airline#extensions#tabline#enabled=1 "顶部tab显示

nmap <tab> :bn<cr> "设置tab键映射,使用tab切换顶部Buffer, bp是向前切换顶部Buffer
nmap <S-tab> :bp<CR>

"nnoremap <C-g> :NERDTreeFocus<CR>
"nnoremap <C-n> :NERDTree<CR>
"nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <silent> <F2> :NERDTreeToggle<CR>

autocmd vimenter * NERDTree "打开nvim的时候，自动打开nerdtree
let g:NERDTreeWinSize=35
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="-"
let g:NERDTreeBookmarksFile=expand('$HOME').'/.NERDTreeBookmarks.nvim'
" 显示书签列表
let NERDTreeShowBookmarks=1


"启用perl provider
let g:perl_host_prog = '/usr/local/bin/perl'
"启用 python-provider
let g:python3_host_prog = '/usr/local/bin/python3'

" remember the last editing position
if has("autocmd")  
autocmd BufReadPost *   
    \if line("'\"")>0 && line("'\"")<=line("$") |  
    \   exe "normal! g`\"" |  
    \endif  
endif

""""""""""""""""""""""""""""""""""
"Rust的语法配置
" Vim-rust
""""""""""""""""""""""""""""""""""
let g:rustfmt_autosave = 1
let g:rustfmt_command = "rustfmt"
let g:rust_recommended_style = 0
let g:rustfmt_options = ['--emit=stdout']
let g:rust_fold = 1
let g:rustfmt_skip_children = ['match']
let g:rustfmt_fail_silently = 1
let g:rust_doc_command = "rustdoc"
let g:rustc_command = "rustc"
let g:rust_use_language_server = 1
let g:LanguageClient_serverCommands = {
            \ 'rust': ['rustup', 'run', 'stable', 'rls'],
            \ }
let g:LanguageClient_loggingLevel = 'INFO'
let g:LanguageClient_autoStart = 1
let g:LanguageClient_autoStart = 'rust'


""""""""""""""""""""""""""""""""""
" C/C++ 开发相关配置
" coc-clangd 配置
" 注意：此处的 clangd 可能需要根据自己的安装路径进行调整
""""""""""""""""""""""""""""""""""
let g:coc_global_extensions = [
\ 'coc-clangd',
\ ]
let g:coc_settings = {
\ "clangd.path": "/Library/Developer/CommandLineTools/usr/bin/clangd",
\ "clangd.arguments": [
\     "--background-index",
\     "--completion-style=bundled",
\     "--header-insertion=iwyu",
\     "--suggest-missing-includes",
\     "--clang-tidy",
\     "--cross-file-rename",
\     "--header-insertion-decorators"
\   ],
\ }

""""""""""""""""""""""""""""""""""
" tagbar配置
""""""""""""""""""""""""""""""""""
" 启动时自动focus
let g:tagbar_autofocus=1
let g:tagbar_width=35

" <F10>打开/关闭Tagbar
nnoremap <silent> <F10> :TagbarToggle<CR>


""""""""""""""""""""""""""""""""""
"Plug 'lfv89/vim-interestingwords' 配置
""""""""""""""""""""""""""""""""""
nnoremap <silent> <leader>k :call InterestingWords('n')<cr>
vnoremap <silent> <leader>k :call InterestingWords('v')<cr>
nnoremap <silent> <leader>K :call UncolorAllWords()<cr>

nnoremap <silent> n :call WordNavigation(1)<cr>
nnoremap <silent> N :call WordNavigation(0)<cr>

let g:interestingWordsTermColors = ['154', '121', '211', '137', '214', '222']
let g:interestingWordsGUIColors = ['#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF']
