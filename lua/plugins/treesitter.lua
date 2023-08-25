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
	opts = function()
		return {
			autotag = { enable = true },
			context_commentstring = { enable = true, enable_autocmd = false },
			ensure_installed = { "c", "cpp", "lua", "python", "markdown" },
			auto_install = false,
			highlight = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
			indent = { enable = true },
		}
	end,
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
