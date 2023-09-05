local vim = vim
local conditions = require("heirline.conditions")
-- local utils = require("heirline.utils")
local onedark_colors = {
	dark = "#282c34",
	red = "#e06c75",
	green = "#98c379",
	orange = "#e5c078",
	blue = "#61afef",
	purple = "#c678dd",
	cyan = "#56b6c2",
	gray = "#abb2bf",
	bg = "#1E222A",
}

local ViMode = {
	-- get vim current mode, this information will be required by the provider
	-- and the highlight functions, so we compute it only once per component
	-- evaluation and store it as a component attribute
	init = function(self)
		self.mode = vim.fn.mode(1) -- :h mode()
	end,
	-- Now we define some dictionaries to map the output of mode() to the
	-- corresponding string and color. We can put these into `static` to compute
	-- them at initialisation time.
	static = {
		mode_names = { -- change the strings if you like it vvvvverbose!
			n = "NORMAL",
			no = "N?",
			nov = "N?",
			noV = "N?",
			["no\22"] = "N?",
			niI = "Ni",
			niR = "Nr",
			niV = "Nv",
			nt = "Nt",
			v = "VISUAL",
			vs = "Vs",
			V = "V-LINE",
			Vs = "V-LINE",
			["\22"] = "V-BLOCK",
			["\22s"] = "V-BLOCK",
			s = "SELECT",
			S = "S-LINE",
			["\19"] = "^S",
			i = "INSERT",
			ic = "Ic",
			ix = "Ix",
			R = "RRPLACE",
			Rc = "Rc",
			Rx = "Rx",
			Rv = "Rv",
			Rvc = "Rv",
			Rvx = "Rv",
			c = "COMMAND",
			cv = "Ex",
			r = "PROMPT",
			rm = "M",
			["r?"] = "?",
			["!"] = "!",
			t = "TERMINAL",
		},
		mode_colors = {
			n = "#61afef",
			i = "#98c379",
			v = "#56b6c2",
			V = "#56b6c2",
			["\22"] = "#56b6c2",
			c = "#e5c07b",
			s = "#c678dd",
			S = "#c678dd",
			["\19"] = "#c678dd",
			R = "#e5c07b",
			r = "#e5c07b",
			["!"] = "#e06c75",
			t = "#e06c75",
		},
	},
	-- We can now access the value of mode() that, by now, would have been
	-- computed by `init()` and use it to index our strings dictionary.
	-- note how `static` fields become just regular attributes once the
	-- component is instantiated.
	-- To be extra meticulous, we can also add some vim statusline syntax to
	-- control the padding and make sure our string is always at least 2
	-- characters long. Plus a nice Icon.
	provider = function(self)
		return "  ⚡ " .. self.mode_names[self.mode] .. " "
	end,
	-- Same goes for the highlight. Now the foreground will change according to the current mode.
	hl = function(self)
		local mode = self.mode:sub(1, 1) -- get only the first mode character
		return { fg = self.mode_colors[mode], bold = true }
	end,
	-- Re-evaluate the component only on ModeChanged event!
	-- Also allows the statusline to be re-evaluated when entering operator-pending mode
	update = {
		"ModeChanged",
		pattern = "*:*",
		callback = vim.schedule_wrap(function()
			vim.cmd("redrawstatus")
		end),
	},
}

-- We can now define some children separately and add them later
local FileInfo = {
	{
		provider = function(self)
			local icon = "󰈚"
			local filename = (vim.fn.expand("%") == "" and "Empty ") or vim.fn.expand("%:t")

			if filename ~= "Empty " then
				local extension = vim.fn.fnamemodify(filename, ":e")
				self.icon, self.icon_color =
					require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
				return self.icon .. " "
			end
			return icon
		end,
		hl = function(self)
			return { fg = self.icon_color }
		end,
	},
	{
		provider = function()
			local filename = (vim.fn.expand("%") == "" and "Empty ") or vim.fn.expand("%:t")
			return " " .. filename .. " "
		end,
	},
}
local FileFlags = {
	{
		condition = function()
			return vim.bo.modified
		end,
		provider = "[+] ",
		hl = { fg = onedark_colors.green },
	},
	{
		condition = function()
			return not vim.bo.modifiable or vim.bo.readonly
		end,
		provider = "",
		hl = { fg = onedark_colors.orange },
	},
}

local Separate = { provider = "%=" }

local FileTab = {
	condition = function()
		return vim.o.columns > 140
	end,
	provider = function()
		return "SPACE: " .. vim.o.tabstop
	end,
	hl = { fg = onedark_colors.cyan },
}
local FileType = {
	condition = function()
		return vim.o.columns > 140
	end,
	provider = function()
		if vim.bo.ft == "NvimTree" then
			return ""
		end
		return vim.bo.ft == "" and "PLAIN TEXT " or string.upper(vim.bo.ft)
	end,
	hl = { fg = onedark_colors.blue },
}
local FileEncoding = {
	condition = function()
		return vim.o.columns > 140
	end,
	provider = function()
		return string.upper(vim.bo.fileencoding) == "" and " " or " " .. string.upper(vim.bo.fileencoding) .. " "
	end,
	hl = { fg = onedark_colors.red },
}
local FileSize = {
	condition = function()
		return vim.o.columns > 140
	end,
	provider = function()
		-- stackoverflow, compute human readable file size
		local suffix = { "b", "k", "M", "G", "T", "P", "E" }
		local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
		fsize = (fsize < 0 and 0) or fsize
		if fsize < 1024 then
			return string.format(" %g%s", fsize, suffix[1]) .. " "
		end
		local i = math.floor((math.log(fsize) / math.log(1024)))
		return string.format(" %.2g%s", fsize / math.pow(1024, i), suffix[i + 1]) .. " "
	end,
	hl = { fg = onedark_colors.orange },
}

