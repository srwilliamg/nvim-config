local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

if vim.g.vscode then
  -- DAP ui shortcuts
  print("Settings DAP shortcuts")
  local dap = require("dap")
  keymap("n", "<F8>", dap.continue, { desc = "Debug: Continue", opts })
  keymap("n", "<F10>", dap.step_over, { desc = "Debug: Step Over", opts })
  keymap("n", "<F11>", dap.step_into, { desc = "Debug: Step Into", opts })
  keymap("n", "<F12>", dap.step_out, { desc = "Debug: Step Out", opts })
  keymap("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint", opts })
  keymap("n", "<leader>du", dap.toggle({}), { desc = "Debug: Toggle UI", opts })
  keymap("n", "<leader>de", dap.eval({}), { desc = "Debug: eval", opts })
end
