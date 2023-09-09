---@diagnostic disable: undefined-global
-- Setup language servers.
local lspconfig = require("lspconfig")
local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false
	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint(bufnr, true)
	end
end

local capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), cmp_capabilities)

capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}


lspconfig.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
lspconfig.clangd.setup({
	cmd = {
		"clangd",
    "--background-index",
    "--suggest-missing-includes",
    "--clang-tidy",
		"--query-driver=C:/Program Files/JetBrains/CLion 2022.3.1/bin/mingw/bin/g++.exe",
	},
	on_attach = on_attach,
	capabilities = capabilities,
})
require("neodev").setup({})
lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			hint = { enable = false },
			completion = {
				callSnippet = "Replace",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {
					"vim",
				},
			},
			workspace = {
				checkThirdParty = false,
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					[vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
				maxPreload = 100000,
				preloadFileSize = 10000,
			},
		},
	},
})
local utils = require("core.utils")
if utils.has("lspsaga.nvim") then
	vim.keymap.set("n", "<leader>lp", "<cmd>Lspsaga show_workspace_diagnostics<cr>", { desc = "Project diagnostics" })
	vim.keymap.set("n", "<leader>lb", "<cmd>Lspsaga show_buf_diagnostics<cr>", { desc = "Buffer diagnostics" })
	vim.keymap.set("n", "<leader>lo", "<cmd>Lspsaga show_line_diagnostics<cr>", { desc = "Open diagnostic" })
	vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { desc = "Prev diagnostic" })
	vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", { desc = "Next diagnostic" })
else
	vim.keymap.set("n", "<leader>lb", vim.diagnostic.setloclist, { desc = "Buffer diagnostics" })
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
	vim.keymap.set("n", "<leader>lo", vim.diagnostic.open_float, { desc = "Open diagnostic" })
end
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local get_opts = function(option)
			local opts = { buffer = ev.buf }
			if option then
				opts = vim.tbl_extend("force", opts, option)
			end
			return opts
		end
		if utils.has("Lspsaga.nvim") then
			-- stylua: ignore
		  vim.keymap.set( { "n", "v" }, "<leader>la", "<cmd>Lspsaga code_action", get_opts({ desc = "Code action" }))
		else
			vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, get_opts({ desc = "Rename" }))
			-- stylua: ignore
			vim.keymap.set( { "n", "v" }, "<leader>la", vim.lsp.buf.code_action, get_opts({ desc = "Code action" }))
			vim.keymap.set("n", "K", vim.lsp.buf.hover, get_opts({ desc = "Hover" }))
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, get_opts({ desc = "Definition" }))
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, get_opts({ desc = "Declaration" }))
			vim.keymap.set("n", "gr", vim.lsp.buf.references, get_opts({ desc = "References" }))
			-- stylua: ignore start
			vim.keymap.set( "n", "gi", vim.lsp.buf.implementation, get_opts({ desc = "Implementation" }))
			vim.keymap.set( "n", "<leader>lk", vim.lsp.buf.signature_help, get_opts({ desc = "Signature_help" }))
			vim.keymap.set( "n", "<leader>ld", vim.lsp.buf.type_definition, get_opts({ desc = "Type definition" }))

			vim.keymap.set( "n", "<leader>lwa", vim.lsp.buf.add_workspace_folder, get_opts({ desc = "Add workspace folder" }))
			vim.keymap.set( "n", "<leader>lwr", vim.lsp.buf.remove_workspace_folder, get_opts({ desc = "Remove workspace folder" }))
			-- stylua: ignore end
			vim.keymap.set("n", "<leader>lwl", function()
				print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
			end, get_opts({ desc = "List workleader folders" }))
			vim.keymap.set("n", "<leader>lm", function()
				vim.lsp.buf.format({ async = true })
			end, get_opts({ desc = "Lsp format" }))
		end
	end,
})

local diag_icon = {
	Error = "✘",
	Warn = "▲", -- 
	Hint = "💡", -- ⚑ 󰛩
	Info = " ",
}
for name, icon in pairs(diag_icon) do
	local dname = "DiagnosticSign" .. name
	vim.fn.sign_define(dname, {
		texthl = dname,
		text = icon,
	})
end
vim.diagnostic.config({
	virtual_text = false,
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = true,
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})
