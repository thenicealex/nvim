return {
	"rebelot/heirline.nvim",
	-- You can optionally lazy-load heirline on UiEnter
	-- to make sure all required plugins and colorschemes are loaded before setup
	-- event = "UiEnter",
	opts = function()
		local conditions = require("heirline.conditions")
		local utils = require("heirline.utils")
		local onedark_colors = {
			dark = "#282c34",
			red = "#e06c75",
			green = "#98c379",
			orange = "#e5c078",
			blue = "#61afef",
			purple = "#c678dd",
			cyan = "#56b6c2",
			gray = "#abb2bf",
			bg = "#1a1d23",
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
					["\22"] = "^V",
					["\22s"] = "^V",
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
					["\22"] = "56b6c2",
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
				return "  " .. self.mode_names[self.mode] .. "  "
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
						return self.icon
					end
					return icon
				end,
				hl = function(self)
					return { fg = self.icon_color, bg = onedark_colors.bg }
				end,
			},
			{
				provider = function()
					local filename = (vim.fn.expand("%") == "" and "Empty ") or vim.fn.expand("%:t")
					return " " .. filename .. " "
				end,
				hl = { bg = onedark_colors.bg },
			},
		}
		local FileFlags = {
			{
				condition = function()
					return vim.bo.modified
				end,
				provider = "[+]",
				hl = { fg = onedark_colors.green },
			},
			{
				condition = function()
					return not vim.bo.modifiable or vim.bo.readonly
				end,
				provider = "",
				hl = { fg = onedark_colors.orange },
			},
			{ provider = "%=", hl = { bg = onedark_colors.bg } },
		}

		local FileType = {
			provider = function()
				return vim.bo.ft == "" and "{} plain text  " or "{} " .. vim.bo.ft .. " "
			end,
			hl = { fg = onedark_colors.blue, bg = onedark_colors.bg },
		}
		local FileEncoding = {
			provider = function()
				return string.upper(vim.bo.fileencoding) == "" and "" or string.upper(vim.bo.fileencoding) .. "  "
			end,
			hl = { fg = onedark_colors.red, bg = onedark_colors.bg },
		}
		-- We're getting minimalists here!
		local Ruler = {
			-- %l = current line number
			-- %L = number of lines in the buffer
			-- %c = column number
			-- %P = percentage through file of displayed window
			provider = function()
				return vim.o.columns > 140 and " Ln %l, Col %c  " or ""
			end,
			hl = { bg = onedark_colors.bg },
		}

		-- return config
		return {
			statusline = {
				ViMode,

				-- FileNameBlock,
				FileInfo,
				FileFlags,

				Ruler,

				FileEncoding,
				FileType,
			},
		}
	end,
	config = function(_, opts)
		require("heirline").setup(opts)
	end,
}
