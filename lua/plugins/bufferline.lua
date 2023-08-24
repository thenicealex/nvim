return {
	'akinsho/bufferline.nvim',
	version = "*",
	event = "VeryLazy",
	-- opts = {}，
	config = function(_, opts)
		require("bufferline").setup(opts)
	end,
}
