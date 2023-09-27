return {
	{
		"nvimdev/rapid.nvim",
		cmd = { "Rapid" },
		config = function()
			require("rapid").setup({})
		end,
	},
}
