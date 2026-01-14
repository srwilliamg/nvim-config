return {
  "saghen/blink.cmp",
  enabled = not vim.g.vscode,
  build = "cargo build --release",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "nvim-tree/nvim-web-devicons", -- Optional for file icons
    "onsails/lspkind.nvim", --optional icons
    { "L3MON4D3/LuaSnip", version = "v2.*" },
    -- "giuxtaposition/blink-cmp-copilot",
  },
  opts = {
    keymap = {
      preset = "none",
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<CR>"] = { "select_and_accept" },
      ["<C-space>"] = {
        function(cmp)
          cmp.show({ providers = { "snippets" } })
        end,
      },
    },
    snippets = { preset = "luasnip" },
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
        -- lsp = {
        --   name = "LSP",
        --   module = "blink.cmp.sources.lsp",
        --   enabled = true,
        --   async = true,
        --   timeout_ms = 200, -- Allow Amazon Q suggestions more time to arrive.
        -- },
        lsp = {
          name = "LSP",
          module = "blink.cmp.sources.lsp",
          -- Filter out 'text' items from the LSP provider (use 'buffer' provider for that).
          transform_items = function(_, items)
            for _, item in ipairs(items) do
              if
                item.labelDetails
                and item.labelDetails.description
                and item.labelDetails.description == "Amazon Q"
              then
                item.score_offset = 1000
              end
              if item.kind == require("blink.cmp.types").CompletionItemKind.Snippet then
                item.score_offset = item.score_offset - 3
              end
            end
            return vim.tbl_filter(function(item)
              return item.kind ~= require("blink.cmp.types").CompletionItemKind.Text
            end, items)
          end,
          async = true, -- Show partial results while waiting for all providers.
          timeout_ms = 200, -- Maximum time to wait before showing partial results.
          min_keyword_length = 0, -- Minimum characters that trigger the provider.
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        buffer = { max_items = 5 },
      },

      default = { "lsp", "path", "snippets", "buffer", "cmdline", "lazydev" },
    },
    init = function()
      vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
        group = vim.api.nvim_create_augroup("my.amazonq", { clear = true }),
        callback = function(ev)
          if vim.b.amazonq then
            vim.cmd.startinsert()
          end
        end,
      })
      -- CTRL-q (insert-mode) manually triggers Amazon Q completion (inline suggestions).
      vim.keymap.set("i", "<C-q>", function()
        local client = vim.lsp.get_clients({ bufnr = 0, name = "amazonq-completion" })[1]
        if not client then
          vim.notify("Amazon Q not enabled for this buffer")
          return
        end
        vim.lsp.completion.enable(true, client.id, 0)
        vim.notify("Amazon Q: working...")
        vim.lsp.completion.get()
        -- vim.cmd[[redraw | echo '']]
      end)
    end,
    -- config = function(_, opts)
    --   local lspconfig = require("lspconfig")
    --   for server, config in pairs(opts.servers) do
    --     -- passing config.capabilities to blink.cmp merges with the capabilities in your
    --     -- `opts[server].capabilities, if you've defined it
    --     config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
    --     lspconfig[server].setup(config)
    --   end
    --   require("blink").setup(opts)
    -- end,
  },
}
