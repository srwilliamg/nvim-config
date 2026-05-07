require("lazyload").on_vim_enter(function()
  vim.pack.add({
    { src = Utils.github("MagicDuck/grug-far.nvim"), name = "grug-far" },
  })
  require("grug-far").setup({
    -- options, see Configuration section below
    -- there are no required options atm
  })
  vim.keymap.set({ "n", "x" }, "<leader>wre", function()
    -- require("grug-far").open({ visualSelectionUsage = "operate-within-range" })
    require("grug-far").open({ prefills = { paths = vim.fn.expand("%"), search = vim.fn.expand("<cword>") } })
  end, { desc = "grug-far: Search within range" })

  vim.keymap.set({ "n", "x" }, "<leader>re", function()
    require("grug-far").open()
  end, { desc = "grug-far: Search within range" })
end)
