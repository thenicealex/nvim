return {
	"akinsho/bufferline.nvim",
	version = "*",
	event = "VeryLazy",
	enabled = false,
	opts = {
		options = {
			-- buffer_close_icon = "",
			always_show_bufferline = false,
			offsets = { { filetype = "NvimTree", text = "", separator = true } },
		},
		highlights = {},
	},
	config = function(_, opts)
		require("bufferline").setup(opts)
	end,
}
