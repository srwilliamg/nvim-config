local luaLspConfig = {
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
local harperLspConfig = {
  settings = {
    ["harper-ls"] = {
      userDictPath = "~/.config/nvim/lua/resources/spell/dict.txt",
      workspaceDictPath = "~/.config/workspace-spelling.txt",
      linters = {
        SentenceCapitalization = false,
        SpellCheck = true,
        LongSentences = false,
      },
      diagnosticSeverity = "hint", --information
    },
  },
}
local goplsLspConfig = {
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
}

return {
  lua = luaLspConfig,
  harper = harperLspConfig,
  go = goplsLspConfig,
}
