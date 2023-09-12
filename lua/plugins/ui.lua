return {
	{
		"rcarriga/nvim-notify",
		keys = {
			{
				"<localleader>nD",
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
			local util = require("core.utils")
			if not util.has("noice.nvim") then
				util.on_very_lazy(function()
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
				inc_rename = false,
				lsp_doc_border = false,
			},
		},
		-- stylua: ignore
		keys = {
			{
				"<C-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end,
				mode = "c",
				desc = "Redirect Cmdline",
			},
			{
				"<localleader>nl",
				function() require("noice").cmd("last") end,
				desc = "Noice Last Message",
			},
			{
				"<localleader>nh",
				function() require("noice").cmd("history") end,
				desc = "Noice History",
			},
			{
				"<localleader>na",
				function() require("noice").cmd("all") end,
				desc = "Noice All",
			},
			{
				"<localleader>nd",
				function() require("noice").cmd("dismiss") end,
				desc = "Dismiss All",
			},
			{
				"<c-f>",
				function()
					if not require("noice.lsp").scroll(4) then
						return "<c-f>"
					end
				end,
				silent = true, expr = true, desc = "Scroll forward",
				mode = { "i", "n", "s" },
			},
			{
				"<c-b>",
				function()
					if not require("noice.lsp").scroll(-4) then
						return "<c-b>"
					end
				end,
				silent = true, expr = true, desc = "Scroll backward",
				mode = { "i", "n", "s" },
			},
		},
	},
	{ "eandrju/cellular-automaton.nvim", cmd = "CellularAutomation" },
}
