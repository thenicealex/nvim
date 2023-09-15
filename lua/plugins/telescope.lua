return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.2",
		cmd = "Telescope",
		keys = {
			{ "<leader>f", "<cmd>Telescope find_files<cr>" },
			{ "<leader>B", "<cmd>Telescope buffers<cr>", desc = "Telescope buffers" },
			{ "<leader>s", "<cmd>Telescope current_buffer_fuzzy_find<cr>" },
			{ "<localleader>ss", "<cmd>Telescope live_grep<cr>", desc = "global search" },
			{ "<localleader>fh", "<cmd>Telescope help_tags<cr>", desc = "help doc" },
			{
				"<localleader>fa",
				"<cmd>Telescope find_files follow=true no_ignore=true hidden=true<cr>",
				desc = "find all file",
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		opts = {
			defaults = {
				vimgrep_arguments = {
					"rg",
					"--glob=!*.dict",
					"-L",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},
				selection_caret = "  ",
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.6,
						results_width = 0.7,
					},
					vertical = {
						mirror = false,
					},
					width = 0.87,
					height = 0.80,
				},
				sorting_strategy = "ascending",
			},
			pickers = {
				find_files = {
					prompt_title = "",
					prompt_prefix = "Files> ",
				},
				buffers = {
					prompt_title = "",
					prompt_prefix = "Buffers> ",
				},
				live_grep = {
					prompt_title = "",
					prompt_prefix = "Global Search> ",
					layout_strategy = "vertical",
					layout_config = {
						vertical = {
							prompt_position = "top",
							width = 0.9,
							height = 0.9,
							preview_height = 0.5,
							preview_cutoff = 0,
						},
					},
				},
				current_buffer_fuzzy_find = {
					prompt_title = "",
					prompt_prefix = "Search> ",
					layout_strategy = "vertical",
					layout_config = {
						vertical = {
							prompt_position = "top",
							width = 0.9,
							height = 0.9,
							preview_height = 0.5,
							preview_cutoff = 0,
						},
					},
				},
			},
			extensions = {},
		},
		config = function(_, opts)
			local fb_actions = require("telescope").extensions.file_browser.actions
			local trouble = require("trouble.providers.telescope")
			opts.defaults.mappings = {
				i = { ["<c-t>"] = trouble.open_with_trouble },
				n = { ["<c-t>"] = trouble.open_with_trouble },
			}
			opts.extensions = {
				file_browser = {
					dir_icon = "󰉋",
					dir_icon_hl = "TelescopeFileBrowIcon",
					display_stat = { date = true, size = true, mode = true },
					mappings = {
						["n"] = {
							["c"] = fb_actions.create,
							["r"] = fb_actions.rename,
							["d"] = fb_actions.remove,
							["o"] = fb_actions.open,
							["h"] = fb_actions.goto_parent_dir,
						},
					},
				},
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
				},
			}
			require("telescope").setup(opts)
			require("telescope").load_extension("file_browser")
			require("telescope").load_extension("fzf")
		end,
	},
}
