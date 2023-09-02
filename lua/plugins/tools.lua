return {
	{ "nvim-lua/plenary.nvim", event = "VeryLazy" },
	{ "nvim-tree/nvim-web-devicons", event = "VeryLazy" },
	{
		"HiPhish/rainbow-delimiters.nvim",
		-- event = "VeryLazy",
	},
	{
		"windwp/nvim-spectre",
		keys = {
			{
				"<localleader>S",
				'<cmd>lua require("spectre").toggle()<CR>',
				desc = "Toggle Spectre",
			},

			{
				"<leader>sw",
				'<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
				desc = "Search current word",
			},
		},
		config = function()
			require("spectre").setup({})
		end,
	},
	{
		"echasnovski/mini.cursorword",
		version = "*",
		event = "VeryLazy",
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"NvimTree",
					"Trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
				callback = function()
					vim.b.minicursorword_disable = true
				end,
			})
		end,
		config = function()
			require("mini.cursorword").setup()
		end,
	},
	{
		"uga-rosa/ccc.nvim",
		keys = {
			{ "<localleader>ct", "<cmd>CccHighlighterToggle<cr>", desc = "Hightlighte colors" },
			{ "<localleader>cp", "<cmd>CccPick<cr>", desc = "Pick colors" },
		},
	},
	{
		"nguyenvukhang/nvim-toggler",
		keys = { { "<localleader>cw", "<cmd>lua require('nvim-toggler').toggle()<cr>", desc = "Invert word" } },
		opts = {
			-- your own inverses
			inverses = {
				["vim"] = "emacs",
				["true"] = "false",
				["!="] = "==",
			},
			-- removes the default <leader>i keymap
			remove_default_keybinds = true,
			-- removes the default set o f inverses
			remove_default_inverses = true,
		},
		config = function(_, opts)
			require("nvim-toggler").setup(opts)
		end,
	},
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
		"ThePrimeagen/harpoon",
		keys = {
			{
				"<leader>mf",
				mode = { "n" },
				function()
					require("harpoon.mark").add_file()
				end,
				desc = "Mark file",
			},
			{
				"<leader>ml",
				mode = { "n" },
				function()
					require("harpoon.ui").toggle_quick_menu()
				end,
				desc = "Mark menu",
			},
			{
				"1",
				mode = { "n" },
				function()
					require("harpoon.ui").nav_file(1)
				end,
				desc = "Mark menu",
			},
			{
				"2",
				mode = { "n" },
				function()
					require("harpoon.ui").nav_file(2)
				end,
				desc = "Mark menu",
			},
			{
				"3",
				mode = { "n" },
				function()
					require("harpoon.ui").nav_file(3)
				end,
				desc = "Mark menu",
			},
		},
	},
	{
		"folke/neodev.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts)
			require("neodev").setup(opts)
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		enabled = false,
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = true,
					auto_trigger = true,
					debounce = 75,
					keymap = {
						accept = "<M-l>",
						accept_word = false,
						accept_line = false,
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
			})
		end,
	},
	{
		"glepnir/flybuf.nvim",
		cmd = "FlyBuf",
		keys = { { "<leader>b", "<cmd>FlyBuf<cr>" } },
		config = function()
			require("flybuf").setup({})
		end,
	},
	{
		"mg979/vim-visual-multi",
		lazy = false,
	},
	{ "akinsho/toggleterm.nvim", version = "*", config = true },
}
