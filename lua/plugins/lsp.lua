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
}
