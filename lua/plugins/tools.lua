return {
	{ "HiPhish/rainbow-delimiters.nvim", event = "VeryLazy" },
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
			require("spectre").setup()
		end,
	},
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
		"rcarriga/nvim-notify",
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Dismiss all Notifications",
			},
		},
		opts = {
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		},
		init = function()
			-- when noice is not enabled, install notify on VeryLazy
			local Util = require("core.utils")
			if not Util.has("noice.nvim") then
				Util.on_very_lazy(function()
					vim.notify = require("notify")
				end)
			end
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "%d+L, %d+B" },
							{ find = "; after #%d+" },
							{ find = "; before #%d+" },
						},
					},
					view = "mini",
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = true,
			},
		},
		keys = {
			{
				"<S-Enter>",
				function()
					require("noice").redirect(vim.fn.getcmdline())
				end,
				mode = "c",
				desc = "Redirect Cmdline",
			},
			{
				"<leader>snl",
				function()
					require("noice").cmd("last")
				end,
				desc = "Noice Last Message",
			},
			{
				"<leader>snh",
				function()
					require("noice").cmd("history")
				end,
				desc = "Noice History",
			},
			{
				"<leader>sna",
				function()
					require("noice").cmd("all")
				end,
				desc = "Noice All",
			},
			{
				"<leader>snd",
				function()
					require("noice").cmd("dismiss")
				end,
				desc = "Dismiss All",
			},
			{
				"<c-f>",
				function()
					if not require("noice.lsp").scroll(4) then
						return "<c-f>"
					end
				end,
				silent = true,
				expr = true,
				desc = "Scroll forward",
				mode = { "i", "n", "s" },
			},
			{
				"<c-b>",
				function()
					if not require("noice.lsp").scroll(-4) then
						return "<c-b>"
					end
				end,
				silent = true,
				expr = true,
				desc = "Scroll backward",
				mode = { "i", "n", "s" },
			},
		},
	},
	{
		"glepnir/flybuf.nvim",
		cmd = "FlyBuf",
		keys = {  {"<leader>b", "<cmd>FlyBuf<cr>"}  },
		config = function()
			require("flybuf").setup({})
		end,
	},
}
