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
	"nvim-lua/plenary.nvim",
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	require("plugins.flash"),
	require("plugins.neo-tree"),
	require("plugins.comment"),
	require("plugins.treesitter"),
	require("plugins.which-key"),
	require("plugins.themes"),
	require("plugins.bufferline"),
	require("plugins.statusline"),
	require("plugins.autopairs"),
	require("plugins.surround"),
	require("plugins.cmp"),
	require("plugins.formatter"),
	require("plugins.mason"),
	require("plugins.git"),
	{ "lukas-reineke/indent-blankline.nvim" },
	{"HiPhish/rainbow-delimiters.nvim"},
	{
		"onsails/lspkind.nvim",
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
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		event = "VeryLazy",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
		},
		opts = {
			-- configurations go here
		},
	},
	{
		"ThePrimeagen/harpoon",
		-- event = "VeryLazy",
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
})
