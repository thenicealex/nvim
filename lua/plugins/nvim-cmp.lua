return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-cmdline",
			{
				"uga-rosa/cmp-dictionary",
				opts = {},
				config = function(_, opts)
					local cmp_dic = require("cmp_dictionary")
					cmp_dic.setup(opts)
					cmp_dic.switcher({ spelllang = { en = "~/american_english.dic" } })
				end,
			},
		},
		event = "InsertEnter",
		opts = function()
			return require("plugins.configs.cmpconfig")
		end,
		config = function(_, opts)
			require("cmp").setup(opts)
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		-- dependencies = "rafamadriz/friendly-snippets",
		event = "InsertEnter",
		config = function()
			-- vscode format
			require("luasnip.loaders.from_vscode").lazy_load({paths="./snippets"})

			vim.api.nvim_create_autocmd("InsertLeave", {
				callback = function()
					if
						require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
						and not require("luasnip").session.jump_active
					then
						require("luasnip").unlink_current()
					end
				end,
			})
		end,
	},
}
