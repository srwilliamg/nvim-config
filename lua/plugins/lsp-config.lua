local desc = Utils.plugin_keymap_desc("LSP")
local configs = require("plugins.lsp.configs")

return {
  {
    "mason-org/mason.nvim",
    enabled = not vim.g.vscode,
    opts = {
      opts = {
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    enabled = not vim.g.vscode,
    opts = {
      automjtic_enable = true,
      ensure_installed = {
        "lua_ls",
        "eslint",
        "gopls",
        "jsonls",
        "stylua",
        "ts_ls",
        "yamlls",
        "sqlls",
        "ts_ls",
        "eslint",
        "harper_ls",
      },
    },
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
  },
  {
    "neovim/nvim-lspconfig",
    enabled = not vim.g.vscode,
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      "mason-org/mason.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      -- config also enables the LSP
      vim.lsp.config("lua_ls", configs.lua)
      vim.lsp.config("gopls", configs.go)
      vim.lsp.config("harper_ls", configs.harper)

      -- LSP
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = desc("Hover") })
      vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = desc("Rename") })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = desc("Code Action") })
      vim.keymap.set("n", "<leader>cc", vim.lsp.codelens.run, { desc = desc("Run Codelens") })
      vim.keymap.set("n", "<leader>cC", vim.lsp.codelens.refresh, { desc = desc("Refresh & Display Codelens") })
      vim.keymap.set("n", "<leader>cR", function()
        Snacks.rename.rename_file()
      end, { desc = desc("Rename File") })

      -- Code Display Hints
      vim.keymap.set("n", "<leader>cdh", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        vim.notify("Toggled Go inline hints")
      end, { desc = desc("Toggle Go inline hints") })
    end,
  },
}
