return {
  "sindrets/diffview.nvim",
  event = "VeryLazy",
  enabled = not vim.g.vscode,
  dependencies = { "nvim-tree/nvim-web-devicons", opts = {} },
}
