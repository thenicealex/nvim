return {
  "linux-cultist/venv-selector.nvim",
  cmd = "VenvSelect",
  opts = function(_, opts)
    if LazyVim.has("nvim-dap-python") then
      opts.dap_enabled = true
    end
    return vim.tbl_deep_extend("force", opts, {
      anaconda_envs_path = "C:/Users/alex/miniconda3/envs",
      parents = 0,
      name = {
        "venv",
        ".venv",
        "env",
        ".env",
      },
    })
  end,
}
