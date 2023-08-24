return {
	-- {
	-- 	"thenicealex/onedark.nvim",
	-- 	priority = 1000,
	-- 	opts = {
	-- 		palette = "astrodark",
	-- 		background = {
	-- 			light = "astrolight",
	-- 			dark = "astrodark",
	-- 		},
	-- 	},
	-- 	config = function(_, opts)
	-- 		require("astrotheme").setup(opts)
	-- 	end,
	-- },
	{
		"folke/tokyonight.nvim",
		enabled = false,
		priority = 1000,
		opts = {},
	},
	{dir = "~/onedark"},
	{
		dir = "~/onedark.nvim",
		enabled = false,
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
	{ 'rktjmp/lush.nvim',
		cmd = {"LushRunTutorial", "Lushify"}
	}
}
