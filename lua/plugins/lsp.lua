return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		init = function()
			require("core.utils").lazy_load("nvim-lspconfig")
		end,
		config = function()
			require("plugins.configs.lspconfig")
		end,
	},
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		event = "LspAttach",
		opts = {
			-- options
		},
	},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		event = "VeryLazy",
		version = "*",
		dependencies = { "SmiteshP/nvim-navic" },
		opts = {
			-- configurations go here
		},
	},
}
