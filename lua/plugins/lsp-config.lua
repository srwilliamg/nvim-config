local desc = Utils.plugin_keymap_desc("LSP")

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

        -- "delve",
        -- "go-debug-adapter",
        -- "goimports",
        -- "gotests",
        -- "gotestsum",
        -- "js-debug-adapter",
        -- "prettier",
        -- "prettierd",
        -- "typescript-language-server",
      },
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
  {
    "neovim/nvim-lspconfig",
    enabled = not vim.g.vscode,
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      "mason-org/mason.nvim",
      {
        "saghen/blink.cmp",
        build = "cargo build --release",
      },
    },
    config = function()
      vim.lsp.enable("jsonls") -- npm i -g vscode-langservers-extracted

      vim.lsp.config["lua_ls"] = {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
        settings = {
          format = {
            enable = false,
          },
          diagnostics = {
            globals = { "vim", "require" },
          },
          telemetry = {
            enable = false,
          },
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
          },
        },
      }

      -- config also enables the LSP
      vim.lsp.config("gopls", {
        filetypes = { "go", "gomod", "gosum", "gotmpl", "gohtmltmpl", "gotexttmpl" },
        message_level = vim.lsp.protocol.MessageType.Error,
        cmd = {
          "gopls",
          "-remote.debug=:0",
        },
        capabilities = {
          textDocument = {
            completion = {
              completionItem = {
                commitCharactersSupport = true,
                deprecatedSupport = true,
                documentationFormat = { "markdown", "plaintext" },
                preselectSupport = true,
                insertReplaceSupport = true,
                labelDetailsSupport = true,
                snippetSupport = true,
                resolveSupport = {
                  properties = {
                    "documentation",
                    "details",
                    "additionalTextEdits",
                  },
                },
              },
              contextSupport = true,
              dynamicRegistration = true,
            },
          },
        },
        settings = {
          gopls = {
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeLoopVariables = true,
            },
            analyses = {
              unusedparams = true,
              nilness = true,
              unusedwrite = true,
              useany = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      })

      vim.lsp.enable("harper_ls")
      vim.lsp.config("harper_ls", {
        settings = {
          ["harper-ls"] = {
            userDictPath = "~/.config/nvim/lua/resources/spell/user.txt",
            workspaceDictPath = "~/.config/nvim/lua/resources/spell/ws.txt",
            fileDictPath = "~/.config/nvim/lua/resources/spell/file.txt",
            linters = {
              SentenceCapitalization = false,
              SpellCheck = false,
              LongSentences = false,
            },
            diagnosticSeverity = "hint", --information
          },
        },
      })

      -- Code Display Hints
      vim.keymap.set("n", "<leader>cdh", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        vim.notify("Toggled Go inline hints")
      end, { desc = desc("Toggle Go inline hints") })
      -- LSP-friendly mappings (require LSP configured)
      -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = desc("Go to implementation") })
      -- vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = desc("Type definition") })
      -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = desc("Definition") })
      -- vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = desc("References") })
      -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = desc("Declaration") })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = desc("Hover") })
      vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = desc("Rename") })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = desc("Code Action") })
      vim.keymap.set("n", "<leader>cc", vim.lsp.codelens.run, { desc = desc("Run Codelens") })
      vim.keymap.set("n", "<leader>cC", vim.lsp.codelens.refresh, { desc = desc("Refresh & Display Codelens") })
      vim.keymap.set("n", "<leader>cR", function()
        Snacks.rename.rename_file()
      end, { desc = desc("Rename File") })

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
  },
}
