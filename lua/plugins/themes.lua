local th = require("core.config")
return {
	{
		dir = "D:/workstation/github/onedark-nvim",
		priority = 1000,
		enabled = th.theme.onedark,
		config = function()
			vim.cmd("colorscheme onedark")
		end,
	},
	{
		"folke/tokyonight.nvim",
		enabled = th.theme.tokyonight,
		priority = 1000,
		opts = {},
		config = function()
			vim.cmd("colorscheme tokyonight")
		end,
	},
}
