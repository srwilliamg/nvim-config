return {
  "nvim-treesitter/nvim-treesitter",
  -- enabled = not vim.g.vscode,
  enabled = true,
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
  opts = {
    indent = { enable = true }, ---@type lazyvim.TSFeat
    highlight = { enable = true }, ---@type lazyvim.TSFeat
    folds = { enable = true }, ---@type lazyvim.TSFeat
    -- A list of parser names, or "all" (the listed parsers MUST always be installed)
    ensure_installed = {
      "c",
      "lua",
      "vim",
      "vimdoc",
      "query",
      "markdown",
      "markdown_inline",
      "bash",
      "html",
      "javascript",
      "json",
      "lua",
      "go",
      "gopls",
      "gomod",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "regex",
      "tsx",
      "typescript",
      "vim",
      "yaml",
    },
    sync_install = true,
    auto_install = true,
  },
}
