return {
	"williamboman/mason.nvim",
	-- event = "VeryLazy",
	-- cmd = { "Mason", "MasonInstall", "MasonUninstall" },
	-- event = { "BufReadPre", "BufNewFile" },
	opts = {},-- pyright clandg
	config = function(_, opts)
		require("mason").setup(opts)
	end,
}
