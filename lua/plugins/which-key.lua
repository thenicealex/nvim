return {
	"folke/which-key.nvim",
	keys = { "<leader>", ',','"', "'", "`", "c", "v", "g" },
	cmd = "WhichKey",
	opts = {
		plugins = { spelling = true },
		defaults = {
			mode = { "n", "v" },
			["]"] = { name = "+next" },
			["["] = { name = "+prev" },
			["<leader>f"] = { "Find File" },
			["<leader>b"] = { "Find Buffer" },
			["<leader>s"] = { "Search Words" },
			["<localleader>f"] = { name = "+file/find" },
			["<localleader>b"] = { name = "+buffer" },
			["<localleader>l"] = { name = "+lsp" },
			["<localleader>g"] = { name = "+git" },
			["<localleader>gh"] = { name = "+hunks" },
			["<localleader>q"] = { name = "+quit/session" },
			["<localleader>s"] = { name = "+search" },
			["<localleader>w"] = { name = "+windows" },
			["<localleader>x"] = { name = "+diagnostics/quickfix" },
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.register(opts.defaults)
	end,
}
