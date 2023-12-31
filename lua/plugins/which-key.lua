return {
	"folke/which-key.nvim",
	init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
	keys = { "<leader>", ',','"', "'", "`", "c", "v", "g","z" },
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
			["<leader>l"] = { name = "+lsp" },
			["<leader>m"] = { name = "+marks" },
			["<localleader>c"] = { name = "+change/colors" },
			["<localleader>f"] = { name = "+file/find" },
			["<localleader>b"] = { name = "+buffer" },
			["<localleader>g"] = { name = "+git" },
			["<localleader>gh"] = { name = "+hunks" },
			["<localleader>q"] = { name = "+quit/session" },
			["<localleader>s"] = { name = "+search" },
			["<localleader>w"] = { name = "+windows" },
			["<localleader>x"] = { name = "+diagnostics/quickfix" },
			["<localleader>n"] = { name = "+notice" },
			["<localleader>r"] = { name = "+run code" },
			-- ["<localleader>rc"] = { name = "+c/cpp" },
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.register(opts.defaults)
	end,
}
