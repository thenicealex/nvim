if vim.loader and vim.fn.has("nvim-0.9.1") == 1 then
	vim.loader.enable()
end
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{"nvim-lua/plenary.nvim", event = "VeryLazy"},
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	require("plugins.flash"),
	require("plugins.nvimtree"),
	require("plugins.comment"),
	require("plugins.treesitter"),
	require("plugins.which-key"),
	require("plugins.themes"),
	-- require("plugins.bufferline"),
	require("plugins.statusline"),
	require("plugins.indentline"),
	require("plugins.autopairs"),
	require("plugins.surround"),
	require("plugins.nvim-cmp"),
	require("plugins.formatter"),
	require("plugins.mason"),
	require("plugins.lsp"),
	require("plugins.git"),
	require("plugins.tools"),
	require("plugins.telescope"),
	{
		"onsails/lspkind.nvim",
		event = "VeryLazy",
		opts = {
			mode = "symbol",
			symbol_map = {
				Array = "󰅪",
				Boolean = "⊨",
				Class = "󰌗",
				Constructor = "",
				Key = "󰌆",
				Namespace = "󰅪",
				Null = "NULL",
				Number = "#",
				Object = "󰀚",
				Package = "󰏗",
				Property = "",
				Reference = "",
				Snippet = "",
				String = "󰀬",
				TypeParameter = "󰊄",
				Unit = "",
			},
			menu = {},
		},
		-- enabled = vim.g.icons_enabled,
		enabled = true,
		config = function(_, opts)
			require("lspkind").init(opts)
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
})
