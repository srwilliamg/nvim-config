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
  explorer = { enabled = false },
  indent = { enabled = true },
  input = { enabled = true },
  picker = { enabled = true, sources = { explorer = { hidden = true }, grep = { hidden = true } } },
  scratch = { ft = "markdown", win = { width = 0.9, height = 0.9, backdrop = 60 } },
  gh = { enabled = false },
  gitbrowse = { enabled = false },
  image = { enabled = false },
  statuscolumn = { enabled = false },
  scroll = { enabled = false },
  quickfile = { enabled = true },
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
    -- notification = {
    --   border = false,
    --   zindex = 100,
    --   ft = "markdown",
    --   wo = {
    --     winblend = 5,
    --     wrap = false,
    --     conceallevel = 2,
    --     colorcolumn = "",
    --   },
    --   bo = { filetype = "snacks_notif" },
    -- },
  },
})

-- vim.api.nvim_create_autocmd("User", {
--   pattern = "VeryLazy",
--   callback = function()
local map = vim.keymap.set
local function S()
  return rawget(_G, "Snacks") or require("snacks")
end
local ddesc = desc
-- helper to set mapping with defaults
local function nmap(mode, lhs, fn, opts)
  opts = opts or {}
  opts.noremap = true
  opts.silent = opts.silent == nil and true or opts.silent
  if opts.desc == nil and ddesc and type(ddesc) == "function" then
    opts.desc = opts.desc
  end
  map(mode, lhs, fn, opts)
end

-- LSP
nmap("n", "gd", function()
  local Snacks = S()
  Snacks.picker.lsp_definitions()
end, { desc = ddesc("Goto Definition") })
nmap("n", "gD", function()
  local Snacks = S()
  Snacks.picker.lsp_declarations()
end, { desc = ddesc("Goto Declaration") })
nmap("n", "gr", function()
  local Snacks = S()
  Snacks.picker.lsp_references()
end, { desc = ddesc("References"), nowait = true })
nmap("n", "gI", function()
  local Snacks = S()
  Snacks.picker.lsp_implementations()
end, { desc = ddesc("Goto Implementation") })
nmap("n", "gy", function()
  local Snacks = S()
  Snacks.picker.lsp_type_definitions()
end, { desc = ddesc("Goto T[y]pe Definition") })
nmap("n", "gO", function()
  local Snacks = S()
  Snacks.picker.lsp_symbols()
end, { desc = ddesc("LSP Symbols") })
nmap("n", "gai", function()
  local Snacks = S()
  Snacks.picker.lsp_incoming_calls()
end, { desc = "C[a]lls Incoming" })
nmap("n", "gao", function()
  local Snacks = S()
  Snacks.picker.lsp_outgoing_calls()
end, { desc = "C[a]lls Outgoing" })
nmap("n", "<leader>ss", function()
  local Snacks = S()
  Snacks.picker.lsp_symbols()
end, { desc = ddesc("LSP Symbols") })
nmap("n", "<leader>sS", function()
  local Snacks = S()
  Snacks.picker.lsp_workspace_symbols()
end, { desc = ddesc("LSP Workspace Symbols") })

-- Top Pickers & Explorer
nmap("n", "<leader><space>", function()
  local Snacks = S()
  Snacks.picker.smart()
end, { desc = ddesc("Smart Find Files") })
nmap("n", "<leader>,", function()
  local Snacks = S()
  Snacks.picker.buffers()
end, { desc = ddesc("Buffers") })
nmap("n", "<leader>bl", function()
  local Snacks = S()
  Snacks.picker.buffers()
end, { desc = ddesc("Buffers") })
nmap("n", "<leader>/", function()
  local Snacks = S()
  Snacks.picker.grep()
end, { desc = ddesc("Grep") })
nmap("n", "<leader>:", function()
  local Snacks = S()
  Snacks.picker.command_history()
end, { desc = ddesc("Command History") })
nmap("n", "<leader>n", function()
  local Snacks = S()
  Snacks.picker.notifications()
end, { desc = ddesc("Notification History") })

-- find
nmap("n", "<leader>fb", function()
  local Snacks = S()
  Snacks.picker.buffers()
end, { desc = ddesc("Buffers") })
nmap("n", "<leader>fc", function()
  local Snacks = S()
  Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
end, { desc = ddesc("Find Config File") })
nmap("n", "<leader>ff", function()
  local Snacks = S()
  Snacks.picker.files()
end, { desc = ddesc("Find Files") })
nmap("n", "<leader>fg", function()
  local Snacks = S()
  Snacks.picker.git_files()
end, { desc = ddesc("Find Git Files") })
nmap("n", "<leader>fp", function()
  local Snacks = S()
  Snacks.picker.projects()
end, { desc = ddesc("Projects") })
nmap("n", "<leader>fr", function()
  local Snacks = S()
  Snacks.picker.recent()
end, { desc = ddesc("Recent") })

-- git
nmap("n", "<leader>gb", function()
  local Snacks = S()
  Snacks.picker.git_branches()
end, { desc = ddesc("Git Branches") })
nmap("n", "<leader>gl", function()
  local Snacks = S()
  Snacks.picker.git_log()
end, { desc = ddesc("Git Log") })
nmap("n", "<leader>gL", function()
  local Snacks = S()
  Snacks.picker.git_log_line()
end, { desc = ddesc("Git Log Line") })
nmap("n", "<leader>gs", function()
  local Snacks = S()
  Snacks.picker.git_status()
end, { desc = ddesc("Git Status") })
nmap("n", "<leader>gS", function()
  local Snacks = S()
  Snacks.picker.git_stash()
end, { desc = ddesc("Git Stash") })
nmap("n", "<leader>gd", function()
  local Snacks = S()
  Snacks.picker.git_diff()
end, { desc = ddesc("Git Diff (Hunks)") })
nmap("n", "<leader>gf", function()
  local Snacks = S()
  Snacks.picker.git_log_file()
end, { desc = ddesc("Git Log File") })

-- Grep
nmap("n", "<leader>sb", function()
  local Snacks = S()
  Snacks.picker.lines()
end, { desc = ddesc("Buffer Lines") })
nmap("n", "<leader>sB", function()
  local Snacks = S()
  Snacks.picker.grep_buffers()
end, { desc = ddesc("Grep Open Buffers") })
nmap("n", "<leader>sg", function()
  local Snacks = S()
  Snacks.picker.grep()
end, { desc = ddesc("Grep") })
nmap({ "n", "x" }, "<leader>sw", function()
  local Snacks = S()
  Snacks.picker.grep_word()
end, { desc = ddesc("Visual selection or word") })

-- search
nmap("n", "<leader>s", function()
  local Snacks = S()
  Snacks.picker.registers()
end, { desc = ddesc("Registers") })
nmap("n", "<leader>s/", function()
  local Snacks = S()
  Snacks.picker.search_history()
end, { desc = ddesc("Search History") })
nmap("n", "<leader>sa", function()
  local Snacks = S()
  Snacks.picker.autocmds()
end, { desc = ddesc("Autocmds") })
nmap("n", "<leader>sb", function()
  local Snacks = S()
  Snacks.picker.lines()
end, { desc = ddesc("Buffer Lines") })
nmap("n", "<leader>sc", function()
  local Snacks = S()
  Snacks.picker.command_history()
end, { desc = ddesc("Command History") })
nmap("n", "<leader>sC", function()
  local Snacks = S()
  Snacks.picker.commands()
end, { desc = ddesc("Commands") })
nmap("n", "<leader>sd", function()
  local Snacks = S()
  Snacks.picker.diagnostics()
end, { desc = ddesc("Diagnostics") })
nmap("n", "<leader>sD", function()
  local Snacks = S()
  Snacks.picker.diagnostics_buffer()
end, { desc = ddesc("Buffer Diagnostics") })
nmap("n", "<leader>sh", function()
  local Snacks = S()
  Snacks.picker.help()
end, { desc = ddesc("Help Pages") })
nmap("n", "<leader>sH", function()
  local Snacks = S()
  Snacks.picker.highlights()
end, { desc = ddesc("Highlights") })
nmap("n", "<leader>si", function()
  local Snacks = S()
  Snacks.picker.icons()
end, { desc = ddesc("Icons") })
nmap("n", "<leader>sj", function()
  local Snacks = S()
  Snacks.picker.jumps()
end, { desc = ddesc("Jumps") })
nmap("n", "<leader>sk", function()
  local Snacks = S()
  Snacks.picker.keymaps()
end, { desc = ddesc("Keymaps") })
nmap("n", "<leader>sl", function()
  local Snacks = S()
  Snacks.picker.loclist()
end, { desc = ddesc("Location List") })
nmap("n", "<leader>sm", function()
  local Snacks = S()
  Snacks.picker.marks()
end, { desc = ddesc("Marks") })
nmap("n", "<leader>sM", function()
  local Snacks = S()
  Snacks.picker.man()
end, { desc = ddesc("Man Pages") })
nmap("n", "<leader>sp", function()
  local Snacks = S()
  Snacks.picker.lazy()
end, { desc = ddesc("Search for Plugin Spec") })
nmap("n", "<leader>sq", function()
  local Snacks = S()
  Snacks.picker.qflist()
end, { desc = ddesc("Quickfix List") })
nmap("n", "<leader>sR", function()
  local Snacks = S()
  Snacks.picker.resume()
end, { desc = ddesc("Resume") })
nmap("n", "<leader>su", function()
  local Snacks = S()
  Snacks.picker.undo()
end, { desc = ddesc("Undo History") })
nmap("n", "<leader>uC", function()
  local Snacks = S()
  Snacks.picker.colorschemes()
end, { desc = ddesc("Colorschemes") })

-- Other
nmap("n", "<leader>z", function()
  local Snacks = S()
  Snacks.zen()
end, { desc = ddesc("Toggle Zen Mode") })
nmap("n", "<leader>Z", function()
  local Snacks = S()
  Snacks.zen.zoom()
end, { desc = ddesc("Toggle Zoom") })
nmap("n", "<leader>.", function()
  local Snacks = S()
  Snacks.scratch()
end, { desc = ddesc("Toggle Scratch Buffer") })
nmap("n", "<leader>S", function()
  local Snacks = S()
  Snacks.scratch.select()
end, { desc = ddesc("Select Scratch Buffer") })
nmap("n", "<leader>n", function()
  local Snacks = S()
  Snacks.notifier.show_history()
end, { desc = ddesc("Notification History") })
nmap("n", "<leader>bd", function()
  local Snacks = S()
  Snacks.bufdelete()
end, { desc = ddesc("Delete Buffer") })
nmap("n", "<leader>cR", function()
  local Snacks = S()
  Snacks.rename.rename_file()
end, { desc = ddesc("Rename File") })
nmap({ "n", "v" }, "<leader>gB", function()
  local Snacks = S()
  Snacks.gitbrowse()
end, { desc = ddesc("Git Browse") })
nmap("n", "<leader>gg", function()
  local Snacks = S()
  Snacks.lazygit()
end, { desc = ddesc("Lazygit") })
nmap("n", "<leader>un", function()
  local Snacks = S()
  Snacks.notifier.hide()
end, { desc = ddesc("Dismiss All Notifications") })
nmap({ "n", "t" }, "<c-/>", function()
  local Snacks = S()
  Snacks.terminal()
end, { desc = ddesc("Toggle Terminal") })
nmap("n", "<c-_>", function()
  local Snacks = S()
  Snacks.terminal()
end, { desc = ddesc("which_key_ignore") })
nmap({ "n", "t" }, "<c-t>", function()
  local Snacks = S()
  Snacks.terminal.toggle()
end, { desc = "Toggle Terminal" })
nmap({ "n", "t" }, "]]", function()
  local Snacks = S()
  Snacks.words.jump(vim.v.count1)
end, { desc = ddesc("Next Reference") })
nmap({ "n", "t" }, "[[", function()
  local Snacks = S()
  Snacks.words.jump(-vim.v.count1)
end, { desc = ddesc("Prev Reference") })

-- Setup some globals for debugging (lazy-loaded)
_G.dd = function(...)
  Snacks.debug.inspect(...)
end
_G.bt = function()
  Snacks.debug.backtrace()
end

vim.g.snacks_animate = false
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
Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
Snacks.toggle.treesitter():map("<leader>uT")
Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
Snacks.toggle.inlay_hints():map("<leader>uh")
Snacks.toggle.indent():map("<leader>ug")
Snacks.toggle.dim():map("<leader>uD")
--   end,
-- })
