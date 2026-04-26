vim.schedule(function()
vim.pack.add({
    "https://github.com/rebelot/kanagawa.nvim",
  })

  require("kanagawa").setup({
    theme = "wave",
    background = {
      dark = "dragon",
      light = "wave",
    },
  })

  vim.cmd("colorscheme kanagawa-dragon")
end)
