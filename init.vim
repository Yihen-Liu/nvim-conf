"""""""""""""""快捷键"""""""""""""""
"shift+k: 显示函数帮助信息
""""""""""""""""""""""""""""""""""""

set number
set relativenumber
set autoindent
set tabstop=4
set shiftwidth=4
set smarttab
set softtabstop=4
set mouse=a

" 历史容量
set history=1000

"开启真彩色
set termguicolors

"使用语法高亮定义代码折叠
set foldmethod=syntax

"打开文件是默认不折叠代码
set foldlevelstart=99

" 禁止生成临时文件
set noswapfile
" 禁止高亮search结果, 目前可以通过 ,k 快捷键引入高亮能力
"set nohlsearch

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

"可见屏幕捏，快速跳转
Plug 'phaazon/hop.nvim'

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
" 在nerdtree上显示文件的git状态
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'tpope/vim-surround' "Surrounding ysw
Plug 'tpope/vim-fugitive' "git
"Plug 'gabrielelana/vim-markdown' "markdown

"高亮光标所在的单词
Plug 'lfv89/vim-interestingwords'

"为了让coc可以支持CPP，需要执行 :CocInstall coc-clangd
"如果没有安装clangd，可以继续执行: CocCommand clangd.install
Plug 'neoclide/coc.nvim', {'branch': 'release'}  "code completion


Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } "for golang
"使用quickfix显示golang语法Error
let g:go_list_type = "quickfix"


"为了可以支持C语言，需要安装clangd, :CocInstall coc-clangd
"然后配置coc-settings.json文件,

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

"括号显示增强
Plug 'luochen1990/rainbow'

"专业处理代码错误
Plug 'dense-analysis/ale'

"代码注释的管理
Plug 'preservim/nerdcommenter'

"rsync插件，在项目目录的底层放置 .vim-arsync配置内容
" https://github.com/KenN7/vim-arsync
"Plug 'kenn7/vim-arsync'
call plug#end()

"显示当前文件的全路径
nnoremap <C-g>  1<C-g>

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

colorscheme gruvbox
"colorscheme desert 
"colorscheme moonlight
"colorscheme monokai
"colorscheme emerald

"设置状态栏颜色主题
"https://github.com/vim-airline/vim-airline-themes/blob/master/autoload/airline/themes/base16_monokai.vim
let g:airline_theme = "molokai"
let g:airline_powerline_fonts = 1 "开启powerline字体显示，例如状态栏上的小三角图标
let g:airline#extensions#tabline#enabled=1 "顶部tab显示

nmap <tab> :bn<cr> "设置tab键映射,使用tab切换顶部Buffer, bp是向前切换顶部Buffer
nmap <S-tab> :bp<CR>

"nnoremap <C-g> :NERDTreeFocus<CR>
"nnoremap <C-n> :NERDTree<CR>
"nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <silent> <F2> :NERDTreeToggle<CR>

"打开管理窗口并将光标定位到当前文件
nnoremap <silent> <leader>f :NERDTreeFind<cr>

"当NERDTree为剩下的唯一窗口时自动关闭, 为了适配BufOnly自定义命令，关掉这个配置
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"关闭所有的buffer, 除了当前的buffer
command! BufOnly execute 'let current_buf = bufnr("%")' | bufdo if bufnr('%') != current_buf | bdelete | endif

autocmd vimenter * NERDTree "打开nvim的时候，自动打开nerdtree
"let g:NERDTreeWinSize=31
let g:NERDTreeWinSize=28
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
"let g:coc_settings = {
"\ "clangd.path": "/Library/Developer/CommandLineTools/usr/bin/clangd",
"\ "clangd.arguments": [
"\     "--background-index",
"\     "--completion-style=bundled",
"\     "--header-insertion=iwyu",
"\     "--clang-tidy",
"\     "--cross-file-rename",
"\     "--header-insertion-decorators"
"\   ],
"\ }


"--suggest-missing-includes",
"忽略cpp文件中的未使用函数及变量警告, 好像不生效，参建bitcoin
let g:ale_cpp_clang_options = '-Wall -Wextra -Werror -Eno-unused-variable -Eno-unused-function'

""""""""""""""""""""""""""""""""""
" tagbar配置
""""""""""""""""""""""""""""""""""
" 使用 ctags 作为标签生成器
"let g:tagbar_type_ctags_bin = 'ctags'
" 启动时自动focus
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 0
" let g:tagbar_autoshow = 1
let g:tagbar_width=31
"let g:tagbar_width=28
"当是如下文件类型时，自动打开Tagbar
"autocmd BufReadPost *.cpp,*.c,*.h,*.cc,*.cxx,*.go,*.py,*.php call tagbar#autoopen() 

