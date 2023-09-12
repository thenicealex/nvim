return {
  "sindrets/diffview.nvim",
  cmd = "DiffviewOpen",
  opts = {},
  config = function (_, opts)
    require("diffview").setup(opts)
  end
}
