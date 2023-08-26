return {
	"rebelot/heirline.nvim",
	-- You can optionally lazy-load heirline on UiEnter
	-- to make sure all required plugins and colorschemes are loaded before setup
	-- event = "UiEnter",
	opts = function()
	return require("plugins.configs.statuslineconf")
	end,
	config = function(_, opts)
		require("heirline").setup(opts)
	end,
}
