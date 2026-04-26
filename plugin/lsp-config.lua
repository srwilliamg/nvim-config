local desc = Utils.plugin_keymap_desc("LSP")
local configs = require("plugin.lsp.configs")

vim.pack.add {"https://github.com/mason-org/mason-lspconfig.nvim", "https://github.com/neovim/nvim-lspconfig",
              "https://github.com/mason-org/mason.nvim"}

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
require("mason-lspconfig").setup({
    automjtic_enable = true,
    ensure_installed = {"lua_ls", "eslint", "gopls", "jsonls", "stylua", "ts_ls", "yamlls", "sqlls", "ts_ls", "eslint" -- "harper_ls",
    }
})

-- placing the builtin LSP config here for organization reasons.
-- vim.lsp.config("*", {
--     capabilities = vim.lsp.protocol.make_client_capabilities()
-- })

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function()

        -- config also enables the LSP
        vim.lsp.config("lua_ls", configs.lua)
        vim.lsp.config("gopls", configs.go)
        -- vim.lsp.config("harper_ls", configs.harper)

        -- LSP
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {
            desc = desc("Hover")
        })
        vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, {
            desc = desc("Rename")
        })
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {
            desc = desc("Code Action")
        })
        vim.keymap.set("n", "<leader>cc", vim.lsp.codelens.run, {
            desc = desc("Run Codelens")
        })
        vim.keymap.set("n", "<leader>cC", vim.lsp.codelens.refresh, {
            desc = desc("Refresh & Display Codelens")
        })
        vim.keymap.set("n", "<leader>cR", function()
            Snacks.rename.rename_file()
        end, {
            desc = desc("Rename File")
        })

        -- Code Display Hints
        vim.keymap.set("n", "<leader>cdh", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            vim.notify("Toggled Go inline hints")
        end)
    end,
    once = true
})
