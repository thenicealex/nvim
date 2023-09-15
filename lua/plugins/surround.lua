return {
	"kylechui/nvim-surround",
	version = "*",
	keys = {
		{ mod = "n", "ys" },
		{ mode = "n", "yss" },
		{ mode = "n", "yS" },
		{ mode = "n", "ySS" },
		{ mode = "v", "S" },
		{ mode = "v", "gS" },
		{ mode = "n", "ds" },
		{ mode = "n", "cs" },
		{ mode = "n", "cS" },
	},
	opts = {
		keymaps = {
			insert = "<C-g>s",
			insert_line = "<C-g>S",
			normal = "ys",
			normal_cur = "yss",
			normal_line = "yS",
			normal_cur_line = "ySS",
			visual = "S",
			visual_line = "gS",
			delete = "ds",
			change = "cs",
			change_line = "cS",
		},
	},
	config = function(_, opts)
		require("nvim-surround").setup(opts)
	end,
}
