return {
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		init = function()
			require("core.utils").lazy_load("nvim-lspconfig")
		end,
		config = function()
			require("plugins.configs.lspconfig")
		end,
	},
	{
		"folke/neodev.nvim",
		event = "LspAttach",
		-- opts = {},
		-- config = function(_, opts)
		-- 	require("neodev").setup(opts)
		-- end,
	},
	{ 'Bekaboo/dropbar.nvim',
		event = "LspAttach",
	enabled = true,},
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		keys = {},
		opts = {
			symbol_in_winbar = { enable = false },
			lightbulb = { enable = false },
		},
		config = function(_, opts)
			require("lspsaga").setup(opts)
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
	},
}
