require("core")


local cmd = "nvim -h"
local stdout = {}
local stderr = {}
local jobid = vim.fn.jobstart(cmd, {
	on_stdout = function(_, data, _)
		data = table.concat(data, "\n")
		if #data > 0 then
			stdout[#stdout + 1] = data
		end
	end,
	on_stderr = function(_, data, _)
		stderr[#stderr + 1] = table.concat(data, "\n")
	end,
	on_exit = function()
		-- coroutine.resume(co)
	end,
	stdout_buffered = true,
	stderr_buffered = true,
})

vim.print(stdout)
