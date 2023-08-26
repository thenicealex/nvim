return {
	{
		"nvim-tree/nvim-tree.lua",
		-- init = function(_, bufnr)
		-- 	local api = require("nvim-tree.api")
		--
		-- 	local function opts(desc)
		-- 		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
		-- 	end
		--
		-- 	-- default mappings
		-- 	api.config.mappings.default_on_attach(bufnr)
		--
		-- 	-- custom mappings
		-- 	vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
		-- 	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
		-- end,
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Filetree toggle" },
			{ "<leader>o", "<cmd>NvimTreeFocus<cr>", desc = "Filetree focus" },
		},
		opts = {
			filters = {
				dotfiles = false,
				exclude = {},
			},
			disable_netrw = true,
			hijack_netrw = true,
			hijack_cursor = true,
			hijack_unnamed_buffer_when_opening = false,
			sync_root_with_cwd = true,
			update_focused_file = {
				enable = true,
				update_root = false,
			},
			view = {
				adaptive_size = false,
				side = "left",
				width = 30,
				preserve_window_proportions = true,
			},
			git = {
				enable = false,
				ignore = true,
			},
			filesystem_watchers = {
				enable = true,
			},
			actions = {
				open_file = {
					resize_window = true,
				},
			},
			renderer = {
				root_folder_label = false,
				highlight_git = false,
				highlight_opened_files = "none",

				indent_markers = {
					enable = false,
				},

				icons = {
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = false,
					},

					glyphs = {
						default = "󰈚",
						symlink = "",
						-- folder = {
						-- 	default = "",
						-- 	empty = "",
						-- 	empty_open = "",
						-- 	open = "",
						-- 	symlink = "",
						-- 	symlink_open = "",
						-- 	arrow_open = "",
						-- 	arrow_closed = "",
						-- },
						git = {
							unstaged = "✗",
							staged = "✓",
							unmerged = "",
							renamed = "➜",
							untracked = "★",
							deleted = "",
							ignored = "◌",
						},
					},
				},
			},
		},
		config = function(_, opts)
			require("nvim-tree").setup(opts)
		end,
	},
	{
		"stevearc/oil.nvim",
		command = "Oil",
		event = "VeryLazy",
		opts = {
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<C-s>"] = "actions.select_vsplit",
				["<C-h>"] = "actions.select_split",
				["<C-t>"] = "actions.select_tab",
				["<C-p>"] = "actions.preview",
				["<C-c>"] = "actions.close",
				["<C-l>"] = "actions.refresh",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["~"] = "actions.tcd",
				["g."] = "actions.toggle_hidden",
			},
			-- Set to false to disable all of the above keymaps
			use_default_keymaps = true,
		},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function(_, opts)
			require("oil").setup(opts)
		end,
	},
}
