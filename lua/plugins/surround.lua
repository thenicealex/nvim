return {
	"kylechui/nvim-surround",
	version = "*",
	keys = { "cs", "ds", "ys" },
	config = function()
		require("nvim-surround").setup()
	end,
}
