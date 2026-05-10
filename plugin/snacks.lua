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

vim.pack.add({
  "https://github.com/folke/snacks.nvim",
  "https://github.com/folke/which-key.nvim",
}, { load = true })

require("snacks").setup({
  terminal = {
    win = {
      wo = {
        winbar = "",
      },
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
        { icon = " ", key = "p", desc = "Projects", action = ":lua Snacks.picker.projects()" },
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
      -- { section = "startup" },
    },
  },
  ---@class snacks.notifier.Config
  notifier = {
    timeout = 1000,
    style = "minimal",
    width = { min = 40, max = 0.6 },
    height = { min = 1, max = 0.6 },
  },
  -- stylua: ignore start
  explorer     = { enabled = false },
  gh           = { enabled = false },
  gitbrowse    = { enabled = false },
  image        = { enabled = false },
  scroll       = { enabled = false },
  statuscolumn = { enabled = false },
  zen          = { enabled = false },
  -- stylua: ignore end
  indent = { enabled = true },
  input = { enabled = true },
  picker = { hidden = true, ignored = true, enabled = true, sources = { explorer = { hidden = true, ignored = false }, grep = { hidden = true, ignored = false } } },
  quickfile = { enabled = true },
  scratch = { ft = "markdown", win = { width = 0.9, height = 0.9, backdrop = 60 } },
  scope = { enabled = true },
  words = { enabled = true },
  styles = {
    scratch = {
      width = 150,
      height = 50,
      bo = { buftype = "", buflisted = false, bufhidden = "hide", swapfile = false },
      minimal = false,
      noautocmd = false,
      -- position = "right",
      zindex = 20,
      wo = { winhighlight = "NormalFloat:Normal" },
      footer_keys = true,
      border = true,
    },
  },
})

