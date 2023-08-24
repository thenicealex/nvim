return {
	'akinsho/bufferline.nvim',
	version = "*",
	-- opts = {}，
	config = function(_, opts)
		require("bufferline").setup(opts)
	end,
}
