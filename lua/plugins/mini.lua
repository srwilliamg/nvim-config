return {
  {

    enabled = not vim.g.vscode,
    "nvim-mini/mini.pairs",
    version = "*",
    config = function()
      require("mini.pairs").setup()
    end,
  },
  {
    enabled = not vim.g.vscode,
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    enabled = not vim.g.vscode,
    "nvim-mini/mini.surround",
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
