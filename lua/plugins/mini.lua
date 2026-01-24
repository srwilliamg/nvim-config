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
        add = "za", -- Add surrounding in Normal and Visual modes
        delete = "zd", -- Delete surrounding
        find = "zf", -- Find surrounding [ to the right ]
        find_left = "zF", -- Find surrounding [ to the left ]
        highlight = "zh", -- Highlight surrounding
        replace = "zr", -- Replace surrounding
        update_n_lines = "zn", -- Update `n_lines`
      },
    },
  },
}
