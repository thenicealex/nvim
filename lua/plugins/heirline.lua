return {
	"rebelot/heirline.nvim",
	-- You can optionally lazy-load heirline on UiEnter
	-- to make sure all required plugins and colorschemes are loaded before setup
  -- event = "BufEnter",
  event ="VeryLazy",
  opts = function ()
    local statusline = require("plugins.configs.statusline").statusline
    return {
      statusline = statusline,
    }
  end,
	config = function(_, opts)
    require("heirline").setup(opts)
	end,
}
