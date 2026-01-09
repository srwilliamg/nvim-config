return {
  "shortcuts/no-neck-pain.nvim",
  version = "*",
  opts = {
    width = 200,
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
      enableOnTabEnter = true,
      -- When `true`, reloads the plugin configuration after a colorscheme change.
      ---@type boolean
      reloadOnColorSchemeChange = true,
    },
    buffers = {
      right = {
        enabled = false,
      },
    },
    integrations = {
      NeoTree = {
        -- The position of the tree.
        ---@type "left"|"right"
        position = "left",
        -- When `true`, if the tree was opened before enabling the plugin, we will reopen it.
        reopen = true,
      },
    },
  },
}
