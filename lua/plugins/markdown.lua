return {
	"iamcco/markdown-preview.nvim",
	ft = { "md","markdown" },
	build = "cd app && npm install",
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }
	end,
}
