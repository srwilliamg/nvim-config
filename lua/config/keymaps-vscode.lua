-- VSCode Neovim
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- next diagnostic
keymap("n", "]f", "<cmd>lua require('vscode').action('editor.action.marker.nextInFiles')<CR>")
keymap("n", "]d", "<cmd>lua require('vscode').action('editor.action.marker.next')<CR>")

-- previous diagnostic
keymap("n", "[f", "<cmd>lua require('vscode').action('editor.action.marker.prevInFiles')<CR>")
keymap("n", "[d", "<cmd>lua require('vscode').action('editor.action.marker.prev')<CR>")

-- removes highlighting after escaping vim search
keymap("n", "<Esc>", "<Esc>:noh<CR>", opts)
keymap({ "n", "v" }, "<leader>t", "<cmd>lua require('vscode').action('workbench.action.terminal.toggleTerminal')<CR>")
keymap({ "n", "v" }, "<leader>b", "<cmd>lua require('vscode').action('editor.debug.action.toggleBreakpoint')<CR>")
keymap({ "n", "v" }, "<leader>d", "<cmd>lua require('vscode').action('editor.action.showHover')<CR>")
keymap({ "n", "v" }, "<leader>a", "<cmd>lua require('vscode').action('editor.action.quickFix')<CR>")
keymap({ "n", "v" }, "<leader>sp", "<cmd>lua require('vscode').action('workbench.actions.view.problems')<CR>")
keymap({ "n", "v" }, "<leader>cn", "<cmd>lua require('vscode').action('notifications.clearAll')<CR>")
keymap({ "n", "v" }, "<leader>cp", "<cmd>lua require('vscode').action('workbench.action.showCommands')<CR>")
keymap({ "n", "v" }, "<leader>pr", "<cmd>lua require('vscode').action('code-runner.run')<CR>")
keymap({ "n", "v" }, "<leader>fd", "<cmd>lua require('vscode').action('editor.action.formatDocument')<CR>")

keymap({ "n", "v" }, "<leader>ff", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>")
keymap({ "n", "v" }, "<leader><leader>", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>")

vim.keymap.set({ "n", "x", "i" }, "<C-d>", function()
  require("vscode").with_insert(function()
    require("vscode").action("editor.action.addSelectionToNextFindMatch")
  end)
end)

vim.keymap.set({ "n", "x" }, "<leader>r", function()
  require("vscode").with_insert(function()
    require("vscode").action("editor.action.refactor")
  end)
end)
