return {
	{
		"nvim-tree/nvim-tree.lua",
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
      respect_buf_cwd = false,
			update_focused_file = {
				enable = true,
				update_root = false,
			},
			view = {
				adaptive_size = false,
				side = "left",
				width = 30,
				preserve_window_proportions = true,
				signcolumn = "yes",
			},
			git = {
				enable = true,
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
				indent_width = 2,
				indent_markers = {
					enable = true,
					inline_arrows = true,
				},
				icons = {
					git_placement = "after",
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
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
}
