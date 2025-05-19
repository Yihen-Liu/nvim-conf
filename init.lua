vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.softtabstop = 4

-- 鼠标可拖拽
vim.opt.mouse = 'a'

-- 历史容量
vim.opt.history = 1000

-- 开启真彩色
vim.opt.termguicolors = true

-- 使用语法高亮定义代码折叠
vim.opt.foldmethod = 'syntax'

-- 打开文件时默认不折叠代码
vim.opt.foldlevelstart = 99

-- 禁止生成临时文件
vim.opt.swapfile = false

-- 高亮 search 结果
vim.opt.hlsearch = true

-- 重新设置 neovim 的前导键
vim.g.mapleader = ","


local lazypath = vim.fn.stdpath("config") .. "/lua/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
    })
end

vim.opt.rtp:prepend(vim.fs.normalize(lazypath)) -- 确保路径格式正确

require("lazy").setup({
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },

	-- Neovim 通用实用工具库，提供了很多实用的函数
    { "nvim-lua/plenary.nvim"},

	 -- 颜色方案插件
	 {'morhetz/gruvbox'},

    -- 状态栏插件
	{'vim-airline/vim-airline'},

	-- 状态栏主题插件
	{'vim-airline/vim-airline-themes'},
	
	-- 安装 tagbar 插件
	{'preservim/tagbar'},

	-- 安装 NerdTree 插件
	{'preservim/nerdtree',dependencies = { "Xuyuanp/nerdtree-git-plugin" }},

	-- 安装 nerdtree-git-plugin 插件, 在nerdtree上显示文件的git状态
    --{'Xuyuanp/nerdtree-git-plugin'},

	-- 安装 vim-surround 插件
	{'tpope/vim-surround'},

	-- 安装 vim-fugitive 插件
	{'tpope/vim-fugitive', lazy=false},

	-- 安装 vim-interestingwords 插件
	{'lfv89/vim-interestingwords'},

	-- 安装 Comment 插件, 自动加注释, gc/gb
	{
		'numToStr/Comment.nvim',
		opts = {}
	},
	-- 安装 coc.nvim 插件
    { 'neoclide/coc.nvim', branch = 'release' },

    -- 安装 vim-go 插件
    { 'fatih/vim-go', build = ':GoUpdateBinaries' },

	  -- 安装 fzf 插件，并运行安装脚本
	{ 'junegunn/fzf', build = './install --all' },

	-- 安装 fzf.vim 插件
	{'junegunn/fzf.vim'},

	-- buffer 管理器, 默认快捷键是 leader+b
	{'jeetsukumaran/vim-buffergator'},

	--  自动补全括号、引号等成对符号，提高代码编写效率, 输入 (，会自动补全 )等
	{'jiangmiao/auto-pairs'},

	-- 书签管理器: mm mi ma mc mn mp
	{'MattesGroeger/vim-bookmarks'},

	{
		'github/copilot.vim',
		event = "InsertEnter", -- 进入插入模式时加载
	},

	-- 错误检查插件
	{'dense-analysis/ale'},

	-- neovim中的虚拟terminal终端插件 F12打开
	{
		'voldikss/vim-floaterm',
		config = function()
			local keymap = vim.api.nvim_set_keymap
			local opts = { noremap = true, silent = true }

			-- Normal Mode 映射
			keymap("n", "<F7>", ":FloatermNew<CR>", opts)
			keymap("n", "<F8>", ":FloatermPrev<CR>", opts)
			keymap("n", "<F9>", ":FloatermNext<CR>", opts)
			keymap("n", "<F12>", ":FloatermToggle<CR>", opts)

			-- Terminal Mode 映射（退出终端模式后执行）
			keymap("t", "<F7>", "<C-\\><C-n>:FloatermNew<CR>", opts)
			keymap("t", "<F8>", "<C-\\><C-n>:FloatermPrev<CR>", opts)
			keymap("t", "<F9>", "<C-\\><C-n>:FloatermNext<CR>", opts)
			keymap("t", "<F12>", "<C-\\><C-n>:FloatermToggle<CR>", opts)
		end
	},

	-- 最大化当前屏幕
	{
		"szw/vim-maximizer",
		keys = {
			{ "<leader>m", ":MaximizerToggle<CR>", desc = "Toggle maximize window" }
		},
	},

	--	nvim命令行提示
	{ 
		"gelguy/wilder.nvim",
		config = function()
		local wilder = require("wilder")

			wilder.setup({modes = {":", "/", "?"}})
			
			wilder.set_option("renderer", wilder.renderer_mux({
			  [":"] = wilder.popupmenu_renderer(
				wilder.popupmenu_border_theme({
				  highlights = {
					border = "Normal",
				  },
					border = "rounded",
				})
			  ),
			  ["/"] = wilder.wildmenu_renderer({
				highlighter = wilder.basic_highlighter(),
			  }),
			}))

		end
	}, 

	-- 顶部标签页plugin，:Bo :Bc 命令就是来源于这个插件
	{
		'romgrk/barbar.nvim',
		dependencies = {
		  -- 'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
		  -- 'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
		},
		init = function() 
			vim.g.barbar_auto_setup = false 
			require('configs.barbar') -- 这里加载映射
		end,
		opts = {
		  icons = {
			  filetype = {
				enabled = false, -- 这里禁用文件类型图标, 因为没有安装nvim-web-devicons
			  }
		  },
		},
  },

  {
	  "neovim/nvim-lspconfig",
	  config = function()
		require("lspconfig").gopls.setup({})
	  end
  },

  require('plugins.avante'),
  require('plugins.rainbow'),
  require("plugins.flash"),
  require("plugins.miniFiles"),
  require("plugins.rust"),
})
-- 设置状态栏颜色主题
-- vim.g.airline_theme = "molokai"
vim.g.airline_theme = "gruvbox"

