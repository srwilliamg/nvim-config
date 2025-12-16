local desc = Utils.plugin_keymap_desc("Snacks")
local logo = [[
⠀⠀⠀⠀⠀⠀⠀⣠⡤⠶⡄⠀⠀⠀⠀⠀⠀⠀⢠⠶⣦⣀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢀⣴⣿⡟⠀⠈⣀⣾⣝⣯⣿⣛⣷⣦⡀⠀⠈⢿⣿⣦⡀⠀⠀⠀⠀
⠀⠀⠀⣴⣿⣿⣿⡇⠀⢼⣿⣽⣿⢻⣿⣻⣿⣟⣷⡄⠀⢸⣿⣿⣾⣄⠀⠀⠀
⠀⠀⣞⣿⣿⣿⣿⣷⣤⣸⣟⣿⣿⣻⣯⣿⣿⣿⣿⣀⣴⣿⣿⣿⣿⣯⣆⠀⠀
⠀⡼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣜⡆⠀
⢠⣟⣯⣿⣿⣿⣷⢿⣫⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣬⣟⠿⣿⣿⣿⣿⡷⣾⠀
⢸⣯⣿⣿⡏⠙⡇⣾⣟⣿⡿⢿⣿⣿⣿⣿⣿⢿⣟⡿⣿⠀⡟⠉⢹⣿⣿⢿⡄
⢸⣯⡿⢿⠀⠀⠱⢈⣿⢿⣿⡿⣏⣿⣿⣿⣿⣿⣿⣿⣿⣀⠃⠀⢸⡿⣿⣿⡇
⢸⣿⣇⠈⢃⣴⠟⠛⢉⣸⣇⣹⣿⣿⠚⡿⣿⣉⣿⠃⠈⠙⢻⡄⠎⠀⣿⡷⠃
⠈⡇⣿⠀⠀⠻⣤⠠⣿⠉⢻⡟⢷⣝⣷⠉⣿⢿⡻⣃⢀⢤⢀⡏⠀⢠⡏⡼⠀
⠀⠘⠘⡅⠀⣔⠚⢀⣉⣻⡾⢡⡾⣻⣧⡾⢃⣈⣳⢧⡘⠤⠞⠁⠀⡼⠁⠀⠀
⠀⠀⠀⠸⡀⠀⢠⡎⣝⠉⢰⠾⠿⢯⡘⢧⡧⠄⠀⡄⢻⠀⠀⠀⢰⠁⠀⠀⠀
⠀⠀⠀⠀⠁⠀⠈⢧⣈⠀⠘⢦⠀⣀⠇⣼⠃⠰⣄⣡⠞⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⢤⠼⠁⠀⠀⠳⣤⡼⠀⠀⠀⠀⠀⠀
    ]]

