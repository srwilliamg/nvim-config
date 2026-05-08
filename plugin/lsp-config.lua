local desc = Utils.plugin_keymap_desc("LSP")

vim.pack.add({ Utils.github("mason-org/mason-lspconfig.nvim"), Utils.github("neovim/nvim-lspconfig"), Utils.github("mason-org/mason.nvim") }, { load = true })

require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})
require("mason-lspconfig").setup({
  automatic_enable = true,
  ensure_installed = {
    "lua_ls",
    "jsonls",
    "gopls",
    "stylua",
    "yamlls",
    "sqlls",
    "eslint",
    "ts_ls",
  },
})

local configs = require("lsp.configs")
-- config also enables the LSP
vim.lsp.config("lua_ls", configs.lua)
vim.lsp.config("gopls", configs.go)

-- LSP
vim.keymap.set("n", "K", vim.lsp.buf.hover, {
  desc = desc("Hover"),
})
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, {
  desc = desc("Rename"),
})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {
  desc = desc("Code Action"),
})
vim.keymap.set("n", "<leader>cc", vim.lsp.codelens.run, {
  desc = desc("Run Codelens"),
})
vim.keymap.set("n", "<leader>cC", vim.lsp.codelens.refresh, {
  desc = desc("Refresh & Display Codelens"),
})

vim.keymap.set("n", "<leader>cdh", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  vim.notify("Toggled Go inline hints")
end)
