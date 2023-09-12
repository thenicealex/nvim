vim.g.mapleader = " "
vim.g.maplocalleader = ","

local o = vim.opt

o.mouse = "a"
o.relativenumber = false
o.number = true
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.termguicolors = true
o.splitright = true
o.splitbelow = true
o.laststatus = 3
o.cursorline = true
o.signcolumn = "yes"
o.swapfile = false
o.autoread = true
o.clipboard = "unnamedplus"
o.splitkeep = "screen"
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
o.foldenable = true
o.foldcolumn = "1"
o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
o.foldlevelstart = 99
-- o.foldtext = " "
-- o.fillchars = { eob = " ", fold = " ", foldopen = "", foldsep = " ", foldclose = "" }
-- o.statuscolumn='%s%l%=%C'
-- vim.o.statuscolumn='%=%l%s%{foldlevel(v:lnum) > 0 ? (foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? "-" : "+") : "│") : " " }'
