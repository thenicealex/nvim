return {
	"williamboman/mason.nvim",
	-- event = "VeryLazy",
	-- cmd = { "Mason", "MasonInstall", "MasonUninstall" },
	opts = {},
	config = function(_, opts)
		require("mason").setup(opts)
	end,
}
