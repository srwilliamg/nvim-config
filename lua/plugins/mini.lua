return {
  {
    "nvim-mini/mini.pairs",
    enabled = not vim.g.vscode,
    version = "*",
    config = function()
      require("mini.pairs").setup()
    end,
  },
  {
    "folke/todo-comments.nvim",
    enabled = not vim.g.vscode,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "nvim-mini/mini.surround",
    enabled = not vim.g.vscode,
    version = false,
    opts = {
      mappings = {
        add = "sa", -- Add surrounding in Normal and Visual modes
        delete = "sd", -- Delete surrounding
        find = "sf", -- Find surrounding [ to the right ]
        find_left = "sF", -- Find surrounding [ to the left ]
        highlight = "sh", -- Highlight surrounding
        replace = "sr", -- Replace surrounding
        update_n_lines = "sn", -- Update `n_lines`
      },
    },
  },
}
