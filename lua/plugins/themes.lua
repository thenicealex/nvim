return {
	{
		"thenicealex/onedark.nvim",
		priority = 1000,
		opts = {
			palette = "astrodark",
			background = {
				light = "astrolight",
				dark = "astrodark",
			},
		},
		config = function(_, opts)
			require("astrotheme").setup(opts)
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
}
