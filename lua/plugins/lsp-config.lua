return {
    {
        "mason-org/mason.nvim",
        enabled = not vim.g.vscode,
        opts = {}
    },
    {
        "mason-org/mason-lspconfig.nvim",
        enabled = not vim.g.vscode,
        opts = {},
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
    },
    {
        'saghen/blink.cmp',
        enabled = not vim.g.vscode,
        -- optional: provides snippets for the snippet source
        dependencies = { 'rafamadriz/friendly-snippets' },
        opts = {
            completion = {
                documentation = { auto_show = true },
            },
            keymap = {
                preset = "none",
                ["<C-j>"] = { "select_next", "fallback" },
                ["<C-k>"] = { "select_prev", "fallback" },
                ["<CR>"] = { "select_and_accept" },
            },

        }
    },
    {
        "neovim/nvim-lspconfig",
        enabled = not vim.g.vscode,
        config = function()
            vim.lsp.enable('golangci_lint_ls')
            vim.lsp.enable('gopls')
            vim.lsp.enable('ts_ls')
            vim.lsp.enable('docker_language_server') -- go install github.com/docker/docker-language-server/cmd/docker-language-server@latest
            vim.lsp.enable('jsonls') --npm i -g vscode-langservers-extracted
            vim.lsp.enable('lua_ls')
            vim.diagnostic.config({
                signs = {
                    numhl = {
                        [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
                        [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
                        [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
                        [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
                    },
                    text = {
                        [vim.diagnostic.severity.ERROR] = "X",
                        [vim.diagnostic.severity.HINT] = "?",
                        [vim.diagnostic.severity.INFO] = "I",
                        [vim.diagnostic.severity.WARN] = "!",
                    },
                },
                update_in_insert = true,
                virtual_text = false,
                virtual_lines = { current_line = true },
            })
        end,
        dependencies = {
            "mason-org/mason-lspconfig.nvim",
            "mason-org/mason.nvim",
            { "saghen/blink.cmp", build = "cargo build --release" },
        },
    }
}
