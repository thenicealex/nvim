return {
	{
		"uga-rosa/ccc.nvim",
		keys = {
			{ "<leader>ct", "<cmd>CccHighlighterToggle<cr>", desc = "Hightlighte colors" },
			{ "<leader>cp", "<cmd>CccPick<cr>", desc = "Pick colors" },
		},
	},
	{ "RRethy/vim-illuminate", event = "VeryLazy" },
	{
		"nguyenvukhang/nvim-toggler",
		keys = { { "<leader>cc", "<cmd>lua require('nvim-toggler').toggle()<cr>", desc = "Invert word" } },
		opts = {
			-- your own inverses
			inverses = {
				["vim"] = "emacs",
				["true"] = "false",
				["!="] = "==",
			},
			-- removes the default <leader>i keymap
			remove_default_keybinds = true,
			-- removes the default set of inverses
			remove_default_inverses = true,
		},
		config = function(_, opts)
			require("nvim-toggler").setup(opts)
		end,
	},
	{ "HiPhish/rainbow-delimiters.nvim" },
}
