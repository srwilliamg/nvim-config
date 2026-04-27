require("lazyload").on_vim_enter(function()
  vim.pack.add({
    { src = Utils.github("sindrets/diffview.nvim"), name = "diffview" }, --depend on: "nvim-tree/nvim-web-devicons"
  })

  require("diffview").setup()
end)
