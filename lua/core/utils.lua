local M = {}

function M.has(plugin)
	return require("lazy.core.config").spec.plugins[plugin] ~= nil
end

M.lazy_load = function(plugin)
	vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
		group = vim.api.nvim_create_augroup("BeLazyOnFileOpen" .. plugin, {}),
		callback = function()
			local file = vim.fn.expand("%")
			local condition = file ~= "NvimTree_1" and file ~= "[lazy]" and file ~= ""

			if condition then
				vim.api.nvim_del_augroup_by_name("BeLazyOnFileOpen" .. plugin)

				-- dont defer for treesitter as it will show slow highlighting
				-- This deferring only happens only when we do "nvim filename"
				if plugin ~= "nvim-treesitter" then
					vim.schedule(function()
						require("lazy").load({ plugins = plugin })

						if plugin == "nvim-lspconfig" then
							vim.cmd("silent! do FileType")
						end
					end, 0)
				else
					require("lazy").load({ plugins = plugin })
				end
			end
		end,
	})
end

function M.on_very_lazy(fn)
	vim.api.nvim_create_autocmd("User", {
		pattern = "VeryLazy",
		callback = function()
			fn()
		end,
	})
end

function M.is_system_win()
	return vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
end

-- Comments selected text and pastes it uncommented below and moves cursor to pasted section.
function M.comment_yank_paste()
	local win = vim.api.nvim_get_current_win()
	local cur = vim.api.nvim_win_get_cursor(win)
	local set_cur = vim.api.nvim_win_set_cursor
	local vstart = vim.fn.getpos("v")[2]
	local current_line = vim.fn.line(".")
	if vstart == current_line then
		vim.cmd.yank()
		require("Comment.api").toggle.linewise.current()
		vim.cmd.put()
		set_cur(win, { cur[1] + 1, cur[2] })
	else
		if vstart < current_line then
			vim.cmd(":" .. vstart .. "," .. current_line .. "y")
			vim.cmd.put()
			set_cur(win, { vim.fn.line("."), cur[2] })
		else
			vim.cmd(":" .. current_line .. "," .. vstart .. "y")
			set_cur(win, { vstart, cur[2] })
			vim.cmd.put()
			set_cur(win, { vim.fn.line("."), cur[2] })
		end
		require("Comment.api").toggle.linewise(vim.fn.visualmode())
	end
end

return M
