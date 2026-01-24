local desc = Utils.plugin_keymap_desc("AmazonQ")
return {
  {
    name = "amazonq",
    enabled = false,
    url = "https://github.com/awslabs/amazonq.nvim.git",
    opts = {
      inline_suggest = true,
      ssoStartUrl = "https://view.awsapps.com/start", -- Authenticate with Amazon Q Free Tier

      -- Filetypes where the Q will be activated
      -- See: https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/q-language-ide-support.html
      -- `amazonq` is required for Q Chat feature.
      filetypes = {
        "markdown",
        "md",
        "yaml",
        "yml",
        "json",
        "amazonq",
        "bash",
        "java",
        "python",
        "typescript",
        "javascript",
        "csharp",
        "ruby",
        "kotlin",
        "sh",
        "sql",
        "c",
        "cpp",
        "go",
        "rust",
        "lua",
      },
    },
    keys = {
      {
        "<leader>as",
        "<CMD>AmazonQ start<CR>",
        desc = desc("Start"),
      },
      {
        "<leader>al",
        "<CMD>AmazonQ login<CR>",
        desc = desc("Login"),
      },
      {
        "<leader>aq",
        "<CMD>AmazonQ toggle<CR>",
        desc = desc("Chat"),
      },
      {
        "<leader>ae",
        "<CMD>'<,'>AmazonQ explain<CR>",
        desc = desc("Explain"),
      },
      {
        "<leader>af",
        "<CMD>'<,'>AmazonQ fix<CR>",
        desc = desc("Fix"),
      },
      {
        "<leader>ao",
        "<CMD>'<,'>AmazonQ optimize<CR>",
        desc = desc("Optimize"),
      },
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
      end)
    end,
  },
}
