return {
	"skywind3000/asyncrun.vim",
  cmd = { "AsyncRun", "AsyncStop", "AsyncTask" },
	config = function()
		vim.g.asyncrun_open = 6
		vim.g.asyncrun_bell = 1
		vim.keymap.set("n", "<F10>", ":call asyncrun#quickfix_toggle(6)<cr>", { noremap = true, silent = true, desc = "Toggle asyncQf" })
		vim.keymap.set(
			"n",
			"<localleader>rcc",
			':AsyncRun gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)\\$(VIM_FILENOEXT)" <cr>',
			{ noremap = true, silent = true, desc = "Compile C" }
		)
		vim.keymap.set(
			"n",
			"<localleader>rcr",
			':AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)\\$(VIM_FILENOEXT).exe" <cr>',
			{ noremap = true, silent = true, desc = "Run C" }
		)
	end,
}
