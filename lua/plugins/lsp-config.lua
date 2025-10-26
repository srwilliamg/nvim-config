return {
  {
    "mason-org/mason.nvim",
    enabled = not vim.g.vscode,
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    enabled = not vim.g.vscode,
    opts = {},
    dependencies = { {
      "mason-org/mason.nvim",
      opts = {},
    }, "neovim/nvim-lspconfig" },
  },
  {
    "saghen/blink.cmp",
    enabled = not vim.g.vscode,
    -- optional: provides snippets for the snippet source
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      completion = {
        documentation = {
          auto_show = true,
        },
      },
      keymap = {
        preset = "none",
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-CR>"] = { "select_and_accept" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    enabled = not vim.g.vscode,
    config = function()
      local lspconfig = vim.lsp.config
      local lspEnable = vim.lsp.enable

      lspEnable("golangci_lint_ls")
      lspEnable("gopls")
      lspEnable("ts_ls")
      lspEnable("docker_language_server") -- go install github.com/docker/docker-language-server/cmd/docker-language-server@latest
      lspEnable("jsonls") -- npm i -g vscode-langservers-extracted
      lspEnable("lua_ls")

      lspconfig("lua_ls", {
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = "LuaJIT",
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim", "require" },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = false,
            },
          },
        },
      })

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
        virtual_lines = {
          current_line = true,
        },
      })
    end,
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      "mason-org/mason.nvim",
      {
        "saghen/blink.cmp",
        build = "cargo build --release",
      },
    },
  },
}
