vim.pack.add({
  Utils.github("rcarriga/nvim-dap-ui"),
  Utils.github("jay-babu/mason-nvim-dap.nvim"),
  Utils.github("mfussenegger/nvim-dap"),
  Utils.github("theHamsta/nvim-dap-virtual-text"),
  Utils.github("nvim-neotest/nvim-nio"),
  Utils.github("mason-org/mason-lspconfig.nvim"),
  Utils.github("leoluz/nvim-dap-go"),
})
local initMasonDAP = function()
  require("mason-nvim-dap").setup({
    ensure_installed = {
      "js-debug-adapter",
      "delve",
    },
    automatic_installation = true,
    handlers = {
      function(config)
        require("mason-nvim-dap").default_setup(config)
      end,
      delve = function(config)
        table.insert(config.configurations, 1, {
          -- args = function()
          --   return vim.split(vim.fn.input("args> "), " ")
          -- end,
          type = "delve",
          name = "Run: cmd/api/main",
          request = "launch",
          program = "${workspaceFolder}/cmd/api/main.go",
          envFile = "${workspaceFolder}/.env",
          outputMode = "remote",
          console = "internalConsole",
        })
        table.insert(config.configurations, 1, {
          type = "delve",
          name = "Run: file",
          request = "launch",
          program = "${file}",
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
          { id = "console", size = 0 },
        },
        size = 10,
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

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({})
    -- vim.cmd("Neotree close")
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close({})
    -- vim.cmd("Neotree")
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close({})
    -- vim.cmd("Neotree")
  end

  vim.keymap.set("n", "<leader>du", function()
    require("dapui").toggle()
  end, { desc = "Dap UI" })
  vim.keymap.set({ "n", "v" }, "<leader>de", function()
    require("dapui").eval()
  end, { desc = "Eval" })
end

local initDAP = function()
  local dap = require("dap")
  local local_debugger = vim.fn.expand("~/.local/share/nvim/js-debug/src/dapDebugServer.js")

  require("dap-go").setup({
    dap_configurations = {
      {
        type = "go",
        name = "Run: ./main",
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
      {
        type = "go",
        name = "Run: file",
        request = "launch",
        program = "${file}",
        buildFlags = require("dap-go").get_build_flags,
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
  dap.configurations.javascript = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      sourceMaps = true,
      program = "${file}",
      protocol = "inspector",
      cwd = vim.fn.getcwd(), -- Use current working directory
      skipFiles = {
        "<node_internals>/**",
        "node_modules/**",
      },
    },
  }
  dap.configurations.typescript = {
    {
      runtimeExecutable = "npx",
      runtimeArgs = { "ts-node" },
      type = "pwa-node",
      request = "launch",
      name = "Launch TypeScript file",
      program = "${file}",
      cwd = vim.fn.getcwd(), -- Use current working directory
      skipFiles = {
        "<node_internals>/**",
        "node_modules/**",
      },
      sourceMaps = true,
    },
  }
  dap.set_log_level("TRACE")
  -- DAP Keymaps
  vim.keymap.set("n", "<leader>dr", function()
    vim.notify("Restarting Debugger...", vim.log.levels.INFO)
    require("dap").restart()
  end, { desc = "toggle [d]ebug [r]estart" })

  vim.keymap.set("n", "<leader>db", function()
    require("dap").toggle_breakpoint()
  end, { desc = "toggle [d]ebug [b]reakpoint" })

  vim.keymap.set("n", "<leader>dB", function()
    require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
  end, { desc = "[d]ebug [B]reakpoint (conditional)" })

  vim.keymap.set("n", "<leader>dc", function()
    require("dap").continue()
  end, { desc = "[d]ebug [c]ontinue" })

  vim.keymap.set("n", "<leader>dC", function()
    require("dap").run_to_cursor()
  end, { desc = "[d]ebug [C]ursor" })

  vim.keymap.set("n", "<leader>dg", function()
    require("dap").goto_()
  end, { desc = "[d]ebug [g]o to line" })

  vim.keymap.set("n", "<leader>do", function()
    require("dap").step_over()
  end, { desc = "[d]ebug step [o]ver" })

  vim.keymap.set("n", "<leader>dO", function()
    require("dap").step_out()
  end, { desc = "[d]ebug step [O]ut" })

  vim.keymap.set("n", "<leader>di", function()
    require("dap").step_into()
  end, { desc = "[d]ebug [i]nto" })

  vim.keymap.set("n", "<leader>dj", function()
    require("dap").down()
  end, { desc = "[d]ebug [j]ump down" })

  vim.keymap.set("n", "<leader>dk", function()
    require("dap").up()
  end, { desc = "[d]ebug [k]ump up" })

  vim.keymap.set("n", "<leader>dl", function()
    require("dap").run_last()
  end, { desc = "[d]ebug [l]ast" })

  vim.keymap.set("n", "<leader>dp", function()
    require("dap").pause()
  end, { desc = "[d]ebug [p]ause" })

  vim.keymap.set("n", "<leader>dR", function()
    require("dap").repl.toggle()
  end, { desc = "[d]ebug [r]epl" })

  vim.keymap.set("n", "<leader>ds", function()
    require("dap").session()
  end, { desc = "[d]ebug [s]ession" })

  vim.keymap.set("n", "<leader>dt", function()
    require("dap").terminate()
  end, { desc = "[d]ebug [t]erminate" })

  vim.keymap.set("n", "<leader>dw", function()
    require("dap.ui.widgets").hover()
  end, { desc = "[d]ebug [w]idgets" })

  -- Function keys
  vim.keymap.set("n", "<F5>", function()
    require("dap").continue()
  end, { desc = "Debug: Continue" })
  vim.keymap.set("n", "<F10>", function()
    require("dap").step_over()
  end, { desc = "Debug: Step Over" })
  vim.keymap.set("n", "<F11>", function()
    require("dap").step_into()
  end, { desc = "Debug: Step Into" })
  vim.keymap.set("n", "<F12>", function()
    require("dap").step_out()
  end, { desc = "Debug: Step Out" })
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    initDAP()
    initDapUI()
    initMasonDAP()
  end,
  once = true,
})