-- We're getting minimalists here!
local Ruler = {
	-- %l = current line number
	-- %L = number of lines in the buffer
	-- %c = column number
	-- %P = percentage through file of displayed window
	provider = function()
		return vim.o.columns > 140 and " Ln %l, Col %c %P " or " %l:%c %P "
	end,
	on_click = {
		callback = function()
			-- If you prefer Lazygit
			-- use vim.defer_fn() if the callback requires
			-- opening of a floating window
			-- (this also applies to telescope)
			vim.defer_fn(function() end, 100)
		end,
		name = "heirline_ruler",
	},
}

local Git = {
	on_click = {
		callback = function()
			-- If you prefer Lazygit
			-- use vim.defer_fn() if the callback requires
			-- opening of a floating window
			-- (this also applies to telescope)
			vim.defer_fn(function()
				local utils = require("core.utils")
				if utils.has("toggleterm.nvim") and utils.is_system_win() then
					local Terminal = require("toggleterm.terminal").Terminal
					local gitui =
						Terminal:new({ cmd = "gitui", close_on_exit = true, direction = "float", hidden = true })
					gitui:toggle()
				end
				print("Hello Git")
			end, 100)
		end,
		name = "heirline_git",
	},
	condition = conditions.is_git_repo,

	init = function(self)
		self.status_dict = vim.b.gitsigns_status_dict
		self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
	end,

	hl = { fg = onedark_colors.orange },

	{ -- git branch name
		provider = function(self)
			return "  " .. self.status_dict.head
		end,
		hl = { bold = true },
	},
	-- You could handle delimiters, icons and counts similar to Diagnostics
	{
		condition = function(self)
			return self.has_changes
		end,
		provider = " ",
	},
	{
		provider = function(self)
			local count = self.status_dict.added or 0
			return count > 0 and ("+" .. count .. " ")
		end,
		hl = { fg = onedark_colors.green },
	},
	{
		provider = function(self)
			local count = self.status_dict.removed or 0
			return count > 0 and ("-" .. count .. " ")
		end,
		hl = { fg = onedark_colors.red },
	},
	{
		provider = function(self)
			local count = self.status_dict.changed or 0
			return count > 0 and ("~" .. count)
		end,
		hl = { fg = onedark_colors.orange },
	},
	{
		condition = function(self)
			return self.has_changes
		end,
		provider = " ",
	},
}
---@diagnostic disable-next-line: unused-local
local SearchCount = {
	condition = function()
		return vim.v.hlsearch ~= 0
	end,
	init = function(self)
		local ok, search = pcall(vim.fn.searchcount)
		if ok and search.total then
			self.search = search
		end
	end,
	provider = function(self)
		local search = self.search
		return string.format(" [%d/%d]", search.current, math.min(search.total, search.maxcount))
	end,
	hl = { fg = onedark_colors.red },
}

local LSPActive = {
	condition = conditions.lsp_attached,
	update = { "LspAttach", "LspDetach" },
	on_click = {
		callback = function()
			vim.defer_fn(function()
				vim.cmd("LspInfo")
			end, 100)
		end,
		name = "heirline_LSP",
	},
	-- You can keep it simple,
	-- provider = " [LSP]",

	-- Or complicate things a bit and get the servers names
	provider = function()
		local names = {}
		for _, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
			table.insert(names, server.name)
		end
		return " [" .. table.concat(names, " ") .. "] "
	end,
	hl = { fg = onedark_colors.green, bold = true },
}
local Diagnostics = {

	condition = conditions.has_diagnostics,

	static = {
		error_icon = "󰅚 ",
		warn_icon = " ",
		info_icon = " ",
		hint_icon = "󰛩 ",
	},

	init = function(self)
		self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
		self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
	end,

	update = { "DiagnosticChanged", "BufEnter" },

	{
		provider = " ",
	},
	{
		on_click = {
			callback = function()
				vim.defer_fn(function()
					print("hello git")
				end, 100)
			end,
			name = "heirline_errors",
		},
		provider = function(self)
			-- 0 is just another output, we can decide to print it or not!
			return self.errors > 0 and (self.error_icon .. self.errors .. " ")
		end,
		hl = { fg = onedark_colors.red },
	},
	{
		on_click = {
			callback = function()
				vim.defer_fn(function()
					print("hello git")
				end, 100)
			end,
			name = "heirline_warnings",
		},
		provider = function(self)
			return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
		end,
		hl = { fg = onedark_colors.orange },
	},
	{
		on_click = {
			callback = function()
				vim.defer_fn(function()
					print("hello git")
				end, 100)
			end,
			name = "heirline_info",
		},
		provider = function(self)
			return self.info > 0 and (self.info_icon .. self.info .. " ")
		end,
		hl = { fg = onedark_colors.green },
	},
	{
		on_click = {
			callback = function()
				vim.defer_fn(function()
					print("hello git")
				end, 100)
			end,
			name = "heirline_hits",
		},
		provider = function(self)
			return self.hints > 0 and (self.hint_icon .. self.hints)
		end,
		hl = { fg = onedark_colors.purple },
	},
	{
		provider = " ",
	},
}

require("heirline").setup({
	statusline = {
		ViMode,
		FileInfo,
		FileFlags,
		Git,
		-- SearchCount,

		Separate,

		Ruler,
		Diagnostics,
		LSPActive,
		FileTab,
		FileEncoding,
		FileType,
		FileSize,
	},
})
