return {
	"williamboman/mason.nvim",
	-- event = "VeryLazy",
	-- cmd = { "Mason", "MasonInstall", "MasonUninstall" },
	event = { "BufReadPre", "BufNewFile" },
	opts = {},
	config = function(_, opts)
		require("mason").setup(opts)
	end,
}
