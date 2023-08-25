return {
	"akinsho/bufferline.nvim",
	version = "*",
	event = "VeryLazy",
	opts = {
		options = {
			mode = "buffers",
			buffer_close_icon = "",
			always_show_bufferline = false,
			offsets = { { filetype = "NvimTree", text = "File Explorer", separator = true, padding = 1 } },
		},
		highlights = {
			close_button_selected = {
				-- bg = "#61afef",
				-- bg = "<colour-value-here>",
			},
			buffer_selected = {
				-- bg = "#61afef",
			},
		},
	},
	config = function(_, opts)
		require("bufferline").setup(opts)
	end,
}
