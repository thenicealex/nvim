-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
	-- NOTE: Yes, you can install new plugins here!
	"mfussenegger/nvim-dap",
	enabled = true,
  cmd = {"DapContinue"},
	-- init = function()
	-- 	require("core.utils").lazy_load("nvim-dap")
	-- end,
	-- NOTE: And you can specify dependencies as well
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
      -- stylua: ignore
      keys = {
        { "<localleader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
        { "<localleader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
      },
			opts = {
				icons = { expanded = "", collapsed = "" },
			},
			config = function(_, opts)
				local dap = require("dap")
				local dapui = require("dapui")
				dapui.setup(opts)
				dap.listeners.after.event_initialized["dapui_config"] = function()
					dapui.open({})
				end
				dap.listeners.before.event_terminated["dapui_config"] = function()
					dapui.close({})
				end
				dap.listeners.before.event_exited["dapui_config"] = function()
					dapui.close({})
				end
			end,
		},

		-- Installs the debug adapters for you
		{
			"jay-babu/mason-nvim-dap.nvim",
			-- dependencies = "mason.nvim",
			cmd = { "DapInstall", "DapUninstall" },
		},
		{
			"theHamsta/nvim-dap-virtual-text",
			config = function()
				require("nvim-dap-virtual-text").setup({
					virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",
				})
			end,
		},

		-- Add your own debuggers here
		-- 'leoluz/nvim-dap-go',
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- Basic debugging keymaps, feel free to change to your liking!
		vim.keymap.set("n", "<localleader>dd", dap.continue, { desc = "Debug: Start/Continue" })
		vim.keymap.set("n", "<localleader>di", dap.step_into, { desc = "Debug: Step Into" })
		vim.keymap.set("n", "<localleader>dv", dap.step_over, { desc = "Debug: Step Over" })
		vim.keymap.set("n", "<localleader>do", dap.step_out, { desc = "Debug: Step Out" })
		vim.keymap.set("n", "<localleader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
		vim.keymap.set("n", "<localleader>dB", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Debug: Set Breakpoint" })

		dap.adapters.python = {
			type = "executable",
			command = "python",
			args = { "-m", "debugpy.adapter" },
		}
		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Launch file",
				program = "${file}",
			},
		}
		dap.adapters.cppdbg = {
			id = "cppdbg",
			type = "executable",
			command = "OpenDebugAD7.exe",
			options = {
				detached = false,
			},
		}
		-- install gdb via scoop or other in windows
		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "cppdbg",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "\\", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtEntry = true,
				args = {},
				runInTerminal = false,
				-- MIMode = "lldb",
				-- miDebuggerPath = "lldb.exe"
			},
		}
		setupCommands = {
			{
				text = "-enable-pretty-printing",
				description = "enable pretty printing",
				ignoreFailures = false,
			},
		}

		dap.configurations.c = dap.configurations.cpp
		vim.fn.sign_define("DapBreakpoint", { text = "🚩", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })
		-- Install golang specific config
		-- require('dap-go').setup()
	end,
}
