return {
	"akinsho/toggleterm.nvim",
	cmd = "ToggleTerm",
	keys = { {
		"<leader>tt",
		"<cmd>ToggleTerm<cr>",
		desc = "Toggle terminal",
	} },
	version = "*",
	opts = {
		size = 10,
		open_mapping = [[<C-\>]],
		start_in_insert = true,
		direction = "float",
		shell = "pwsh.exe",
		float_opts = {
			border = "curved",
			width = math.ceil(vim.o.columns * 0.8),
			height = math.ceil(vim.o.columns * 0.2),
		},
	},
	config = function(_, opts)
		local powershell_options = {
			shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
			shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
			shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
			shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
			shellquote = "",
			shellxquote = "",
		}
		for option, value in pairs(powershell_options) do
			vim.opt[option] = value
		end

		function _G.set_terminal_keymaps()
			local opts = { buffer = 0 }
			vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
			vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
			vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
			vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
			vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
			vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
			vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
		end
		-- if you only want these mappings for toggle term use term://*toggleterm#* instead
		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
		require("toggleterm").setup(opts)
	end,
}
