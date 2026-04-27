vim.pack.add({
  Utils.github("rebelot/kanagawa.nvim"),
}, { load = true })

require("kanagawa").setup({
  theme = "wave",
  background = {
    dark = "dragon",
    light = "wave",
  },
})

vim.cmd("colorscheme kanagawa-dragon")
