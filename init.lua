require("core")
local plugins_ok, _ = pcall(require, "plugins")
if not plugins_ok then
	return
end
-- vim.cmd("colorscheme tokyonight")
vim.cmd("colorscheme onedark")
