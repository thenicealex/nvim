return {
  "sindrets/diffview.nvim",
  command = "DiffviewOpen",
  opts = {},
  config = function (_, opts)
    require("diffview").setup(opts)
  end
}
