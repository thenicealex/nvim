return {
  "nvim-lualine/lualine.nvim",
  enabled = true,
  opts = function()
    return {
      options = {
        theme = "auto",
        component_separators = { left = " ", right = " " },
        section_separators = { left = " ", right = " " },
      },
    }
  end,
}
