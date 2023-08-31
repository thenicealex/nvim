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
		"j-hui/fidget.nvim",
		tag = "legacy",
		event = "LspAttach",
		enabled = false,
		opts = {
			-- options
		},
	},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		enabled = true,
		event = "LspAttach",
		version = "*",
		dependencies = { "SmiteshP/nvim-navic" },
		opts = {
			-- configurations go here
		},
	},
	{
    'nvimdev/lspsaga.nvim',
		event = 'LspAttach',
		keys = {},
		opts = {
			symbol_in_winbar ={enable = false},
			lightbulb ={enable = false},
		},
    config = function(_,opts)
        require('lspsaga').setup(opts)
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons'     -- optional
    }
}
}
