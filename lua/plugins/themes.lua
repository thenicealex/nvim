return {
	{
		"folke/tokyonight.nvim",
		enabled = false,
		priority = 1000,
		opts = {},
	},
	{ dir = "~/onedark",
		priority = 1000,
		enabled = false },
	{
		dir = "~/onedark.nvim",
		enabled = true,
		priority = 1000,
		opts = {
			palette = "onedark",
			background = {
				light = "astrolight",
				dark = "onedark",
			},
		},
		config = function(_, opts)
			require("onedark").setup(opts)
		end,
	},
	{
		"olimorris/onedarkpro.nvim",
		enabled = false,
		priority = 1000, -- Ensure it loads first
	},
	{ "ellisonleao/gruvbox.nvim",
		enabled = false,
		priority = 1000 },
}
