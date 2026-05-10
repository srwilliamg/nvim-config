local initMasonDAP = function()
  require("mason-nvim-dap").setup({
    ensure_installed = {
      "js-debug-adapter",
      "delve",
    },
    automatic_installation = true,
    handlers = {
      delve = function(config)
        table.insert(config.configurations, 1, {
          type = "delve",
          name = "Run: cmd/api/main",
          request = "launch",
          program = "${workspaceFolder}/cmd/api/main.go",
          envFile = "${workspaceFolder}/.env",
          outputMode = "remote",
          console = "internalConsole",
        })
        require("mason-nvim-dap").default_setup(config)
      end,
    },
  })
end

local initDapUI = function()
  local dap, dapui = require("dap"), require("dapui")
  dapui.setup({
    layouts = {
      {
        elements = {
          { id = "breakpoints", size = 0.2 },
          { id = "scopes", size = 0.6 },
          { id = "watches", size = 0.1 },
          { id = "stacks", size = 0.1 },
        },
        size = 40,
        position = "left",
      },
      {
        elements = {
          { id = "repl", size = 1 },
        },
        size = 0.3,
        position = "bottom",
      },
    },
    floating = {
      max_height = 1,
      max_width = 1,
    },
    controls = {
      enabled = true,
      element = "repl",
    },
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "dap-repl",
    callback = function()
      vim.cmd([[
      syntax match DapLogError /\v\c(error|falta|panic)/
      syntax match DapLogWarn /\v\c(warn|warning)/
      syntax match DapLogInfo /\v\c(info)/
      syntax match DapLogDebug /\v\c(debug|trace)/
      ]])
      vim.api.nvim_set_hl(0, "DapLogError", { fg = "#f38ba8" })
      vim.api.nvim_set_hl(0, "DapLogWarn", { fg = "#f9e2af" })
      vim.api.nvim_set_hl(0, "DapLogInfo", { fg = "#89b4fa" })
      vim.api.nvim_set_hl(0, "DapLogDebug", { fg = "#6c7086" })
    end,
  })

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end

  vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Dap UI" })
  vim.keymap.set({ "n", "v" }, "<leader>de", dapui.eval, { desc = "Eval" })
end

local initDAP = function()
  local dap = require("dap")
  local local_debugger = vim.fn.expand("~/.local/share/nvim/js-debug/src/dapDebugServer.js")

  require("dap-go").setup({
    dap_configurations = {
      {
        type = "go",
        name = "Debug: main",
        request = "launch",
        program = "${workspaceFolder}/main.go",
        port = "${port}",
        console = "integratedTerminal",
        envFile = "${workspaceFolder}/.env",
        outputMode = "remote",
        dlvFlags = {
          "--log",
          "--log-output=debugger,dap", -- More verbose logging
          "--log-dest=/tmp/delve-verbose.log",
        },
      },
    },
    -- delve configurations
    delve = {
      path = "dlv",
      initialize_timeout_sec = 20,
      port = "${port}",
      args = {},
      build_flags = {},
      detached = vim.fn.has("win32") == 0,
      cwd = nil,
    },
    tests = {
      verbose = false,
    },
  })

  dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
      command = "node",
      args = { local_debugger, "${port}" },
    },
  }

  local js_shared = {
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach to process",
      processId = require("dap.utils").pick_process,
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      skipFiles = { "<node_internals>/**", "node_modules/**" },
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Jest test",
      runtimeExecutable = "npx",
      runtimeArgs = { "jest", "--runInBand", "--no-coverage", "${file}" },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      sourceMaps = true,
      skipFiles = { "<node_internals>/**", "node_modules/**" },
    },
  }

  dap.configurations.javascript = vim.list_extend({
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      skipFiles = { "<node_internals>/**", "node_modules/**" },
    },
  }, js_shared)

  dap.configurations.typescript = vim.list_extend({
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch TS file (ts-node)",
      runtimeExecutable = "npx",
      runtimeArgs = { "ts-node" },
      program = "${file}",
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      skipFiles = { "<node_internals>/**", "node_modules/**" },
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch npm debug script",
      runtimeExecutable = "npm",
      runtimeArgs = { "run", "debug" },
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      skipFiles = { "<node_internals>/**", "node_modules/**" },
    },
  }, js_shared)


  -- DAP Keymaps
  -- stylua: ignore start
  local maps = {
    { "<leader>dr", function() vim.notify("Restarting Debugger...", vim.log.levels.INFO); dap.restart() end, "toggle [d]ebug [r]estart" },
    { "<leader>db", dap.toggle_breakpoint,                                                                    "toggle [d]ebug [b]reakpoint" },
    { "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,               "[d]ebug [B]reakpoint (conditional)" },
    { "<leader>dc", dap.continue,                                                                             "[d]ebug [c]ontinue" },
    { "<leader>dC", dap.run_to_cursor,                                                                        "[d]ebug [C]ursor" },
    { "<leader>dg", dap.goto_,                                                                                "[d]ebug [g]o to line" },
    { "<leader>do", dap.step_over,                                                                            "[d]ebug step [o]ver" },
    { "<leader>dO", dap.step_out,                                                                             "[d]ebug step [O]ut" },
    { "<leader>di", dap.step_into,                                                                            "[d]ebug [i]nto" },
    { "<leader>dj", dap.down,                                                                                 "[d]ebug [j]ump down" },
    { "<leader>dk", dap.up,                                                                                   "[d]ebug [k]jump up" },
    { "<leader>dl", dap.run_last,                                                                             "[d]ebug [l]ast" },
    { "<leader>dp", dap.pause,                                                                                "[d]ebug [p]ause" },
    { "<leader>dR", dap.repl.toggle,                                                                          "[d]ebug [R]epl" },
    { "<leader>ds", dap.session,                                                                              "[d]ebug [s]ession" },
    { "<leader>dt", dap.terminate,                                                                            "[d]ebug [t]erminate" },
    { "<leader>dw", require("dap.ui.widgets").hover,                                                          "[d]ebug [w]idgets" },
    { "<F5>",       dap.continue,                                                                             "Debug: Continue" },
    { "<F10>",      dap.step_over,                                                                            "Debug: Step Over" },
    { "<F11>",      dap.step_into,                                                                            "Debug: Step Into" },
    { "<F12>",      dap.step_out,                                                                             "Debug: Step Out" },
  }
  -- stylua: ignore end
  for _, m in ipairs(maps) do
    vim.keymap.set("n", m[1], m[2], { desc = m[3] })
  end
end

vim.pack.add({
  Utils.github("rcarriga/nvim-dap-ui"),
  Utils.github("jay-babu/mason-nvim-dap.nvim"),
  Utils.github("mfussenegger/nvim-dap"),
  Utils.github("theHamsta/nvim-dap-virtual-text"),
  Utils.github("nvim-neotest/nvim-nio"),
  Utils.github("mason-org/mason-lspconfig.nvim"),
  Utils.github("leoluz/nvim-dap-go"),
})
require("lazyload").on_vim_enter(function()
  initDAP()
  initDapUI()
  initMasonDAP()
end)

-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function()
--     initDAP()
--     initDapUI()
--     initMasonDAP()
--   end,
--   once = true,
-- })
