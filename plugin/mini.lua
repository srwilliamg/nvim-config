require("lazyload").on_vim_enter(function()
  vim.pack.add({
    Utils.github("nvim-mini/mini.pairs"),
    Utils.github("nvim-mini/mini.surround"),
    Utils.github("folke/todo-comments.nvim"), -- depends on :"nvim-lua/plenary.nvim"
    Utils.github("chentoast/marks.nvim"),
  })

  require("marks").setup()
  require("mini.pairs").setup()
  require("todo-comments").setup()
  require("mini.surround").setup({
    mappings = {
      add = "sa", -- Add surrounding in Normal and Visual modes
      delete = "sd", -- Delete surrounding
      find = "sf", -- Find surrounding [ to the right ]
      find_left = "sF", -- Find surrounding [ to the left ]
      highlight = "sh", -- Highlight surrounding
      replace = "sr", -- Replace surrounding
      update_n_lines = "sn", -- Update `n_lines`
    },
  })
end)
