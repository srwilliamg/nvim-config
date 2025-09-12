-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- dap keymaps
local dap = require("dap")
vim.keymap.set("n", "<F8>", dap.continue, { desc = "Debug: Continue" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })

-- copilot keymaps
vim.keymap.set("i", "<C-j>", 'copilot#Accept("<CR>")', { expr = true, replace_keycodes = false })
vim.keymap.set("n", "<leader>cd", ":Copilot disable <CR>", {})
vim.keymap.set("n", "<leader>ce", ":Copilot enable <CR>", {})
vim.keymap.set("n", "<leader>ci", ":Copilot auth<CR>", {})
vim.keymap.set("n", "<leader>cq", function()
  require("CopilotChat").toggle()
end, { desc = "Toggle Copilot Chat" })
