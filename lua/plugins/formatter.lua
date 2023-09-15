return {
	{
		"nvimdev/guard.nvim",
		cmd = { "GuardFmt", "GuardEnable", "GuardDisable" },
		keys = { { "<localleader>fm", "<cmd>GuardFmt<cr>", desc = "Format file" } },
		dependencies = {
			"nvimdev/guard-collection",
		},
		config = function()
			local ft = require("guard.filetype")
			ft("c"):fmt({
				cmd = "clang-format",
				args = { "--style={BasedOnStyle: Google, IndentWidth: 4}" },
				stdin = true,
				ignore_patterns = { "neovim", "vim" },
			}):lint("clang-tidy")
			ft("cpp"):fmt({
				cmd = "clang-format",
				args = { "--style={BasedOnStyle: Google, IndentWidth: 4}" },
				stdin = true,
				ignore_patterns = { "neovim", "vim" },
			}):lint("clang-tidy")
			ft("python"):fmt({
				cmd = "black",
				stdin = true,
			})
			-- cargo install stylua --features lua52
			ft("lua"):fmt({
				cmd = "stylua",
				args = { "-" },
				stdin = true,
				ignore_patterns = "%w_spec%.lua",
			})
			ft("json", "javascript", "typescript"):fmt("prettier")

			require("guard").setup({
				-- the only options for the setup function
				fmt_on_save = false,
				-- Use lsp if no formatter was defined for this filetype
				lsp_as_default_formatter = false,
			})
		end,
	},
}
