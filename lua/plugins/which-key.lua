return {
	"folke/which-key.nvim",
	keys = { "<leader>", '"', "'", "`", "c", "v", "g" },
	cmd = "WhichKey",
	opts = {},
	config = function(_, opts)
		require("which-key").setup(opts)
	end,
}
