local desc = Utils.plugin_keymap_desc("Oil")

return {
  "stevearc/oil.nvim",
  enabled = not vim.g.vscode,
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  keys = {
    {
      mode = { "n" },
      "<leader>o",
      function()
        vim.cmd("Oil")
      end,
      desc = desc("File Explorer"),
    },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  config = function(_, opts)
    require("oil").setup(opts)
  end,
}
