return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
		"nvim-treesitter/nvim-treesitter-textobjects",
		"windwp/nvim-ts-autotag",
	},
	init = function()
		require("core.utils").lazy_load("nvim-treesitter")
	end,
	event = { "BufReadPost", "BufNewFile" },
	cmd = { "TSInstall", "TSInstallInfo", "TSToggle", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
	build = ":TSUpdate",
	opts = {
		autotag = { enable = true },
		context_commentstring = { enable = true, enable_autocmd = false },
		ensure_installed = { "c", "cpp", "lua", "python", "markdown" },
		auto_install = false,
		highlight = { enable = true },
		indent = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<cr>",
				node_incremental = "<cr>",
				scope_incremental = false,
				node_decremental = "<bs>",
			},
		},
		textobjects = {
			select = {
				enable = true,
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
				},
			},
		},
	},
	config = function(_, opts)
		-- vim.opt.foldmethod = "expr"
		-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
		require("nvim-treesitter.configs").setup(opts)
	end,
}
