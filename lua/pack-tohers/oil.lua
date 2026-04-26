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
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "OilActionsPost",
      callback = function(event)
        if event.data.actions[1].type == "move" then
          Snacks.rename.on_rename_file(event.data.actions[1].src_url, event.data.actions[1].dest_url)
        end
      end,
    })
  end,
}
