return {
	{
		"echasnovski/mini.cursorword",
		version = "*",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts)
			require("mini.cursorword").setup(opts)
		end,
	},
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
	{ "HiPhish/rainbow-delimiters.nvim" },
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		-- event = { "BufReadPost", "BufNewFile" },
		config = true,
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<localleader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<localleader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<localleader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<localleader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
	},
	{
		"windwp/nvim-spectre",
		event = "BufRead",
		config = function()
			require("spectre").setup()
		end,
	},
	{
		"s1n7ax/nvim-window-picker",
		version = "1.*",
		keys = {
			{
				"n",
				"<localleader>wp",
				function()
					local picker = require("window-picker")
					local picked_window_id = picker.pick_window({
						include_current_win = true,
					}) or vim.api.nvim_get_current_win()
					vim.api.nvim_set_current_win(picked_window_id)
				end,
				{ desc = "Pick a window" },
			},
				{
					"n",
					"<localleader>ws",
					function()
						local picker = require("window-picker")
						local window = picker.pick_window({
							include_current_win = false,
						})
						local target_buffer = vim.fn.winbufnr(window)
						-- Set the target window to contain current buffer
						vim.api.nvim_win_set_buf(window, 0)
						-- Set current window to contain target buffer
						vim.api.nvim_win_set_buf(0, target_buffer)
					end,
					{ desc = "Swap windows" },
			},
		},
		config = function()
			require("window-picker").setup({
				autoselect_one = true,
				include_current = false,
				filter_rules = {
					-- filter using buffer options
					bo = {
						-- if the file type is one of following, the window will be ignored
						filetype = { "NvimTree","neo-tree", "neo-tree-popup", "notify", "quickfix" },

						-- if the buffer type is one of following, the window will be ignored
						buftype = { "terminal" },
					},
				},
				other_win_hl_color = "#e35e4f",
			})
		end,
	},
}
