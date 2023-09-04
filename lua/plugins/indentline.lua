return {
	{
		"echasnovski/mini.indentscope",
		version = "*",
		enabled = true,
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
		config = function(opts)
			require("mini.indentscope").setup(opts)
		end,
	},
}
