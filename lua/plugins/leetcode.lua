return {
	{
		dir = "D:/workstation/github/leetcode-nvim",
		enabled = true,
		cmd = { "LCTEST", "LCList", "LCTest", "LCSubmit", "LCDisplay" },
		opts = {
			language = "cpp",
		},
		config = function(_, opts)
			require("leetcode").setup(opts)
		end,
	},
	{
		dir = "D:/workstation/github/leetup.nvim",
		enabled = false,
		cmd = "Leetup",
		dependencies = {
			{ "m00qek/baleia.nvim", enabled = true },
		},
		opts = {
			language = "cpp",
			floating_window = {
				borderchars = {
					r = "─",
					l = "│",
					ul = "╭",
					ur = "╮",
					dr = "╯",
					dl = "╰",
				},
			},
		},
		config = function(_, opts)
			require("leetup").setup(opts)
		end,
	},
}
