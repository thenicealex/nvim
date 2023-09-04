return {
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
	opts = {
		defaults = {
			vimgrep_arguments = {
				"rg",
				"-L",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
			},
			selection_caret = "  ",
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
				preview_cutoff = 120,
			},
		},
		pickers = {
			find_files = {
				theme = "dropdown",
				-- layout_strategy = "vertical",
				previewer = false,
				prompt_title = "",
				prompt_prefix = "Files> ",
			},
			buffers = {
				theme = "dropdown",
				previewer = false,
				prompt_title = "",
				prompt_prefix = "Buffers> ",
			},
			live_grep = {
				theme = "dropdown",
				prompt_title = "",
				preview_title = "",
				prompt_prefix = "Global search> ",
				layout_config = {
					width = 0.8,
					height = 0.5,
				},
			},
			current_buffer_fuzzy_find = {
				theme = "dropdown",
				prompt_title = "",
				preview_title = "",
				prompt_prefix = "Search> ",
				layout_config = {
					width = 0.8,
					height = 0.4,
				},
			},
		},
		extensions = {
			-- Your extension configuration goes here:
			-- extension_name = {
			--   extension_config_key = value,
			-- }
			-- please take a look at the readme of the extension you want to configure
		},
	},
	config = function(_, opts)
		require("telescope").setup(opts)
	end,
}
