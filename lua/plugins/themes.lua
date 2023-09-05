return {
	{
		dir = "D:/workstation/github/onedark-nvim",
		priority = 1000,
		enabled = true,
		config = function()
			vim.cmd("colorscheme onedark")
		end,
	},
	{
		"folke/tokyonight.nvim",
		enabled = false,
		priority = 1000,
		opts = {},
		config = function()
			vim.cmd("colorscheme tokyonight")
		end,
	},
}
