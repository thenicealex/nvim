return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = { "MunifTanjim/nui.nvim" },
	cmd = "Neotree",
	keys = {
		{ "<leader>e", "<cmd>Neotree toggle<cr>" , desc = "Filetree toggle", },
	},
	config = function()
		require("neo-tree").setup()
	end,
}
