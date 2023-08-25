return {
	"lukas-reineke/indent-blankline.nvim",
	init = function()
		require("core.utils").lazy_load("indent-blankline.nvim")
	end,
	event = { "BufReadPost", "BufNewFile" },
	enabled = true,
	opts = {
		enabled = true,
		use_treesitter = true,
		char_highlight = "LineNr",
		space_char_blankline = " ",
		show_current_context = true,
		show_current_context_start = true,
		show_end_of_line = false,
		show_first_indent_level = true,
		show_trailing_blankline_indent = false,
		char_highlight_list = {
			-- "RainbowDelimiterRed",
			-- "RainbowDelimiterYellow",
			-- "RainbowDelimiterBlue",
			-- "RainbowDelimiterOrange",
			-- "RainbowDelimiterGreen",
			-- "RainbowDelimiterViolet",
			-- "RainbowDelimiterCyan",
		},
		buftype_exclude = {
			"quickfix",
			"help",
			"nofile",
			"prompt",
			"terminal",
		},
		filetype_exclude = {
			"",
			"NvimTree",
			"Trouble",
			"dashboard",
			"fugitive*",
			"git*",
			"help",
			"lspinfo",
			"mason",
			"packer",
		},
	},
	config = function(_, opts)
		require("indent_blankline").setup(opts)
	end,
}
