local desc = Utils.plugin_keymap_desc("Oil")

return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  keys = {
    {
      mode = { "n" },
      "<leader>e",
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
