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

vim.api.nvim_set_hl(0, "MyPmenuSel", { fg = "#efefef", bg = "#2d4d74", bold = true })
vim.api.nvim_set_hl(0, "MyFloatBorder", { bg = "#1e222a" })
local border_opts = {
	border = "rounded",
	scrollbar = false,
	-- TODO:
	winhighlight = "FloatBorder:MyFloatBorder,CursorLine:MyPmenuSel,Search:None",
}

local function has_words_before()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = { { name = "buffer" } },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, { { name = "cmdline" } }),
})

local formatting_style = {
	-- default fields order i.e completion word + item.kind + item.kind icons
	fields = { "abbr", "kind", "menu" },
	format = function(entry, vim_item)
		local kind_icons = require("icons").lspkind
		-- From kind_icons array
		-- This concatonates the icons with the name of the item kind
		vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind] or "?", vim_item.kind)
		local function trim(text)
			local max = 23
			if text and text:len() > max then
				text = text:gsub("%b()~", "()")
				text = text:sub(1, max)
			end
			return text
		end
		vim_item.abbr = trim(vim_item.abbr):gsub("^%s+", "")
		-- Source
		-- vim_item.menu = ({
		-- 	buffer = "[Buffer]",
		-- 	nvim_lsp = "[LSP]",
		-- 	luasnip = "[LuaSnip]",
		-- 	nvim_lua = "[Lua]",
		-- })[entry.source.name]
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
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		completion = cmp.config.window.bordered(border_opts),
		documentation = cmp.config.window.bordered(border_opts),
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
				config = {
					sources = cmp.config.sources({ { name = "dictionary" } }),
				},
			}),
			{ "i" }
		),
		["<C-y>"] = cmp.config.disable,
		["Tab"] = cmp.mapping.disable,
		["<S-Tab>"] = cmp.config.disable,
		-- ["<Tab>"] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_next_item()
		-- 	elseif luasnip.expand_or_jumpable() then
		-- 		luasnip.expand_or_jump()
		-- 	elseif has_words_before() then
		-- 		cmp.complete()
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, { "i", "s" }),
		-- ["<S-Tab>"] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_prev_item()
		-- 	elseif luasnip.jumpable(-1) then
		-- 		luasnip.jump(-1)
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, { "i", "s" }),
	},
	completion = {
		-- Automatically select the first item
		completeopt = "menu,menuone,noinsert,noselect",
	},

	sources = cmp.config.sources({
		{
			name = "nvim_lsp",
			priority = 1000,
			-- keyword_length = 3,
		},
		{
			name = "luasnip",
			priority = 750,
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
