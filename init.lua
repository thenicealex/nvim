require("core")
require("plugins")
-- vim.cmd("colorscheme tokyonight-moon")
vim.cmd("colorscheme onedark")
require("tabufline.lazyload")
require("plenary.reload").reload_module("tabufline.modules")
vim.opt.tabline = "%!v:lua.require('tabufline.modules').run()"
