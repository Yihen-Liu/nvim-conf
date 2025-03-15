-- 目前只安装了 c golang lua的Treesitter 解析器来解析括号;
-- rainbow-delimiters.nvim 依赖 Treesitter 解析器来解析括号，所以需要先检查是否安装了对应语言的 Treesitter 解析器。
--  :TSInstallInfo   可以查看已经安装了哪些语言的 Treesitter 解析器。
return {
	"HiPhish/rainbow-delimiters.nvim",
	  event = "BufReadPost",
	  config = function()
		local rainbow_delimiters = require("rainbow-delimiters")

		vim.g.rainbow_delimiters = {
		  strategy = {
			[""] = rainbow_delimiters.strategy["global"],
			vim = rainbow_delimiters.strategy["local"],
		  },
		  query = {
			[""] = "rainbow-delimiters",
			lua = "rainbow-blocks",
		  },
		  highlight = {
			"RainbowDelimiterRed",
			"RainbowDelimiterYellow",
			"RainbowDelimiterBlue",
			"RainbowDelimiterOrange",
			"RainbowDelimiterGreen",
			"RainbowDelimiterViolet",
			"RainbowDelimiterCyan",
		  },
		}
	   end
}