-- 开启 powerline 字体显示，例如状态栏上的小三角图标
vim.g.airline_powerline_fonts = 1

-- 启用顶部 tab 显示
vim.g["airline#extensions#tabline#enabled"] = 1

-- 设置 colorscheme 为 gruvbox
vim.g.gruvbox_contrast_dark = "medium" -- 可选 "soft"、"medium"、"hard"
vim.cmd("colorscheme gruvbox")

-- 可选：绑定快捷键打开 tagbar
vim.api.nvim_set_keymap('n', '<F10>', ':TagbarToggle<CR>', { noremap = true, silent = true })

-- 可选：绑定快捷键打开 NerdTree
vim.api.nvim_set_keymap('n', '<F2>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })

-- 设置 vim-interestingwords 的终端配色方案
vim.g.interestingWordsTermColors = {'154', '121', '211', '137', '214', '222', '172', '144', '191'}

-- 设置 vim-interestingwords 的 GUI 配色方案
vim.g.interestingWordsGUIColors = {'#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF', '#CC8AA2', '#DCC2E5', '#B11E2F'}


-- 配置 nerdtree-git-plugin 的 Git 状态指示器
vim.g.NERDTreeGitStatusIndicatorMapCustom = {
    Modified  = "✹",
    Staged    = "✚",
    Untracked = "✭",
    Renamed   = "➜",
    Unmerged  = "═",
    Deleted   = "✖",
    Dirty     = "✗",
    Clean     = "✔︎",
    Unknown   = "?"
}

-- 设置 Neovim 使用系统剪贴板
vim.o.clipboard = 'unnamedplus'

-- 配置 nerdcommenter 插件
vim.g.NERDSpaceDelims = 1  -- 空格分隔注释符号
vim.g.NERDCommentEmptyLines = 1  -- 允许对空行加注释
vim.g.NERDTrimWhitespaces = 1  -- 去除注释后尾部的空格
vim.g.NERDDefaultAlign = 'left'  -- 默认对齐方式为左对齐

-- 设置 autocmd 在 Neovim 启动时自动打开 NERDTree
vim.cmd([[
  autocmd VimEnter * NERDTree
]])

-- 设置 NERDTree 的窗口大小
vim.g.NERDTreeWinSize = 33
-- 打开 NERDTree 并将光标定位到当前文件
vim.api.nvim_set_keymap('n', '<leader>f', ':NERDTreeFind<CR>', { noremap = true, silent = true })
-- 设置可展开和可折叠目录的箭头符号
vim.g.NERDTreeDirArrowExpandable = "+"
vim.g.NERDTreeDirArrowCollapsible = "-"

-- 设置书签文件的位置
vim.g.NERDTreeBookmarksFile = vim.fn.expand('$HOME') .. '/.NERDTreeBookmarks.nvim'

-- 显示书签列表
vim.g.NERDTreeShowBookmarks = 1

-- 设置快捷键显示当前文件的全路径
vim.api.nvim_set_keymap('n', '<C-g>', ':echo expand("%:p")<CR>', { noremap = true, silent = true })

-- 设置 rainbow 插件的配置
vim.g.rainbow_active = 1  -- 启用 rainbow 插件

-- 设置 rainbow 插件的颜色配置
vim.g.rainbow_conf = {
  guifgs = {'darkyellow', 'darkorange3', 'seagreen', 'lightpink'},  -- GUI颜色
  ctermfgs = {'white', 'yellow', 'cyan', 'magenta'},  -- 终端颜色
}

-- 设置 tagbar 配置
vim.g.tagbar_autofocus = 1  -- 自动聚焦
vim.g.tagbar_autoclose = 0  -- 不自动关闭
vim.g.tagbar_use_cache = 0  -- 不使用缓存
vim.g.tagbar_width = 31  -- 设置 Tagbar 窗口宽度

-- 设置自动打开 Tagbar 的文件类型
-- vim.cmd([[
--  autocmd BufReadPost *.cpp,*.c,*.h,*.cc,*.cxx,*.go,*.py,*.php call tagbar#autoopen()
-- ]])

-- 使用 Tab 切换到下一个 buffer
vim.api.nvim_set_keymap('n', '<Tab>', ':bn<CR>', { noremap = true, silent = true })

-- 使用 Shift+Tab 切换到上一个 buffer
vim.api.nvim_set_keymap('n', '<S-Tab>', ':bp<CR>', { noremap = true, silent = true })

-- 在命令模式下映射 qq 为 qa 退出 Neovim
vim.api.nvim_set_keymap('c', 'qq', 'qa', { noremap = true, silent = false })

-- 配置 coc.nvim 和 gopls
vim.cmd([[
  let g:coc_global_extensions = ['coc-go']
  let g:coc_go_use_gopls = 1
]])

-- 当新建文件时，reload 重新加载coc.nvim以便发现新建的文件内容
vim.api.nvim_create_user_command("Reload", "CocRestart", {})

-- 设置 GoTo 代码导航的快捷键映射
vim.api.nvim_set_keymap('n', 'gd', '<Plug>(coc-definition)', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gy', '<Plug>(coc-type-definition)', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gi', '<Plug>(coc-implementation)', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gr', '<Plug>(coc-references)', { noremap = true, silent = true })

-- vim-go 配置
vim.cmd([[
  let g:go_auto_type_info = 0  "光标悬停时自动显示类型信息; 0: 关闭； 1：打开
  let g:go_fmt_command = "goimports"
  let g:go_doc_keywordprg = ":GoDoc"
  let g:go_list_type = 'quickfix'  " 显示 Go 错误到 quickfix
]])

-- 在插入模式下，Tab 键可以选择 coc.nvim 下拉内容
vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { noremap = true, expr = true, silent = true })

-- 在插入模式下，按回车键确认 coc.nvim 的候选词
vim.api.nvim_set_keymap('i', '<CR>', [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()<CR>"]], { noremap = true, expr = true, silent = true })


-- 如果需要，你可以添加自定义的快捷键来使用 vim-buffergator：
--vim.api.nvim_set_keymap('n', '<leader>b', ':Buffergator<CR>', { noremap = true, silent = true })

-- 设置 buffergator 配置项 --
vim.g.buffergator_viewport_split_policy = "B"  -- 设置缓冲区分割策略
vim.g.buffergator_autoupdate = 1  -- 自动更新 buffergator 视图

-- 设置书签相关配置 --
vim.g.bookmark_highlight_lines = 1  -- 高亮书签行
vim.g.bookmark_save_per_working_dir = 1  -- 每个工作目录保存书签
vim.g.bookmark_auto_save = 1  -- 自动保存书签
vim.g.bookmark_display_annotation = 1  -- 显示书签的注释
vim.g.bookmark_auto_save_file = vim.fn.expand('~/.bookmarks')  -- 设置书签自动保存的位置
vim.g.bookmark_auto_close = 1  -- 在 quickfix 中选择书签后自动关闭 quickfix

-- 映射快捷键: ml 显示所有书签
vim.api.nvim_set_keymap('n', 'ml', '<Plug>BookmarkShowAll', { noremap = true, silent = true })

-- 打开文件时进行ALE检查 --
vim.g.ale_lint_on_enter = 1
-- 映射ALE快捷键，跳转到上一个错误或警告
vim.api.nvim_set_keymap('n', 'sp', '<Plug>(ale_previous_wrap)', { noremap = true, silent = true })
-- 映射ALE快捷键，跳转到下一个错误或警告
vim.api.nvim_set_keymap('n', 'sn', '<Plug>(ale_next_wrap)', { noremap = true, silent = true })
-- 映射 Leader+d 查看错误或警告的详细信息
vim.api.nvim_set_keymap('n', '<Leader>d', ':ALEDetail<CR>', { noremap = true, silent = true })
-- 禁用 ALE 插件的虚拟文本显示, 仅在底部显示错误信息
vim.g.ale_virtualtext_cursor =  'disabled'
-- 在底部，格式化ALE显示消息
vim.g.ale_echo_msg_format = '[%linter%] %s [%severity%]'


-- 在Floatterm中打开Broot, 当broot退出时，自动关闭Floatterm, 避免残留
vim.api.nvim_create_user_command("Broot", function()
  vim.cmd("FloatermNew --width=0.8 --height=0.8 --autoclose=1 broot")
end, {})

--barbar.nvim 配置
-- 命令行模式新增Bc 关闭当前buffer
vim.api.nvim_create_user_command("Bc", function()
    vim.cmd("BufferClose")
end, {})

-- 命令行模式新增Bc 关闭当前buffer
vim.api.nvim_create_user_command("Bo", function()
    vim.cmd("BufferCloseAllButCurrent")
end, {})

-- 绑定快捷键，打开mini.files
vim.keymap.set("n", "<leader>e", MiniFiles.open, { desc = "打开 mini.files" })
