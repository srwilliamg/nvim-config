return {
  {
    "folke/lazydev.nvim",
    enabled = not vim.g.vscode,
    ft = "lua",
    opts = {
      library = {
        "lazy.nvim",
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "LazyVim", words = { "LazyVim" } },
      },
      integrations = {
        lspconfig = true,
        cmp = true,
        coq = false,
      },
    },
  },
}
