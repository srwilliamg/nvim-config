return {
  {
    enabled = not vim.g.vscode,
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    init = function()
      -- vim.cmd.colorscheme("gruvbox")
      -- vim.o.background = "dark" -- or "light" for light mode
      -- vim.cmd([[colorscheme gruvbox]])
    end,
    config = function(_, opts)
      require("gruvbox").setup(opts)
    end,
    opts = {
      terminal_colors = true, -- add neovim terminal colors
      undercurl = true,
      underline = false,
      bold = true,
      italic = {
        strings = false,
        emphasis = false,
        comments = false,
        operators = false,
        folds = false,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = "", -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {
        -- dark background
        CursorLineNr = { fg = "#fabd2f", bold = true },
        Search = { bg = "#fabd2f", fg = "#1d2021" },
        IncSearch = { bg = "#fabd2f", fg = "#1d2021" },
        Visual = { bg = "#3c3836" },
      },
      dim_inactive = false,
      transparent_mode = false,
    },
  },
  {
    enabled = not vim.g.vscode,
    "rebelot/kanagawa.nvim",
    config = function(_, opts)
      require("kanagawa").setup({
        theme = "wave",
        background = {
          dark = "dragon",
          light = "wave",
        },
      })
    end,
    init = function()
      vim.cmd("colorscheme kanagawa")
      require("kanagawa").load("wave")
    end,
  },
  {
    enabled = not vim.g.vscode,
    "navarasu/onedark.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("onedark").setup({
        style = "warmer",
      })
      -- require("onedark").load()
    end,
  },
}
