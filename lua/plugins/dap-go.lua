return {
  "leoluz/nvim-dap-go",
  enabled = not vim.g.vscode,
  dependencies = { "mfussenegger/nvim-dap" },
  config = function()
    require("dap-go").setup({
      dap_configurations = {
        {
          type = "go",
          name = "Attach to Go Server",
          request = "launch",
          program = "${workspaceFolder}/main.go",
          port = "${port}",
          console = "integratedTerminal",
          outputMode = "remote",
          dlvFlags = {
            "--log",
            "--log-output=debugger,dap", -- More verbose logging
            "--log-dest=/tmp/delve-verbose.log",
          },
        },
        {
          type = "go",
          name = "Debug (Build Flags)",
          request = "launch",
          program = "${file}",
          buildFlags = require("dap-go").get_build_flags,
          console = "integratedTerminal",
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
  end,
}
