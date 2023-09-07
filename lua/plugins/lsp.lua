return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "folke/neodev.nvim", opts = {} },
			{"williamboman/mason.nvim", config = true},
			{"williamboman/mason-lspconfig.nvim"},
			{
				"hrsh7th/cmp-nvim-lsp",
				cond = function()
					return require("core.utils").has("nvim-cmp")
				end,
			},
		},
		init = function()
			require("core.utils").lazy_load("nvim-lspconfig")
		end,
		config = function()
			require("plugins.configs.lspconfig")
		end,
	},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		event = "VeryLazy",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		opts = {},
	},
	{
		"Bekaboo/dropbar.nvim",
		enabled = false,
		config = function()
			require("dropbar").setup({
				general = {
					enable = function(buf, win)
						return not vim.api.nvim_win_get_config(win).zindex
							and vim.bo[buf].buftype ~= "help"
							and vim.api.nvim_buf_get_name(buf) ~= ""
							and not vim.wo[win].diff
					end,
				},
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
