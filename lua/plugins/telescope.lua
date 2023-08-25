return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.2",
	cmd = "Telescope",
	keys = {
		{ "<leader>f", "<cmd>Telescope find_files<cr>" },
		{ "<leader>b", "<cmd>Telescope buffers<cr>" },
		{ "<leader>s", "<cmd>Telescope curren_buffer_fuzzy_find<cr>" },
		{ "<localleader>ss", "<cmd>Telescope live_grep<cr>" },
		{ "<localleader>fh", "<cmd>Telescope help_tags<cr>" },
		{ "<localleader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<cr>" },
	},
}
