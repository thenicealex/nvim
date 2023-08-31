return {
	"mhartington/formatter.nvim",
	keys = { { "<localleader>fm", "<cmd>Format<cr>", desc = "Format file" } },
	opts = {
		filetype = {
			lua = {
				-- require("formatter.filetypes.lua").stylua,
				function()
					local util = require("formatter.util")
					-- Supports conditional formatting
					if util.get_current_buffer_file_name() == "special.lua" then
						return nil
					end

					-- Full specification of configurations is down below and in Vim help
					-- files
					return {
						exe = "stylua",
						args = {
							"--search-parent-directories",
							"--stdin-filepath",
							util.escape_path(util.get_current_buffer_file_path()),
							"--",
							"-",
						},
						stdin = true,
					}
				end,
			},
			cpp = {
				function()
					local util = require("formatter.util")
					return {
						exe = "clang-format",
						args = {
							"-assume-filename",
							util.escape_path(util.get_current_buffer_file_name()),
						},
						stdin = true,
						try_node_modules = true,
					}
				end,
			},
			c = {
				function()
					local util = require("formatter.util")
					return {
						exe = "clang-format -style='{IndentWidth: 4}'",
						args = {
							"-assume-filename",
							util.escape_path(util.get_current_buffer_file_name()),
						},
						stdin = true,
						try_node_modules = true,
					}
				end,
			},
			python = {
				function()
					return {
						exe = "black",
						args = { "-q", "-" },
						stdin = true,
					}
				end,
			},
			json = {
				function()
					local util = require("formatter.util")
					return {
						-- npm -g install prettier
						exe = "prettier",
						args = {
							"--stdin-filepath",
							util.escape_path(util.get_current_buffer_file_path()),
						},
						stdin = true,
						try_node_modules = true,
					}
				end,
			},
			["*"] = {
				-- require("formatter.filetypes.any").remove_trailing_whitespace
			},
		},
	},
	config = function(_, opts)
		require("formatter").setup(opts)
	end,
}
