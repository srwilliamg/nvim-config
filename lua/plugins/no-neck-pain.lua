return {
  enabled = not vim.g.vscode,
  "shortcuts/no-neck-pain.nvim",
  version = "*",
  opts = {
    width = 160,
    minSideBufferWidth = 0,
    autocmds = {
      -- When `true`, enables the plugin when you start Neovim.
      -- If the main window is  a side tree (e.g. NvimTree) or a dashboard, the command is delayed until it finds a valid window.
      -- The command is cleaned once it has successfuly ran once.
      -- When `safe`, debounces the plugin before enabling it.
      -- This is recommended if you:
      --  - use a dashboard plugin, or something that also triggers when Neovim is entered.
      --  - usually leverage commands such as `nvim +line file` which are executed after Neovim has been entered.
      ---@type boolean | "safe"
      enableOnVimEnter = true,
      -- When `true`, enables the plugin when you enter a new Tab.
      -- note: it does not trigger if you come back to an existing tab, to prevent unwanted interfer with user's decisions.
      ---@type boolean
      enableOnTabEnter = false,
      -- When `true`, reloads the plugin configuration after a colorscheme change.
      ---@type boolean
      reloadOnColorSchemeChange = false,
      -- When `true`, entering one of no-neck-pain side buffer will automatically skip it and go to the next available buffer.
      ---@type boolean
      skipEnteringNoNeckPainBuffer = true,
    },
    buffers = {
      -- colors = {
      --   blend = -0.9,
      -- },
      left = {
        enabled = true,
      },
      right = {
        enabled = true,
        scratchPad = {
          -- set to `false` to
          -- disable auto-saving
          enabled = true,
          pathToFile = "~/code/scratch-pad.md",
        },
      },

      bo = {
        filetype = "md",
      },
    },
    integrations = {
      neotest = {
        -- The position of the tree.
        ---@type "right"
        position = "right",
        -- When `true`, if the tree was opened before enabling the plugin, we will reopen it.
        reopen = true,
      },
      NeoTree = {
        -- The position of the tree.
        ---@type "left"|"right"
        position = "left",
        -- When `true`, if the tree was opened before enabling the plugin, we will reopen it.
        reopen = false,
      },
      dashboard = {
        -- When `true`, debounce will be applied to the init method, leaving time for the dashboard to open.
        enabled = true,
        -- if a dashboard that you use isn't supported, you can use this field to set a matching filetype, also don't hesitate to open a pull-request with the edited list (DASHBOARDS) found in lua/no-neck-pain/util/constants.lua.
        ---@type string[]|nil
        filetypes = nil,
      },
    },
  },
  config = function(_, opts)
    local nnp = require("no-neck-pain")
    nnp.setup(opts)
  end,
}
