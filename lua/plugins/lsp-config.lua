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
    dependencies = {
      "rafamadriz/friendly-snippets",
      "nvim-tree/nvim-web-devicons", -- Optional for file icons
      "onsails/lspkind.nvim", --optional icons
      -- "giuxtaposition/blink-cmp-copilot",
      "L3MON4D3/LuaSnip",
    },
    opts = {
      completion = {
        documentation = {
          auto_show = true,
        },
        ghost_text = {
          enabled = true,
          show_with_menu = false,
        },
        menu = {
          auto_show = true,
          draw = {
            -- use tree sitter to label
            treesitter = { "lsp" },
            columns = {
              { "kind_icon" },
              { "label" },
              { "source_name" },
            },
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  local icon = ctx.kind_icon
                  if vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                    if dev_icon then
                      icon = dev_icon
                    end
                  else
                    icon = require("lspkind").symbolic(ctx.kind, {
                      mode = "symbol",
                    })
                  end

                  return icon .. ctx.icon_gap
                end,
              },
            },
          },
        },
      },
      keymap = {
        preset = "none",
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<CR>"] = { "select_and_accept" },
      },
      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      --- @type blink.cmp.SourceConfigPartial
      sources = {
        providers = {
          -- copilot = {
          --   enabled = false,
          --   name = "copilot",
          --   module = "blink-cmp-copilot",
          --   score_offset = 100,
          --   async = true,
          --   transform_items = function(_, items)
          --     for _, item in ipairs(items) do
          --       item.kind_icon = ""
          --       item.kind_name = "Copilot"
          --     end
          --     return items
          --   end,
          -- },
          markdown = {
            name = "markdown",
            module = "render-markdown.integ.blink",
            enabled = true,
            fallbacks = { "lsp" },
          },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
          buffer = { max_items = 5 },
        },

        default = { "lsp", "path", "snippets", "buffer", "cmdline", "lazydev" },
      },
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
      local lspconfig = vim.lsp.config
      local lspEnable = vim.lsp.enable

      -- go install github.com/nametake/golangci-lint-langserver@latest
      -- go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
      lspEnable("golangci_lint_ls")
      lspEnable("gopls")
      lspconfig("gopls", {
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
          },
        },
      })
      lspEnable("ts_ls")
      lspEnable("docker_language_server") -- go install github.com/docker/docker-language-server/cmd/docker-language-server@latest
      lspEnable("jsonls") -- npm i -g vscode-langservers-extracted
      lspEnable("lua_ls")
      lspconfig("lua_ls", {
        settings = {
          Lua = {
            -- Disable formatting provided by Lua LS
            format = {
              enable = false,
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim", "require" },
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
  },
}
