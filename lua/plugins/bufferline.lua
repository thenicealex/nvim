return {
	"akinsho/bufferline.nvim",
	version = "*",
	event = "VeryLazy",
	opts = {
		-- offsets = {{ filetype = "NvimTree", text = "Explorer" },},
	},
	config = function(_, opts)
		require("bufferline").setup(opts)
	end,
}
