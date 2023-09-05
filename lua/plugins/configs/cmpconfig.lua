local cmp = require("cmp")
local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end
vim.keymap.set({ "i", "s" }, "<Tab>", function()
	luasnip.jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
	luasnip.jump(-1)
end, { silent = true })

local function border(hl_name)
	return {
		{ "╭", hl_name },
		{ "─", hl_name },
		{ "╮", hl_name },
		{ "│", hl_name },
		{ "╯", hl_name },
		{ "─", hl_name },
		{ "╰", hl_name },
		{ "│", hl_name },
	}
end

---@diagnostic disable-next-line: unused-local, unused-function
local function has_words_before()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

---@diagnostic disable-next-line: unknown-diag-code
---@diagnostic disable-next-line: missing-fields
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = { { name = "buffer" } },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
---@diagnostic disable-next-line: unknown-diag-code
---@diagnostic disable-next-line: missing-fields
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, { { name = "cmdline" } }),
})

local formatting_style = {
	-- default fields order i.e completion word + item.kind + item.kind icons
	fields = { "abbr", "kind", "menu" },
	---@diagnostic disable-next-line: unused-local
	format = function(entry, vim_item)
		local kind_icons = require("icons").lspkind
		-- From kind_icons array
		-- This concatonates the icons with the name of the item kind
		vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind] or "?", vim_item.kind)
		-- vim_item.kind = string.format("%s", kind_icons[vim_item.kind] or "?")
		local function trim(text)
			local max = 28
			if text and text:len() > max then
				-- text = text:gsub("%b()~", "()")
				text = text:sub(1, max) .. "..."
			end
			return text
		end
		vim_item.abbr = trim(vim_item.abbr)
		-- Source
		-- vim_item.menu = ({
		-- 	buffer = "[Buffer]",
		-- 	nvim_lsp = "[LSP]",
		-- 	luasnip = "[LuaSnip]",
		-- 	nvim_lua = "[Lua]",
		-- })[entry.source.name]
		vim_item.menu = nil
		return vim_item
	end,
}
return {
	preselect = cmp.PreselectMode.None,
	formatting = formatting_style,
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	completion = {
		completeopt = "menu,menuone,noselect",
	},
	window = {
		completion = {
			border = border("CmpBorder"),
			scrollbar = false,
			winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:none",
		},
		documentation = {
			border = border("CmpDocBorder"),
			winhighlight = "Normal:CmpDoc",
		},
	},
	mapping = {
		["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<M-o>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<C-x>"] = cmp.mapping(
			cmp.mapping.complete({
				---@diagnostic disable-next-line: unknown-diag-code
				---@diagnostic disable-next-line: missing-fields
				config = {
					sources = cmp.config.sources({ { name = "dictionary" } }),
				},
			}),
			{ "i" }
		),
		["<C-y>"] = cmp.config.disable,
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif require("luasnip").expand_or_jumpable() then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif require("luasnip").jumpable(-1) then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
			else
				fallback()
			end
		end, { "i", "s" }),
	},

	sources = cmp.config.sources({
		{
			name = "nvim_lsp",
			priority = 750,
			-- keyword_length = 3,
		},
		{
			name = "luasnip",
			priority = 1000,
			option = { use_show_condition = true },
			entry_filter = function()
				local context = require("cmp.config.context")
				local string_ctx = context.in_treesitter_capture("string") or context.in_syntax_group("String")
				local comment_ctx = context.in_treesitter_capture("comment") or context.in_syntax_group("Comment")

				--   Returning `true` will keep the entry, while returning `false` will remove it.
				return not string_ctx and not comment_ctx
			end,
		},
		{
			name = "buffer",
			priority = 500,
			option = {
				get_bufnrs = function()
					local bufs = {}
					for _, win in ipairs(vim.api.nvim_list_wins()) do
						bufs[vim.api.nvim_win_get_buf(win)] = true
					end
					return vim.tbl_keys(bufs)
				end,
			},
		},
		{ name = "path", priority = 250 },
	}),
}
