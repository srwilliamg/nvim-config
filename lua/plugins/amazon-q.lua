local desc = Utils.plugin_keymap_desc("AmazonQ")
return {
  {
    enabled = false,
    name = "amazonq",
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
  },
}
