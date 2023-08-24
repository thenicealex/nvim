return {
	"shellRaining/hlchunk.nvim",
	event = "VeryLazy",
	opts = {
		indent = {
			enable = true,
			use_treesitter = true,
			-- { "│", "¦", "┆", "┊", }
			chars = { "│" },
			style = {
				"#696c76",
				-- { fg = "#e06c75" },
				-- { fg = "#61afef" },
				-- { fg = "#98c379" },
				-- { fg = "#e5c07b" },
				-- { fg = "#c678dd" },
				-- { fg = "#56b6c2" },
			},
		},
		line_num = {
			enable = true,
			use_treesitter = true,
			style = "#806d9c",
		},
	},
	config = function(_, opts)
		require("hlchunk").setup(opts)
	end,
}
