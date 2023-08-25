return {
	"akinsho/bufferline.nvim",
	version = "*",
	event = "VeryLazy",
	opts = {
		options = {
			mode = "buffers",
			-- buffer_close_icon = "",
			indicator = {
				icon = "▎", -- this should be omitted if indicator style is not 'icon'
				style = "icon",
			},
			always_show_bufferline = false,
			offsets = { { filetype = "NvimTree", text = "File Explorer", separator = true } },
		},
		highlights = {},
	},
	config = function(_, opts)
		require("bufferline").setup(opts)
	end,
}