return {
  "folke/snacks.nvim",
  enabled = not vim.g.vscode,
  priority = 1000,
  lazy = false,
  opts = {
    zen = {
      win = {
        width = 0.8,
        backdrop = {
          transparent = false,
        },
      },
      center = true,
      toggles = {
        dim = true,
      },
    },
    bigfile = { enabled = true },
    dashboard = {
      width = 60,
      row = nil, -- dashboard position. nil for center
      col = nil, -- dashboard position. nil for center
      pane_gap = 4, -- empty columns between vertical panes
      autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
      -- These settings are used by some built-in sections
      preset = {
        pick = nil,
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        header = logo,
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    ---@class snacks.notifier.Config
    notifier =
      ---@field enabled? boolean
      ---@field keep? fun(notif: snacks.notifier.Notif): boolean # global keep function
      ---@field filter? fun(notif: snacks.notifier.Notif): boolean # filter our unwanted notifications (return false to hide)
      {

        border = true,

        zindex = 100,
        ft = "markdown",
        wo = {
          winblend = 5,
          wrap = false,
          conceallevel = 2,
          colorcolumn = "",
        },
        bo = { filetype = "snacks_notif" },
        style = "minimal",
        width = { min = 40, max = 0.6 },
        height = { min = 1, max = 0.6 },
      },
    picker = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {
      notification = {
        -- wo = { wrap = true } -- Wrap notifications
      },
    },
  },
  keys = {
    -- Top Pickers & Explorer
    {
      "<leader><space>",
      function()
        Snacks.picker.smart()
      end,
      desc = desc("Smart Find Files"),
    },
    {
      "<leader>,",
      function()
        Snacks.picker.buffers()
      end,
      desc = desc("Buffers"),
    },
    {
      "<leader>/",
      function()
        Snacks.picker.grep()
      end,
      desc = desc("Grep"),
    },
    {
      "<leader>:",
      function()
        Snacks.picker.command_history()
      end,
      desc = desc("Command History"),
    },
    {
      "<leader>n",
      function()
        Snacks.picker.notifications()
      end,
      desc = desc("Notification History"),
    },
    {
      "<leader>e",
      function()
        Snacks.explorer()
      end,
      desc = desc("File Explorer"),
    },
    -- find
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      desc = desc("Buffers"),
    },
    {
      "<leader>fc",
      function()
        Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = desc("Find Config File"),
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = desc("Find Files"),
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.git_files()
      end,
      desc = desc("Find Git Files"),
    },
    {
      "<leader>fp",
      function()
        Snacks.picker.projects()
      end,
      desc = desc("Projects"),
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.recent()
      end,
      desc = desc("Recent"),
    },
    -- git
    {
      "<leader>gb",
      function()
        Snacks.picker.git_branches()
      end,
      desc = desc("Git Branches"),
    },
    {
      "<leader>gl",
      function()
        Snacks.picker.git_log()
      end,
      desc = desc("Git Log"),
    },
    {
      "<leader>gL",
      function()
        Snacks.picker.git_log_line()
      end,
      desc = desc("Git Log Line"),
    },
    {
      "<leader>gs",
      function()
        Snacks.picker.git_status()
      end,
      desc = desc("Git Status"),
    },
    {
      "<leader>gS",
      function()
        Snacks.picker.git_stash()
      end,
      desc = desc("Git Stash"),
    },
    {
      "<leader>gd",
      function()
        Snacks.picker.git_diff()
      end,
      desc = desc("Git Diff (Hunks)"),
    },
    {
      "<leader>gf",
      function()
        Snacks.picker.git_log_file()
      end,
      desc = desc("Git Log File"),
    },
    -- Grep
    {
      "<leader>sb",
      function()
        Snacks.picker.lines()
      end,
      desc = desc("Buffer Lines"),
    },
    {
      "<leader>sB",
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = desc("Grep Open Buffers"),
    },
    {
      "<leader>sg",
      function()
        Snacks.picker.grep()
      end,
      desc = desc("Grep"),
    },
    {
      "<leader>sw",
      function()
        Snacks.picker.grep_word()
      end,
      desc = desc("Visual selection or word"),
      mode = { "n", "x" },
    },
    -- search
    {
      '<leader>s"',
      function()
        Snacks.picker.registers()
      end,
      desc = desc("Registers"),
    },
    {
      "<leader>s/",
      function()
        Snacks.picker.search_history()
      end,
      desc = desc("Search History"),
    },
    {
      "<leader>sa",
      function()
        Snacks.picker.autocmds()
      end,
      desc = desc("Autocmds"),
    },
    {
      "<leader>sb",
      function()
        Snacks.picker.lines()
      end,
      desc = desc("Buffer Lines"),
    },
    {
      "<leader>sc",
      function()
        Snacks.picker.command_history()
      end,
      desc = desc("Command History"),
    },
    {
      "<leader>sC",
      function()
        Snacks.picker.commands()
      end,
      desc = desc("Commands"),
    },
    {
      "<leader>sd",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = desc("Diagnostics"),
    },
    {
      "<leader>sD",
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = desc("Buffer Diagnostics"),
    },
    {
      "<leader>sh",
      function()
        Snacks.picker.help()
      end,
      desc = desc("Help Pages"),
    },
    {
      "<leader>sH",
      function()
        Snacks.picker.highlights()
      end,
      desc = desc("Highlights"),
    },
    {
      "<leader>si",
      function()
        Snacks.picker.icons()
      end,
      desc = desc("Icons"),
    },
    {
      "<leader>sj",
      function()
        Snacks.picker.jumps()
      end,
      desc = desc("Jumps"),
    },
    {
      "<leader>sk",
      function()
        Snacks.picker.keymaps()
      end,
      desc = desc("Keymaps"),
    },
    {
      "<leader>sl",
      function()
        Snacks.picker.loclist()
      end,
      desc = desc("Location List"),
    },
    {
      "<leader>sm",
      function()
        Snacks.picker.marks()
      end,
      desc = desc("Marks"),
    },
    {
      "<leader>sM",
      function()
        Snacks.picker.man()
      end,
      desc = desc("Man Pages"),
    },
    {
      "<leader>sp",
      function()
        Snacks.picker.lazy()
      end,
      desc = desc("Search for Plugin Spec"),
    },
    {
      "<leader>sq",
      function()
        Snacks.picker.qflist()
      end,
      desc = desc("Quickfix List"),
    },
    {
      "<leader>sR",
      function()
        Snacks.picker.resume()
      end,
      desc = desc("Resume"),
    },
    {
      "<leader>su",
      function()
        Snacks.picker.undo()
      end,
      desc = desc("Undo History"),
    },
    {
      "<leader>uC",
      function()
        Snacks.picker.colorschemes()
      end,
      desc = desc("Colorschemes"),
    },
    -- LSP
    {
      "gd",
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = desc("Goto Definition"),
    },
    {
      "gD",
      function()
        Snacks.picker.lsp_declarations()
      end,
      desc = desc("Goto Declaration"),
    },
    {
      "gr",
      function()
        Snacks.picker.lsp_references()
      end,
      nowait = true,
      desc = desc("References"),
    },
    {
      "gI",
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = desc("Goto Implementation"),
    },
    {
      "gy",
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = desc("Goto T[y]pe Definition"),
    },
    {
      "<leader>ss",
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = desc("LSP Symbols"),
    },
    {
      "<leader>sS",
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = desc("LSP Workspace Symbols"),
    },
    -- Other
    {
      "<leader>z",
      function()
        Snacks.zen()
      end,
      desc = desc("Toggle Zen Mode"),
    },
    {
      "<leader>Z",
      function()
        Snacks.zen.zoom()
      end,
      desc = desc("Toggle Zoom"),
    },
    {
      "<leader>.",
      function()
        Snacks.scratch()
      end,
      desc = desc("Toggle Scratch Buffer"),
    },
    {
      "<leader>S",
      function()
        Snacks.scratch.select()
      end,
      desc = desc("Select Scratch Buffer"),
    },
    {
      "<leader>n",
      function()
        Snacks.notifier.show_history()
      end,
      desc = desc("Notification History"),
    },
    {
      "<leader>bd",
      function()
        Snacks.bufdelete()
      end,
      desc = desc("Delete Buffer"),
    },
    {
      "<leader>cR",
      function()
        Snacks.rename.rename_file()
      end,
      desc = desc("Rename File"),
    },
    {
      "<leader>gB",
      function()
        Snacks.gitbrowse()
      end,
      desc = desc("Git Browse"),
      mode = { "n", "v" },
    },
    {
      "<leader>gg",
      function()
        Snacks.lazygit()
      end,
      desc = desc("Lazygit"),
    },
    {
      "<leader>un",
      function()
        Snacks.notifier.hide()
      end,
      desc = desc("Dismiss All Notifications"),
    },
    {
      "<c-/>",
      function()
        Snacks.terminal()
      end,
      desc = desc("Toggle Terminal"),
    },
    {
      "<c-_>",
      function()
        Snacks.terminal()
      end,
      desc = desc("which_key_ignore"),
    },
    {
      "]]",
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = desc("Next Reference"),
      mode = { "n", "t" },
    },
    {
      "[[",
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = desc("Prev Reference"),
      mode = { "n", "t" },
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end

        -- Override print to use snacks for `:=` command
        if vim.fn.has("nvim-0.11") == 1 then
          vim._print = function(_, ...)
            dd(...)
          end
        else
          vim.print = _G.dd
        end

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle
          .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
          :map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")
      end,
    })
  end,
}
