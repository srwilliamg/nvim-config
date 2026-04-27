-- require("lazyload").on_vim_enter(function()
vim.pack.add({
  { src = Utils.github("MagicDuck/grug-far.nvim"), name = "grug-far" },
})
require("grug-far").setup({
  -- options, see Configuration section below
  -- there are no required options atm
})
-- end)
