return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    setup = {
      yamlls = function(_, opts)
        opts.settings = {
          yaml = {
            keyOrdering = false,
            customTags = {
              "!Base64",
              "!Cidr",
              "!FindInMap sequence",
              "!GetAtt",
              "!GetAZs",
              "!ImportValue",
              "!Join sequence",
              "!Ref",
              "!Select sequence",
              "!Split sequence",
              "!Sub sequence",
              "!Sub",
              "!And sequence",
              "!Condition",
              "!Equals sequence",
              "!If sequence",
              "!Not sequence",
              "!Or sequence",
            },
            schemaStore = {
              enable = true,
            },
          },
        }
      end,
    },
  },
}
