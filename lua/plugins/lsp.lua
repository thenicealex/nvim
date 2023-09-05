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
		"williamboman/mason.nvim",
		opts = {}, -- pyright clandg
		config = function(_, opts)
			require("mason").setup(opts)
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = "VeryLazy",
		opts = {},
		oonfig = function(_, opts)
			require("mason-lspconfig").setup(opts)
		end,
	},
	{
		"folke/neodev.nvim",
		event = "LspAttach",
		init = function()
			require("core.utils").lazy_load("neodev.nvim")
		end,
		-- opts = {},
		-- config = function(_, opts)
		-- 	require("neodev").setup(opts)
		-- end,
	},
	{
		"Bekaboo/dropbar.nvim",
		enabled = true,
		config = function()
			require("dropbar").setup({
				icons = {
					ui = {
						bar = {
							separator = "  ",
							extends = "…",
						},
					},
				},
			})
		end,
	},
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
