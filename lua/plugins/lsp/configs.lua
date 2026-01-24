local luaLspConfig = {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
        path ~= vim.fn.stdpath("config")
        and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
      then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using (most
        -- likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Tell the language server how to find Lua modules same way as Neovim
        -- (see `:h lua-module-load`)
        path = {
          "lua/?.lua",
          "lua/?/init.lua",
        },
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          -- Depending on the usage, you might want to add additional paths
          -- here.
          -- '${3rd}/luv/library'
          -- '${3rd}/busted/library'
        },
        -- Or pull in all of 'runtimepath'.
        -- NOTE: this is a lot slower and will cause issues when working on
        -- your own configuration.
        -- See https://github.com/neovim/nvim-lspconfig/issues/3189
        -- library = {
        --   vim.api.nvim_get_runtime_file('', true),
        -- }
      },
    })
  end,
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
      codeLens = {
        enable = true,
      },
      hint = {
        enable = true,
        semicolon = "Disable",
      },
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
        SpellCheck = false,
        LongSentences = false,
        Matcher = false,
        CorrectNumberSuffix = false,
        Spaces = false,
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
