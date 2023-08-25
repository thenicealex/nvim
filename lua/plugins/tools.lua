return {
	{
		"uga-rosa/ccc.nvim",
		keys = {
			{ "<leader>ct", "<cmd>CccHighlighterToggle<cr>", desc = "Hightlighte colors" },
			{ "<leader>cp", "<cmd>CccPick<cr>", desc = "Pick colors" },
		},
	},
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
	{ "HiPhish/rainbow-delimiters.nvim", event = "VeryLazy" },
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		-- event = { "BufReadPost", "BufNewFile" },
		config = true,
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
	},
}
