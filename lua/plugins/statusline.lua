return {
	"rebelot/heirline.nvim",
	-- You can optionally lazy-load heirline on UiEnter
	-- to make sure all required plugins and colorschemes are loaded before setup
	event = "VeryLazy",
	opts = {},
	config = function()
		require("plugins.configs.statuslineconf")
	end,
}