require("lazyload").on_vim_enter(function()
  local map = vim.keymap.set

  local function pick(method, opts)
    return function()
      Snacks.picker[method](opts)
    end
  end

  -- LSP
  map("n", "gd", pick("lsp_definitions"), { desc = desc("Goto Definition") })
  map("n", "gD", pick("lsp_declarations"), { desc = desc("Goto Declaration") })
  map("n", "gr", pick("lsp_references"), { desc = desc("References"), nowait = true })
  map("n", "gI", pick("lsp_implementations"), { desc = desc("Goto Implementation") })
  map("n", "gy", pick("lsp_type_definitions"), { desc = desc("Goto T[y]pe Definition") })
  map("n", "gO", pick("lsp_symbols"), { desc = desc("LSP Symbols") })
  map("n", "gai", pick("lsp_incoming_calls"), { desc = "C[a]lls Incoming" })
  map("n", "gao", pick("lsp_outgoing_calls"), { desc = "C[a]lls Outgoing" })
  map("n", "<leader>ss", pick("lsp_symbols"), { desc = desc("LSP Symbols") })
  map("n", "<leader>sS", pick("lsp_workspace_symbols"), { desc = desc("LSP Workspace Symbols") })

  -- Top Pickers & Explorer
  map("n", "<leader><space>", pick("smart"), { desc = desc("Smart Find Files") })
  map("n", "<leader>,", pick("buffers"), { desc = desc("Buffers") })
  map("n", "<leader>bl", pick("buffers"), { desc = desc("Buffers") })
  map("n", "<leader>/", pick("grep"), { desc = desc("Grep") })
  map("n", "<leader>:", pick("command_history"), { desc = desc("Command History") })
  map("n", "<leader>n", pick("notifications"), { desc = desc("Notification History") })

  -- find
  map("n", "<leader>fb", pick("buffers"), { desc = desc("Buffers") })
  map("n", "<leader>fc", pick("files", { cwd = vim.fn.stdpath("config") }), { desc = desc("Find Config File") })
  map("n", "<leader>ff", pick("files"), { desc = desc("Find Files") })
  map("n", "<leader>fg", pick("git_files"), { desc = desc("Find Git Files") })
  map("n", "<leader>fp", pick("projects"), { desc = desc("Projects") })
  map("n", "<leader>fr", pick("recent"), { desc = desc("Recent") })

  -- git
  map("n", "<leader>gb", pick("git_branches"), { desc = desc("Git Branches") })
  map("n", "<leader>gl", pick("git_log"), { desc = desc("Git Log") })
  map("n", "<leader>gL", pick("git_log_line"), { desc = desc("Git Log Line") })
  map("n", "<leader>gs", pick("git_status"), { desc = desc("Git Status") })
  map("n", "<leader>gS", pick("git_stash"), { desc = desc("Git Stash") })
  map("n", "<leader>gd", pick("git_diff"), { desc = desc("Git Diff (Hunks)") })
  map("n", "<leader>gf", pick("git_log_file"), { desc = desc("Git Log File") })

  -- Grep
  map("n", "<leader>sB", pick("grep_buffers"), { desc = desc("Grep Open Buffers") })
  map("n", "<leader>sg", pick("grep"), { desc = desc("Grep") })
  map({ "n", "x" }, "<leader>sw", pick("grep_word"), { desc = desc("Visual selection or word") })

  -- search
  map("n", "<leader>sr", pick("registers"), { desc = desc("Registers") })
  map("n", "<leader>s/", pick("search_history"), { desc = desc("Search History") })
  map("n", "<leader>sa", pick("autocmds"), { desc = desc("Autocmds") })
  map("n", "<leader>sb", pick("lines"), { desc = desc("Buffer Lines") })
  map("n", "<leader>sc", pick("command_history"), { desc = desc("Command History") })
  map("n", "<leader>sC", pick("commands"), { desc = desc("Commands") })
  map("n", "<leader>sd", pick("diagnostics"), { desc = desc("Diagnostics") })
  map("n", "<leader>sD", pick("diagnostics_buffer"), { desc = desc("Buffer Diagnostics") })
  map("n", "<leader>sh", pick("help"), { desc = desc("Help Pages") })
  map("n", "<leader>sH", pick("highlights"), { desc = desc("Highlights") })
  map("n", "<leader>si", pick("icons"), { desc = desc("Icons") })
  map("n", "<leader>sj", pick("jumps"), { desc = desc("Jumps") })
  map("n", "<leader>sk", pick("keymaps"), { desc = desc("Keymaps") })
  map("n", "<leader>sl", pick("loclist"), { desc = desc("Location List") })
  map("n", "<leader>sm", pick("marks"), { desc = desc("Marks") })
  map("n", "<leader>sM", pick("man"), { desc = desc("Man Pages") })
  map("n", "<leader>sp", pick("lazy"), { desc = desc("Search for Plugin Spec") })
  map("n", "<leader>sq", pick("qflist"), { desc = desc("Quickfix List") })
  map("n", "<leader>sR", pick("resume"), { desc = desc("Resume") })
  map("n", "<leader>su", pick("undo"), { desc = desc("Undo History") })
  map("n", "<leader>uC", pick("colorschemes"), { desc = desc("Colorschemes") })

  -- Other
  map("n", "<leader>z", function()
    Snacks.zen()
  end, { desc = desc("Toggle Zen Mode") })
  map("n", "<leader>Z", function()
    Snacks.zen.zoom()
  end, { desc = desc("Toggle Zoom") })
  map("n", "<leader>.", function()
    Snacks.scratch()
  end, { desc = desc("Toggle Scratch Buffer") })
  map("n", "<leader>S", function()
    Snacks.scratch.select()
  end, { desc = desc("Select Scratch Buffer") })
  map("n", "<leader>bd", function()
    Snacks.bufdelete()
  end, { desc = desc("Delete Buffer") })
  map("n", "<leader>cR", function()
    Snacks.rename.rename_file()
  end, { desc = desc("Rename File") })
  map({ "n", "v" }, "<leader>gB", function()
    Snacks.gitbrowse()
  end, { desc = desc("Git Browse") })
  map("n", "<leader>gg", function()
    Snacks.lazygit()
  end, { desc = desc("Lazygit") })
  map("n", "<leader>un", function()
    Snacks.notifier.hide()
  end, { desc = desc("Dismiss All Notifications") })
  map({ "n", "t" }, "<c-/>", function()
    Snacks.terminal()
  end, { desc = desc("Toggle Terminal") })
  map("n", "<c-_>", function()
    Snacks.terminal()
  end, { desc = desc("which_key_ignore") })
  map({ "n", "t" }, "<c-t>", function()
    Snacks.terminal.toggle()
  end, { desc = "Toggle Terminal" })
  map({ "n", "t" }, "]]", function()
    Snacks.words.jump(vim.v.count1)
  end, { desc = desc("Next Reference") })
  map({ "n", "t" }, "[[", function()
    Snacks.words.jump(-vim.v.count1)
  end, { desc = desc("Prev Reference") })

  -- Setup some globals for debugging (lazy-loaded)
  _G.dd = function(...)
    Snacks.debug.inspect(...)
  end
  _G.bt = function()
    Snacks.debug.backtrace()
  end

  vim.g.snacks_animate = false
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
  Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
  Snacks.toggle.treesitter():map("<leader>uT")
  Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
  Snacks.toggle.inlay_hints():map("<leader>uh")
  Snacks.toggle.indent():map("<leader>ug")
  Snacks.toggle.dim():map("<leader>uD")
end)
