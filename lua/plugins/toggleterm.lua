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
		size = function(term)
			if term.direction == "horizontal" then
				return 20
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.4
			end
		end,
		start_in_insert = true,
		direction = "float",
		shell = "pwsh.exe",
		float_opts = {
			border = "curved",
			width = math.ceil(vim.o.columns * 0.8),
			height = math.ceil(vim.o.columns * 0.2),
		},
		on_create = function()
			vim.opt.foldcolumn = "0"
			vim.opt.signcolumn = "no"
		end,
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
			local option = { buffer = 0 }
			vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], option)
			vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], option)
			vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], option)
			vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], option)
			vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], option)
			vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], option)
		end
		-- if you only want these mappings for toggle term use term://*toggleterm#* instead
		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
		require("toggleterm").setup(opts)
	end,
}