" <F10>打开/关闭Tagbar
nnoremap <silent> <F10> :TagbarToggle<CR>

""""""""""""""""""""""""""""""""""
"Plug 'lfv89/vim-interestingwords' 给光标所在的单词着色
""""""""""""""""""""""""""""""""""
nnoremap <silent> <leader>k :call InterestingWords('n')<cr>
vnoremap <silent> <leader>k :call InterestingWords('v')<cr>
nnoremap <silent> <leader>K :call UncolorAllWords()<cr>

nnoremap <silent> n :call WordNavigation(1)<cr>
nnoremap <silent> N :call WordNavigation(0)<cr>

let g:interestingWordsTermColors = ['154', '121', '211', '137', '214', '222', "172", '144', '191']
let g:interestingWordsGUIColors = ['#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF', '#CC8AA2', '#DCC2E5', '#B11E2F']


""""""""""""""""""""""""""""""""""
"Plug 'nerdtree-git-plugin' 配置
""""""""""""""""""""""""""""""""""
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

""""""""""""""""""""""""""""""""""
" rainbow配置
""""""""""""""""""""""""""""""""""
" rainbow激活
let g:rainbow_active = 1
" darkwhite是原色, guifgs配置的是nvim的颜色
" lightmagenta颜色比较亮，看起来比较方便 seagreen3
let g:rainbow_conf = {
\	'guifgs': ['darkyellow', 'darkorange3', 'seagreen', 'lightpink'],
\	'ctermfgs': ['white', 'yellow', 'cyan', 'magenta'],
\}


""""""""""""""""""""""""""""""""""
"bookmarks setting
""""""""""""""""""""""""""""""""""
let g:bookmark_highlight_lines = 1
let g:bookmark_save_per_working_dir = 1
"自动保存书签
let g:bookmark_auto_save = 1
let g:bookmark_display_annotation = 1
"书签自动保存的位置
let g:bookmark_auto_save_file = '~/.bookmarks'
"在quickfix中选择书签后，自动关闭quickfix
let g:bookmark_auto_close = 1
"nmap ml <Plug>BookmarkShowAll

""""""""""""""""""""""""""""""""""
"quickfix setting
""""""""""""""""""""""""""""""""""
"前导键 + q  打开/关闭quickfix
nnoremap <leader>q :call QuickfixToggle()<cr>

let g:quickfix_is_open = 0

function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
    else
        copen
        let g:quickfix_is_open = 1
    endif
endfunction

""""""""""""""""""""""""""""""""""
"Plug 'dense-analysis/ale' 设置
"在coc.nvim配置文件中添加 "diagnostic.displayByAle": true , 否则插件之间会有冲突
"https://github.com/dense-analysis/ale/blob/master/doc/ale-c.txt 帮助文档
""""""""""""""""""""""""""""""""""
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

"打开文件时进行检查
let g:ale_lint_on_enter = 1

" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

"普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)

"<Leader>d查看错误或警告的详细信息
nmap <Leader>d :ALEDetail<CR>

let g:ale_linters = {
    \ 'go': ['golint', 'go vet', 'go fmt'],
    \ 'cpp': ['clang'],
    \ }

" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1

" 忽略cpp中未使用参数的报警信息
let g:ale_cpp_clang_options = '-Wall -Wextra -Werror -Wunused-variable  -Wunused-function'

" ale忽略对.h文件的检查
autocmd BufRead,BufNewFile *.h let b:ale_enabled = 0

"禁用显示错误或警告信息, 只在底部栏显示
let g:ale_virtualtext_cursor = 'disabled'
""""""""""""""""""""""""""""""""""
" Plug 'scrooloose/nerdcommenter' 设置 (加注释)
""""""""""""""""""""""""""""""""""
" <leader>cc   加注释
" <leader>cu   解注释

" 注释的时候自动加个空格
let g:NERDSpaceDelims=1


""""""""""""""""""""""""""""""""""
" Plug 'tpope/vim-surround'
"help reference link: https://yyq123.github.io/learn-vim/learn-vim-plugin-surround.html
""""""""""""""""""""""""""""""""""
"ys	添加环绕字符
"yS	添加环绕字符并拆分新行
"yss 为整行添加环绕字符
"ySS 为整行添加环绕字符并拆分新行
"cs	修改环绕字符
"cS	修改环绕字符并拆分新行
"ds	删除环绕字符
"
"surround插件可以识别并处理以下目标实体：
" ( )
" { }
" [ ]
" < >
" `
" "
" '
" t（标签）
" w（单词）

