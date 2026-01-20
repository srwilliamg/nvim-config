return {
  "saghen/blink.cmp",
  version = "1.*",
  enabled = not vim.g.vscode,
  build = "cargo build --release",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "nvim-tree/nvim-web-devicons",
    "echasnovski/mini.snippets",
    -- "giuxtaposition/blink-cmp-copilot",
  },
  opts = {
    -- snippets = { preset = "luasnip" },
    snippets = { preset = "mini_snippets" },
    keymap = {
      preset = "none",
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<CR>"] = { "select_and_accept" },
      -- ["<C-space>"] = {
      --   function(cmp)
      --     cmp.show({ providers = { "snippets" } })
      --   end,
      -- },
    },
    completion = {
      trigger = {
        show_on_insert = true,
      },
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
          treesitter = { "lsp" },
          columns = {
            { "kind_icon" },
            { "label" },
            { "source_name" },
          },
        },
      },
    },
    sources = {
      default = { "lazydev", "lsp", "snippets", "path", "buffer", "cmdline" },
      providers = {
        lsp = {
          name = "LSP",
          module = "blink.cmp.sources.lsp",
          enabled = true,
          async = true,
          timeout_ms = 100, -- Allow Amazon Q suggestions more time to arrive.
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        buffer = { max_items = 5 },
        snippets = {
          opts = {
            friendly_snippets = true, -- default
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
  },
}
