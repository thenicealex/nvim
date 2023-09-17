return {
	{
		"folke/edgy.nvim",
		enabled = false,
		event = "VeryLazy",
		opts = {},
	},
	{
		"petertriho/nvim-scrollbar",
		event = "BufRead",
		config = function()
			require("scrollbar").setup({
				show = true,
				show_in_active_only = true,
				excluded_buftypes = {
					"terminal",
				},
				excluded_filetypes = {
					"cmp_docs",
					"cmp_menu",
					"noice",
					"prompt",
					"TelescopePrompt",
					"NvimTree",
				},
			})
		end,
	},
}
