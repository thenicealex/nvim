return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		cmd = "Neotree",
		keys = {
			{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Filetree toggle" },
		},
		opts = {
			close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
			enable_git_status = true,
			enable_diagnostics = true,
			sort_function = nil,
			source_selector = {
				winbar = false,
				statusline = false,
			},
			git_status = {
				symbols = {
					-- Change type
					added = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
					modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
					deleted = "✖", -- this can only be used in the git_status source
					renamed = "󰁕", -- this can only be used in the git_status source
					-- Status type
					untracked = "",
					ignored = "",
					unstaged = "󰄱",
					staged = "",
					conflict = "",
				},
			},
			window = {
				position = "left",
				width = 28,
				mapping_options = {
					noremap = true,
					nowait = true,
				},
				mappings = {
					["?"] = "show_help",
					["l"] = "open",
					["<2-LeftMouse>"] = "open",
					["<cr>"] = "open",
					["<esc>"] = "cancel", -- close preview or floating neo-tree window
					["v"] = "open_split",
					["s"] = "open_vsplit",
					["V"] = "split_with_window_picker",
					["S"] = "vsplit_with_window_picker",
					["a"] = {
						"add",
						config = { -- "none", "relative", "absolute"
							show_path = "none",
						},
					},
					["A"] = "add_directory",
					["d"] = "delete",
					["r"] = "rename",
					["y"] = "copy_to_clipboard",
					["x"] = "cut_to_clipboard",
					["p"] = "paste_from_clipboard",
					["c"] = "copy",
					["m"] = "move",
					["q"] = "close_window",
					["R"] = "refresh",
					["P"] = { "toggle_preview", config = { use_float = true } },
					["O"] = "focus_preview",
					["t"] = "open_tabnew",
					-- ["<cr>"] = "open_drop",
					-- ["t"] = "open_tab_drop",
					["w"] = "open_with_window_picker",
					--["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
					["C"] = "close_node",
					-- ['C'] = 'close_all_subnodes',
					["z"] = "close_all_nodes",
					--["Z"] = "expand_all_nodes",
					["<"] = "prev_source",
					[">"] = "next_source",
					["i"] = "show_file_details",
				},
			},
		},
		config = function(_, opts)
			require("neo-tree").setup(opts)
		end,
	},
}
