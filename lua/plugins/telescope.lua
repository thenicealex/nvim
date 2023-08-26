return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.2",
	cmd = "Telescope",
	keys = {
		{ "<leader>f", "<cmd>Telescope find_files<cr>" },
		{ "<leader>b", "<cmd>Telescope buffers<cr>" },
		{ "<leader>s", "<cmd>Telescope current_buffer_fuzzy_find<cr>" },
		{ "<localleader>ss", "<cmd>Telescope live_grep<cr>" },
		{ "<localleader>fh", "<cmd>Telescope help_tags<cr>" },
		{ "<localleader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<cr>" },
	},
	opts = {
		defaults = {
			mappings = {
				i = {
					-- map actions.which_key to <C-h> (default: <C-/>)
					-- actions.which_key shows the mappings for your picker,
					-- e.g. git_{create, delete, ...}_branch for the git_branches picker
					-- ["<C-h>"] = "which_key",
				},
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
				preview_title = '',
				prompt_prefix = "Global search> ",
				layout_config = {
					width = 0.8,
					height = 0.3,
				},
			},
			current_buffer_fuzzy_find = {
				theme = "dropdown",
				prompt_title = "",
				preview_title = '',
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
