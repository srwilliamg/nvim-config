vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = "*",
  group = group,
  once = true,
  callback = function()
    vim.pack.add({ {
      src = "https://github.com/saghen/blink.cmp",
      version = vim.version.range("^1.0"),
    }, "https://github.com/rafamadriz/friendly-snippets", {
      src = "https://github.com/L3MON4D3/LuaSnip",
      version = vim.version.range("^2.0"),
    } })
    require("blink.cmp").setup({
      snippets = {
        preset = "luasnip",
      },
      keymap = {
        preset = "none",
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<CR>"] = { "select_and_accept" },
        ["<C-space>"] = {
          function(cmp)
            cmp.show({
              providers = { "snippets" },
            })
          end,
        },
      },
      completion = {
        trigger = {
          show_on_insert = true,
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
          window = {
            border = "rounded",
          },
        },
        ghost_text = {
          enabled = true,
          show_with_menu = false,
        },
        menu = {
          auto_show = true,
          draw = {
            treesitter = { "lsp" },
            columns = { { "kind_icon" }, { "label" }, { "source_name" } },
          },
        },
      },
      sources = {
        default = { "lsp", "snippets", "path", "buffer", "cmdline" },
        providers = {
          -- lsp = {
          --   name = "LSP",
          --   module = "blink.cmp.sources.lsp",
          --   enabled = true,
          --   async = true,
          --   timeout_ms = 100, -- Allow Amazon Q suggestions more time to arrive.
          -- },
          buffer = {
            max_items = 5,
          },
          snippets = {
            opts = {
              extended_filetypes = {
                markdown = { "jekyll" },
                sh = { "shelldoc" },
                php = { "phpdoc" },
                cpp = { "unreal" },
                go = { "go" },
              },
            },
          },
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
        },
      },
    })
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
})
