if vim.loader and vim.fn.has("nvim-0.9.1") == 1 then
	vim.loader.enable()
end
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	require("plugins.themes"),
	require("plugins.flash"),
	require("plugins.ui"),
	require("plugins.nvimtree"),
	require("plugins.comment"),
	require("plugins.treesitter"),
	require("plugins.which-key"),
	require("plugins.statusline"),
	require("plugins.indentline"),
	require("plugins.autopairs"),
	require("plugins.surround"),
	require("plugins.nvim-cmp"),
	require("plugins.formatter"),
	require("plugins.mason"),
	require("plugins.lsp"),
	require("plugins.git"),
	require("plugins.tools"),
	require("plugins.telescope"),
})


